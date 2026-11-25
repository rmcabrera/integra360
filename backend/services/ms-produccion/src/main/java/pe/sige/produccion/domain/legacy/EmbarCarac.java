package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.EMBAR_CARAC</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "EmbarCarac")
@Table(name = "embar_carac")
public class EmbarCarac extends LegacyEntity {

    /** Legado: CODI_UNID_OPER */
    @Id
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    @Column(name = "eslora", precision = 12, scale = 3)
    public BigDecimal eslora;

    @Column(name = "manga", precision = 12, scale = 3)
    public BigDecimal manga;

    @Column(name = "puntual", precision = 12, scale = 3)
    public BigDecimal puntual;

    @Column(name = "nro_mamp_esta_tran")
    public Short nroMampEstaTran;

    @Column(name = "nro_mamp_esta_long")
    public Short nroMampEstaLong;

    @Column(name = "nro_cubi_bajo_cubi")
    public Short nroCubiBajoCubi;

    @Column(name = "nro_cubi_sobr_cubi")
    public Short nroCubiSobrCubi;

    @Column(name = "nro_mast")
    public Short nroMast;

    @Column(name = "nro_bode")
    public Short nroBode;

    @Column(name = "nro_cuad")
    public Short nroCuad;

    @Column(name = "nro_grua")
    public Short nroGrua;

    @Column(name = "form_popa", length = 30)
    public String formPopa;

    @Column(name = "form_proa", length = 30)
    public String formProa;

    @Column(name = "marc_moto", length = 30)
    public String marcMoto;

    @Column(name = "mode_moto", length = 30)
    public String modeMoto;

    @Column(name = "seri_moto", length = 30)
    public String seriMoto;

    @Column(name = "pote_moto", precision = 12, scale = 3)
    public BigDecimal poteMoto;

    @Column(name = "unid_medi_pote", length = 2)
    public String unidMediPote;

    @Column(name = "tipo_comb", length = 30)
    public String tipoComb;

    @Column(name = "nro_tanq_comb")
    public Short nroTanqComb;

    @Column(name = "capa_tanq_comb", precision = 12, scale = 3)
    public BigDecimal capaTanqComb;

    @Column(name = "tipo_agua", length = 30)
    public String tipoAgua;

    @Column(name = "nro_tanq_agua")
    public Short nroTanqAgua;

    @Column(name = "capa_tanq_agua", precision = 12, scale = 3)
    public BigDecimal capaTanqAgua;
}
