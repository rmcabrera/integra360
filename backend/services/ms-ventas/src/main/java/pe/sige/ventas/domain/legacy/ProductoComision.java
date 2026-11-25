package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Producto_Comision</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ProductoComision")
@Table(name = "producto_comision")
public class ProductoComision extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_comi_prod", nullable = false)
    public Long idComiProd;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "desc_prod", length = 200)
    public String descProd;

    @Column(name = "comision", precision = 18, scale = 2)
    public BigDecimal comision;

    @Column(name = "inicio", precision = 18, scale = 2)
    public BigDecimal inicio;

    @Column(name = "fin", precision = 18, scale = 2)
    public BigDecimal fin;

    @Column(name = "codi_depen", length = 8)
    public String codiDepen;
}
