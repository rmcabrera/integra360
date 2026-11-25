package pe.sige.logistica.application;

import io.quarkus.hibernate.reactive.panache.Panache;
import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import pe.sige.common.api.BusinessException;
import pe.sige.logistica.domain.KardexCalculator;
import pe.sige.logistica.domain.legacy.AlmacenProducto;
import pe.sige.logistica.domain.legacy.Kardex;
import pe.sige.logistica.domain.legacy.Productos;

/**
 * Registro y valorizacion del kardex. Reemplaza SP_KARDEX_INSERT, SP_KARDEX_DELETE, SP_KARDEX_Reproceso
 * y la actualizacion de stock en ALMACEN_PRODUCTO / PRODUCTOS.
 * Todos los metodos deben ejecutarse dentro de una transaccion reactiva.
 */
@ApplicationScoped
public class KardexService {

    /** Registra un movimiento y recalcula los saldos del producto en el periodo. */
    public Uni<Kardex> registrar(MovimientoKardex m) {
        if (KardexCalculator.INGRESO.equals(m.io()) && m.precioUnitario() == null) {
            throw new BusinessException("PRECIO_REQUERIDO", "Un ingreso requiere precio unitario");
        }
        return Productos.<Productos>findById(m.codiProd())
                .onItem().ifNull().failWith(() -> new BusinessException("PRODUCTO_NO_EXISTE", "Producto " + m.codiProd() + " no existe"))
                .flatMap(prod -> nextCodigo().flatMap(codi -> {
                    Kardex k = new Kardex();
                    k.codiKard = codi;
                    k.codiProd = m.codiProd();
                    k.codiAlma = m.codiAlma();
                    k.fechTran = m.fecha();
                    k.periodo = m.fecha().getYear();
                    k.iO = m.io();
                    k.cantIngr = KardexCalculator.INGRESO.equals(m.io()) ? m.cantidad() : BigDecimal.ZERO;
                    k.cantSali = KardexCalculator.SALIDA.equals(m.io()) ? m.cantidad() : BigDecimal.ZERO;
                    k.precUnit = m.precioUnitario();
                    k.codiTipoDocu = m.codiTipoDocu();
                    k.nroSeri = m.serie();
                    k.nroDocu = m.numero();
                    k.codiDocuIO = m.codiDocuOrigen();
                    k.item = m.item();
                    k.codiMone = m.codiMone();
                    k.tipoCamb = m.tipoCambio();
                    k.concepto = m.concepto();
                    k.codiCuen = prod.nroCuen;
                    k.estado = "1";
                    k.creacion = LocalDateTime.now();
                    return k.<Kardex>persist()
                            .call(() -> recalcular(m.codiProd(), k.periodo))
                            .replaceWith(k);
                }));
    }

    /** Elimina los movimientos generados por un documento (anulacion) y recalcula. */
    public Uni<Long> eliminarPorDocumento(String codiDocuOrigen, String io, String codiProd, int periodo) {
        return Kardex.delete("codiDocuIO = ?1 and iO = ?2 and codiProd = ?3 and periodo = ?4", codiDocuOrigen, io, codiProd, periodo)
                .call(() -> recalcular(codiProd, periodo));
    }

    /** Recalculo completo de un producto en un periodo (antes SP_KARDEX_Reproceso). */
    public Uni<Void> recalcular(String codiProd, int periodo) {
        return Panache.getSession().flatMap(s -> s.flush())
                .chain(() -> Kardex.<Kardex>list("codiProd = ?1 and periodo = ?2 order by fechTran, codiKard", codiProd, periodo))
                .flatMap(filas -> {
                    Map<String, BigDecimal[]> saldos = KardexCalculator.recalcular(filas);
                    return actualizarStock(codiProd, saldos, filas);
                });
    }

    private Uni<Void> actualizarStock(String codiProd, Map<String, BigDecimal[]> saldos, List<Kardex> filas) {
        Uni<Void> chain = Uni.createFrom().voidItem();
        for (var e : saldos.entrySet()) {
            if (e.getKey().isEmpty()) {
                continue;
            }
            chain = chain.chain(() -> AlmacenProducto.update(
                    "stockAlma = ?1, precPromAlma = ?2 where codiAlma = ?3 and codiProd = ?4",
                    e.getValue()[0], e.getValue()[1].setScale(3, java.math.RoundingMode.HALF_UP), e.getKey(), codiProd)
                    .flatMap(rows -> rows > 0 ? Uni.createFrom().voidItem() : crearAlmacenProducto(e.getKey(), codiProd, e.getValue())));
        }
        if (!filas.isEmpty()) {
            Kardex last = filas.get(filas.size() - 1);
            chain = chain.chain(() -> Productos.update("stock = ?1, precProm = ?2 where codiProd = ?3",
                    last.cantSaldo, last.precProm.setScale(2, java.math.RoundingMode.HALF_UP), codiProd).replaceWithVoid());
        }
        return chain;
    }

    private Uni<Void> crearAlmacenProducto(String codiAlma, String codiProd, BigDecimal[] saldo) {
        AlmacenProducto ap = new AlmacenProducto();
        ap.codiAlma = codiAlma;
        ap.codiProd = codiProd;
        ap.stockAlma = saldo[0];
        ap.precPromAlma = saldo[1];
        return ap.persist().replaceWithVoid();
    }

    private Uni<String> nextCodigo() {
        return Panache.getSession()
                .flatMap(s -> s.createNativeQuery("select nextval('kardex_codi_seq')", Long.class).getSingleResult())
                .map(n -> String.format("%020d", n));
    }
}
