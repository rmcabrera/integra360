package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.COEF_LIQU_IMP</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CoefLiquImp")
@Table(name = "coef_liqu_imp")
public class CoefLiquImp extends LegacyEntity {

    @Id
    @Column(name = "aniomes", length = 6, nullable = false)
    public String aniomes;

    @Column(name = "valor_renta", precision = 18, scale = 4)
    public BigDecimal valorRenta;

    /** Legado: Fech_Venc */
    @Column(name = "fech_venc")
    public LocalDateTime fechVenc;

    @Column(name = "cfa", precision = 18, scale = 2)
    public BigDecimal cfa;

    @Column(name = "otros_ma", precision = 18, scale = 2)
    public BigDecimal otrosMa;

    @Column(name = "cerrado", nullable = false)
    public Boolean cerrado;

    /** Legado: IGV_5_Ant */
    @Column(name = "igv_5_ant", precision = 18, scale = 2)
    public BigDecimal igv5Ant;

    /** Legado: IGV_5_Act */
    @Column(name = "igv_5_act", precision = 18, scale = 2)
    public BigDecimal igv5Act;

    /** Legado: IGV_Favor_Ant */
    @Column(name = "igv_favor_ant", precision = 18, scale = 2)
    public BigDecimal igvFavorAnt;

    /** Legado: Perc_Act */
    @Column(name = "perc_act", precision = 18, scale = 2)
    public BigDecimal percAct;

    /** Legado: Perc_Ant */
    @Column(name = "perc_ant")
    public Long percAnt;

    /** Legado: Rete_Act */
    @Column(name = "rete_act", precision = 18, scale = 2)
    public BigDecimal reteAct;

    /** Legado: Rete_Ant */
    @Column(name = "rete_ant", precision = 18, scale = 2)
    public BigDecimal reteAnt;

    /** Legado: Factor_R3C */
    @Column(name = "factor_r3c", precision = 18, scale = 4)
    public BigDecimal factorR3c;

    /** Legado: Saldo_R3C_ant */
    @Column(name = "saldo_r3c_ant", precision = 18, scale = 2)
    public BigDecimal saldoR3cAnt;

    /** Legado: ITAN */
    @Column(name = "itan", precision = 18, scale = 2)
    public BigDecimal itan;

    @Column(name = "bonifi", precision = 12, scale = 2)
    public BigDecimal bonifi;

    @Column(name = "cofigv", precision = 12, scale = 6)
    public BigDecimal cofigv;

    @Column(name = "porc", precision = 12, scale = 6)
    public BigDecimal porc;

    @Column(name = "cfn", precision = 12, scale = 2)
    public BigDecimal cfn;
}
