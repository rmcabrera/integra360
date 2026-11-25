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
 * Tabla legado <b>dbo.DETALLE_ORDEN_COMPRA_DISTRIBUCION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DetalleOrdenCompraDistribucion")
@Table(name = "detalle_orden_compra_distribucion")
@IdClass(DetalleOrdenCompraDistribucion.Pk.class)
public class DetalleOrdenCompraDistribucion extends LegacyEntity {

    /** Legado: CODI_ORDE_COMP */
    @Id
    @Column(name = "codi_orde_comp", length = 10, nullable = false)
    public String codiOrdeComp;

    /** Legado: CODI_PROD */
    @Id
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    /** Legado: CODI_ALMA */
    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    /** Legado: CANTIDAD */
    @Column(name = "cantidad", precision = 18, scale = 4)
    public BigDecimal cantidad;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiOrdeComp;
        public String codiProd;
        public String codiAlma;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiOrdeComp, other.codiOrdeComp)
                && Objects.equals(codiProd, other.codiProd)
                && Objects.equals(codiAlma, other.codiAlma);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiOrdeComp, codiProd, codiAlma);
        }
    }
}
