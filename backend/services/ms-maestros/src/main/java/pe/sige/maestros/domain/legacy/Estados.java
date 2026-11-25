package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ESTADOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Estados")
@Table(name = "estados")
public class Estados extends LegacyEntity {

    /** Legado: ESTADO */
    @Id
    @Column(name = "estado", length = 1, nullable = false)
    public String estado;

    /** Legado: DESC_ESTA */
    @Column(name = "desc_esta", length = 50)
    public String descEsta;
}
