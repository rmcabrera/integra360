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
 * Tabla legado <b>dbo.BANCOS_SALDOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "BancosSaldos")
@Table(name = "bancos_saldos")
@IdClass(BancosSaldos.Pk.class)
public class BancosSaldos extends LegacyEntity {

    /** Legado: NRO_CUEN */
    @Id
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    /** Legado: ANIO */
    @Id
    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2, nullable = false)
    public String codiMone;

    /** Legado: SALD_00 */
    @Column(name = "sald_00", precision = 18, scale = 2)
    public BigDecimal sald00;

    /** Legado: SALD_01 */
    @Column(name = "sald_01", precision = 18, scale = 2)
    public BigDecimal sald01;

    /** Legado: SALD_02 */
    @Column(name = "sald_02", precision = 18, scale = 2)
    public BigDecimal sald02;

    /** Legado: SALD_03 */
    @Column(name = "sald_03", precision = 18, scale = 2)
    public BigDecimal sald03;

    /** Legado: SALD_04 */
    @Column(name = "sald_04", precision = 18, scale = 2)
    public BigDecimal sald04;

    /** Legado: SALD_05 */
    @Column(name = "sald_05", precision = 18, scale = 2)
    public BigDecimal sald05;

    /** Legado: SALD_06 */
    @Column(name = "sald_06", precision = 18, scale = 2)
    public BigDecimal sald06;

    /** Legado: SALD_07 */
    @Column(name = "sald_07", precision = 18, scale = 2)
    public BigDecimal sald07;

    /** Legado: SALD_08 */
    @Column(name = "sald_08", precision = 18, scale = 2)
    public BigDecimal sald08;

    /** Legado: SALD_09 */
    @Column(name = "sald_09", precision = 18, scale = 2)
    public BigDecimal sald09;

    /** Legado: SALD_10 */
    @Column(name = "sald_10", precision = 18, scale = 2)
    public BigDecimal sald10;

    /** Legado: SALD_11 */
    @Column(name = "sald_11", precision = 18, scale = 2)
    public BigDecimal sald11;

    /** Legado: SALD_12 */
    @Column(name = "sald_12", precision = 18, scale = 2)
    public BigDecimal sald12;

    /** Legado: SALDB_00 */
    @Column(name = "saldb_00", precision = 18, scale = 2)
    public BigDecimal saldb00;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String nroCuen;
        public String anio;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(nroCuen, other.nroCuen)
                && Objects.equals(anio, other.anio);
        }

        @Override
        public int hashCode() {
            return Objects.hash(nroCuen, anio);
        }
    }
}
