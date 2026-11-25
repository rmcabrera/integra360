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
 * Tabla legado <b>dbo.SOLI_PRES_INGR_DESC</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SoliPresIngrDesc")
@Table(name = "soli_pres_ingr_desc")
@IdClass(SoliPresIngrDesc.Pk.class)
public class SoliPresIngrDesc extends LegacyEntity {

    /** Legado: CODI_SOLI_PRES */
    @Id
    @Column(name = "codi_soli_pres", length = 10, nullable = false)
    public String codiSoliPres;

    /** Legado: NRO_ITEM */
    @Id
    @Column(name = "nro_item", nullable = false)
    public Short nroItem;

    /** Legado: TIPO_MONT */
    @Column(name = "tipo_mont", length = 1)
    public String tipoMont;

    /** Legado: DESC_MONT */
    @Column(name = "desc_mont", length = 100)
    public String descMont;

    /** Legado: MONTO */
    @Column(name = "monto", precision = 15, scale = 4)
    public BigDecimal monto;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiSoliPres;
        public Short nroItem;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiSoliPres, other.codiSoliPres)
                && Objects.equals(nroItem, other.nroItem);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiSoliPres, nroItem);
        }
    }
}
