package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SINDICATOS_PERSONAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SindicatosPersonal")
@Table(name = "sindicatos_personal")
@IdClass(SindicatosPersonal.Pk.class)
public class SindicatosPersonal extends LegacyEntity {

    @Id
    @Column(name = "codi_sind", length = 2, nullable = false)
    public String codiSind;

    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    @Column(name = "estado", length = 1)
    public String estado;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiSind;
        public String codiPers;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiSind, other.codiSind)
                && Objects.equals(codiPers, other.codiPers);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiSind, codiPers);
        }
    }
}
