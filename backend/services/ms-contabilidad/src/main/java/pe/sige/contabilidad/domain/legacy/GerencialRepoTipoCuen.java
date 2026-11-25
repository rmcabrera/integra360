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
 * Tabla legado <b>dbo.GERENCIAL_REPO_TIPO_CUEN</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "GerencialRepoTipoCuen")
@Table(name = "gerencial_repo_tipo_cuen")
@IdClass(GerencialRepoTipoCuen.Pk.class)
public class GerencialRepoTipoCuen extends LegacyEntity {

    @Id
    @Column(name = "id_gere", nullable = false)
    public Integer idGere;

    @Id
    @Column(name = "id_tipo", nullable = false)
    public Integer idTipo;

    @Id
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Integer idGere;
        public Integer idTipo;
        public String nroCuen;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(idGere, other.idGere)
                && Objects.equals(idTipo, other.idTipo)
                && Objects.equals(nroCuen, other.nroCuen);
        }

        @Override
        public int hashCode() {
            return Objects.hash(idGere, idTipo, nroCuen);
        }
    }
}
