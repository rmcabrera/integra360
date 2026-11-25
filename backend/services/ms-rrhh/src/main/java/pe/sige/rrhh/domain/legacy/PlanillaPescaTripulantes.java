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
 * Tabla legado <b>dbo.PLANILLA_PESCA_TRIPULANTES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PlanillaPescaTripulantes")
@Table(name = "planilla_pesca_tripulantes")
@IdClass(PlanillaPescaTripulantes.Pk.class)
public class PlanillaPescaTripulantes extends LegacyEntity {

    @Id
    @Column(name = "codi_sema", length = 8, nullable = false)
    public String codiSema;

    @Id
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    @Id
    @Column(name = "codi_carg", length = 4, nullable = false)
    public String codiCarg;

    @Id
    @Column(name = "dia", nullable = false)
    public LocalDateTime dia;

    @Column(name = "nom_dia", length = 10, nullable = false)
    public String nomDia;

    @Column(name = "pesc_real", precision = 12, scale = 3)
    public BigDecimal pescReal;

    @Column(name = "prec_snp", precision = 12, scale = 3)
    public BigDecimal precSnp;

    @Column(name = "porc_distr", precision = 12, scale = 3)
    public BigDecimal porcDistr;

    @Column(name = "parte", precision = 12, scale = 3)
    public BigDecimal parte;

    @Column(name = "adicional", precision = 12, scale = 3)
    public BigDecimal adicional;

    @Column(name = "monto", precision = 12, scale = 3)
    public BigDecimal monto;

    @Column(name = "refri", precision = 12, scale = 3)
    public BigDecimal refri;

    @Column(name = "espe_parte", precision = 12, scale = 3)
    public BigDecimal espeParte;

    @Column(name = "espe_adic", precision = 12, scale = 3)
    public BigDecimal espeAdic;

    @Column(name = "espe_monto", precision = 12, scale = 3)
    public BigDecimal espeMonto;

    @Id
    @Column(name = "nro_asis", length = 1, nullable = false)
    public String nroAsis;

    @Column(name = "mesanio", length = 6)
    public String mesanio;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiSema;
        public String codiUnidOper;
        public String codiPers;
        public String codiCarg;
        public LocalDateTime dia;
        public String nroAsis;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiSema, other.codiSema)
                && Objects.equals(codiUnidOper, other.codiUnidOper)
                && Objects.equals(codiPers, other.codiPers)
                && Objects.equals(codiCarg, other.codiCarg)
                && Objects.equals(dia, other.dia)
                && Objects.equals(nroAsis, other.nroAsis);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiSema, codiUnidOper, codiPers, codiCarg, dia, nroAsis);
        }
    }
}
