package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.EXTRA_CONTA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ExtraConta")
@Table(name = "extra_conta")
public class ExtraConta extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    /** Legado: RUC */
    @Column(name = "ruc", length = 11)
    public String ruc;

    /** Legado: TM */
    @Column(name = "tm", precision = 18, scale = 3, nullable = false)
    public BigDecimal tm;

    /** Legado: PREC_TM */
    @Column(name = "prec_tm", precision = 18, scale = 2)
    public BigDecimal precTm;

    /** Legado: COMB */
    @Column(name = "comb")
    public Long comb;

    /** Legado: PRE_COMB */
    @Column(name = "pre_comb", precision = 18, scale = 4)
    public BigDecimal preComb;

    /** Legado: FDO_RETE */
    @Column(name = "fdo_rete", precision = 18, scale = 2)
    public BigDecimal fdoRete;

    /** Legado: UP */
    @Column(name = "up", precision = 18, scale = 2)
    public BigDecimal up;
}
