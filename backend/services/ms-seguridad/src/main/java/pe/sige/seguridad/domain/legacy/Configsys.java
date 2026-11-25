package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ConfigSys</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Configsys")
@Table(name = "configsys")
public class Configsys extends LegacyEntity {

    @Id
    @Column(name = "id_conf", nullable = false)
    public Integer idConf;

    @Column(name = "valor", length = 50)
    public String valor;
}
