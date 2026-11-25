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
 * Tabla legado <b>dbo.HORA_PERS_FECH</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "HoraPersFech")
@Table(name = "hora_pers_fech")
@IdClass(HoraPersFech.Pk.class)
public class HoraPersFech extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: FECH_INIC */
    @Id
    @Column(name = "fech_inic", nullable = false)
    public LocalDateTime fechInic;

    /** Legado: FECH_FIN */
    @Column(name = "fech_fin")
    public LocalDateTime fechFin;

    /** Legado: CODI_HORA */
    @Column(name = "codi_hora")
    public Short codiHora;

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
