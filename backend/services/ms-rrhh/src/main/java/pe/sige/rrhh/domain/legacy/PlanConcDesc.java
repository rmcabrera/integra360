package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PLAN_CONC_DESC</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PlanConcDesc")
@Table(name = "plan_conc_desc")
public class PlanConcDesc extends LegacyEntity {

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

    /** Legado: CODI_DESC */
    @Column(name = "codi_desc", length = 10, nullable = false)
    public String codiDesc;

    /** Legado: NRO_PAGO */
    @Column(name = "nro_pago")
    public Integer nroPago;

    /** Legado: CODI_TIPO_TRAB */
    @Column(name = "codi_tipo_trab", length = 2, nullable = false)
    public String codiTipoTrab;

    /** Legado: INDI_TIPO_DESC */
    @Column(name = "indi_tipo_desc", length = 2, nullable = false)
    public String indiTipoDesc;

    /** Legado: VALOR */
    @Column(name = "valor", precision = 12, scale = 2, nullable = false)
    public BigDecimal valor;

    /** Legado: INDI_TIEM_DESC */
    @Column(name = "indi_tiem_desc", length = 10)
    public String indiTiemDesc;
}
