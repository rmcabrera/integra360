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
 * Tabla legado <b>dbo.SALDO_BANCOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SaldoBancos")
@Table(name = "saldo_bancos")
@IdClass(SaldoBancos.Pk.class)
public class SaldoBancos extends LegacyEntity {

    /** Legado: FECHA */
    @Id
    @Column(name = "fecha", nullable = false)
    public LocalDateTime fecha;

    /** Legado: NRO_CUEN */
    @Id
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    /** Legado: CODI_MONE */
    @Id
    @Column(name = "codi_mone", length = 2, nullable = false)
    public String codiMone;

    /** Legado: SALDO */
    @Column(name = "saldo", precision = 12, scale = 3)
    public BigDecimal saldo;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public LocalDateTime fecha;
        public String nroCuen;
        public String codiMone;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(fecha, other.fecha)
                && Objects.equals(nroCuen, other.nroCuen)
                && Objects.equals(codiMone, other.codiMone);
        }

        @Override
        public int hashCode() {
            return Objects.hash(fecha, nroCuen, codiMone);
        }
    }
}
