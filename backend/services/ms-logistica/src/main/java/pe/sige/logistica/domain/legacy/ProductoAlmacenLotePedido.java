package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PRODUCTO_ALMACEN_LOTE_PEDIDO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ProductoAlmacenLotePedido")
@Table(name = "producto_almacen_lote_pedido")
public class ProductoAlmacenLotePedido extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    @Column(name = "codi_prod_alma_lote", nullable = false)
    public Long codiProdAlmaLote;

    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    @Column(name = "lote", length = 30, nullable = false)
    public String lote;

    @Column(name = "fec_vence")
    public LocalDateTime fecVence;

    @Column(name = "stock", precision = 18, scale = 2)
    public BigDecimal stock;

    @Column(name = "ubicacion", length = 50)
    public String ubicacion;

    @Column(name = "condicion", length = 1)
    public String condicion;

    @Column(name = "situacion")
    public Integer situacion;

    @Column(name = "codi_orden_pedi")
    public Integer codiOrdenPedi;

    @Column(name = "canti_salida_venta", precision = 18, scale = 2)
    public BigDecimal cantiSalidaVenta;
}
