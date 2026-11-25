package pe.sige.produccion.domain.legacy;

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
 * Tabla legado <b>dbo.PRECIO_PACTADO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PrecioPactado")
@Table(name = "precio_pactado")
@IdClass(PrecioPactado.Pk.class)
public class PrecioPactado extends LegacyEntity {

    /** Legado: CODI_SEMA */
    @Id
    @Column(name = "codi_sema", length = 8, nullable = false)
    public String codiSema;

    /** Legado: CODI_CLIE_PROV */
    @Id
    @Column(name = "codi_clie_prov", length = 5, nullable = false)
    public String codiClieProv;

    /** Legado: CODI_ESPE */
    @Id
    @Column(name = "codi_espe", length = 2, nullable = false)
    public String codiEspe;

    /** Legado: PREC_PACT */
    @Column(name = "prec_pact", precision = 9, scale = 3)
    public BigDecimal precPact;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiSema;
        public String codiClieProv;
        public String codiEspe;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiSema, other.codiSema)
                && Objects.equals(codiClieProv, other.codiClieProv)
                && Objects.equals(codiEspe, other.codiEspe);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiSema, codiClieProv, codiEspe);
        }
    }
}
