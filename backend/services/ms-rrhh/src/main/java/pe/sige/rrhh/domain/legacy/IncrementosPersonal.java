package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.INCREMENTOS_PERSONAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "IncrementosPersonal")
@Table(name = "incrementos_personal")
@IdClass(IncrementosPersonal.Pk.class)
public class IncrementosPersonal extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: NRO_INCRE */
    @Id
    @Column(name = "nro_incre", nullable = false)
    public Short nroIncre;

    /** Legado: DESC_INCR */
    @Column(name = "desc_incr", length = 100)
    public String descIncr;

    /** Legado: TIPO_INCRE */
    @Column(name = "tipo_incre", nullable = false)
    public Boolean tipoIncre;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: VALOR */
    @Column(name = "valor", precision = 12, scale = 2, nullable = false)
    public BigDecimal valor;

    /** Legado: ESTA_ACTI */
    @Column(name = "esta_acti", nullable = false)
    public Boolean estaActi;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public Short nroIncre;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(nroIncre, other.nroIncre);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, nroIncre);
        }
    }
}
