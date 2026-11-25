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
 * Tabla legado <b>dbo.CCNU_FAMILIAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CcnuFamilias")
@Table(name = "ccnu_familias")
@IdClass(CcnuFamilias.Pk.class)
public class CcnuFamilias extends LegacyEntity {

    @Id
    @Column(name = "codi_fami", length = 4, nullable = false)
    public String codiFami;

    /** Legado: cod_Seg */
    @Id
    @Column(name = "cod_seg", length = 2, nullable = false)
    public String codSeg;

    @Column(name = "desc_fami", length = 250)
    public String descFami;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiFami;
        public String codSeg;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiFami, other.codiFami)
                && Objects.equals(codSeg, other.codSeg);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiFami, codSeg);
        }
    }
}
