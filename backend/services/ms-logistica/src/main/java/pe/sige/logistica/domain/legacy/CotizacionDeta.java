package pe.sige.logistica.domain.legacy;

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
 * Tabla legado <b>dbo.COTIZACION_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CotizacionDeta")
@Table(name = "cotizacion_deta")
@IdClass(CotizacionDeta.Pk.class)
public class CotizacionDeta extends LegacyEntity {

    @Id
    @Column(name = "codi_coti", nullable = false)
    public Long codiCoti;

    @Id
    @Column(name = "codi_deta", nullable = false)
    public Integer codiDeta;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "cantidad", precision = 18, scale = 3)
    public BigDecimal cantidad;

    @Column(name = "stock", precision = 18, scale = 3)
    public BigDecimal stock;

    @Column(name = "p_unit", precision = 18, scale = 3)
    public BigDecimal pUnit;

    @Column(name = "total", precision = 18, scale = 3)
    public BigDecimal total;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiCoti;
        public Integer codiDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiCoti, other.codiCoti)
                && Objects.equals(codiDeta, other.codiDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiCoti, codiDeta);
        }
    }
}
