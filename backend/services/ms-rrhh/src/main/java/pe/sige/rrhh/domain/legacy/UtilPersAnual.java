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
 * Tabla legado <b>dbo.UTIL_PERS_ANUAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "UtilPersAnual")
@Table(name = "util_pers_anual")
@IdClass(UtilPersAnual.Pk.class)
public class UtilPersAnual extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: PERIODO */
    @Id
    @Column(name = "periodo", length = 4, nullable = false)
    public String periodo;

    /** Legado: IMPORTE */
    @Column(name = "importe", precision = 18, scale = 4)
    public BigDecimal importe;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public String periodo;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(periodo, other.periodo);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, periodo);
        }
    }
}
