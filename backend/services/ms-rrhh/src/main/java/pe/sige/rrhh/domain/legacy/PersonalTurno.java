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
 * Tabla legado <b>dbo.PERSONAL_TURNO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PersonalTurno")
@Table(name = "personal_turno")
@IdClass(PersonalTurno.Pk.class)
public class PersonalTurno extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: CODI_TURN */
    @Id
    @Column(name = "codi_turn", length = 2, nullable = false)
    public String codiTurn;

    /** Legado: FECH_INIC */
    @Id
    @Column(name = "fech_inic", nullable = false)
    public LocalDateTime fechInic;

    /** Legado: FECH_TERM */
    @Column(name = "fech_term")
    public LocalDateTime fechTerm;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public String codiTurn;
        public LocalDateTime fechInic;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(codiTurn, other.codiTurn)
                && Objects.equals(fechInic, other.fechInic);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, codiTurn, fechInic);
        }
    }
}
