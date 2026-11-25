package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PROVEEDOR_PRODUCTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ProveedorProductos")
@Table(name = "proveedor_productos")
@IdClass(ProveedorProductos.Pk.class)
public class ProveedorProductos extends LegacyEntity {

    /** Legado: CODI_CLIE_PROV */
    @Id
    @Column(name = "codi_clie_prov", length = 5, nullable = false)
    public String codiClieProv;

    /** Legado: CODI_FAMI_PROD */
    @Id
    @Column(name = "codi_fami_prod", length = 2, nullable = false)
    public String codiFamiProd;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiClieProv;
        public String codiFamiProd;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiClieProv, other.codiClieProv)
                && Objects.equals(codiFamiProd, other.codiFamiProd);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiClieProv, codiFamiProd);
        }
    }
}
