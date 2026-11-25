package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.pres_grup</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PresGrup")
@Table(name = "pres_grup")
public class PresGrup extends LegacyEntity {

    @Id
    @Column(name = "codi_grup", length = 2, nullable = false)
    public String codiGrup;

    @Column(name = "desc_grup", length = 40)
    public String descGrup;
}
