package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CREDITOS_DETALLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CreditosDetalle")
@Table(name = "creditos_detalle")
@IdClass(CreditosDetalle.Pk.class)
public class CreditosDetalle extends LegacyEntity {

    @Id
    @Column(name = "codi_credito", nullable = false)
    public Long codiCredito;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codi_deta", nullable = false)
    public Long codiDeta;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "valor", precision = 18, scale = 2)
    public BigDecimal valor;

    @Column(name = "activo", length = 1)
    public String activo;

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
