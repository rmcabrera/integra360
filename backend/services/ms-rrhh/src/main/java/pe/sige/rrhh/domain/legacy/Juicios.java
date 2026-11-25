package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.JUICIOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Juicios")
@Table(name = "juicios")
public class Juicios extends LegacyEntity {

    /** Legado: CODI_JUIC */
    @Id
    @Column(name = "codi_juic", length = 6, nullable = false)
    public String codiJuic;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: NRO_JUIC */
    @Column(name = "nro_juic", nullable = false)
    public Integer nroJuic;

    /** Legado: FECH_JUIC */
    @Column(name = "fech_juic", nullable = false)
    public LocalDateTime fechJuic;

    /** Legado: MOTI_JUIC */
    @Column(name = "moti_juic", length = 100)
    public String motiJuic;

    /** Legado: ESTA_ACTI */
    @Column(name = "esta_acti", nullable = false)
    public Boolean estaActi;

    /** Legado: TIPO_DESC */
    @Column(name = "tipo_desc", nullable = false)
    public Boolean tipoDesc;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2, nullable = false)
    public String codiMone;

    /** Legado: MONT_DESC */
    @Column(name = "mont_desc", precision = 12, scale = 2, nullable = false)
    public BigDecimal montDesc;

    /** Legado: INTE_TIEM_DESC */
    @Column(name = "inte_tiem_desc", length = 20)
    public String inteTiemDesc;

    /** Legado: APLI_TODA_REMU */
    @Column(name = "apli_toda_remu")
    public Boolean apliTodaRemu;

    /** Legado: PERS_BENE_JUIC */
    @Column(name = "pers_bene_juic", length = 200)
    public String persBeneJuic;

    /** Legado: DNI_PERS_BENE */
    @Column(name = "dni_pers_bene", length = 10)
    public String dniPersBene;

    /** Legado: NRO_RESO_JUDI */
    @Column(name = "nro_reso_judi", length = 50)
    public String nroResoJudi;

    /** Legado: JUZGADO */
    @Column(name = "juzgado", length = 200)
    public String juzgado;

    /** Legado: APLI_TOPE */
    @Column(name = "apli_tope")
    public Boolean apliTope;

    /** Legado: TOPE */
    @Column(name = "tope", precision = 15, scale = 4)
    public BigDecimal tope;

    /** Legado: SALDO */
    @Column(name = "saldo", precision = 15, scale = 4)
    public BigDecimal saldo;

    @Column(name = "codi_banc", length = 2)
    public String codiBanc;

    @Column(name = "nro_cta_cte_bene", length = 20)
    public String nroCtaCteBene;

    @Column(name = "codi_mone_cta_cte_bene", length = 2)
    public String codiMoneCtaCteBene;
}
