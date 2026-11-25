package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.JUICIOS_EMPRESA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "JuiciosEmpresa")
@Table(name = "juicios_empresa")
public class JuiciosEmpresa extends LegacyEntity {

    /** Legado: CODI_JUIC_EMPR */
    @Id
    @Column(name = "codi_juic_empr", length = 5, nullable = false)
    public String codiJuicEmpr;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: FECH_INIC */
    @Column(name = "fech_inic")
    public LocalDateTime fechInic;

    /** Legado: FECH_TERM */
    @Column(name = "fech_term")
    public LocalDateTime fechTerm;

    /** Legado: DESC_JUIC */
    @Column(name = "desc_juic", length = 100)
    public String descJuic;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: MONTO */
    @Column(name = "monto", precision = 12, scale = 2)
    public BigDecimal monto;

    /** Legado: JUZGADO */
    @Column(name = "juzgado", length = 100)
    public String juzgado;

    /** Legado: NOMB_JUEZ */
    @Column(name = "nomb_juez", length = 100)
    public String nombJuez;

    /** Legado: OBSERVACION */
    @Column(name = "observacion", length = 200)
    public String observacion;

    /** Legado: NRO_EXP */
    @Column(name = "nro_exp", length = 15)
    public String nroExp;

    /** Legado: Activo */
    @Column(name = "activo")
    public Boolean activo;
}
