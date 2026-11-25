package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PLAN_CONC_INCR</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PlanConcIncr")
@Table(name = "plan_conc_incr")
public class PlanConcIncr extends LegacyEntity {

    /** Legado: CODI_PRIN */
    @Id
    @Column(name = "codi_prin", length = 10, nullable = false)
    public String codiPrin;

    /** Legado: CODI_PLAN_CONC */
    @Column(name = "codi_plan_conc", length = 10, nullable = false)
    public String codiPlanConc;

    /** Legado: CODI_CONC */
    @Column(name = "codi_conc", length = 6, nullable = false)
    public String codiConc;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: NRO_INCRE */
    @Column(name = "nro_incre", nullable = false)
    public Integer nroIncre;

    /** Legado: CODI_TIPO_PERS */
    @Column(name = "codi_tipo_pers", length = 2, nullable = false)
    public String codiTipoPers;

    /** Legado: VALOR */
    @Column(name = "valor", precision = 12, scale = 2, nullable = false)
    public BigDecimal valor;
}
