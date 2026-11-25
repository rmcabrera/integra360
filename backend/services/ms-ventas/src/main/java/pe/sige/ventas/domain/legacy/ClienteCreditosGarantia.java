package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CLIENTE_CREDITOS_GARANTIA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ClienteCreditosGarantia")
@Table(name = "cliente_creditos_garantia")
@IdClass(ClienteCreditosGarantia.Pk.class)
public class ClienteCreditosGarantia extends LegacyEntity {

    @Id
    @Column(name = "codi_credito", nullable = false)
    public Long codiCredito;

    @Id
    @Column(name = "doc_garantia", length = 2, nullable = false)
    public String docGarantia;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiCredito;
        public String docGarantia;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiCredito, other.codiCredito)
                && Objects.equals(docGarantia, other.docGarantia);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiCredito, docGarantia);
        }
    }
}
