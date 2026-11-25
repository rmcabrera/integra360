package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ORDEN_PRODUCCION_FACTURA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "OrdenProduccionFactura")
@Table(name = "orden_produccion_factura")
@IdClass(OrdenProduccionFactura.Pk.class)
public class OrdenProduccionFactura extends LegacyEntity {

    /** Legado: Codi_Orde_Produc */
    @Id
    @Column(name = "codi_orde_produc", nullable = false)
    public Integer codiOrdeProduc;

    /** Legado: Codi_Fact */
    @Id
    @Column(name = "codi_fact", nullable = false)
    public Integer codiFact;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Integer codiOrdeProduc;
        public Integer codiFact;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiOrdeProduc, other.codiOrdeProduc)
                && Objects.equals(codiFact, other.codiFact);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiOrdeProduc, codiFact);
        }
    }
}
