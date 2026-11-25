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
 * Tabla legado <b>dbo.PRODUCTOS_LOTES_NOTA_VENTA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ProductosLotesNotaVenta")
@Table(name = "productos_lotes_nota_venta")
@IdClass(ProductosLotesNotaVenta.Pk.class)
public class ProductosLotesNotaVenta extends LegacyEntity {

    @Id
    @Column(name = "codi_deta_ingre_sali", length = 12, nullable = false)
    public String codiDetaIngreSali;

    @Id
    @Column(name = "codi_prod_alma_lote", nullable = false)
    public Long codiProdAlmaLote;

    @Column(name = "cantidad", precision = 18, scale = 2)
    public BigDecimal cantidad;

    @Id
    @Column(name = "codi_nota_venta", nullable = false)
    public Long codiNotaVenta;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiDetaIngreSali;
        public Long codiProdAlmaLote;
        public Long codiNotaVenta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiDetaIngreSali, other.codiDetaIngreSali)
                && Objects.equals(codiProdAlmaLote, other.codiProdAlmaLote)
                && Objects.equals(codiNotaVenta, other.codiNotaVenta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiDetaIngreSali, codiProdAlmaLote, codiNotaVenta);
        }
    }
}
