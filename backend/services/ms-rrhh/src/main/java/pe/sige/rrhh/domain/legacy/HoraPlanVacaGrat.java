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
 * Tabla legado <b>dbo.HORA_PLAN_VACA_GRAT</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "HoraPlanVacaGrat")
@Table(name = "hora_plan_vaca_grat")
@IdClass(HoraPlanVacaGrat.Pk.class)
public class HoraPlanVacaGrat extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: FECH_INIC */
    @Id
    @Column(name = "fech_inic", nullable = false)
    public LocalDateTime fechInic;

    /** Legado: CODI_TIPO_PLAN */
    @Id
    @Column(name = "codi_tipo_plan", length = 2, nullable = false)
    public String codiTipoPlan;

    /** Legado: FECH_TERM */
    @Column(name = "fech_term")
    public LocalDateTime fechTerm;

    /** Legado: ANIO */
    @Column(name = "anio", length = 4)
    public String anio;

    /** Legado: MES */
    @Column(name = "mes", length = 2)
    public String mes;

    /** Legado: PROM_REMU_HORA_25 */
    @Column(name = "prom_remu_hora_25", precision = 12, scale = 2)
    public BigDecimal promRemuHora25;

    /** Legado: PROM_REMU_HORA_35 */
    @Column(name = "prom_remu_hora_35", precision = 12, scale = 2)
    public BigDecimal promRemuHora35;

    /** Legado: REMU_OTRO_INGR */
    @Column(name = "remu_otro_ingr", precision = 12, scale = 2)
    public BigDecimal remuOtroIngr;

    /** Legado: NRO_MESE_PAGA */
    @Column(name = "nro_mese_paga")
    public Short nroMesePaga;

    /** Legado: NRO_DIAS_PAGA */
    @Column(name = "nro_dias_paga")
    public Short nroDiasPaga;

    /** Legado: MOTI_OBSE */
    @Column(name = "moti_obse", length = 200)
    public String motiObse;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public LocalDateTime fechInic;
        public String codiTipoPlan;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(fechInic, other.fechInic)
                && Objects.equals(codiTipoPlan, other.codiTipoPlan);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, fechInic, codiTipoPlan);
        }
    }
}
