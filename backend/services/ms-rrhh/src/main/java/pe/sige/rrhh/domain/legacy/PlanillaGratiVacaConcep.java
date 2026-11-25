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
 * Tabla legado <b>dbo.PLANILLA_GRATI_VACA_CONCEP</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PlanillaGratiVacaConcep")
@Table(name = "planilla_grati_vaca_concep")
@IdClass(PlanillaGratiVacaConcep.Pk.class)
public class PlanillaGratiVacaConcep extends LegacyEntity {

    /** Legado: CODI_PLAN_grva */
    @Id
    @Column(name = "codi_plan_grva", length = 10, nullable = false)
    public String codiPlanGrva;

    /** Legado: CODI_CONC */
    @Id
    @Column(name = "codi_conc", length = 6, nullable = false)
    public String codiConc;

    /** Legado: AFECTO */
    @Column(name = "afecto")
    public Boolean afecto;

    /** Legado: VALOR */
    @Column(name = "valor", precision = 18, scale = 2)
    public BigDecimal valor;

    /** Legado: MONTO */
    @Column(name = "monto", precision = 18, scale = 2)
    public BigDecimal monto;

    /** Legado: CODI */
    @Column(name = "codi", length = 2)
    public String codi;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPlanGrva;
        public String codiConc;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPlanGrva, other.codiPlanGrva)
                && Objects.equals(codiConc, other.codiConc);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPlanGrva, codiConc);
        }
    }
}
