package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.m_LINEA_CLASE_C</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "MLineaClaseC")
@Table(name = "m_linea_clase_c")
public class MLineaClaseC extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ide", nullable = false)
    public Integer ide;

    /** Legado: CODI_LCC */
    @Column(name = "codi_lcc", length = 5)
    public String codiLcc;

    /** Legado: DESC_LCC */
    @Column(name = "desc_lcc", length = 100, nullable = false)
    public String descLcc;

    /** Legado: CODI_SUBC */
    @Column(name = "codi_subc", length = 3, nullable = false)
    public String codiSubc;

    /** Legado: TD */
    @Column(name = "td", precision = 18, scale = 2)
    public BigDecimal td;
}
