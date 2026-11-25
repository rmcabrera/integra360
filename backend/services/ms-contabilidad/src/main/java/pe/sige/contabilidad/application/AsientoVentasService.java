package pe.sige.contabilidad.application;

import io.quarkus.hibernate.reactive.panache.Panache;
import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.jboss.logging.Logger;
import pe.sige.common.events.FacturaEvent;
import pe.sige.contabilidad.domain.legacy.Contabilizacion;
import pe.sige.contabilidad.domain.legacy.MoviContables;

/**
 * Asiento automatico de ventas. Port de PA_Generar_Asiento_Ventas:
 * <pre>
 *   12 Cuentas por cobrar  (CUENTA1/CA1)  total
 *   40 Tributos - IGV      (CUENTA2/CA2)  igv
 *   70 Ventas              (CUENTA4/CA4)  valor de venta
 * </pre>
 * La configuracion contable sigue en la tabla CONTABILIZACION. Moneda '01' = soles; en otra moneda
 * se registra el importe en dolares y su equivalente en soles con el tipo de cambio de la factura.
 * Debe ejecutarse dentro de una transaccion reactiva.
 */
@ApplicationScoped
public class AsientoVentasService {

    private static final Logger LOG = Logger.getLogger(AsientoVentasService.class);
    private static final String SOLES = "01";

    /** tipo de documento -> codigo en CONTABILIZACION (p.ej. 0001=factura, 0003=boleta) */
    @ConfigProperty(name = "sige.contabilidad.ventas")
    Map<String, String> codigoPorTipoDocu;

    public Uni<Integer> generar(FacturaEvent f) {
        String codigo = codigoPorTipoDocu.getOrDefault(f.codiTipoDocu(), codigoPorTipoDocu.get("default"));
        return Contabilizacion.<Contabilizacion>findById(codigo).flatMap(cfg -> {
            if (cfg == null) {
                LOG.warnf("Sin configuracion contable %s para tipo %s; factura %s no contabilizada", codigo, f.codiTipoDocu(), f.codiFact());
                return Uni.createFrom().item(0);
            }
            String anio = String.valueOf(f.fecha().getYear());
            String mes = String.format("%02d", f.fecha().getMonthValue());
            String subdia = cfg.subdiario == null ? "5" : cfg.subdiario;
            return siguienteComprobante(anio, mes, subdia).flatMap(compr -> {
                List<MoviContables> lineas = new ArrayList<>();
                lineas.add(linea(f, cfg.cuenta1, cfg.ca1, f.total(), cfg.desc1, anio, mes, subdia, compr));
                if (f.igv() != null && f.igv().signum() != 0) {
                    lineas.add(linea(f, cfg.cuenta2, cfg.ca2, f.igv(), cfg.desc2, anio, mes, subdia, compr));
                }
                lineas.add(linea(f, cfg.cuenta4, cfg.ca4, f.valorVenta(), cfg.desc4, anio, mes, subdia, compr));
                return siguientesCodigos(lineas.size()).flatMap(codigos -> {
                    for (int i = 0; i < lineas.size(); i++) {
                        lineas.get(i).codiContable = codigos.get(i);
                    }
                    return Panache.getSession().flatMap(s -> s.persistAll(lineas.toArray())).replaceWith(lineas.size());
                });
            });
        });
    }

    /** Anulacion: como el legado, el asiento se conserva con glosa ANULADO e importes en cero. */
    public Uni<Integer> anular(FacturaEvent f) {
        return MoviContables.update("glosa = 'ANULADO', importe = 0, igv = 0, total = 0, importeD = 0, igvD = 0, totalD = 0 "
                + "where registro = ?1 and codiTipoDocu = ?2", f.codiFact(), f.codiTipoDocu());
    }

    private MoviContables linea(FacturaEvent f, String cuenta, String cargoAbono, BigDecimal monto, String glosa,
            String anio, String mes, String subdia, String compr) {
        boolean soles = SOLES.equals(f.codiMone());
        BigDecimal tc = f.tipoCambio() == null || soles ? BigDecimal.ONE : f.tipoCambio();
        BigDecimal montoSoles = monto.multiply(tc).setScale(2, RoundingMode.HALF_UP);
        MoviContables m = new MoviContables();
        m.anio = anio;
        m.mes = mes;
        m.subdia = subdia;
        m.compr = compr;
        m.codiMone = f.codiMone();
        m.fecha = f.fecha().atStartOfDay();
        m.nroCuen = cuenta;
        m.codiClieProv = f.codiClieProv();
        m.serie = f.serie();
        m.nroDocu = f.numero();
        m.codiTipoDocu = f.codiTipoDocu();
        m.importe = montoSoles;
        m.total = montoSoles;
        m.importeD = soles ? BigDecimal.ZERO : monto;
        m.totalD = soles ? BigDecimal.ZERO : monto;
        m.tipoCambio = soles ? BigDecimal.ZERO : tc;
        m.cargoAbono = cargoAbono;
        m.glosa = glosa == null ? "VENTA " + f.serie() + "-" + f.numero() : glosa;
        m.registro = f.codiFact();
        m.tipoVenta = "1";
        m.hechoPor = f.usuario() == null ? null : f.usuario().substring(0, Math.min(5, f.usuario().length()));
        m.creacion = LocalDateTime.now();
        m.fechaCreacion = m.creacion;
        return m;
    }

    /** numero de comprobante contable correlativo por anio/mes/subdiario, serializado con un advisory lock */
    private Uni<String> siguienteComprobante(String anio, String mes, String subdia) {
        String key = anio + mes + subdia;
        return Panache.getSession().flatMap(s -> s
                .createNativeQuery("select 1 from (select pg_advisory_xact_lock(hashtext(:k))) l", Integer.class)
                .setParameter("k", "compr:" + key)
                .getSingleResult()
                .chain(() -> s.createNativeQuery("select coalesce(max(compr::integer), 0) + 1 from movi_contables "
                        + "where anio = :a and mes = :m and subdia = :s and compr ~ '^[0-9]+$'", Integer.class)
                        .setParameter("a", anio).setParameter("m", mes).setParameter("s", subdia)
                        .getSingleResult()))
                .map(n -> String.format("%010d", n));
    }

    private Uni<List<String>> siguientesCodigos(int n) {
        return Panache.getSession().flatMap(s -> s
                .createNativeQuery("select nextval('movi_contables_codi_seq') from generate_series(1, :n)", Long.class)
                .setParameter("n", n)
                .getResultList())
                .map(l -> l.stream().map(v -> String.format("%010d", v)).toList());
    }
}
