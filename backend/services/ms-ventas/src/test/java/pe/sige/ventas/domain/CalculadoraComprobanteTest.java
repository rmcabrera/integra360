package pe.sige.ventas.domain;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import java.math.BigDecimal;
import java.util.List;
import org.junit.jupiter.api.Test;
import pe.sige.ventas.domain.CalculadoraComprobante.Linea;

class CalculadoraComprobanteTest {

    private static final BigDecimal IGV = new BigDecimal("0.18");

    @Test
    void preciosSinIgv() {
        var t = CalculadoraComprobante.calcular(List.of(new Linea(new BigDecimal("2"), new BigDecimal("50"), null)), IGV, true, false);
        assertEquals(new BigDecimal("100.00"), t.valorVenta());
        assertEquals(new BigDecimal("18.00"), t.igv());
        assertEquals(new BigDecimal("118.00"), t.total());
    }

    @Test
    void preciosConIgv() {
        var t = CalculadoraComprobante.calcular(List.of(new Linea(BigDecimal.ONE, new BigDecimal("118"), null)), IGV, true, true);
        assertEquals(new BigDecimal("100.00"), t.valorVenta());
        assertEquals(new BigDecimal("118.00"), t.total());
    }

    @Test
    void exonerado() {
        var t = CalculadoraComprobante.calcular(List.of(new Linea(new BigDecimal("3"), new BigDecimal("10"), BigDecimal.ONE)), IGV, false, false);
        assertEquals(new BigDecimal("29.00"), t.total());
        assertEquals(0, t.igv().signum());
    }

    @Test
    void descuentoMayorQueImporte() {
        assertThrows(IllegalArgumentException.class, () -> CalculadoraComprobante.calcular(
                List.of(new Linea(BigDecimal.ONE, BigDecimal.ONE, BigDecimal.TEN)), IGV, false, false));
    }
}
