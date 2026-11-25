package pe.sige.contabilidad.domain.legacy;

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
 * Tabla legado <b>dbo.DETALLE_CALC_AF</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DetalleCalcAf")
@Table(name = "detalle_calc_af")
@IdClass(DetalleCalcAf.Pk.class)
public class DetalleCalcAf extends LegacyEntity {

    /** Legado: CODI_ACTIVO */
    @Id
    @Column(name = "codi_activo", length = 7, nullable = false)
    public String codiActivo;

    /** Legado: FECHA_DETALLE */
    @Id
    @Column(name = "fecha_detalle", length = 6, nullable = false)
    public String fechaDetalle;

    /** Legado: FECHA_ACTIVO */
    @Column(name = "fecha_activo", length = 6)
    public String fechaActivo;

    /** Legado: COSTO_HIST */
    @Column(name = "costo_hist", precision = 12, scale = 2)
    public BigDecimal costoHist;

    /** Legado: COSTO_AJUS */
    @Column(name = "costo_ajus", precision = 12, scale = 2)
    public BigDecimal costoAjus;

    /** Legado: DEPRE_HIST_ANT */
    @Column(name = "depre_hist_ant", precision = 12, scale = 2)
    public BigDecimal depreHistAnt;

    /** Legado: DEPRE_HIST_ACT */
    @Column(name = "depre_hist_act", precision = 12, scale = 2)
    public BigDecimal depreHistAct;

    /** Legado: DEPRE_AJUS_ACT */
    @Column(name = "depre_ajus_act", precision = 12, scale = 2)
    public BigDecimal depreAjusAct;

    /** Legado: DEPRE_AJUS_ANT */
    @Column(name = "depre_ajus_ant", precision = 12, scale = 2)
    public BigDecimal depreAjusAnt;

    /** Legado: DEPRE_ACUM_HIST */
    @Column(name = "depre_acum_hist", precision = 12, scale = 2)
    public BigDecimal depreAcumHist;

    /** Legado: DEPRE_ACUM_AJUS */
    @Column(name = "depre_acum_ajus", precision = 12, scale = 2)
    public BigDecimal depreAcumAjus;

    /** Legado: NETO_HIST */
    @Column(name = "neto_hist", precision = 12, scale = 2)
    public BigDecimal netoHist;

    /** Legado: NETO_AJUS */
    @Column(name = "neto_ajus", precision = 12, scale = 2)
    public BigDecimal netoAjus;

    /** Legado: ORIGEN */
    @Column(name = "origen")
    public Boolean origen;

    /** Legado: RETIRADO */
    @Column(name = "retirado", length = 1)
    public String retirado;

    /** Legado: VALOR_DEPRE */
    @Column(name = "valor_depre", precision = 18, scale = 2)
    public BigDecimal valorDepre;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiActivo;
        public String fechaDetalle;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiActivo, other.codiActivo)
                && Objects.equals(fechaDetalle, other.fechaDetalle);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiActivo, fechaDetalle);
        }
    }
}
