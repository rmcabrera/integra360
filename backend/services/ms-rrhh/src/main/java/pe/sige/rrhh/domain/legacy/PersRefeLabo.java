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
 * Tabla legado <b>dbo.PERS_REFE_LABO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PersRefeLabo")
@Table(name = "pers_refe_labo")
@IdClass(PersRefeLabo.Pk.class)
public class PersRefeLabo extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 10, nullable = false)
    public String codiPers;

    /** Legado: FECH_INIC */
    @Id
    @Column(name = "fech_inic", nullable = false)
    public LocalDateTime fechInic;

    /** Legado: FECH_TERM */
    @Column(name = "fech_term")
    public LocalDateTime fechTerm;

    /** Legado: EMPRESA */
    @Column(name = "empresa", length = 100)
    public String empresa;

    /** Legado: CARGO */
    @Column(name = "cargo", length = 100)
    public String cargo;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public LocalDateTime fechInic;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(fechInic, other.fechInic);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, fechInic);
        }
    }
}
