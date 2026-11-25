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
 * Tabla legado <b>dbo.vale_CREDITO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ValeCredito")
@Table(name = "vale_credito")
@IdClass(ValeCredito.Pk.class)
public class ValeCredito extends LegacyEntity {

    @Id
    @Column(name = "codi_vale", nullable = false)
    public Long codiVale;

    @Id
    @Column(name = "codi_credito", nullable = false)
    public Long codiCredito;

    @Column(name = "monto", precision = 19, scale = 4, nullable = false)
    public BigDecimal monto;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiVale;
        public Long codiCredito;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiVale, other.codiVale)
                && Objects.equals(codiCredito, other.codiCredito);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiVale, codiCredito);
        }
    }
}
