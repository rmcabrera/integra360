package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.FAMILIA_PRODUCTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "FamiliaProducto")
@Table(name = "familia_producto")
public class FamiliaProducto extends LegacyEntity {

    /** Legado: CODI_FAMI_PROD */
    @Id
    @Column(name = "codi_fami_prod", length = 2, nullable = false)
    public String codiFamiProd;

    /** Legado: DESC_FAMI_PROD */
    @Column(name = "desc_fami_prod", length = 100)
    public String descFamiProd;

    /** Legado: PROD_SERV */
    @Column(name = "prod_serv", length = 1)
    public String prodServ;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    @Column(name = "cod_lin_pro", length = 2)
    public String codLinPro;
}
