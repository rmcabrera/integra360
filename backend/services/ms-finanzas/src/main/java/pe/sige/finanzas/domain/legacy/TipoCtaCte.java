package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_CTA_CTE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoCtaCte")
@Table(name = "tipo_cta_cte")
public class TipoCtaCte extends LegacyEntity {

    /** Legado: CODI_TIPO_CTA_CTE */
    @Id
    @Column(name = "codi_tipo_cta_cte", length = 2, nullable = false)
    public String codiTipoCtaCte;

    /** Legado: DESC_TIPO_CTA_CTE */
    @Column(name = "desc_tipo_cta_cte", length = 100)
    public String descTipoCtaCte;

    /** Legado: NEMO_TIPO_CTA_CTE */
    @Column(name = "nemo_tipo_cta_cte", length = 20)
    public String nemoTipoCtaCte;
}
