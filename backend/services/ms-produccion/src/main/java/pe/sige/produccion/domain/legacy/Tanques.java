package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TANQUES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Tanques")
@Table(name = "tanques")
public class Tanques extends LegacyEntity {

    /** Legado: CODI_TANQ */
    @Id
    @Column(name = "codi_tanq", length = 2, nullable = false)
    public String codiTanq;

    /** Legado: DESC_TANQ */
    @Column(name = "desc_tanq", length = 50, nullable = false)
    public String descTanq;

    /** Legado: STOC_TANQ */
    @Column(name = "stoc_tanq", precision = 12, scale = 3)
    public BigDecimal stocTanq;

    /** Legado: CAPA_TANQ */
    @Column(name = "capa_tanq", precision = 12, scale = 3)
    public BigDecimal capaTanq;
}
