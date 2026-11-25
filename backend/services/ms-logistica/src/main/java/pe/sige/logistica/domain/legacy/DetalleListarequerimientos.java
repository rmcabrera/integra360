package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DETALLE_LISTAREQUERIMIENTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DetalleListarequerimientos")
@Table(name = "detalle_listarequerimientos")
public class DetalleListarequerimientos extends LegacyEntity {

    /** Legado: CODI_DETA_LIST_REQU */
    @Id
    @Column(name = "codi_deta_list_requ", length = 10, nullable = false)
    public String codiDetaListRequ;

    /** Legado: CODI_LIST_REQU */
    @Column(name = "codi_list_requ", length = 8, nullable = false)
    public String codiListRequ;

    /** Legado: CODI_PROD */
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    /** Legado: CANTIDAD */
    @Column(name = "cantidad", precision = 10, scale = 4)
    public BigDecimal cantidad;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    /** Legado: STOC_ULTI */
    @Column(name = "stoc_ulti", precision = 15, scale = 4)
    public BigDecimal stocUlti;

    /** Legado: STOC_TEMP_ULTI */
    @Column(name = "stoc_temp_ulti", precision = 15, scale = 4)
    public BigDecimal stocTempUlti;

    /** Legado: ULTI_PREC */
    @Column(name = "ulti_prec", precision = 18, scale = 4)
    public BigDecimal ultiPrec;

    /** Legado: CODI_MONE_ULTI_PREC */
    @Column(name = "codi_mone_ulti_prec", length = 2)
    public String codiMoneUltiPrec;

    /** Legado: CUEN_COST */
    @Column(name = "cuen_cost", length = 7)
    public String cuenCost;

    /** Legado: FECH_ULTI_REQU */
    @Column(name = "fech_ulti_requ")
    public LocalDateTime fechUltiRequ;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;
}
