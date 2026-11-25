package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_MEDIDA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoMedida")
@Table(name = "tipo_medida")
public class TipoMedida extends LegacyEntity {

    /** Legado: CODIGO */
    @Id
    @Column(name = "codigo", length = 2, nullable = false)
    public String codigo;

    /** Legado: DESC_MEDIDA */
    @Column(name = "desc_medida", length = 50)
    public String descMedida;
}
