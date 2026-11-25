package pe.sige.logistica.domain;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import pe.sige.logistica.domain.legacy.Kardex;

/**
 * Valorizacion de kardex por costo promedio ponderado, general y por almacen.
 * <p>
 * Porta la logica de SP_KARDEX_INSERT + SP_KARDEX_Reproceso: en lugar de calcular solo la fila nueva
 * leyendo "la ultima anterior" (lo que dejaba saldos inconsistentes con movimientos con fecha pasada),
 * recalcula en orden cronologico todas las filas del producto en el periodo. Asi el kardex siempre cuadra.
 */
public final class KardexCalculator {

    public static final String INGRESO = "I";
    public static final String SALIDA = "O";
    private static final int SCALE = 4;

    private KardexCalculator() {
    }

    private static final class Saldo {
        BigDecimal cantidad = BigDecimal.ZERO;
        BigDecimal valor = BigDecimal.ZERO;
        BigDecimal promedio = BigDecimal.ZERO;
    }

    /**
     * Recalcula saldos de las filas (ya ordenadas por fecha y codigo). Modifica las entidades in situ.
     *
     * @return saldos finales por almacen (cantidad y promedio) para actualizar ALMACEN_PRODUCTO
     */
    public static Map<String, BigDecimal[]> recalcular(List<Kardex> filas) {
        Saldo general = new Saldo();
        Map<String, Saldo> porAlmacen = new HashMap<>();
        for (Kardex k : filas) {
            Saldo alma = porAlmacen.computeIfAbsent(k.codiAlma == null ? "" : k.codiAlma, a -> new Saldo());
            if (INGRESO.equals(k.iO)) {
                BigDecimal cant = nz(k.cantIngr);
                BigDecimal valor = cant.multiply(nz(k.precUnit)).setScale(SCALE, RoundingMode.HALF_UP);
                k.cantSali = BigDecimal.ZERO;
                k.valoSali = BigDecimal.ZERO;
                k.valoSaliAlma = BigDecimal.ZERO;
                k.valoIngr = valor;
                k.valoIngrAlma = valor;
                aplicarIngreso(general, cant, valor);
                aplicarIngreso(alma, cant, valor);
            } else {
                BigDecimal cant = nz(k.cantSali);
                k.cantIngr = BigDecimal.ZERO;
                k.valoIngr = BigDecimal.ZERO;
                k.valoIngrAlma = BigDecimal.ZERO;
                // la salida se valoriza al promedio vigente (general y del almacen)
                k.precUnit = general.promedio;
                k.valoSali = aplicarSalida(general, cant);
                k.valoSaliAlma = aplicarSalida(alma, cant);
            }
            k.cantSaldo = general.cantidad;
            k.valoSaldo = general.valor;
            k.precProm = general.promedio;
            k.cantSaldoAlma = alma.cantidad;
            k.valoSaldoAlma = alma.valor;
            k.precPromAlma = alma.promedio;
        }
        Map<String, BigDecimal[]> out = new HashMap<>();
        porAlmacen.forEach((a, s) -> out.put(a, new BigDecimal[] { s.cantidad, s.promedio }));
        return out;
    }

    private static void aplicarIngreso(Saldo s, BigDecimal cant, BigDecimal valor) {
        s.cantidad = s.cantidad.add(cant);
        s.valor = s.valor.add(valor);
        if (s.cantidad.signum() > 0) {
            s.promedio = s.valor.divide(s.cantidad, SCALE, RoundingMode.HALF_UP);
        }
    }

    private static BigDecimal aplicarSalida(Saldo s, BigDecimal cant) {
        BigDecimal valor = cant.multiply(s.promedio).setScale(SCALE, RoundingMode.HALF_UP);
        s.cantidad = s.cantidad.subtract(cant);
        s.valor = s.cantidad.signum() == 0 ? BigDecimal.ZERO : s.valor.subtract(valor);
        return valor;
    }

    private static BigDecimal nz(BigDecimal v) {
        return v == null ? BigDecimal.ZERO : v;
    }
}
