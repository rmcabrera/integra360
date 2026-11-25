package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.MATERIAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Material")
@Table(name = "material")
public class Material extends LegacyEntity {

    /** Legado: Codi_Material */
    @Id
    @Column(name = "codi_material", nullable = false)
    public Integer codiMaterial;

    /** Legado: Desc_Material */
    @Column(name = "desc_material", length = 50, nullable = false)
    public String descMaterial;
}
