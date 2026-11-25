package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.USUARIOS_GRUPOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "UsuariosGrupos")
@Table(name = "usuarios_grupos")
@IdClass(UsuariosGrupos.Pk.class)
public class UsuariosGrupos extends LegacyEntity {

    /** Legado: CODI_USUA */
    @Id
    @Column(name = "codi_usua", length = 5, nullable = false)
    public String codiUsua;

    /** Legado: CODI_GRUP */
    @Id
    @Column(name = "codi_grup", nullable = false)
    public Integer codiGrup;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiUsua;
        public Integer codiGrup;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiUsua, other.codiUsua)
                && Objects.equals(codiGrup, other.codiGrup);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiUsua, codiGrup);
        }
    }
}
