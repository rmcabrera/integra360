package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.m_CUENTAS_CONTABLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "MCuentasContable")
@Table(name = "m_cuentas_contable")
public class MCuentasContable extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ide", nullable = false)
    public Integer ide;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    /** Legado: DESC_CUEN */
    @Column(name = "desc_cuen", length = 100)
    public String descCuen;

    /** Legado: NRO_SUB_CUEN */
    @Column(name = "nro_sub_cuen", length = 7)
    public String nroSubCuen;

    /** Legado: CODI_LCC */
    @Column(name = "codi_lcc", length = 5, nullable = false)
    public String codiLcc;

    /** Legado: CTA_6 */
    @Column(name = "cta_6", length = 7)
    public String cta6;

    /** Legado: TIPO_CUEN */
    @Column(name = "tipo_cuen", length = 1)
    public String tipoCuen;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 10)
    public String codiMone;

    /** Legado: NRO_CTA_CTE_BANC */
    @Column(name = "nro_cta_cte_banc", length = 30)
    public String nroCtaCteBanc;

    /** Legado: CODI_BANC */
    @Column(name = "codi_banc", length = 2)
    public String codiBanc;

    /** Legado: CODI_TIPO_CUEN_BANC */
    @Column(name = "codi_tipo_cuen_banc", length = 2)
    public String codiTipoCuenBanc;

    /** Legado: PORC_DETR */
    @Column(name = "porc_detr", precision = 15, scale = 4)
    public BigDecimal porcDetr;

    /** Legado: TRANSFER */
    @Column(name = "transfer", length = 1)
    public String transfer;

    /** Legado: CTA_CIERRE */
    @Column(name = "cta_cierre", length = 7)
    public String ctaCierre;

    /** Legado: TIPO_COSTO */
    @Column(name = "tipo_costo", length = 1)
    public String tipoCosto;
}
