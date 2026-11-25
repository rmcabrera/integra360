package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.REFERENCIAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Referencias")
@Table(name = "referencias")
public class Referencias extends LegacyEntity {

    @Id
    @Column(name = "codi_refe", length = 2, nullable = false)
    public String codiRefe;

    @Column(name = "descrip_refe", length = 100)
    public String descripRefe;
}
