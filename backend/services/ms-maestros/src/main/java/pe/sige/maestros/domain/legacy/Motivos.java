package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.MOTIVOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Motivos")
@Table(name = "motivos")
public class Motivos extends LegacyEntity {

    /** Legado: CODI_MOTI */
    @Id
    @Column(name = "codi_moti", length = 3, nullable = false)
    public String codiMoti;

    /** Legado: DESC_MOTI */
    @Column(name = "desc_moti", length = 100, nullable = false)
    public String descMoti;
}
