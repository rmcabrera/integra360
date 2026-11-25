package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.MOTI_BAJA_DH</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "MotiBajaDh")
@Table(name = "moti_baja_dh")
public class MotiBajaDh extends LegacyEntity {

    /** Legado: Codi_Moti_Baja_DH */
    @Id
    @Column(name = "codi_moti_baja_dh", nullable = false)
    public Short codiMotiBajaDh;

    /** Legado: Codi_Moti_Baja_DH_Sunat */
    @Column(name = "codi_moti_baja_dh_sunat", nullable = false)
    public Short codiMotiBajaDhSunat;

    /** Legado: Desc_Moti_Baja_DH */
    @Column(name = "desc_moti_baja_dh", length = 100, nullable = false)
    public String descMotiBajaDh;
}
