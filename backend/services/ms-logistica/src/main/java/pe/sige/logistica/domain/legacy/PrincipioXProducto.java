package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PRINCIPIO_X_PRODUCTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PrincipioXProducto")
@Table(name = "principio_x_producto")
@IdClass(PrincipioXProducto.Pk.class)
public class PrincipioXProducto extends LegacyEntity {

    @Id
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sec", nullable = false)
    public Integer sec;

    @Column(name = "codi_prin", length = 3)
    public String codiPrin;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiProd;
        public Integer sec;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiProd, other.codiProd)
                && Objects.equals(sec, other.sec);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiProd, sec);
        }
    }
}
