package pe.sige.logistica.domain;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.math.BigDecimal;
import java.util.List;
import org.junit.jupiter.api.Test;
import pe.sige.logistica.domain.legacy.Kardex;

class KardexCalculatorTest {

    private static Kardex mov(String io, String alma, String cant, String precio) {
        Kardex k = new Kardex();
        k.iO = io;
        k.codiAlma = alma;
        if ("I".equals(io)) {
            k.cantIngr = new BigDecimal(cant);
            k.precUnit = new BigDecimal(precio);
        } else {
            k.cantSali = new BigDecimal(cant);
        }
        return k;
    }

    @Test
    void promedioPonderado() {
        Kardex a = mov("I", "01", "10", "10");
        Kardex b = mov("I", "01", "10", "20");
        Kardex c = mov("O", "01", "5", null);
        var saldos = KardexCalculator.recalcular(List.of(a, b, c));
        assertEquals(0, new BigDecimal("15").compareTo(b.precProm));
        assertEquals(0, new BigDecimal("75").compareTo(c.valoSali));
        assertEquals(0, new BigDecimal("15").compareTo(c.cantSaldo));
        assertEquals(0, new BigDecimal("225").compareTo(c.valoSaldo));
        assertEquals(0, new BigDecimal("15").compareTo(saldos.get("01")[0]));
    }

    @Test
    void saldosPorAlmacenIndependientes() {
        Kardex a = mov("I", "01", "10", "10");
        Kardex b = mov("I", "02", "10", "30");
        Kardex c = mov("O", "02", "4", null);
        KardexCalculator.recalcular(List.of(a, b, c));
        // general: promedio 20; almacen 02: promedio 30
        assertEquals(0, new BigDecimal("80").compareTo(c.valoSali));
        assertEquals(0, new BigDecimal("120").compareTo(c.valoSaliAlma));
        assertEquals(0, new BigDecimal("6").compareTo(c.cantSaldoAlma));
    }
}
