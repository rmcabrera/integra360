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
 * Tabla legado <b>dbo.GRAT_TRIP_DETA_CONC</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "GratTripDetaConc")
@Table(name = "grat_trip_deta_conc")
@IdClass(GratTripDetaConc.Pk.class)
public class GratTripDetaConc extends LegacyEntity {

    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    @Id
    @Column(name = "codi_sema_inic", length = 8, nullable = false)
    public String codiSemaInic;

    @Id
    @Column(name = "codi_sema_fin", length = 8, nullable = false)
    public String codiSemaFin;

    @Id
    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    @Id
    @Column(name = "codi_conc", length = 6, nullable = false)
    public String codiConc;

    @Column(name = "monto", precision = 12, scale = 3)
    public BigDecimal monto;

    @Column(name = "valor", precision = 12, scale = 3)
    public BigDecimal valor;

    /** Legado: CODI_TIPO_PLAN */
    @Id
    @Column(name = "codi_tipo_plan", length = 2, nullable = false)
    public String codiTipoPlan;

    /** Legado: MESANIO_PROV */
    @Column(name = "mesanio_prov", length = 6)
    public String mesanioProv;

    /** Legado: CODI_JUIC */
    @Column(name = "codi_juic", length = 6)
    public String codiJuic;

    /** Legado: MES */
    @Id
    @Column(name = "mes", length = 2, nullable = false)
    public String mes;

    @Id
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public String codiSemaInic;
        public String codiSemaFin;
        public String anio;
        public String codiConc;
        public String codiTipoPlan;
        public String codiUnidOper;
        public String mes;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(codiSemaInic, other.codiSemaInic)
                && Objects.equals(codiSemaFin, other.codiSemaFin)
                && Objects.equals(anio, other.anio)
                && Objects.equals(codiConc, other.codiConc)
                && Objects.equals(codiTipoPlan, other.codiTipoPlan)
                && Objects.equals(codiUnidOper, other.codiUnidOper)
                && Objects.equals(mes, other.mes);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, codiSemaInic, codiSemaFin, anio, codiConc, codiTipoPlan, codiUnidOper, mes);
        }
    }
}
