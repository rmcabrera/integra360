package pe.sige.ventas.domain.legacy;

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
 * Tabla legado <b>dbo.LIQUIDACION_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "LiquidacionDeta")
@Table(name = "liquidacion_deta")
@IdClass(LiquidacionDeta.Pk.class)
public class LiquidacionDeta extends LegacyEntity {

    @Id
    @Column(name = "codi_liqu", nullable = false)
    public Long codiLiqu;

    @Id
    @Column(name = "codi_deta", nullable = false)
    public Integer codiDeta;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "detalle", length = 150)
    public String detalle;

    @Column(name = "f", length = 1)
    public String f;

    @Column(name = "importe", precision = 12, scale = 3)
    public BigDecimal importe;

    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    @Column(name = "serie", length = 10)
    public String serie;

    @Column(name = "nro_docu", length = 20)
    public String nroDocu;

    @Column(name = "tipo_contab", length = 3)
    public String tipoContab;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "nro_recibo", length = 10)
    public String nroRecibo;

    @Column(name = "codi_ruta", length = 5)
    public String codiRuta;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiLiqu;
        public Integer codiDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiLiqu, other.codiLiqu)
                && Objects.equals(codiDeta, other.codiDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiLiqu, codiDeta);
        }
    }
}
