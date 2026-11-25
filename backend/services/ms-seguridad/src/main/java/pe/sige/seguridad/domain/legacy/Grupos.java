package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Grupos</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Grupos")
@Table(name = "grupos")
public class Grupos extends LegacyEntity {

    @Id
    @Column(name = "codi_grup", nullable = false)
    public Integer codiGrup;

    @Column(name = "nomb_grup", length = 15, nullable = false)
    public String nombGrup;
}
