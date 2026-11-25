package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.convenio_detalle</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ConvenioDetalle")
@Table(name = "convenio_detalle")
@IdClass(ConvenioDetalle.Pk.class)
public class ConvenioDetalle extends LegacyEntity {

    @Id
    @Column(name = "codi_conv", nullable = false)
    public Long codiConv;

    @Id
    @Column(name = "fecha", nullable = false)
    public LocalDateTime fecha;

    @Id
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    @Column(name = "cantidad", precision = 12, scale = 3)
    public BigDecimal cantidad;

    @Column(name = "descripcion", length = 150)
    public String descripcion;

    /** Legado: ITEM */
    @Column(name = "item")
    public Integer item;

    @Column(name = "estado")
    public Integer estado;

    @Column(name = "saldo", precision = 12, scale = 3)
    public BigDecimal saldo;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiConv;
        public LocalDateTime fecha;
        public String codiProd;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiConv, other.codiConv)
                && Objects.equals(fecha, other.fecha)
                && Objects.equals(codiProd, other.codiProd);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiConv, fecha, codiProd);
        }
    }
}
