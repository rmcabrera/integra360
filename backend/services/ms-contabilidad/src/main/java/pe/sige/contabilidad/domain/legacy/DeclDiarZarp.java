package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DECL_DIAR_ZARP</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DeclDiarZarp")
@Table(name = "decl_diar_zarp")
public class DeclDiarZarp extends LegacyEntity {

    /** Legado: CODI_DECL_DIAR_ZARP */
    @Id
    @Column(name = "codi_decl_diar_zarp", length = 10, nullable = false)
    public String codiDeclDiarZarp;

    /** Legado: NUME_DECL */
    @Column(name = "nume_decl", length = 10)
    public String numeDecl;

    /** Legado: FECHA */
    @Column(name = "fecha", nullable = false)
    public LocalDateTime fecha;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    /** Legado: NRO_MATRI */
    @Column(name = "nro_matri", length = 15)
    public String nroMatri;

    /** Legado: ARQU_BRUT */
    @Column(name = "arqu_brut", precision = 9, scale = 4)
    public BigDecimal arquBrut;

    /** Legado: CODI_PUER_CAPI */
    @Column(name = "codi_puer_capi", length = 2)
    public String codiPuerCapi;

    /** Legado: ZONA_PESC */
    @Column(name = "zona_pesc", length = 100)
    public String zonaPesc;

    /** Legado: TIEM_OPER */
    @Column(name = "tiem_oper", length = 100)
    public String tiemOper;

    /** Legado: FECH_ESTI_ARRI */
    @Column(name = "fech_esti_arri")
    public LocalDateTime fechEstiArri;

    /** Legado: CODI_USUA_REPR */
    @Column(name = "codi_usua_repr", length = 5)
    public String codiUsuaRepr;

    /** Legado: FECH_VENC_MATR */
    @Column(name = "fech_venc_matr")
    public LocalDateTime fechVencMatr;

    /** Legado: FECH_VENC_LMC */
    @Column(name = "fech_venc_lmc")
    public LocalDateTime fechVencLmc;

    /** Legado: FECH_VENC_COMP_COMP */
    @Column(name = "fech_venc_comp_comp")
    public LocalDateTime fechVencCompComp;

    /** Legado: FECH_VENC_RADI_BALI */
    @Column(name = "fech_venc_radi_bali")
    public LocalDateTime fechVencRadiBali;

    /** Legado: FECH_VENC_SEGU */
    @Column(name = "fech_venc_segu")
    public LocalDateTime fechVencSegu;

    /** Legado: FECH_VENC_HIDR_CARB */
    @Column(name = "fech_venc_hidr_carb")
    public LocalDateTime fechVencHidrCarb;

    /** Legado: FECH_VENC_AGUA_SUCI */
    @Column(name = "fech_venc_agua_suci")
    public LocalDateTime fechVencAguaSuci;

    /** Legado: CODI_PATR */
    @Column(name = "codi_patr", length = 5)
    public String codiPatr;
}
