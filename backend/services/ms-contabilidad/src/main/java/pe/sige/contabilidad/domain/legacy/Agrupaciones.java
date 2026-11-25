package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.AGRUPACIONES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Agrupaciones")
@Table(name = "agrupaciones")
public class Agrupaciones extends LegacyEntity {

    /** Legado: CODI_GRUP */
    @Id
    @Column(name = "codi_grup", length = 5, nullable = false)
    public String codiGrup;

    /** Legado: DESC_GRUP */
    @Column(name = "desc_grup", length = 100)
    public String descGrup;
}
