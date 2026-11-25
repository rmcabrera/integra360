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
 * Tabla legado <b>dbo.ASISTENCIA_PERSONAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AsistenciaPersonal")
@Table(name = "asistencia_personal")
@IdClass(AsistenciaPersonal.Pk.class)
public class AsistenciaPersonal extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: Fecha */
    @Id
    @Column(name = "fecha", length = 10, nullable = false)
    public String fecha;

    /** Legado: Turno */
    @Id
    @Column(name = "turno", nullable = false)
    public Integer turno;

    /** Legado: HE1 */
    @Column(name = "he1")
    public LocalDateTime he1;

    /** Legado: HS1 */
    @Column(name = "hs1")
    public LocalDateTime hs1;

    @Column(name = "codi_usua", length = 5)
    public String codiUsua;

    @Column(name = "codi_usua_modi", length = 5)
    public String codiUsuaModi;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public String fecha;
        public Integer turno;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(fecha, other.fecha)
                && Objects.equals(turno, other.turno);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, fecha, turno);
        }
    }
}
