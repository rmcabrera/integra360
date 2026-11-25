package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PLANILLA_SUBSIDIO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PlanillaSubsidio")
@Table(name = "planilla_subsidio")
public class PlanillaSubsidio extends LegacyEntity {

    @Id
    @Column(name = "codi_plan_subs", length = 10, nullable = false)
    public String codiPlanSubs;

    @Column(name = "mesanio", length = 6, nullable = false)
    public String mesanio;

    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    @Column(name = "importe", precision = 12, scale = 2)
    public BigDecimal importe;

    @Column(name = "fech_pago")
    public LocalDateTime fechPago;

    @Column(name = "form_pago", length = 15)
    public String formPago;

    @Column(name = "nro_cheque", length = 15)
    public String nroCheque;

    /** Legado: Tipo */
    @Column(name = "tipo", length = 1)
    public String tipo;

    /** Legado: CODI_SEMA */
    @Column(name = "codi_sema", length = 8)
    public String codiSema;
}
