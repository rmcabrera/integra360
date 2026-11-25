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
 * Tabla legado <b>dbo.SALI_MATE_X_PROY</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SaliMateXProy")
@Table(name = "sali_mate_x_proy")
@IdClass(SaliMateXProy.Pk.class)
public class SaliMateXProy extends LegacyEntity {

    /** Legado: CODI_DOCU_SALI */
    @Id
    @Column(name = "codi_docu_sali", length = 10, nullable = false)
    public String codiDocuSali;

    /** Legado: CODI_PROY */
    @Id
    @Column(name = "codi_proy", length = 10, nullable = false)
    public String codiProy;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiDocuSali;
        public String codiProy;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiDocuSali, other.codiDocuSali)
                && Objects.equals(codiProy, other.codiProy);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiDocuSali, codiProy);
        }
    }
}
