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
 * Tabla legado <b>dbo.CONCEPTOS_CONTABLES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ConceptosContables")
@Table(name = "conceptos_contables")
@IdClass(ConceptosContables.Pk.class)
public class ConceptosContables extends LegacyEntity {

    /** Legado: CODI_CONC */
    @Id
    @Column(name = "codi_conc", length = 6, nullable = false)
    public String codiConc;

    /** Legado: NRO_CUEN */
    @Id
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    /** Legado: CODI_CONC_FINA */
    @Column(name = "codi_conc_fina", length = 6)
    public String codiConcFina;

    /** Legado: CARG_ABON */
    @Column(name = "carg_abon", length = 1)
    public String cargAbon;

    /** Legado: TIPO_CONT */
    @Id
    @Column(name = "tipo_cont", length = 1, nullable = false)
    public String tipoCont;

    /** Legado: CODI_TIPO_PLAN */
    @Id
    @Column(name = "codi_tipo_plan", length = 2, nullable = false)
    public String codiTipoPlan;

    /** Legado: CODI_TIPO_PROV */
    @Column(name = "codi_tipo_prov", length = 2)
    public String codiTipoProv;

    /** Legado: CODI_TIPO_PERS */
    @Id
    @Column(name = "codi_tipo_pers", length = 2, nullable = false)
    public String codiTipoPers;

    /** Legado: CODI_UNI_OPER */
    @Column(name = "codi_uni_oper", length = 5)
    public String codiUniOper;

    /** Legado: FACT_MULT */
    @Column(name = "fact_mult", precision = 9, scale = 4)
    public BigDecimal factMult;

    /** Legado: CODI_SIST_PENS */
    @Column(name = "codi_sist_pens", length = 2)
    public String codiSistPens;

    /** Legado: CODI_RELA */
    @Column(name = "codi_rela", length = 5)
    public String codiRela;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiConc;
        public String nroCuen;
        public String tipoCont;
        public String codiTipoPlan;
        public String codiTipoPers;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiConc, other.codiConc)
                && Objects.equals(nroCuen, other.nroCuen)
                && Objects.equals(tipoCont, other.tipoCont)
                && Objects.equals(codiTipoPlan, other.codiTipoPlan)
                && Objects.equals(codiTipoPers, other.codiTipoPers);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiConc, nroCuen, tipoCont, codiTipoPlan, codiTipoPers);
        }
    }
}
