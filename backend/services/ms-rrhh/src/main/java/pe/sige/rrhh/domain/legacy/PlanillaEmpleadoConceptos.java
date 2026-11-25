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
 * Tabla legado <b>dbo.PLANILLA_EMPLEADO_CONCEPTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PlanillaEmpleadoConceptos")
@Table(name = "planilla_empleado_conceptos")
@IdClass(PlanillaEmpleadoConceptos.Pk.class)
public class PlanillaEmpleadoConceptos extends LegacyEntity {

    /** Legado: CODI_PLAN_EMPL */
    @Id
    @Column(name = "codi_plan_empl", length = 10, nullable = false)
    public String codiPlanEmpl;

    /** Legado: CODI_CONC */
    @Id
    @Column(name = "codi_conc", length = 6, nullable = false)
    public String codiConc;

    /** Legado: AFECTO */
    @Column(name = "afecto", nullable = false)
    public Boolean afecto;

    /** Legado: VALOR */
    @Column(name = "valor", precision = 12, scale = 2, nullable = false)
    public BigDecimal valor;

    /** Legado: MONTO */
    @Column(name = "monto", precision = 12, scale = 2)
    public BigDecimal monto;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPlanEmpl;
        public String codiConc;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPlanEmpl, other.codiPlanEmpl)
                && Objects.equals(codiConc, other.codiConc);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPlanEmpl, codiConc);
        }
    }
}
