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
 * Tabla legado <b>dbo.HORA_LABO_SEMA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "HoraLaboSema")
@Table(name = "hora_labo_sema")
@IdClass(HoraLaboSema.Pk.class)
public class HoraLaboSema extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: FECH_INIC */
    @Id
    @Column(name = "fech_inic", nullable = false)
    public LocalDateTime fechInic;

    /** Legado: FECH_term */
    @Column(name = "fech_term", nullable = false)
    public LocalDateTime fechTerm;

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

    /** Legado: ANIO */
    @Id
    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    /** Legado: MES */
    @Id
    @Column(name = "mes", length = 2, nullable = false)
    public String mes;

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

    /** Legado: CODI_TIPO_PERS */
    @Column(name = "codi_tipo_pers", length = 2)
    public String codiTipoPers;

    /** Legado: SEMANA */
    @Column(name = "semana")
    public Short semana;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public LocalDateTime fechInic;
        public String anio;
        public String mes;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(fechInic, other.fechInic)
                && Objects.equals(anio, other.anio)
                && Objects.equals(mes, other.mes);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, fechInic, anio, mes);
        }
    }
}
