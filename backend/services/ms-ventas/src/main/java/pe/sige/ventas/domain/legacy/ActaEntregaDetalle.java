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
 * Tabla legado <b>dbo.acta_entrega_detalle</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ActaEntregaDetalle")
@Table(name = "acta_entrega_detalle")
@IdClass(ActaEntregaDetalle.Pk.class)
public class ActaEntregaDetalle extends LegacyEntity {

    @Id
    @Column(name = "codi_act", nullable = false)
    public Long codiAct;

    @Id
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    @Column(name = "cantidad", precision = 12, scale = 3)
    public BigDecimal cantidad;

    @Column(name = "descripcion", length = 150)
    public String descripcion;

    /** Legado: ITEM */
    @Id
    @Column(name = "item", nullable = false)
    public Integer item;

    @Column(name = "codi_conv")
    public Long codiConv;

    @Column(name = "item_conv")
    public Integer itemConv;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiAct;
        public String codiProd;
        public Integer item;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiAct, other.codiAct)
                && Objects.equals(codiProd, other.codiProd)
                && Objects.equals(item, other.item);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiAct, codiProd, item);
        }
    }
}
