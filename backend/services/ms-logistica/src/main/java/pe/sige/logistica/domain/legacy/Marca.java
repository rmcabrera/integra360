package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.MARCA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Marca")
@Table(name = "marca")
public class Marca extends LegacyEntity {

    /** Legado: CODI_MARCA */
    @Id
    @Column(name = "codi_marca", length = 4, nullable = false)
    public String codiMarca;

    /** Legado: DESC_MARCA */
    @Column(name = "desc_marca", length = 50)
    public String descMarca;
}
