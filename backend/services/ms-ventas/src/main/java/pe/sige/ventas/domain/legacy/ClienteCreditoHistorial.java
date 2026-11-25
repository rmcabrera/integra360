package pe.sige.ventas.domain.legacy;

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
 * Tabla legado <b>dbo.CLIENTE_CREDITO_HISTORIAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ClienteCreditoHistorial")
@Table(name = "cliente_credito_historial")
@IdClass(ClienteCreditoHistorial.Pk.class)
public class ClienteCreditoHistorial extends LegacyEntity {

    @Id
    @Column(name = "codi_credito", nullable = false)
    public Long codiCredito;

    @Id
    @Column(name = "codi_deta", nullable = false)
    public Long codiDeta;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "decripcion", length = 255)
    public String decripcion;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiCredito;
        public Long codiDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiCredito, other.codiCredito)
                && Objects.equals(codiDeta, other.codiDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiCredito, codiDeta);
        }
    }
}
