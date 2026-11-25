package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PLANILLA_DE_EMPLEADOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PlanillaDeEmpleados")
@Table(name = "planilla_de_empleados")
public class PlanillaDeEmpleados extends LegacyEntity {

    /** Legado: CODI_PLAN_EMPL */
    @Id
    @Column(name = "codi_plan_empl", length = 10, nullable = false)
    public String codiPlanEmpl;

    /** Legado: ANIO */
    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    /** Legado: MES */
    @Column(name = "mes", length = 2, nullable = false)
    public String mes;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: CODI_TIPO_PLAN */
    @Column(name = "codi_tipo_plan", length = 2)
    public String codiTipoPlan;

    /** Legado: FECH_INIC */
    @Column(name = "fech_inic")
    public LocalDateTime fechInic;

    /** Legado: FECH_TERM */
    @Column(name = "fech_term")
    public LocalDateTime fechTerm;

    /** Legado: IMPORTE */
    @Column(name = "importe", precision = 10, scale = 2)
    public BigDecimal importe;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: INDI_TIEM */
    @Column(name = "indi_tiem", length = 5, nullable = false)
    public String indiTiem;

    /** Legado: FORM_PAGO */
    @Column(name = "form_pago", length = 20)
    public String formPago;

    /** Legado: NRO_CHEQ */
    @Column(name = "nro_cheq", length = 30)
    public String nroCheq;

    /** Legado: FECH_PAGO */
    @Column(name = "fech_pago")
    public LocalDateTime fechPago;

    /** Legado: CODI_SIST_PENS */
    @Column(name = "codi_sist_pens", length = 2)
    public String codiSistPens;

    /** Legado: CODI_TIPO_PERS */
    @Column(name = "codi_tipo_pers", length = 2)
    public String codiTipoPers;

    @Column(name = "semana")
    public Short semana;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;
}
