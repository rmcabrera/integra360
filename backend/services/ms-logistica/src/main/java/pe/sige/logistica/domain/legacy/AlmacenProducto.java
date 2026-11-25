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
 * Tabla legado <b>dbo.Almacen_Producto</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AlmacenProducto")
@Table(name = "almacen_producto")
@IdClass(AlmacenProducto.Pk.class)
public class AlmacenProducto extends LegacyEntity {

    /** Legado: Codi_Alma */
    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    /** Legado: Codi_Prod */
    @Id
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    @Column(name = "prec_costo", precision = 18, scale = 3)
    public BigDecimal precCosto;

    @Column(name = "stock_alma", precision = 18, scale = 2)
    public BigDecimal stockAlma;

    @Column(name = "stock_min_alma", precision = 18, scale = 2)
    public BigDecimal stockMinAlma;

    @Column(name = "stock_temp_alma", precision = 18, scale = 2)
    public BigDecimal stockTempAlma;

    @Column(name = "prec_prom_alma", precision = 18, scale = 3)
    public BigDecimal precPromAlma;

    @Column(name = "prec_porc_uti_men", precision = 18, scale = 2)
    public BigDecimal precPorcUtiMen;

    @Column(name = "prec_porc_uti_may", precision = 18, scale = 2)
    public BigDecimal precPorcUtiMay;

    @Column(name = "prec_porc_uti_esp", precision = 18, scale = 2)
    public BigDecimal precPorcUtiEsp;

    @Column(name = "prec", precision = 18, scale = 2)
    public BigDecimal prec;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiAlma;
        public String codiProd;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiAlma, other.codiAlma)
                && Objects.equals(codiProd, other.codiProd);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiAlma, codiProd);
        }
    }
}
