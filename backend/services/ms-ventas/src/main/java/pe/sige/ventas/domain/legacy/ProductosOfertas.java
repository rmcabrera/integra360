package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PRODUCTOS_OFERTAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ProductosOfertas")
@Table(name = "productos_ofertas")
public class ProductosOfertas extends LegacyEntity {

    @Id
    @Column(name = "item", nullable = false)
    public Long item;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "cantidad", precision = 18, scale = 2)
    public BigDecimal cantidad;

    @Column(name = "precio", precision = 18, scale = 4)
    public BigDecimal precio;

    @Column(name = "fecha_ini")
    public LocalDateTime fechaIni;

    @Column(name = "fecha_fin")
    public LocalDateTime fechaFin;

    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: CODI_ALMA */
    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "usado", precision = 12, scale = 4)
    public BigDecimal usado;

    @Column(name = "precio_costo", precision = 12, scale = 4)
    public BigDecimal precioCosto;
}
