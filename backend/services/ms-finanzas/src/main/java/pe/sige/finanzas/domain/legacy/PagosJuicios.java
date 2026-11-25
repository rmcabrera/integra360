package pe.sige.finanzas.domain.legacy;

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
 * Tabla legado <b>dbo.PAGOS_JUICIOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PagosJuicios")
@Table(name = "pagos_juicios")
@IdClass(PagosJuicios.Pk.class)
public class PagosJuicios extends LegacyEntity {

    /** Legado: CODI_JUIC */
    @Id
    @Column(name = "codi_juic", length = 6, nullable = false)
    public String codiJuic;

    /** Legado: NRO_PAGO */
    @Id
    @Column(name = "nro_pago", length = 4, nullable = false)
    public String nroPago;

    /** Legado: FECH_PAGO */
    @Column(name = "fech_pago", nullable = false)
    public LocalDateTime fechPago;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: MONTO */
    @Column(name = "monto", precision = 12, scale = 2)
    public BigDecimal monto;

    /** Legado: OBSERVACION */
    @Column(name = "observacion", length = 150)
    public String observacion;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiJuic;
        public String nroPago;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiJuic, other.codiJuic)
                && Objects.equals(nroPago, other.nroPago);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiJuic, nroPago);
        }
    }
}
