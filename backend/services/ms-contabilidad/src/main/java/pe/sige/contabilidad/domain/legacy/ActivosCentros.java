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
 * Tabla legado <b>dbo.Activos_centros</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ActivosCentros")
@Table(name = "activos_centros")
@IdClass(ActivosCentros.Pk.class)
public class ActivosCentros extends LegacyEntity {

    @Id
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    @Id
    @Column(name = "codi_cc", nullable = false)
    public Long codiCc;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String nroCuen;
        public Long codiCc;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(nroCuen, other.nroCuen)
                && Objects.equals(codiCc, other.codiCc);
        }

        @Override
        public int hashCode() {
            return Objects.hash(nroCuen, codiCc);
        }
    }
}
