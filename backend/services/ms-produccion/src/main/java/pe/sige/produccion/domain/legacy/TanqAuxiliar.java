package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TANQ_AUXILIAR</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TanqAuxiliar")
@Table(name = "tanq_auxiliar")
public class TanqAuxiliar extends LegacyEntity {

    /** Legado: CODI_TANQ_AUXI */
    @Id
    @Column(name = "codi_tanq_auxi", length = 3, nullable = false)
    public String codiTanqAuxi;

    /** Legado: DESC_TANQ_AUXI */
    @Column(name = "desc_tanq_auxi", length = 50, nullable = false)
    public String descTanqAuxi;

    /** Legado: STOC_TANQ_AUXI */
    @Column(name = "stoc_tanq_auxi", precision = 12, scale = 3)
    public BigDecimal stocTanqAuxi;
}
