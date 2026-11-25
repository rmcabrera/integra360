package pe.sige.common.events;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

/**
 * Contrato publicado por ms-ventas en el topico {@value #TOPIC}.
 * Tipos: {@value #EMITIDA} y {@value #ANULADA}. Version del esquema: 1.
 * Los cambios incompatibles requieren un topico nuevo (.v2).
 */
public record FacturaEvent(
        String codiFact,
        String codiTipoDocu,
        String serie,
        String numero,
        LocalDate fecha,
        String codiClieProv,
        String codiAlma,
        String codiMone,
        BigDecimal tipoCambio,
        BigDecimal valorVenta,
        BigDecimal igv,
        BigDecimal total,
        String usuario,
        List<Item> items) {

    public static final String TOPIC = "sige.ventas.factura.v1";
    public static final String EMITIDA = "ventas.factura.emitida";
    public static final String ANULADA = "ventas.factura.anulada";

    public record Item(String codiDeta, String codiProd, String codiUnidMedi, BigDecimal cantidad,
            BigDecimal valorUnitario, BigDecimal importe) {
    }
}
