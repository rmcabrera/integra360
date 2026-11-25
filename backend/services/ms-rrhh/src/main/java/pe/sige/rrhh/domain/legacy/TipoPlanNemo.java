package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_PLAN_NEMO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoPlanNemo")
@Table(name = "tipo_plan_nemo")
public class TipoPlanNemo extends LegacyEntity {

    /** Legado: CODI_NEMO_PLAN */
    @Id
    @Column(name = "codi_nemo_plan", length = 2, nullable = false)
    public String codiNemoPlan;

    /** Legado: NEMO_PLAN */
    @Column(name = "nemo_plan", length = 2)
    public String nemoPlan;

    /** Legado: DESC_NEMO_PLAN */
    @Column(name = "desc_nemo_plan", length = 100)
    public String descNemoPlan;

    /** Legado: CODI_TIPO_PLAN */
    @Column(name = "codi_tipo_plan", length = 2)
    public String codiTipoPlan;

    /** Legado: CODI_TIPO_PERS */
    @Column(name = "codi_tipo_pers", length = 2)
    public String codiTipoPers;
}
