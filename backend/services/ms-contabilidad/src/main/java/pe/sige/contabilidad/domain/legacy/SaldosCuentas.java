package pe.sige.contabilidad.domain.legacy;

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
 * Tabla legado <b>dbo.SALDOS_CUENTAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SaldosCuentas")
@Table(name = "saldos_cuentas")
@IdClass(SaldosCuentas.Pk.class)
public class SaldosCuentas extends LegacyEntity {

    /** Legado: MESANIO */
    @Id
    @Column(name = "mesanio", length = 6, nullable = false)
    public String mesanio;

    /** Legado: NRO_CUEN */
    @Id
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    /** Legado: SALDOANT */
    @Column(name = "saldoant", precision = 12, scale = 2)
    public BigDecimal saldoant;

    /** Legado: CARGO */
    @Column(name = "cargo", precision = 12, scale = 2)
    public BigDecimal cargo;

    /** Legado: ABONO */
    @Column(name = "abono", precision = 12, scale = 2)
    public BigDecimal abono;

    /** Legado: SALDONUE */
    @Column(name = "saldonue", precision = 12, scale = 2)
    public BigDecimal saldonue;

    /** Legado: CARGOACUM */
    @Column(name = "cargoacum", precision = 12, scale = 3)
    public BigDecimal cargoacum;

    /** Legado: ABONOACUM */
    @Column(name = "abonoacum", precision = 12, scale = 3)
    public BigDecimal abonoacum;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String mesanio;
        public String nroCuen;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(mesanio, other.mesanio)
                && Objects.equals(nroCuen, other.nroCuen);
        }

        @Override
        public int hashCode() {
            return Objects.hash(mesanio, nroCuen);
        }
    }
}
