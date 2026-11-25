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
 * Tabla legado <b>dbo.CONTROL_PROBLEMAS_DETALLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ControlProblemasDetalle")
@Table(name = "control_problemas_detalle")
@IdClass(ControlProblemasDetalle.Pk.class)
public class ControlProblemasDetalle extends LegacyEntity {

    @Id
    @Column(name = "id_control", nullable = false)
    public Long idControl;

    @Id
    @Column(name = "id_sec", nullable = false)
    public Integer idSec;

    @Column(name = "id_sub_fami_prod", length = 4)
    public String idSubFamiProd;

    @Column(name = "opcion", length = 255)
    public String opcion;

    @Column(name = "dosis", length = 255)
    public String dosis;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long idControl;
        public Integer idSec;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(idControl, other.idControl)
                && Objects.equals(idSec, other.idSec);
        }

        @Override
        public int hashCode() {
            return Objects.hash(idControl, idSec);
        }
    }
}
