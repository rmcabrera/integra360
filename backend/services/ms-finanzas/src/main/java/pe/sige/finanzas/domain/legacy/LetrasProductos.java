package pe.sige.finanzas.domain.legacy;

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
 * Tabla legado <b>dbo.LETRAS_PRODUCTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "LetrasProductos")
@Table(name = "letras_productos")
@IdClass(LetrasProductos.Pk.class)
public class LetrasProductos extends LegacyEntity {

    @Id
    @Column(name = "registro", length = 11, nullable = false)
    public String registro;

    @Id
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    @Column(name = "cantidad", precision = 18, scale = 2)
    public BigDecimal cantidad;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String registro;
        public String codiProd;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(registro, other.registro)
                && Objects.equals(codiProd, other.codiProd);
        }

        @Override
        public int hashCode() {
            return Objects.hash(registro, codiProd);
        }
    }
}
