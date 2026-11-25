package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ASISTENCIA_MOTORISTA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AsistenciaMotorista")
@Table(name = "asistencia_motorista")
@IdClass(AsistenciaMotorista.Pk.class)
public class AsistenciaMotorista extends LegacyEntity {

    @Id
    @Column(name = "mesanio", length = 6, nullable = false)
    public String mesanio;

    @Id
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    @Column(name = "codi_carg", length = 4, nullable = false)
    public String codiCarg;

    @Column(name = "dias_traba_quin")
    public Integer diasTrabaQuin;

    @Column(name = "dias_traba_mens")
    public Integer diasTrabaMens;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String mesanio;
        public String codiUnidOper;
        public String codiPers;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(mesanio, other.mesanio)
                && Objects.equals(codiUnidOper, other.codiUnidOper)
                && Objects.equals(codiPers, other.codiPers);
        }

        @Override
        public int hashCode() {
            return Objects.hash(mesanio, codiUnidOper, codiPers);
        }
    }
}
