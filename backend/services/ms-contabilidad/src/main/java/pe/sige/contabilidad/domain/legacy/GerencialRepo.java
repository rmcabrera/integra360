package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.GERENCIAL_REPO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "GerencialRepo")
@Table(name = "gerencial_repo")
public class GerencialRepo extends LegacyEntity {

    @Id
    @Column(name = "id_gere", nullable = false)
    public Integer idGere;

    @Column(name = "desc_gere", length = 150)
    public String descGere;
}
