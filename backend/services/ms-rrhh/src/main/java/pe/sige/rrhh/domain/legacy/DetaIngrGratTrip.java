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
 * Tabla legado <b>dbo.DETA_INGR_GRAT_TRIP</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DetaIngrGratTrip")
@Table(name = "deta_ingr_grat_trip")
@IdClass(DetaIngrGratTrip.Pk.class)
public class DetaIngrGratTrip extends LegacyEntity {

    /** Legado: codi_Sema */
    @Id
    @Column(name = "codi_sema", length = 8, nullable = false)
    public String codiSema;

    @Id
    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: CODI_CARG */
    @Column(name = "codi_carg", length = 5)
    public String codiCarg;

    /** Legado: CODI_UNID_OPER */
    @Id
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    /** Legado: GRATI */
    @Column(name = "grati", precision = 12, scale = 3)
    public BigDecimal grati;

    /** Legado: IMPORTE */
    @Column(name = "importe", precision = 12, scale = 3)
    public BigDecimal importe;

    /** Legado: PORC_PART */
    @Column(name = "porc_part", precision = 12, scale = 3)
    public BigDecimal porcPart;

    /** Legado: NRO_SEMA */
    @Column(name = "nro_sema")
    public Short nroSema;

    /** Legado: CODI_TIPO_PLAN */
    @Id
    @Column(name = "codi_tipo_plan", length = 2, nullable = false)
    public String codiTipoPlan;

    /** Legado: MESANIO_PROV */
    @Column(name = "mesanio_prov", length = 6)
    public String mesanioProv;

    /** Legado: CODI_PLAN_ORIG */
    @Id
    @Column(name = "codi_plan_orig", length = 2, nullable = false)
    public String codiPlanOrig;

    /** Legado: MES */
    @Id
    @Column(name = "mes", length = 2, nullable = false)
    public String mes;

    /** Legado: TIPO_CAMB */
    @Column(name = "tipo_camb", precision = 9, scale = 4)
    public BigDecimal tipoCamb;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiSema;
        public String anio;
        public String codiPers;
        public String codiUnidOper;
        public String codiTipoPlan;
        public String codiPlanOrig;
        public String mes;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiSema, other.codiSema)
                && Objects.equals(anio, other.anio)
                && Objects.equals(codiPers, other.codiPers)
                && Objects.equals(codiUnidOper, other.codiUnidOper)
                && Objects.equals(codiTipoPlan, other.codiTipoPlan)
                && Objects.equals(codiPlanOrig, other.codiPlanOrig)
                && Objects.equals(mes, other.mes);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiSema, anio, codiPers, codiUnidOper, codiTipoPlan, codiPlanOrig, mes);
        }
    }
}
