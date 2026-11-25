package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Puerto</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Puerto")
@Table(name = "puerto")
public class Puerto extends LegacyEntity {

    /** Legado: Codi_Puer */
    @Id
    @Column(name = "codi_puer", length = 2, nullable = false)
    public String codiPuer;

    /** Legado: Desc_Puer */
    @Column(name = "desc_puer", length = 30)
    public String descPuer;
}
