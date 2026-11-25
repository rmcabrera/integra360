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
 * Tabla legado <b>dbo.CCNU_CLASES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CcnuClases")
@Table(name = "ccnu_clases")
@IdClass(CcnuClases.Pk.class)
public class CcnuClases extends LegacyEntity {

    @Id
    @Column(name = "codi_clas", length = 6, nullable = false)
    public String codiClas;

    /** Legado: codi_Fami */
    @Id
    @Column(name = "codi_fami", length = 4, nullable = false)
    public String codiFami;

    /** Legado: desc_Clas */
    @Column(name = "desc_clas", length = 250)
    public String descClas;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiClas;
        public String codiFami;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiClas, other.codiClas)
                && Objects.equals(codiFami, other.codiFami);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiClas, codiFami);
        }
    }
}
