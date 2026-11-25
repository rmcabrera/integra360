package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ZARPES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Zarpes")
@Table(name = "zarpes")
public class Zarpes extends LegacyEntity {

    /** Legado: CODI_ZARP */
    @Id
    @Column(name = "codi_zarp", length = 10, nullable = false)
    public String codiZarp;

    /** Legado: FECH_REPO */
    @Column(name = "fech_repo")
    public LocalDateTime fechRepo;

    /** Legado: CODI_SEMA */
    @Column(name = "codi_sema", length = 8)
    public String codiSema;

    /** Legado: FECH_DESC */
    @Column(name = "fech_desc")
    public LocalDateTime fechDesc;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    /** Legado: CODI_PUER */
    @Column(name = "codi_puer", length = 2)
    public String codiPuer;

    /** Legado: ZONA_PESC */
    @Column(name = "zona_pesc", length = 75)
    public String zonaPesc;

    /** Legado: FECH_ZARP */
    @Column(name = "fech_zarp")
    public LocalDateTime fechZarp;

    /** Legado: FECH_ARRI */
    @Column(name = "fech_arri")
    public LocalDateTime fechArri;

    /** Legado: ZONA_ARRI */
    @Column(name = "zona_arri", length = 75)
    public String zonaArri;

    /** Legado: ZONA_PESC_ARRI */
    @Column(name = "zona_pesc_arri", length = 75)
    public String zonaPescArri;

    /** Legado: CODI_UNID_MEDI */
    @Column(name = "codi_unid_medi", length = 2)
    public String codiUnidMedi;

    /** Legado: PESC_ESTI */
    @Column(name = "pesc_esti", precision = 18, scale = 3)
    public BigDecimal pescEsti;

    /** Legado: PESC_REAL */
    @Column(name = "pesc_real", precision = 18, scale = 3)
    public BigDecimal pescReal;

    /** Legado: FECH_INIC_DESC */
    @Column(name = "fech_inic_desc")
    public LocalDateTime fechInicDesc;

    /** Legado: FECH_TERM_DESC */
    @Column(name = "fech_term_desc")
    public LocalDateTime fechTermDesc;

    /** Legado: OBSE_PESC */
    @Column(name = "obse_pesc", length = 150)
    public String obsePesc;

    /** Legado: CORD_CAPT */
    @Column(name = "cord_capt", length = 25)
    public String cordCapt;

    /** Legado: TEMP_CAPT */
    @Column(name = "temp_capt", length = 20)
    public String tempCapt;

    /** Legado: NUME_CALA */
    @Column(name = "nume_cala")
    public Integer numeCala;

    /** Legado: FECH_POSI_ARRI */
    @Column(name = "fech_posi_arri")
    public LocalDateTime fechPosiArri;

    /** Legado: CODI_PUER2 */
    @Column(name = "codi_puer2", length = 2)
    public String codiPuer2;

    /** Legado: COMB_RECI */
    @Column(name = "comb_reci")
    public Long combReci;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    /** Legado: CODI_PROV_PETR */
    @Column(name = "codi_prov_petr", length = 5)
    public String codiProvPetr;

    /** Legado: NRO_CGS */
    @Column(name = "nro_cgs", length = 10)
    public String nroCgs;

    /** Legado: FECH_SGS */
    @Column(name = "fech_sgs")
    public LocalDateTime fechSgs;

    /** Legado: DESC_SGS */
    @Column(name = "desc_sgs", precision = 18, scale = 3)
    public BigDecimal descSgs;

    /** Legado: LUGA_DESC */
    @Column(name = "luga_desc", length = 200)
    public String lugaDesc;

    /** Legado: OBSE_PESC2 */
    @Column(name = "obse_pesc2", length = 250)
    public String obsePesc2;

    /** Legado: OBSE_PESC3 */
    @Column(name = "obse_pesc3", length = 250)
    public String obsePesc3;

    /** Legado: LUGA_FOND */
    @Column(name = "luga_fond", length = 250)
    public String lugaFond;

    /** Legado: CODI_PATR */
    @Column(name = "codi_patr", length = 5)
    public String codiPatr;

    /** Legado: OROM_MP */
    @Column(name = "orom_mp", precision = 18, scale = 4)
    public BigDecimal oromMp;

    /** Legado: OROM_MA1 */
    @Column(name = "orom_ma1", precision = 18, scale = 4)
    public BigDecimal oromMa1;

    /** Legado: OROM_MA2 */
    @Column(name = "orom_ma2", precision = 18, scale = 4)
    public BigDecimal oromMa2;

    /** Legado: CODI_SITU */
    @Column(name = "codi_situ", length = 2)
    public String codiSitu;

    /** Legado: PESC_TOTA */
    @Column(name = "pesc_tota", precision = 18, scale = 3)
    public BigDecimal pescTota;

    /** Legado: CODI_SEMA_FACT */
    @Column(name = "codi_sema_fact", length = 8)
    public String codiSemaFact;

    @Column(name = "codi_sama_fact", length = 8)
    public String codiSamaFact;

    @Column(name = "refrigerada", length = 1)
    public String refrigerada;

    @Column(name = "conserva", length = 1)
    public String conserva;

    @Column(name = "fondeada")
    public Boolean fondeada;
}
