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
 * Tabla legado <b>dbo.PRODUCTO_ALMACEN_LOTE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ProductoAlmacenLote")
@Table(name = "producto_almacen_lote")
public class ProductoAlmacenLote extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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

    @Column(name = "fech_vence_real")
    public LocalDateTime fechVenceReal;

    @Column(name = "p_arreglo", length = 255)
    public String pArreglo;

    @Column(name = "s_arreglo", length = 255)
    public String sArreglo;

    @Column(name = "iden", length = 50)
    public String iden;

    @Column(name = "codi_orde_comp", length = 10)
    public String codiOrdeComp;

    @Column(name = "correlativo")
    public Integer correlativo;

    @Column(name = "canti_salida_venta", precision = 18, scale = 2)
    public BigDecimal cantiSalidaVenta;

    @Column(name = "fec_ingreso")
    public LocalDateTime fecIngreso;
}
