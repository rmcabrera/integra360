package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.AREAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Areas")
@Table(name = "areas")
public class Areas extends LegacyEntity {

    /** Legado: CODI_AREA */
    @Id
    @Column(name = "codi_area", length = 2, nullable = false)
    public String codiArea;

    /** Legado: NOMB_AREA */
    @Column(name = "nomb_area", length = 50)
    public String nombArea;

    /** Legado: UBICA */
    @Column(name = "ubica", length = 50)
    public String ubica;

    /** Legado: AREA_GRUP */
    @Column(name = "area_grup", length = 2)
    public String areaGrup;
}
