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
 * Tabla legado <b>dbo.PRODUCTOS_BAJA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ProductosBaja")
@Table(name = "productos_baja")
@IdClass(ProductosBaja.Pk.class)
public class ProductosBaja extends LegacyEntity {

    @Id
    @Column(name = "id_ven", nullable = false)
    public Integer idVen;

    @Id
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    @Column(name = "codi_rota")
    public Long codiRota;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Integer idVen;
        public String codiProd;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(idVen, other.idVen)
                && Objects.equals(codiProd, other.codiProd);
        }

        @Override
        public int hashCode() {
            return Objects.hash(idVen, codiProd);
        }
    }
}
