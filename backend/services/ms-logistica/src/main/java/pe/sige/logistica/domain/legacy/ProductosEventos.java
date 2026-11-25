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
 * Tabla legado <b>dbo.PRODUCTOS_EVENTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ProductosEventos")
@Table(name = "productos_eventos")
@IdClass(ProductosEventos.Pk.class)
public class ProductosEventos extends LegacyEntity {

    @Id
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    @Id
    @Column(name = "fecha", nullable = false)
    public LocalDateTime fecha;

    @Column(name = "evento", length = 255)
    public String evento;

    @Column(name = "tipo", length = 1)
    public String tipo;

    @Column(name = "hecho_por", length = 5)
    public String hechoPor;

    @Column(name = "activo", length = 1)
    public String activo;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiProd;
        public String codiAlma;
        public LocalDateTime fecha;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiProd, other.codiProd)
                && Objects.equals(codiAlma, other.codiAlma)
                && Objects.equals(fecha, other.fecha);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiProd, codiAlma, fecha);
        }
    }
}
