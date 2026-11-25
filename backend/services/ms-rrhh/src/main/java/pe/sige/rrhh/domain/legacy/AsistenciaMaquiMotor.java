package pe.sige.rrhh.domain.legacy;

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
 * Tabla legado <b>dbo.ASISTENCIA_MAQUI_MOTOR</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AsistenciaMaquiMotor")
@Table(name = "asistencia_maqui_motor")
@IdClass(AsistenciaMaquiMotor.Pk.class)
public class AsistenciaMaquiMotor extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: FECH_ASIS */
    @Id
    @Column(name = "fech_asis", nullable = false)
    public LocalDateTime fechAsis;

    /** Legado: ASIS_PERS */
    @Column(name = "asis_pers")
    public Boolean asisPers;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public LocalDateTime fechAsis;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(fechAsis, other.fechAsis);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, fechAsis);
        }
    }
}
