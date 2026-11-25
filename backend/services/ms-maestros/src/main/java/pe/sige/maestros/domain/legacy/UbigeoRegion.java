package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.UBIGEO_REGION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "UbigeoRegion")
@Table(name = "ubigeo_region")
public class UbigeoRegion extends LegacyEntity {

    /** Legado: Codi_Ubi_Reg */
    @Id
    @Column(name = "codi_ubi_reg", nullable = false)
    public Short codiUbiReg;

    /** Legado: Codi_Ubi_Reg_Sunat */
    @Column(name = "codi_ubi_reg_sunat", length = 2, nullable = false)
    public String codiUbiRegSunat;

    /** Legado: Desc_Ubi_Reg */
    @Column(name = "desc_ubi_reg", length = 100, nullable = false)
    public String descUbiReg;
}
