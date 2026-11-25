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
 * Tabla legado <b>dbo.GUIA_TRANSPORTISTA_DETALLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "GuiaTransportistaDetalle")
@Table(name = "guia_transportista_detalle")
@IdClass(GuiaTransportistaDetalle.Pk.class)
public class GuiaTransportistaDetalle extends LegacyEntity {

    /** Legado: ID_GUIA */
    @Id
    @Column(name = "id_guia", nullable = false)
    public Long idGuia;

    @Id
    @Column(name = "item", nullable = false)
    public Integer item;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "descripcion", length = 200)
    public String descripcion;

    @Column(name = "cantidad", precision = 18, scale = 3)
    public BigDecimal cantidad;

    @Column(name = "peso", precision = 18, scale = 3)
    public BigDecimal peso;

    @Column(name = "codi_unid_medi", length = 2)
    public String codiUnidMedi;

    @Column(name = "costo_minimo", precision = 18, scale = 4)
    public BigDecimal costoMinimo;

    @Column(name = "precio", precision = 18, scale = 3)
    public BigDecimal precio;

    @Column(name = "total", precision = 18, scale = 3)
    public BigDecimal total;

    @Column(name = "codi_deta_oss")
    public Long codiDetaOss;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long idGuia;
        public Integer item;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(idGuia, other.idGuia)
                && Objects.equals(item, other.item);
        }

        @Override
        public int hashCode() {
            return Objects.hash(idGuia, item);
        }
    }
}
