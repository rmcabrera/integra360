package pe.sige.rrhh.domain.legacy;

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
 * Tabla legado <b>dbo.PLANILLA_SUBS_CONCEPTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PlanillaSubsConcepto")
@Table(name = "planilla_subs_concepto")
@IdClass(PlanillaSubsConcepto.Pk.class)
public class PlanillaSubsConcepto extends LegacyEntity {

    /** Legado: CODI_PLAN_SUBS */
    @Id
    @Column(name = "codi_plan_subs", length = 10, nullable = false)
    public String codiPlanSubs;

    /** Legado: CODI_CONC */
    @Id
    @Column(name = "codi_conc", length = 6, nullable = false)
    public String codiConc;

    /** Legado: AFECTO */
    @Column(name = "afecto", length = 1, nullable = false)
    public String afecto;

    /** Legado: VALOR */
    @Column(name = "valor", precision = 12, scale = 2)
    public BigDecimal valor;

    /** Legado: MONTO */
    @Column(name = "monto", precision = 12, scale = 2)
    public BigDecimal monto;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPlanSubs;
        public String codiConc;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPlanSubs, other.codiPlanSubs)
                && Objects.equals(codiConc, other.codiConc);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPlanSubs, codiConc);
        }
    }
}
