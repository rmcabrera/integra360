package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CONCEPTOS_AFECTOS_PLANILLAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ConceptosAfectosPlanillas")
@Table(name = "conceptos_afectos_planillas")
@IdClass(ConceptosAfectosPlanillas.Pk.class)
public class ConceptosAfectosPlanillas extends LegacyEntity {

    /** Legado: CODI_CONC */
    @Id
    @Column(name = "codi_conc", length = 6, nullable = false)
    public String codiConc;

    /** Legado: CODI_TIPO_PLAN */
    @Id
    @Column(name = "codi_tipo_plan", length = 2, nullable = false)
    public String codiTipoPlan;

    /** Legado: FECH_REGI */
    @Id
    @Column(name = "fech_regi", nullable = false)
    public LocalDateTime fechRegi;

    /** Legado: AFECTO */
    @Column(name = "afecto", nullable = false)
    public Boolean afecto;

    /** Legado: ESTA_ACTI */
    @Column(name = "esta_acti", nullable = false)
    public Boolean estaActi;

    /** Legado: CODI_VALO_UNIT */
    @Column(name = "codi_valo_unit")
    public Integer codiValoUnit;

    /** Legado: RUBRO */
    @Column(name = "rubro", length = 2)
    public String rubro;

    /** Legado: GRUPO */
    @Column(name = "grupo", length = 1)
    public String grupo;

    @Column(name = "formula", length = 250)
    public String formula;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiConc;
        public String codiTipoPlan;
        public LocalDateTime fechRegi;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiConc, other.codiConc)
                && Objects.equals(codiTipoPlan, other.codiTipoPlan)
                && Objects.equals(fechRegi, other.fechRegi);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiConc, codiTipoPlan, fechRegi);
        }
    }
}
