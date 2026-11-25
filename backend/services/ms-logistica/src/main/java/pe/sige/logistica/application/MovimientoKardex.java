package pe.sige.logistica.application;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Movimiento de inventario (ingreso por nota de ingreso / salida por documento de salida o venta).
 *
 * @param io             "I" ingreso, "O" salida
 * @param codiDocuOrigen documento que origina el movimiento (nota de ingreso, salida, factura)
 */
public record MovimientoKardex(
        @NotBlank @Size(max = 8) String codiProd,
        @NotBlank @Size(max = 2) String codiAlma,
        @NotNull LocalDateTime fecha,
        @NotBlank @Pattern(regexp = "[IO]") String io,
        @NotNull @DecimalMin(value = "0", inclusive = false) BigDecimal cantidad,
        @DecimalMin("0") BigDecimal precioUnitario,
        @Size(max = 4) String codiTipoDocu,
        @Size(max = 5) String serie,
        @Size(max = 15) String numero,
        @NotBlank @Size(max = 10) String codiDocuOrigen,
        @Size(max = 12) String item,
        @Size(max = 2) String codiMone,
        BigDecimal tipoCambio,
        @Size(max = 250) String concepto) {
}
