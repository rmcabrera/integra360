package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Almacen_Usuario</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AlmacenUsuario")
@Table(name = "almacen_usuario")
@IdClass(AlmacenUsuario.Pk.class)
public class AlmacenUsuario extends LegacyEntity {

    /** Legado: Codi_Alma */
    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    /** Legado: Codi_Usua */
    @Id
    @Column(name = "codi_usua", length = 5, nullable = false)
    public String codiUsua;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiAlma;
        public String codiUsua;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiAlma, other.codiAlma)
                && Objects.equals(codiUsua, other.codiUsua);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiAlma, codiUsua);
        }
    }
}
