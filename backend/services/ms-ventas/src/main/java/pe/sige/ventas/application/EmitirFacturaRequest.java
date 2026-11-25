package pe.sige.ventas.application;

import jakarta.validation.Valid;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

/**
 * Emision de comprobante de venta (factura/boleta). Reemplaza la secuencia de la ventana
 * w_siep_facturacion: SP_insert_FACTURA + SP_insert_FACTURA_DETALLE + trigger FD_ACTPROD.
 */
public record EmitirFacturaRequest(
        @NotBlank @Size(max = 2) String codiAlma,
        @NotBlank @Size(max = 4) String codiTipoDocu,
        @NotBlank @Size(max = 5) String serie,
        @NotBlank @Size(max = 5) String codiClieProv,
        @NotNull LocalDate fecha,
        LocalDate vencimiento,
        @NotBlank @Size(max = 2) String codiMone,
        @DecimalMin("0") BigDecimal tipoCambio,
        Integer codiTipoPago,
        boolean aplicaIgv,
        boolean preciosIncluyenIgv,
        @Size(max = 30) String ordenCompra,
        @Size(max = 5) String vendedor,
        @NotEmpty @Valid List<Item> items) {

    public record Item(
            @NotBlank @Size(max = 8) String codiProd,
            @Size(max = 300) String descripcion,
            @Size(max = 2) String codiUnidMedi,
            @NotNull @DecimalMin(value = "0", inclusive = false) BigDecimal cantidad,
            @NotNull @DecimalMin("0") BigDecimal precioUnitario,
            @DecimalMin("0") BigDecimal descuento,
            boolean oferta) {
    }
}
