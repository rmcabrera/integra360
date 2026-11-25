package pe.sige.ventas.domain.legacy;

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
 * Tabla legado <b>dbo.BOLETAS_DETALLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "BoletasDetalle")
@Table(name = "boletas_detalle")
@IdClass(BoletasDetalle.Pk.class)
public class BoletasDetalle extends LegacyEntity {

    /** Legado: CODI_BOLE */
    @Id
    @Column(name = "codi_bole", length = 10, nullable = false)
    public String codiBole;

    /** Legado: CODI_DETA */
    @Id
    @Column(name = "codi_deta", length = 3, nullable = false)
    public String codiDeta;

    /** Legado: CODI_ITEM */
    @Column(name = "codi_item", length = 10)
    public String codiItem;

    /** Legado: DESCRIPCION */
    @Column(name = "descripcion")
    public String descripcion;

    /** Legado: CANT_ITEM */
    @Column(name = "cant_item", precision = 12, scale = 2)
    public BigDecimal cantItem;

    /** Legado: PRECIO */
    @Column(name = "precio", precision = 12, scale = 2)
    public BigDecimal precio;

    /** Legado: TOTAL */
    @Column(name = "total", precision = 12, scale = 2)
    public BigDecimal total;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiBole;
        public String codiDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiBole, other.codiBole)
                && Objects.equals(codiDeta, other.codiDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiBole, codiDeta);
        }
    }
}
