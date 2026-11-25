package pe.sige.ventas.domain;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;

/**
 * Calculo de importes de un comprobante (logica que estaba repartida en scripts de la ventana
 * de facturacion y en columnas computadas del DataWindow). Funcion pura: facil de probar.
 */
public final class CalculadoraComprobante {

    public record Linea(BigDecimal cantidad, BigDecimal precioUnitario, BigDecimal descuento) {
    }

    public record LineaCalculada(BigDecimal valorUnitario, BigDecimal importe, BigDecimal igv) {
    }

    public record Totales(List<LineaCalculada> lineas, BigDecimal valorVenta, BigDecimal descuento, BigDecimal igv,
            BigDecimal total) {
    }

    private CalculadoraComprobante() {
    }

    /**
     * @param tasaIgv            p.ej. 0.18
     * @param aplicaIgv          si el comprobante esta afecto
     * @param preciosIncluyenIgv si los precios ingresados ya incluyen IGV
     */
    public static Totales calcular(List<Linea> lineas, BigDecimal tasaIgv, boolean aplicaIgv, boolean preciosIncluyenIgv) {
        BigDecimal factor = BigDecimal.ONE.add(tasaIgv);
        BigDecimal valorVenta = BigDecimal.ZERO;
        BigDecimal descuentos = BigDecimal.ZERO;
        BigDecimal igv = BigDecimal.ZERO;
        List<LineaCalculada> out = new ArrayList<>();
        for (Linea l : lineas) {
            BigDecimal dscto = l.descuento() == null ? BigDecimal.ZERO : l.descuento();
            BigDecimal valorUnit = aplicaIgv && preciosIncluyenIgv
                    ? l.precioUnitario().divide(factor, 7, RoundingMode.HALF_UP)
                    : l.precioUnitario().setScale(7, RoundingMode.HALF_UP);
            BigDecimal dsctoSinIgv = aplicaIgv && preciosIncluyenIgv ? dscto.divide(factor, 7, RoundingMode.HALF_UP) : dscto;
            BigDecimal importe = valorUnit.multiply(l.cantidad()).subtract(dsctoSinIgv).setScale(2, RoundingMode.HALF_UP);
            if (importe.signum() < 0) {
                throw new IllegalArgumentException("El descuento supera el importe de la linea");
            }
            BigDecimal igvLinea = aplicaIgv ? importe.multiply(tasaIgv).setScale(2, RoundingMode.HALF_UP) : BigDecimal.ZERO;
            out.add(new LineaCalculada(valorUnit, importe, igvLinea));
            valorVenta = valorVenta.add(importe);
            descuentos = descuentos.add(dsctoSinIgv);
            igv = igv.add(igvLinea);
        }
        valorVenta = valorVenta.setScale(2, RoundingMode.HALF_UP);
        return new Totales(out, valorVenta, descuentos.setScale(2, RoundingMode.HALF_UP), igv, valorVenta.add(igv));
    }
}
