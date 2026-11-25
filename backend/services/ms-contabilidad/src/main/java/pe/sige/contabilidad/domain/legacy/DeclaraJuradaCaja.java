package pe.sige.contabilidad.domain.legacy;

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
 * Tabla legado <b>dbo.DECLARA_JURADA_CAJA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DeclaraJuradaCaja")
@Table(name = "declara_jurada_caja")
@IdClass(DeclaraJuradaCaja.Pk.class)
public class DeclaraJuradaCaja extends LegacyEntity {

    @Id
    @Column(name = "codi_decla", nullable = false)
    public Long codiDecla;

    @Id
    @Column(name = "fecha_caja", nullable = false)
    public LocalDateTime fechaCaja;

    /** Legado: monto_Caja */
    @Column(name = "monto_caja", precision = 18, scale = 2)
    public BigDecimal montoCaja;

    @Id
    @Column(name = "codi_mone", length = 2, nullable = false)
    public String codiMone;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiDecla;
        public LocalDateTime fechaCaja;
        public String codiMone;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiDecla, other.codiDecla)
                && Objects.equals(fechaCaja, other.fechaCaja)
                && Objects.equals(codiMone, other.codiMone);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiDecla, fechaCaja, codiMone);
        }
    }
}
