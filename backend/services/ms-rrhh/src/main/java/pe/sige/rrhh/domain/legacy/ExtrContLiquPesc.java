package pe.sige.rrhh.domain.legacy;

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
 * Tabla legado <b>dbo.Extr_Cont_Liqu_pesc</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ExtrContLiquPesc")
@Table(name = "extr_cont_liqu_pesc")
@IdClass(ExtrContLiquPesc.Pk.class)
public class ExtrContLiquPesc extends LegacyEntity {

    /** Legado: CODI_SEMA */
    @Id
    @Column(name = "codi_sema", length = 8, nullable = false)
    public String codiSema;

    /** Legado: CODI_CLIE_PROV */
    @Id
    @Column(name = "codi_clie_prov", length = 5, nullable = false)
    public String codiClieProv;

    /** Legado: PREC_PACT */
    @Id
    @Column(name = "prec_pact", precision = 18, scale = 2, nullable = false)
    public BigDecimal precPact;

    /** Legado: DSCTO */
    @Column(name = "dscto")
    public Long dscto;

    /** Legado: CODI_BANC */
    @Column(name = "codi_banc", length = 2)
    public String codiBanc;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiSema;
        public String codiClieProv;
        public BigDecimal precPact;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiSema, other.codiSema)
                && Objects.equals(codiClieProv, other.codiClieProv)
                && Objects.equals(precPact, other.precPact);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiSema, codiClieProv, precPact);
        }
    }
}
