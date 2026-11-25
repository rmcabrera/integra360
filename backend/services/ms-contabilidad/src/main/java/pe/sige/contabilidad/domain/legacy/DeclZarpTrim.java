package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DECL_ZARP_TRIM</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DeclZarpTrim")
@Table(name = "decl_zarp_trim")
public class DeclZarpTrim extends LegacyEntity {

    /** Legado: CODI_ZARP_TRIM */
    @Id
    @Column(name = "codi_zarp_trim", length = 10, nullable = false)
    public String codiZarpTrim;

    /** Legado: NUME_ZARP */
    @Column(name = "nume_zarp", length = 10)
    public String numeZarp;

    /** Legado: FECHA */
    @Column(name = "fecha", nullable = false)
    public LocalDateTime fecha;

    /** Legado: FECH_INIC_VIGE */
    @Column(name = "fech_inic_vige")
    public LocalDateTime fechInicVige;

    /** Legado: FECH_FIN_VIGE */
    @Column(name = "fech_fin_vige")
    public LocalDateTime fechFinVige;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    /** Legado: NRO_MATRI */
    @Column(name = "nro_matri", length = 15)
    public String nroMatri;

    /** Legado: ARQU_BRUT */
    @Column(name = "arqu_brut", precision = 9, scale = 4)
    public BigDecimal arquBrut;

    /** Legado: ARQU_NETO */
    @Column(name = "arqu_neto", precision = 9, scale = 4)
    public BigDecimal arquNeto;

    /** Legado: CODI_PUER_CAPI */
    @Column(name = "codi_puer_capi", length = 2)
    public String codiPuerCapi;

    /** Legado: CODI_USUA_REPR */
    @Column(name = "codi_usua_repr", length = 5)
    public String codiUsuaRepr;

    /** Legado: NRO_TRIP */
    @Column(name = "nro_trip")
    public Integer nroTrip;

    /** Legado: FECH_VENC_MATR */
    @Column(name = "fech_venc_matr")
    public LocalDateTime fechVencMatr;

    /** Legado: FECH_VENC_ARQU */
    @Column(name = "fech_venc_arqu")
    public LocalDateTime fechVencArqu;

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

    /** Legado: COLO_CASC */
    @Column(name = "colo_casc", length = 50)
    public String coloCasc;

    /** Legado: COLO_SUPE_ESTR */
    @Column(name = "colo_supe_estr", length = 50)
    public String coloSupeEstr;
}
