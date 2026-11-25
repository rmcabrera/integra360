package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.AREA_GRUP</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AreaGrup")
@Table(name = "area_grup")
public class AreaGrup extends LegacyEntity {

    /** Legado: CODI_AREA_GRUP */
    @Id
    @Column(name = "codi_area_grup", length = 2, nullable = false)
    public String codiAreaGrup;

    /** Legado: DESC_AREA_GRUP */
    @Column(name = "desc_area_grup", length = 100)
    public String descAreaGrup;

    /** Legado: JERA_AREA */
    @Column(name = "jera_area")
    public Short jeraArea;
}
