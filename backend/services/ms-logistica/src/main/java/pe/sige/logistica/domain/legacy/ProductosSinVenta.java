package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PRODUCTOS_SIN_VENTA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ProductosSinVenta")
@Table(name = "productos_sin_venta")
@IdClass(ProductosSinVenta.Pk.class)
public class ProductosSinVenta extends LegacyEntity {

    @Id
    @Column(name = "fecha", nullable = false)
    public LocalDateTime fecha;

    @Id
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    @Column(name = "desc_prod", length = 150)
    public String descProd;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "ultimaventa")
    public LocalDateTime ultimaventa;

    @Column(name = "plazo")
    public LocalDateTime plazo;

    @Column(name = "diassinventa")
    public Long diassinventa;

    @Column(name = "observaciones", length = 255)
    public String observaciones;

    @Column(name = "codi_usua", length = 5)
    public String codiUsua;

    @Column(name = "creacion")
    public LocalDateTime creacion;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public LocalDateTime fecha;
        public String codiProd;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(fecha, other.fecha)
                && Objects.equals(codiProd, other.codiProd);
        }

        @Override
        public int hashCode() {
            return Objects.hash(fecha, codiProd);
        }
    }
}
