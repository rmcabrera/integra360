package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PERSONAL_SEGUROS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PersonalSeguros")
@Table(name = "personal_seguros")
@IdClass(PersonalSeguros.Pk.class)
public class PersonalSeguros extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: CODI_SEGU */
    @Id
    @Column(name = "codi_segu", nullable = false)
    public Short codiSegu;

    /** Legado: FECH_SEGU */
    @Id
    @Column(name = "fech_segu", nullable = false)
    public LocalDateTime fechSegu;

    /** Legado: TIPO_CANT */
    @Column(name = "tipo_cant")
    public Boolean tipoCant;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: VALOR */
    @Column(name = "valor", precision = 12, scale = 3)
    public BigDecimal valor;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public Short codiSegu;
        public LocalDateTime fechSegu;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(codiSegu, other.codiSegu)
                && Objects.equals(fechSegu, other.fechSegu);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, codiSegu, fechSegu);
        }
    }
}
