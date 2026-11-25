package pe.sige.seguridad.domain.legacy;

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
 * Tabla legado <b>dbo.VISO_EVEN</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "VisoEven")
@Table(name = "viso_even")
@IdClass(VisoEven.Pk.class)
public class VisoEven extends LegacyEntity {

    /** Legado: FECH_EVEN */
    @Id
    @Column(name = "fech_even", nullable = false)
    public LocalDateTime fechEven;

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: DESC_EVEN */
    @Column(name = "desc_even", length = 200)
    public String descEven;

    @Column(name = "name_pc", length = 30)
    public String namePc;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public LocalDateTime fechEven;
        public String codiPers;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(fechEven, other.fechEven)
                && Objects.equals(codiPers, other.codiPers);
        }

        @Override
        public int hashCode() {
            return Objects.hash(fechEven, codiPers);
        }
    }
}
