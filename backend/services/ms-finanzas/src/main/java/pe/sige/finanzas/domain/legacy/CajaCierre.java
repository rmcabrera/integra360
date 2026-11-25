package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CAJA_CIERRE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CajaCierre")
@Table(name = "caja_cierre")
@IdClass(CajaCierre.Pk.class)
public class CajaCierre extends LegacyEntity {

    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    @Id
    @Column(name = "fecha", nullable = false)
    public LocalDateTime fecha;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiAlma;
        public LocalDateTime fecha;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiAlma, other.codiAlma)
                && Objects.equals(fecha, other.fecha);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiAlma, fecha);
        }
    }
}
