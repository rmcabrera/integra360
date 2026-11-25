package pe.sige.ventas.domain.legacy;

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
 * Tabla legado <b>dbo.FACTURA_CUOTAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "FacturaCuotas")
@Table(name = "factura_cuotas")
@IdClass(FacturaCuotas.Pk.class)
public class FacturaCuotas extends LegacyEntity {

    /** Legado: codi_Fact */
    @Id
    @Column(name = "codi_fact", length = 10, nullable = false)
    public String codiFact;

    @Id
    @Column(name = "id_sec", nullable = false)
    public Integer idSec;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "monto", precision = 18, scale = 2)
    public BigDecimal monto;

    @Column(name = "fecha_nc")
    public LocalDateTime fechaNc;

    @Column(name = "monto_nc", precision = 18, scale = 2)
    public BigDecimal montoNc;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiFact;
        public Integer idSec;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiFact, other.codiFact)
                && Objects.equals(idSec, other.idSec);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiFact, idSec);
        }
    }
}
