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
 * Tabla legado <b>dbo.DETALLE_FACTURA_PESCA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DetalleFacturaPesca")
@Table(name = "detalle_factura_pesca")
@IdClass(DetalleFacturaPesca.Pk.class)
public class DetalleFacturaPesca extends LegacyEntity {

    /** Legado: CODI_FACT_PESC */
    @Id
    @Column(name = "codi_fact_pesc", length = 10, nullable = false)
    public String codiFactPesc;

    /** Legado: CODI_DETA_ZARP */
    @Id
    @Column(name = "codi_deta_zarp", length = 15, nullable = false)
    public String codiDetaZarp;

    /** Legado: CANT_TONE */
    @Column(name = "cant_tone", precision = 12, scale = 3, nullable = false)
    public BigDecimal cantTone;

    /** Legado: PREC_UNIT */
    @Column(name = "prec_unit", precision = 12, scale = 3, nullable = false)
    public BigDecimal precUnit;

    /** Legado: SUB_TOTA */
    @Column(name = "sub_tota", precision = 12, scale = 3, nullable = false)
    public BigDecimal subTota;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiFactPesc;
        public String codiDetaZarp;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiFactPesc, other.codiFactPesc)
                && Objects.equals(codiDetaZarp, other.codiDetaZarp);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiFactPesc, codiDetaZarp);
        }
    }
}
