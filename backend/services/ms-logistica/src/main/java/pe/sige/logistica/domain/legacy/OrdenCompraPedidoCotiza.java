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
 * Tabla legado <b>dbo.ORDEN_COMPRA_PEDIDO_COTIZA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "OrdenCompraPedidoCotiza")
@Table(name = "orden_compra_pedido_cotiza")
@IdClass(OrdenCompraPedidoCotiza.Pk.class)
public class OrdenCompraPedidoCotiza extends LegacyEntity {

    /** Legado: CODI_ORDE_COMP */
    @Id
    @Column(name = "codi_orde_comp", length = 10, nullable = false)
    public String codiOrdeComp;

    /** Legado: CODI_DOCU */
    @Id
    @Column(name = "codi_docu", length = 10, nullable = false)
    public String codiDocu;

    /** Legado: CODI_TIPO_DOCU */
    @Id
    @Column(name = "codi_tipo_docu", length = 4, nullable = false)
    public String codiTipoDocu;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiOrdeComp;
        public String codiDocu;
        public String codiTipoDocu;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiOrdeComp, other.codiOrdeComp)
                && Objects.equals(codiDocu, other.codiDocu)
                && Objects.equals(codiTipoDocu, other.codiTipoDocu);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiOrdeComp, codiDocu, codiTipoDocu);
        }
    }
}
