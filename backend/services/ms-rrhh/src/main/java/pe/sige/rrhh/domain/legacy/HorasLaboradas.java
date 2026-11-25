package pe.sige.rrhh.domain.legacy;

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
 * Tabla legado <b>dbo.HORAS_LABORADAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "HorasLaboradas")
@Table(name = "horas_laboradas")
@IdClass(HorasLaboradas.Pk.class)
public class HorasLaboradas extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: FECH_INIC */
    @Id
    @Column(name = "fech_inic", nullable = false)
    public LocalDateTime fechInic;

    /** Legado: D_01 */
    @Column(name = "d_01", precision = 9, scale = 2, nullable = false)
    public BigDecimal d01;

    /** Legado: D_02 */
    @Column(name = "d_02", precision = 9, scale = 2, nullable = false)
    public BigDecimal d02;

    /** Legado: D_03 */
    @Column(name = "d_03", precision = 9, scale = 2, nullable = false)
    public BigDecimal d03;

    /** Legado: D_04 */
    @Column(name = "d_04", precision = 9, scale = 2, nullable = false)
    public BigDecimal d04;

    /** Legado: D_05 */
    @Column(name = "d_05", precision = 9, scale = 2, nullable = false)
    public BigDecimal d05;

    /** Legado: D_06 */
    @Column(name = "d_06", precision = 9, scale = 2, nullable = false)
    public BigDecimal d06;

    /** Legado: D_07 */
    @Column(name = "d_07", precision = 9, scale = 2, nullable = false)
    public BigDecimal d07;

    /** Legado: D_08 */
    @Column(name = "d_08", precision = 9, scale = 2, nullable = false)
    public BigDecimal d08;

    /** Legado: D_09 */
    @Column(name = "d_09", precision = 9, scale = 2, nullable = false)
    public BigDecimal d09;

    /** Legado: D_10 */
    @Column(name = "d_10", precision = 9, scale = 2, nullable = false)
    public BigDecimal d10;

    /** Legado: D_11 */
    @Column(name = "d_11", precision = 9, scale = 2, nullable = false)
    public BigDecimal d11;

    /** Legado: D_12 */
    @Column(name = "d_12", precision = 9, scale = 2, nullable = false)
    public BigDecimal d12;

    /** Legado: D_13 */
    @Column(name = "d_13", precision = 9, scale = 2, nullable = false)
    public BigDecimal d13;

    /** Legado: D_14 */
    @Column(name = "d_14", precision = 9, scale = 2, nullable = false)
    public BigDecimal d14;

    /** Legado: D_15 */
    @Column(name = "d_15", precision = 9, scale = 2, nullable = false)
    public BigDecimal d15;

    /** Legado: D_16 */
    @Column(name = "d_16", precision = 9, scale = 2, nullable = false)
    public BigDecimal d16;

    /** Legado: D_17 */
    @Column(name = "d_17", precision = 9, scale = 2, nullable = false)
    public BigDecimal d17;

    /** Legado: D_18 */
    @Column(name = "d_18", precision = 9, scale = 2, nullable = false)
    public BigDecimal d18;

    /** Legado: D_19 */
    @Column(name = "d_19", precision = 9, scale = 2, nullable = false)
    public BigDecimal d19;

    /** Legado: D_20 */
    @Column(name = "d_20", precision = 9, scale = 2, nullable = false)
    public BigDecimal d20;

    /** Legado: D_21 */
    @Column(name = "d_21", precision = 9, scale = 2, nullable = false)
    public BigDecimal d21;

    /** Legado: D_22 */
    @Column(name = "d_22", precision = 9, scale = 2, nullable = false)
    public BigDecimal d22;

    /** Legado: D_23 */
    @Column(name = "d_23", precision = 9, scale = 2, nullable = false)
    public BigDecimal d23;

    /** Legado: D_24 */
    @Column(name = "d_24", precision = 9, scale = 2, nullable = false)
    public BigDecimal d24;

    /** Legado: D_25 */
    @Column(name = "d_25", precision = 9, scale = 2, nullable = false)
    public BigDecimal d25;

    /** Legado: D_26 */
    @Column(name = "d_26", precision = 9, scale = 2, nullable = false)
    public BigDecimal d26;

    /** Legado: D_27 */
    @Column(name = "d_27", precision = 9, scale = 2, nullable = false)
    public BigDecimal d27;

    /** Legado: D_28 */
    @Column(name = "d_28", precision = 9, scale = 2, nullable = false)
    public BigDecimal d28;

    /** Legado: D_29 */
    @Column(name = "d_29", precision = 9, scale = 2, nullable = false)
    public BigDecimal d29;

    /** Legado: D_30 */
    @Column(name = "d_30", precision = 9, scale = 2, nullable = false)
    public BigDecimal d30;

    /** Legado: D_31 */
    @Column(name = "d_31", precision = 9, scale = 2, nullable = false)
    public BigDecimal d31;

    /** Legado: HORA_REIN_NORM */
    @Column(name = "hora_rein_norm", precision = 9, scale = 2)
    public BigDecimal horaReinNorm;

    /** Legado: HORA_25_REIN_NORM */
    @Column(name = "hora_25_rein_norm", precision = 9, scale = 2)
    public BigDecimal hora25ReinNorm;

    /** Legado: HORA_35_REIN_NORM */
    @Column(name = "hora_35_rein_norm", precision = 9, scale = 2)
    public BigDecimal hora35ReinNorm;

    /** Legado: HORA_REIN_DOMI */
    @Column(name = "hora_rein_domi", precision = 9, scale = 2)
    public BigDecimal horaReinDomi;

    /** Legado: HORA_25_REIN_DOMI */
    @Column(name = "hora_25_rein_domi", precision = 9, scale = 2)
    public BigDecimal hora25ReinDomi;

    /** Legado: HORA_35_REIN_DOMI */
    @Column(name = "hora_35_rein_domi", precision = 9, scale = 2)
    public BigDecimal hora35ReinDomi;

    /** Legado: HORA_REIN_FERI */
    @Column(name = "hora_rein_feri", precision = 9, scale = 2)
    public BigDecimal horaReinFeri;

    /** Legado: HORA_25_REIN_FERI */
    @Column(name = "hora_25_rein_feri", precision = 9, scale = 2)
    public BigDecimal hora25ReinFeri;

    /** Legado: HORA_35_REIN_FERI */
    @Column(name = "hora_35_rein_feri", precision = 9, scale = 2)
    public BigDecimal hora35ReinFeri;

    /** Legado: OBSERVACIONES */
    @Column(name = "observaciones", length = 250)
    public String observaciones;

    /** Legado: INDI_TIEM */
    @Column(name = "indi_tiem", length = 1)
    public String indiTiem;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public LocalDateTime fechInic;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(fechInic, other.fechInic);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, fechInic);
        }
    }
}
