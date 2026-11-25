package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.AUTO_TRAB_CENT_OPER</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AutoTrabCentOper")
@Table(name = "auto_trab_cent_oper")
public class AutoTrabCentOper extends LegacyEntity {

    /** Legado: CODI_AUTO_TRAB_CO */
    @Id
    @Column(name = "codi_auto_trab_co", length = 5, nullable = false)
    public String codiAutoTrabCo;

    /** Legado: NRO_AUTO */
    @Column(name = "nro_auto", nullable = false)
    public Integer nroAuto;

    /** Legado: FECHA */
    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Legado: UNID_OPER_SOLI */
    @Column(name = "unid_oper_soli", length = 5)
    public String unidOperSoli;

    /** Legado: UNID_OPER_CO */
    @Column(name = "unid_oper_co", length = 5)
    public String unidOperCo;

    /** Legado: CODI_PUER_OPER */
    @Column(name = "codi_puer_oper", length = 2)
    public String codiPuerOper;

    /** Legado: LUGAR */
    @Column(name = "lugar", length = 250)
    public String lugar;

    /** Legado: CODI_USUA_SOLI */
    @Column(name = "codi_usua_soli", length = 5)
    public String codiUsuaSoli;

    /** Legado: CODI_USUA_JEFE_TALL */
    @Column(name = "codi_usua_jefe_tall", length = 5)
    public String codiUsuaJefeTall;

    /** Legado: CODI_USUA_AUTO_MANT */
    @Column(name = "codi_usua_auto_mant", length = 5)
    public String codiUsuaAutoMant;

    /** Legado: CODI_USUA_AUTO_FLOT */
    @Column(name = "codi_usua_auto_flot", length = 5)
    public String codiUsuaAutoFlot;

    /** Legado: DESC_GENE_TRAB */
    @Column(name = "desc_gene_trab", length = 250)
    public String descGeneTrab;

    /** Legado: DESC_GENE_TRAB_1 */
    @Column(name = "desc_gene_trab_1", length = 250)
    public String descGeneTrab1;
}
