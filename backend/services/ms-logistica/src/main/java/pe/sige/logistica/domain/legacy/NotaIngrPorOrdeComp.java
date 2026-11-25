package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.NOTA_INGR_POR_ORDE_COMP</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "NotaIngrPorOrdeComp")
@Table(name = "nota_ingr_por_orde_comp")
@IdClass(NotaIngrPorOrdeComp.Pk.class)
public class NotaIngrPorOrdeComp extends LegacyEntity {

    /** Legado: CODI_ORDE_COMP */
    @Id
    @Column(name = "codi_orde_comp", length = 10, nullable = false)
    public String codiOrdeComp;

    /** Legado: CODI_NOTA_INGR */
    @Id
    @Column(name = "codi_nota_ingr", length = 10, nullable = false)
    public String codiNotaIngr;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiOrdeComp;
        public String codiNotaIngr;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiOrdeComp, other.codiOrdeComp)
                && Objects.equals(codiNotaIngr, other.codiNotaIngr);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiOrdeComp, codiNotaIngr);
        }
    }
}
