package pe.sige.ventas.application;

import io.quarkus.hibernate.reactive.panache.Panache;
import io.quarkus.hibernate.reactive.panache.common.WithSession;
import io.quarkus.hibernate.reactive.panache.common.WithTransaction;
import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.LockModeType;
import jakarta.validation.Valid;
import jakarta.ws.rs.NotFoundException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import pe.sige.common.api.BusinessException;
import pe.sige.common.api.PageResponse;
import pe.sige.common.events.FacturaEvent;
import pe.sige.common.messaging.Outbox;
import pe.sige.ventas.domain.CalculadoraComprobante;
import pe.sige.ventas.domain.CalculadoraComprobante.Linea;
import pe.sige.ventas.domain.legacy.AlmacenDocumentos;
import pe.sige.ventas.domain.legacy.Factura;
import pe.sige.ventas.domain.legacy.FacturaDetalle;
import pe.sige.ventas.domain.legacy.ProductosOfertas;
import pe.sige.ventas.infrastructure.ClienteValidator;

/**
 * Casos de uso de facturacion. Migra a Java la logica de:
 * <ul>
 *   <li>SP_insert_FACTURA / SP_insert_FACTURA_DETALLE (alta de cabecera y detalle)</li>
 *   <li>trigger FD_ACTPROD (consumo de stock de ofertas)</li>
 *   <li>correlativo por almacen/serie (ALMACEN_DOCUMENTOS) con bloqueo pesimista en lugar de MAX()+1</li>
 *   <li>anulacion (estado 'A', fecha_elim, motivo_elim)</li>
 * </ul>
 * La actualizacion de kardex (antes SP_KARDEX_INSERT) y el asiento contable
 * (antes PA_Generar_Asiento_Ventas) ocurren de forma asincrona en ms-logistica y ms-contabilidad
 * a partir del evento {@link FacturaEvent}.
 */
@ApplicationScoped
public class FacturaService {

    public static final String ESTADO_EMITIDA = "E";
    public static final String ESTADO_ANULADA = "A";

    @Inject
    Outbox outbox;

    @Inject
    ClienteValidator clientes;

    @ConfigProperty(name = "sige.ventas.igv", defaultValue = "0.18")
    BigDecimal tasaIgv;

    public Uni<Factura> emitir(@Valid EmitirFacturaRequest req, String usuario) {
        // la validacion remota va fuera de la transaccion para no retener conexiones/bloqueos
        return clientes.validar(req.codiClieProv())
                .chain(() -> Panache.withTransaction(() -> registrar(req, usuario)));
    }

    private Uni<Factura> registrar(EmitirFacturaRequest req, String usuario) {
        AlmacenDocumentos.Pk pk = new AlmacenDocumentos.Pk();
        pk.codiAlma = req.codiAlma();
        pk.codiTipoDocu = req.codiTipoDocu();
        pk.serieAlma = req.serie();
        return AlmacenDocumentos.<AlmacenDocumentos>findById(pk, LockModeType.PESSIMISTIC_WRITE)
                .onItem().ifNull().failWith(() -> new BusinessException("SERIE_NO_CONFIGURADA",
                        "No existe la serie " + req.serie() + " para el documento " + req.codiTipoDocu()
                                + " en el almacen " + req.codiAlma()))
                .flatMap(serie -> {
                    if ("0".equals(serie.estado)) {
                        throw new BusinessException("SERIE_INACTIVA", "La serie " + req.serie() + " esta inactiva");
                    }
                    long numero = Math.max(serie.nroActual == null ? 0 : serie.nroActual,
                            serie.nroDocuEmpieza == null ? 0 : serie.nroDocuEmpieza - 1) + 1;
                    serie.nroActual = numero;
                    return nextCodigo().flatMap(codi -> crear(req, usuario, codi, numero));
                });
    }

    private Uni<String> nextCodigo() {
        return Panache.getSession()
                .flatMap(s -> s.createNativeQuery("select nextval('factura_codi_seq')", Long.class).getSingleResult())
                .map(n -> String.format("%010d", n));
    }

    private Uni<Factura> crear(EmitirFacturaRequest req, String usuario, String codiFact, long numero) {
        var totales = CalculadoraComprobante.calcular(
                req.items().stream().map(i -> new Linea(i.cantidad(), i.precioUnitario(), i.descuento())).toList(),
                tasaIgv, req.aplicaIgv(), req.preciosIncluyenIgv());

        Factura f = new Factura();
        f.codiFact = codiFact;
        f.codiAlma = req.codiAlma();
        f.codiTipoDocu = req.codiTipoDocu();
        f.serFact = req.serie();
        f.nroFact = String.format("%08d", numero);
        f.codiClieProv = req.codiClieProv();
        f.fechFact = req.fecha().atStartOfDay();
        f.vencFact = req.vencimiento() == null ? null : req.vencimiento().atStartOfDay();
        f.codiMone = req.codiMone();
        f.tcambio = req.tipoCambio();
        f.codiTipoPago = req.codiTipoPago();
        f.ordeFact = req.ordenCompra();
        f.codUsuaVende = req.vendedor();
        f.aplicaIgv = req.aplicaIgv() ? "1" : "0";
        f.valorIgv = tasaIgv.multiply(BigDecimal.valueOf(100));
        f.valoFact = totales.valorVenta();
        f.subtotaFact = totales.valorVenta();
        f.dsctoFact = totales.descuento();
        f.igvFact = totales.igv();
        f.totaFact = totales.total();
        f.estado = ESTADO_EMITIDA;
        f.contabilizado = "0";
        f.creacion = LocalDateTime.now();
        f.hechoPor = abreviar(usuario);

        List<FacturaDetalle> detalles = new ArrayList<>();
        List<FacturaEvent.Item> items = new ArrayList<>();
        for (int i = 0; i < req.items().size(); i++) {
            var it = req.items().get(i);
            var calc = totales.lineas().get(i);
            FacturaDetalle d = new FacturaDetalle();
            d.codiFact = codiFact;
            d.codiDeta = String.format("%03d", i + 1);
            d.codiAlma = req.codiAlma();
            d.codiProd = it.codiProd();
            d.codiItem = it.codiProd();
            d.descItem = it.descripcion();
            d.codiUnidMedi = it.codiUnidMedi();
            d.cantItem = it.cantidad();
            d.precItem = calc.valorUnitario();
            d.precLista = it.precioUnitario();
            d.dsctoItem = it.descuento();
            d.impoItem = calc.importe();
            d.igv = calc.igv();
            d.inclIgv = req.preciosIncluyenIgv() ? "1" : "0";
            d.prodOfer = it.oferta() ? "1" : "0";
            detalles.add(d);
            items.add(new FacturaEvent.Item(d.codiDeta, d.codiProd, d.codiUnidMedi, d.cantItem, d.precItem, d.impoItem));
        }

        FacturaEvent event = toEvent(f, usuario, items);
        return Panache.getSession()
                .flatMap(s -> s.persist(f).chain(() -> s.persistAll(detalles.toArray())))
                .chain(() -> consumirOfertas(req, f))
                .chain(() -> outbox.record(FacturaEvent.TOPIC, FacturaEvent.EMITIDA, "Factura", codiFact, event))
                .replaceWith(f);
    }

    /** Equivalente al trigger FD_ACTPROD: descuenta del cupo de ofertas vigentes y las cierra al agotarse. */
    private Uni<Void> consumirOfertas(EmitirFacturaRequest req, Factura f) {
        Uni<Void> chain = Uni.createFrom().voidItem();
        for (var it : req.items()) {
            if (!it.oferta()) {
                continue;
            }
            chain = chain
                    .chain(() -> ProductosOfertas.update("usado = coalesce(usado, 0) + ?1 where codiProd = ?2 and codiAlma = ?3 "
                            + "and estado = '1' and ?4 between fechaIni and fechaFin",
                            it.cantidad(), it.codiProd(), f.codiAlma, f.fechFact))
                    .chain(() -> ProductosOfertas.update("estado = '0' where codiProd = ?1 and codiAlma = ?2 "
                            + "and estado = '1' and ?3 between fechaIni and fechaFin and (cantidad - coalesce(usado, 0)) <= 0",
                            it.codiProd(), f.codiAlma, f.fechFact))
                    .replaceWithVoid();
        }
        return chain;
    }

    @WithTransaction
    public Uni<Factura> anular(String codiFact, String motivo, String usuario) {
        return Factura.<Factura>findById(codiFact, LockModeType.PESSIMISTIC_WRITE)
                .onItem().ifNull().failWith(() -> new NotFoundException("Factura " + codiFact + " no existe"))
                .flatMap(f -> {
                    if (ESTADO_ANULADA.equals(f.estado)) {
                        throw new BusinessException("YA_ANULADA", "La factura ya esta anulada");
                    }
                    f.estado = ESTADO_ANULADA;
                    f.fechaElim = LocalDateTime.now();
                    f.motivoElim = motivo;
                    f.codUsuaModi = abreviar(usuario);
                    return detalles(codiFact).flatMap(ds -> {
                        var items = ds.stream().map(d -> new FacturaEvent.Item(d.codiDeta, d.codiProd, d.codiUnidMedi,
                                d.cantItem, d.precItem, d.impoItem)).toList();
                        return outbox.record(FacturaEvent.TOPIC, FacturaEvent.ANULADA, "Factura", codiFact,
                                toEvent(f, usuario, items));
                    }).replaceWith(f);
                });
    }

    @WithSession
    public Uni<FacturaConDetalle> obtener(String codiFact) {
        return Factura.<Factura>findById(codiFact)
                .onItem().ifNull().failWith(() -> new NotFoundException("Factura " + codiFact + " no existe"))
                .flatMap(f -> detalles(codiFact).map(ds -> new FacturaConDetalle(f, ds)));
    }

    @WithSession
    public Uni<PageResponse<Factura>> buscar(FacturaFiltro filtro, int page, int size) {
        var q = filtro.toQuery();
        var query = Factura.<Factura>find(q.jpql() + " order by fechFact desc, codiFact desc", q.params());
        return query.count().flatMap(total -> query.page(page, size).list()
                .map(list -> new PageResponse<>(list, total, page, size)));
    }

    private Uni<List<FacturaDetalle>> detalles(String codiFact) {
        return FacturaDetalle.<FacturaDetalle>list("codiFact = ?1 order by codiDeta", codiFact);
    }

    private static FacturaEvent toEvent(Factura f, String usuario, List<FacturaEvent.Item> items) {
        return new FacturaEvent(f.codiFact, f.codiTipoDocu, f.serFact, f.nroFact, f.fechFact.toLocalDate(), f.codiClieProv,
                f.codiAlma, f.codiMone, f.tcambio, f.valoFact, f.igvFact, f.totaFact, usuario, items);
    }

    /** las columnas de usuario del legado son char(5) */
    private static String abreviar(String usuario) {
        return usuario == null ? null : usuario.length() <= 5 ? usuario : usuario.substring(0, 5);
    }

    public record FacturaConDetalle(Factura cabecera, List<FacturaDetalle> detalle) {
    }
}
