package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.EMBARCACIONES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Embarcaciones")
@Table(name = "embarcaciones")
public class Embarcaciones extends LegacyEntity {

    /** Legado: CODI_UNID_OPER */
    @Id
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    /** Legado: DESC_UNID_OPER */
    @Column(name = "desc_unid_oper", length = 100)
    public String descUnidOper;

    /** Legado: CAPA_BODE */
    @Column(name = "capa_bode", precision = 12, scale = 3)
    public BigDecimal capaBode;

    /** Legado: CAPA_NETA */
    @Column(name = "capa_neta", precision = 12, scale = 3)
    public BigDecimal capaNeta;

    /** Legado: NRO_MATRI */
    @Column(name = "nro_matri", length = 15)
    public String nroMatri;

    /** Legado: LUGA_CONS */
    @Column(name = "luga_cons", length = 50)
    public String lugaCons;

    /** Legado: PORC_DIST */
    @Column(name = "porc_dist", precision = 12, scale = 3)
    public BigDecimal porcDist;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "codi_caja", length = 10)
    public String codiCaja;

    @Column(name = "grupo", length = 10)
    public String grupo;

    /** Legado: SUBSIDIO */
    @Column(name = "subsidio", precision = 18, scale = 2)
    public BigDecimal subsidio;

    /** Legado: ORDEN */
    @Column(name = "orden")
    public Short orden;

    @Column(name = "montoboni", precision = 12, scale = 3)
    public BigDecimal montoboni;

    /** Legado: PROP_TERC */
    @Column(name = "prop_terc", length = 1)
    public String propTerc;

    /** Legado: NEMO_EMBA */
    @Column(name = "nemo_emba", length = 10)
    public String nemoEmba;

    @Column(name = "detra", precision = 18, scale = 2)
    public BigDecimal detra;

    @Column(name = "fech_cese")
    public LocalDateTime fechCese;

    /** Legado: ARQU_BRUT */
    @Column(name = "arqu_brut", precision = 9, scale = 4)
    public BigDecimal arquBrut;

    /** Legado: ARQU_NETO */
    @Column(name = "arqu_neto", precision = 9, scale = 4)
    public BigDecimal arquNeto;

    @Column(name = "mate_casc", length = 50)
    public String mateCasc;

    @Column(name = "colo_casc", length = 50)
    public String coloCasc;

    @Column(name = "mate_supe_estr", length = 50)
    public String mateSupeEstr;

    @Column(name = "colo_supe_estr", length = 50)
    public String coloSupeEstr;

    @Column(name = "montopatron", precision = 18, scale = 3)
    public BigDecimal montopatron;

    @Column(name = "codi_mone_patron", length = 2)
    public String codiMonePatron;

    @Column(name = "monto_segundo", precision = 18, scale = 3)
    public BigDecimal montoSegundo;

    @Column(name = "codi_mone_segun", length = 2)
    public String codiMoneSegun;

    @Column(name = "aplica_segun", length = 1)
    public String aplicaSegun;

    /** Legado: Conserva */
    @Column(name = "conserva", precision = 12, scale = 3)
    public BigDecimal conserva;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "monto_adic", precision = 12, scale = 3)
    public BigDecimal montoAdic;

    @Column(name = "codi_mone_adic", length = 2)
    public String codiMoneAdic;

    @Column(name = "sunat_adic", precision = 12, scale = 3)
    public BigDecimal sunatAdic;

    /** Legado: ESLORA */
    @Column(name = "eslora")
    public Long eslora;

    /** Legado: MANGA */
    @Column(name = "manga")
    public Long manga;

    /** Legado: PUNTUAL */
    @Column(name = "puntual")
    public Long puntual;

    /** Legado: NRO_MAMP_ESTA_TRAN */
    @Column(name = "nro_mamp_esta_tran")
    public Short nroMampEstaTran;

    /** Legado: NRO_CUBI_BAJO_CUBI */
    @Column(name = "nro_cubi_bajo_cubi")
    public Short nroCubiBajoCubi;

    /** Legado: NRO_CUBI_SOBR_CUBI */
    @Column(name = "nro_cubi_sobr_cubi")
    public Short nroCubiSobrCubi;

    /** Legado: NRO_MAST */
    @Column(name = "nro_mast")
    public Short nroMast;

    /** Legado: NRO_BODE */
    @Column(name = "nro_bode")
    public Short nroBode;

    /** Legado: NRO_CUAD */
    @Column(name = "nro_cuad")
    public Short nroCuad;

    /** Legado: NRO_GRUA */
    @Column(name = "nro_grua")
    public Short nroGrua;

    /** Legado: FORM_POPA */
    @Column(name = "form_popa", length = 30)
    public String formPopa;

    /** Legado: FORM_PROA */
    @Column(name = "form_proa", length = 30)
    public String formProa;

    /** Legado: MARC_MOTO */
    @Column(name = "marc_moto", length = 30)
    public String marcMoto;

    /** Legado: MODE_MOTO */
    @Column(name = "mode_moto", length = 30)
    public String modeMoto;

    /** Legado: SERI_MOTO */
    @Column(name = "seri_moto", length = 30)
    public String seriMoto;

    /** Legado: POTE_MOTO */
    @Column(name = "pote_moto")
    public Long poteMoto;

    /** Legado: UNID_MEDI_POTE */
    @Column(name = "unid_medi_pote", length = 2)
    public String unidMediPote;

    /** Legado: TIPO_COMB */
    @Column(name = "tipo_comb", length = 30)
    public String tipoComb;

    /** Legado: NRO_TANQ_COMB */
    @Column(name = "nro_tanq_comb")
    public Short nroTanqComb;

    /** Legado: CAPA_TANQ_COMB */
    @Column(name = "capa_tanq_comb")
    public Long capaTanqComb;

    /** Legado: TIPO_AGUA */
    @Column(name = "tipo_agua", length = 30)
    public String tipoAgua;

    /** Legado: NRO_TANQ_AGUA */
    @Column(name = "nro_tanq_agua")
    public Short nroTanqAgua;

    /** Legado: CAPA_TANQ_AGUA */
    @Column(name = "capa_tanq_agua")
    public Long capaTanqAgua;

    /** Legado: NRO_MAMP_ESTA_LONG */
    @Column(name = "nro_mamp_esta_long")
    public Short nroMampEstaLong;
}
