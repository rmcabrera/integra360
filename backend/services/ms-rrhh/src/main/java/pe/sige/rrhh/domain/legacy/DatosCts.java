package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DATOS_CTS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DatosCts")
@Table(name = "datos_cts")
public class DatosCts extends LegacyEntity {

    /** Legado: CODI_PLAN_CTS */
    @Id
    @Column(name = "codi_plan_cts", length = 10, nullable = false)
    public String codiPlanCts;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: FECH_INIC */
    @Column(name = "fech_inic", nullable = false)
    public LocalDateTime fechInic;

    /** Legado: FECH_TERM */
    @Column(name = "fech_term", nullable = false)
    public LocalDateTime fechTerm;

    /** Legado: TIPO_PAGO */
    @Column(name = "tipo_pago", length = 50)
    public String tipoPago;

    /** Legado: DESC_TIPO_PAGO */
    @Column(name = "desc_tipo_pago", length = 50)
    public String descTipoPago;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: FECH_PAGO */
    @Column(name = "fech_pago")
    public LocalDateTime fechPago;

    /** Legado: CODI_TIPO_PLAN */
    @Column(name = "codi_tipo_plan", length = 2, nullable = false)
    public String codiTipoPlan;

    /** Legado: ANIO */
    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    /** Legado: MES */
    @Column(name = "mes", length = 2, nullable = false)
    public String mes;

    /** Legado: NRO_CHEQ_OPER */
    @Column(name = "nro_cheq_oper", length = 30)
    public String nroCheqOper;

    /** Legado: IMPORTE */
    @Column(name = "importe", precision = 12, scale = 2, nullable = false)
    public BigDecimal importe;

    /** Legado: IMPO_DOLA */
    @Column(name = "impo_dola", precision = 12, scale = 2, nullable = false)
    public BigDecimal impoDola;

    /** Legado: CODI_TIPO_PERS */
    @Column(name = "codi_tipo_pers", length = 2, nullable = false)
    public String codiTipoPers;

    /** Legado: TIPO_CAMB */
    @Column(name = "tipo_camb", precision = 9, scale = 4, nullable = false)
    public BigDecimal tipoCamb;

    /** Legado: ESTA_PAGO */
    @Column(name = "esta_pago", length = 1)
    public String estaPago;

    /** Legado: FECH_VENC */
    @Column(name = "fech_venc")
    public LocalDateTime fechVenc;

    /** Legado: MONT_INTE_DIAR */
    @Column(name = "mont_inte_diar", precision = 12, scale = 6)
    public BigDecimal montInteDiar;

    /** Legado: CODI_BANC */
    @Column(name = "codi_banc", length = 2)
    public String codiBanc;

    @Column(name = "tipo_cts", length = 1)
    public String tipoCts;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    @Column(name = "interes", precision = 12, scale = 2)
    public BigDecimal interes;
}
