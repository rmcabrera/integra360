package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PRODUCTOS_PRECIO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ProductosPrecio")
@Table(name = "productos_precio")
public class ProductosPrecio extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codi_item", nullable = false)
    public Long codiItem;

    @Column(name = "codi_deta_nota_ingr", length = 12)
    public String codiDetaNotaIngr;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "precio", precision = 18, scale = 4)
    public BigDecimal precio;
}
