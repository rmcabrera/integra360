package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.VINCULO_FAMILIAR</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "VinculoFamiliar")
@Table(name = "vinculo_familiar")
public class VinculoFamiliar extends LegacyEntity {

    /** Legado: Codi_Vinc_Fami */
    @Id
    @Column(name = "codi_vinc_fami", nullable = false)
    public Short codiVincFami;

    /** Legado: Codi_Vinc_Fami_Sunat */
    @Column(name = "codi_vinc_fami_sunat", nullable = false)
    public Short codiVincFamiSunat;

    /** Legado: Desc_Vinc_Fami */
    @Column(name = "desc_vinc_fami", length = 50, nullable = false)
    public String descVincFami;
}
