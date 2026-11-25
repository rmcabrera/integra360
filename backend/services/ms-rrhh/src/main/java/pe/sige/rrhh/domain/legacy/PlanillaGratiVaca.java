package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PLANILLA_GRATI_VACA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PlanillaGratiVaca")
@Table(name = "planilla_grati_vaca")
public class PlanillaGratiVaca extends LegacyEntity {

    /** Legado: CODI_PLAN_GRVA */
    @Id
    @Column(name = "codi_plan_grva", length = 10, nullable = false)
    public String codiPlanGrva;

    /** Legado: CODI_SEMA */
    @Column(name = "codi_sema", length = 8)
    public String codiSema;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5)
    public String codiPers;

    /** Legado: CODI_TIPO_PLAN */
    @Column(name = "codi_tipo_plan", length = 2)
    public String codiTipoPlan;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: IMPORTE */
    @Column(name = "importe", precision = 18, scale = 2)
    public BigDecimal importe;

    /** Legado: FORM_PAGO */
    @Column(name = "form_pago", length = 20)
    public String formPago;

    /** Legado: NRO_CHEQ */
    @Column(name = "nro_cheq", length = 30)
    public String nroCheq;

    /** Legado: FECH_PAGO */
    @Column(name = "fech_pago")
    public LocalDateTime fechPago;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    /** Legado: NRO_ASIS */
    @Column(name = "nro_asis", length = 1)
    public String nroAsis;

    /** Legado: MESANIO */
    @Column(name = "mesanio", length = 6)
    public String mesanio;
}
