package pe.sige.logistica.domain.legacy;

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
 * Tabla legado <b>dbo.REGISTRO_ORDEN_PEDIDO_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "RegistroOrdenPedidoDeta")
@Table(name = "registro_orden_pedido_deta")
@IdClass(RegistroOrdenPedidoDeta.Pk.class)
public class RegistroOrdenPedidoDeta extends LegacyEntity {

    @Id
    @Column(name = "codi_orden_pedi", nullable = false)
    public Long codiOrdenPedi;

    @Id
    @Column(name = "codi_deta", nullable = false)
    public Integer codiDeta;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "cantidad", precision = 18, scale = 3)
    public BigDecimal cantidad;

    @Column(name = "cantidad_aux", precision = 12, scale = 2)
    public BigDecimal cantidadAux;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiOrdenPedi;
        public Integer codiDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiOrdenPedi, other.codiOrdenPedi)
                && Objects.equals(codiDeta, other.codiDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiOrdenPedi, codiDeta);
        }
    }
}
