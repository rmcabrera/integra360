package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Planilla_Boni_tripu</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PlanillaBoniTripu")
@Table(name = "planilla_boni_tripu")
public class PlanillaBoniTripu extends LegacyEntity {

    /** Legado: CODI_PLAN_BTRI */
    @Id
    @Column(name = "codi_plan_btri", length = 10, nullable = false)
    public String codiPlanBtri;

    /** Legado: CODI_SEMA */
    @Column(name = "codi_sema", length = 8, nullable = false)
    public String codiSema;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: CODI_TIPO_PLAN */
    @Column(name = "codi_tipo_plan", length = 2, nullable = false)
    public String codiTipoPlan;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: IMPORTE */
    @Column(name = "importe", precision = 10, scale = 2)
    public BigDecimal importe;

    /** Legado: FORM_PAGO */
    @Column(name = "form_pago", length = 20)
    public String formPago;

    /** Legado: NRO_CHEQUE */
    @Column(name = "nro_cheque", length = 30)
    public String nroCheque;

    /** Legado: FECH_PAGO */
    @Column(name = "fech_pago")
    public LocalDateTime fechPago;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    /** Legado: IMPORTE_ESPECIAL */
    @Column(name = "importe_especial", precision = 12, scale = 3)
    public BigDecimal importeEspecial;

    @Column(name = "nro_asis", length = 1)
    public String nroAsis;

    /** Legado: MESANIO */
    @Column(name = "mesanio", length = 6)
    public String mesanio;
}
