package pe.sige.finanzas.domain.legacy;

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
 * Tabla legado <b>dbo.BANCOS_DISPONIBLE_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "BancosDisponibleDeta")
@Table(name = "bancos_disponible_deta")
@IdClass(BancosDisponibleDeta.Pk.class)
public class BancosDisponibleDeta extends LegacyEntity {

    @Id
    @Column(name = "id_sec", nullable = false)
    public Long idSec;

    @Id
    @Column(name = "id_conc", length = 2, nullable = false)
    public String idConc;

    @Column(name = "monto_s", precision = 18, scale = 2)
    public BigDecimal montoS;

    @Column(name = "monto_d", precision = 18, scale = 2)
    public BigDecimal montoD;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long idSec;
        public String idConc;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(idSec, other.idSec)
                && Objects.equals(idConc, other.idConc);
        }

        @Override
        public int hashCode() {
            return Objects.hash(idSec, idConc);
        }
    }
}
