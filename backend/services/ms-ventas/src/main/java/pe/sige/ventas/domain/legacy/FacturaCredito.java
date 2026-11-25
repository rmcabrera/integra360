package pe.sige.ventas.domain.legacy;

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
 * Tabla legado <b>dbo.FACTURA_CREDITO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "FacturaCredito")
@Table(name = "factura_credito")
@IdClass(FacturaCredito.Pk.class)
public class FacturaCredito extends LegacyEntity {

    @Id
    @Column(name = "codi_fact", length = 10, nullable = false)
    public String codiFact;

    @Id
    @Column(name = "codi_credito", nullable = false)
    public Long codiCredito;

    @Column(name = "monto", precision = 19, scale = 4, nullable = false)
    public BigDecimal monto;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiFact;
        public Long codiCredito;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiFact, other.codiFact)
                && Objects.equals(codiCredito, other.codiCredito);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiFact, codiCredito);
        }
    }
}
