package pe.sige.produccion.domain.legacy;

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
 * Tabla legado <b>dbo.ZARPE_COMBUSTIBLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ZarpeCombustible")
@Table(name = "zarpe_combustible")
@IdClass(ZarpeCombustible.Pk.class)
public class ZarpeCombustible extends LegacyEntity {

    /** Legado: CODI_ZARP */
    @Id
    @Column(name = "codi_zarp", length = 10, nullable = false)
    public String codiZarp;

    /** Legado: CODI_PETR */
    @Id
    @Column(name = "codi_petr", length = 3, nullable = false)
    public String codiPetr;

    /** Legado: SER_FACT */
    @Column(name = "ser_fact", length = 5)
    public String serFact;

    /** Legado: NRO_FACT */
    @Column(name = "nro_fact", length = 10)
    public String nroFact;

    /** Legado: CANT_PETR */
    @Column(name = "cant_petr", precision = 12, scale = 3)
    public BigDecimal cantPetr;

    /** Legado: PREC_PETR */
    @Column(name = "prec_petr", precision = 12, scale = 4)
    public BigDecimal precPetr;

    /** Legado: TIPO_DOC */
    @Column(name = "tipo_doc", length = 1)
    public String tipoDoc;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: VALO_VENT */
    @Column(name = "valo_vent", precision = 12, scale = 3)
    public BigDecimal valoVent;

    /** Legado: IGV */
    @Column(name = "igv", precision = 12, scale = 3)
    public BigDecimal igv;

    /** Legado: VALO_TOTA */
    @Column(name = "valo_tota", precision = 12, scale = 3)
    public BigDecimal valoTota;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: TC */
    @Column(name = "tc", precision = 18, scale = 4)
    public BigDecimal tc;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiZarp;
        public String codiPetr;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiZarp, other.codiZarp)
                && Objects.equals(codiPetr, other.codiPetr);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiZarp, codiPetr);
        }
    }
}
