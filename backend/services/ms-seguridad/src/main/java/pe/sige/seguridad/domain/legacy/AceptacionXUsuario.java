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
 * Tabla legado <b>dbo.ACEPTACION_X_USUARIO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AceptacionXUsuario")
@Table(name = "aceptacion_x_usuario")
@IdClass(AceptacionXUsuario.Pk.class)
public class AceptacionXUsuario extends LegacyEntity {

    /** Legado: CODI_USUA */
    @Id
    @Column(name = "codi_usua", length = 5, nullable = false)
    public String codiUsua;

    /** Legado: CODI_TIPO_ACEP */
    @Id
    @Column(name = "codi_tipo_acep", length = 2, nullable = false)
    public String codiTipoAcep;

    @Column(name = "crear", length = 1)
    public String crear;

    @Column(name = "modificar", length = 1)
    public String modificar;

    @Column(name = "eliminar", length = 1)
    public String eliminar;

    @Column(name = "guardar", length = 1)
    public String guardar;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiUsua;
        public String codiTipoAcep;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiUsua, other.codiUsua)
                && Objects.equals(codiTipoAcep, other.codiTipoAcep);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiUsua, codiTipoAcep);
        }
    }
}
