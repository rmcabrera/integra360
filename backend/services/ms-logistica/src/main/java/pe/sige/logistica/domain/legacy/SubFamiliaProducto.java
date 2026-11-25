package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SUB_FAMILIA_PRODUCTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SubFamiliaProducto")
@Table(name = "sub_familia_producto")
public class SubFamiliaProducto extends LegacyEntity {

    /** Legado: CODI_SUB_FAMI_PROD */
    @Id
    @Column(name = "codi_sub_fami_prod", length = 4, nullable = false)
    public String codiSubFamiProd;

    /** Legado: DESC_SUB_FAMI_PROD */
    @Column(name = "desc_sub_fami_prod", length = 100)
    public String descSubFamiProd;

    /** Legado: CODI_FAMI_PROD */
    @Column(name = "codi_fami_prod", length = 2)
    public String codiFamiProd;

    /** Legado: POLI_PREC_ADIC */
    @Column(name = "poli_prec_adic", precision = 9, scale = 4)
    public BigDecimal poliPrecAdic;
}
