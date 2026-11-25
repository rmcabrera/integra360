package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PRINCIPIO_ACTIVO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PrincipioActivo")
@Table(name = "principio_activo")
public class PrincipioActivo extends LegacyEntity {

    @Id
    @Column(name = "codi_prin", length = 3, nullable = false)
    public String codiPrin;

    @Column(name = "descripcion", length = 100)
    public String descripcion;
}
