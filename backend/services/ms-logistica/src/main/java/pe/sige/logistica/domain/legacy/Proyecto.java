package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PROYECTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Proyecto")
@Table(name = "proyecto")
public class Proyecto extends LegacyEntity {

    /** Legado: CODI_PROY */
    @Id
    @Column(name = "codi_proy", length = 10, nullable = false)
    public String codiProy;

    /** Legado: DESC_PROY */
    @Column(name = "desc_proy", length = 100)
    public String descProy;

    /** Legado: FECH_PROY */
    @Column(name = "fech_proy")
    public LocalDateTime fechProy;
}
