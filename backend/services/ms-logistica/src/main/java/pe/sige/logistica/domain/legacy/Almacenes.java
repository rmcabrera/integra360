package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ALMACENES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Almacenes")
@Table(name = "almacenes")
public class Almacenes extends LegacyEntity {

    /** Legado: CODI_ALMA */
    @Id
    @Column(name = "codi_alma", length = 3, nullable = false)
    public String codiAlma;

    /** Legado: DESC_ALMA */
    @Column(name = "desc_alma", length = 50, nullable = false)
    public String descAlma;

    /** Legado: UBIC_ALMA */
    @Column(name = "ubic_alma", length = 100, nullable = false)
    public String ubicAlma;
}
