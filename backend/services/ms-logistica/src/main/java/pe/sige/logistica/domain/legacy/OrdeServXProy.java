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
 * Tabla legado <b>dbo.ORDE_SERV_X_PROY</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "OrdeServXProy")
@Table(name = "orde_serv_x_proy")
@IdClass(OrdeServXProy.Pk.class)
public class OrdeServXProy extends LegacyEntity {

    /** Legado: CODI_ORDE_COMP */
    @Id
    @Column(name = "codi_orde_comp", length = 10, nullable = false)
    public String codiOrdeComp;

    /** Legado: CODI_PROY */
    @Id
    @Column(name = "codi_proy", length = 10, nullable = false)
    public String codiProy;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiOrdeComp;
        public String codiProy;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiOrdeComp, other.codiOrdeComp)
                && Objects.equals(codiProy, other.codiProy);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiOrdeComp, codiProy);
        }
    }
}
