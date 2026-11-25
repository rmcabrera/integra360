package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.LINEA_CLASE_C</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "LineaClaseC")
@Table(name = "linea_clase_c")
public class LineaClaseC extends LegacyEntity {

    /** Legado: CODI_LCC */
    @Id
    @Column(name = "codi_lcc", length = 5, nullable = false)
    public String codiLcc;

    /** Legado: DESC_LCC */
    @Column(name = "desc_lcc", length = 100, nullable = false)
    public String descLcc;

    /** Legado: TD */
    @Column(name = "td", precision = 18, scale = 2)
    public BigDecimal td;

    @Column(name = "codi_subc_4", length = 4)
    public String codiSubc4;
}
