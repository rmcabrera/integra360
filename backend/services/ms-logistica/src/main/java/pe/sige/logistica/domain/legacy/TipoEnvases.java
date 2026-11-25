package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_ENVASES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoEnvases")
@Table(name = "tipo_envases")
public class TipoEnvases extends LegacyEntity {

    /** Legado: Codi_Tipo_Enva */
    @Id
    @Column(name = "codi_tipo_enva", nullable = false)
    public Short codiTipoEnva;

    /** Legado: Desc_Emva */
    @Column(name = "desc_emva", length = 50, nullable = false)
    public String descEmva;
}
