package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.GERENCIAL_REPO_TIPOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "GerencialRepoTipos")
@Table(name = "gerencial_repo_tipos")
@IdClass(GerencialRepoTipos.Pk.class)
public class GerencialRepoTipos extends LegacyEntity {

    @Id
    @Column(name = "id_gere", nullable = false)
    public Integer idGere;

    @Id
    @Column(name = "id_tipo", nullable = false)
    public Integer idTipo;

    @Column(name = "desc_tipo_repo", length = 150)
    public String descTipoRepo;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Integer idGere;
        public Integer idTipo;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(idGere, other.idGere)
                && Objects.equals(idTipo, other.idTipo);
        }

        @Override
        public int hashCode() {
            return Objects.hash(idGere, idTipo);
        }
    }
}
