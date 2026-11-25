package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DESTINOS_PESCA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DestinosPesca")
@Table(name = "destinos_pesca")
public class DestinosPesca extends LegacyEntity {

    @Id
    @Column(name = "codi_dest", length = 3, nullable = false)
    public String codiDest;

    @Column(name = "desc_dest", length = 250)
    public String descDest;

    @Column(name = "abrev", length = 30)
    public String abrev;
}
