package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.COLOR</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Color")
@Table(name = "color")
public class Color extends LegacyEntity {

    /** Legado: Codi_Color */
    @Id
    @Column(name = "codi_color", nullable = false)
    public Short codiColor;

    /** Legado: Desc_Color */
    @Column(name = "desc_color", length = 100)
    public String descColor;
}
