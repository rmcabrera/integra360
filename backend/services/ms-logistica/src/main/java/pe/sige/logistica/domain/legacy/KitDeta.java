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
 * Tabla legado <b>dbo.KIT_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "KitDeta")
@Table(name = "kit_deta")
@IdClass(KitDeta.Pk.class)
public class KitDeta extends LegacyEntity {

    /** Legado: CODI_KIT_INTE */
    @Id
    @Column(name = "codi_kit_inte", length = 4, nullable = false)
    public String codiKitInte;

    /** Legado: NRO_ITEM */
    @Id
    @Column(name = "nro_item", nullable = false)
    public Integer nroItem;

    /** Legado: CODI_PROD */
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    /** Legado: CANTIDAD */
    @Column(name = "cantidad", precision = 9, scale = 2)
    public BigDecimal cantidad;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiKitInte;
        public Integer nroItem;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiKitInte, other.codiKitInte)
                && Objects.equals(nroItem, other.nroItem);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiKitInte, nroItem);
        }
    }
}
