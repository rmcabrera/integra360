package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Talleres</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Talleres")
@Table(name = "talleres")
public class Talleres extends LegacyEntity {

    @Id
    @Column(name = "codi_tall", length = 2, nullable = false)
    public String codiTall;

    @Column(name = "nombre", length = 30, nullable = false)
    public String nombre;
}
