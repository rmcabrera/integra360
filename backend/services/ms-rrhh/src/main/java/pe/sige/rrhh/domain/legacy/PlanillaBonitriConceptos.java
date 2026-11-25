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
 * Tabla legado <b>dbo.Planilla_BoniTri_Conceptos</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PlanillaBonitriConceptos")
@Table(name = "planilla_bonitri_conceptos")
@IdClass(PlanillaBonitriConceptos.Pk.class)
public class PlanillaBonitriConceptos extends LegacyEntity {

    /** Legado: CODI_PLAN_BTRI */
    @Id
    @Column(name = "codi_plan_btri", length = 10, nullable = false)
    public String codiPlanBtri;

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

    /** Legado: ESPECIAL */
    @Column(name = "especial", precision = 12, scale = 3)
    public BigDecimal especial;

    @Column(name = "codi", length = 2)
    public String codi;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPlanBtri;
        public String codiConc;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPlanBtri, other.codiPlanBtri)
                && Objects.equals(codiConc, other.codiConc);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPlanBtri, codiConc);
        }
    }
}
