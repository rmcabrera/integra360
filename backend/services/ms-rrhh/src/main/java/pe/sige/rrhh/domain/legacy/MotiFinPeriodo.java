package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.MOTI_FIN_PERIODO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "MotiFinPeriodo")
@Table(name = "moti_fin_periodo")
public class MotiFinPeriodo extends LegacyEntity {

    /** Legado: Codi_Moti_Fin_Peri */
    @Id
    @Column(name = "codi_moti_fin_peri", nullable = false)
    public Short codiMotiFinPeri;

    /** Legado: Codi_Moti_Fin_Peri_Sunat */
    @Column(name = "codi_moti_fin_peri_sunat", length = 2, nullable = false)
    public String codiMotiFinPeriSunat;

    /** Legado: Desc_Moti_Fin_Peri */
    @Column(name = "desc_moti_fin_peri", length = 100, nullable = false)
    public String descMotiFinPeri;
}
