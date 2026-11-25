package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_CONCEPTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoConceptos")
@Table(name = "tipo_conceptos")
public class TipoConceptos extends LegacyEntity {

    /** Legado: Codi_tipo */
    @Id
    @Column(name = "codi_tipo", length = 1, nullable = false)
    public String codiTipo;

    /** Legado: Descripcion */
    @Column(name = "descripcion", length = 20)
    public String descripcion;
}
