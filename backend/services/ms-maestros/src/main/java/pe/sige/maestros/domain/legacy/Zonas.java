package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ZONAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Zonas")
@Table(name = "zonas")
public class Zonas extends LegacyEntity {

    @Id
    @Column(name = "cod_zona", nullable = false)
    public Long codZona;

    @Column(name = "desc_zona", length = 100)
    public String descZona;
}
