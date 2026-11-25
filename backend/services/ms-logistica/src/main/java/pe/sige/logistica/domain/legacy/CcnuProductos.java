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
 * Tabla legado <b>dbo.CCNU_PRODUCTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CcnuProductos")
@Table(name = "ccnu_productos")
@IdClass(CcnuProductos.Pk.class)
public class CcnuProductos extends LegacyEntity {

    @Id
    @Column(name = "codi_prod_sunat", length = 8, nullable = false)
    public String codiProdSunat;

    @Id
    @Column(name = "codi_clas", length = 6, nullable = false)
    public String codiClas;

    @Column(name = "desc_prod_sunat", length = 250)
    public String descProdSunat;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiProdSunat;
        public String codiClas;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiProdSunat, other.codiProdSunat)
                && Objects.equals(codiClas, other.codiClas);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiProdSunat, codiClas);
        }
    }
}
