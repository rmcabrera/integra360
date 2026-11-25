package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.BAZAR</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Bazar")
@Table(name = "bazar")
public class Bazar extends LegacyEntity {

    /** Legado: CODI_BAZA */
    @Id
    @Column(name = "codi_baza", length = 2, nullable = false)
    public String codiBaza;

    /** Legado: NOMB_BAZA */
    @Column(name = "nomb_baza", length = 100)
    public String nombBaza;

    /** Legado: MONT_INTE */
    @Column(name = "mont_inte", precision = 12, scale = 3)
    public BigDecimal montInte;

    /** Legado: TIPO_MONT */
    @Column(name = "tipo_mont")
    public Long tipoMont;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    /** Legado: OBSERVACION */
    @Column(name = "observacion", length = 200)
    public String observacion;

    /** Legado: CODI_CONC */
    @Column(name = "codi_conc", length = 6)
    public String codiConc;
}
