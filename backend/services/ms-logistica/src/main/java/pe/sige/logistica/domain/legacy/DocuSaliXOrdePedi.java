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
 * Tabla legado <b>dbo.DOCU_SALI_X_ORDE_PEDI</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DocuSaliXOrdePedi")
@Table(name = "docu_sali_x_orde_pedi")
@IdClass(DocuSaliXOrdePedi.Pk.class)
public class DocuSaliXOrdePedi extends LegacyEntity {

    /** Legado: CODI_DOCU_SALI */
    @Id
    @Column(name = "codi_docu_sali", length = 10, nullable = false)
    public String codiDocuSali;

    /** Legado: CODI_ORDE_PEDI */
    @Id
    @Column(name = "codi_orde_pedi", length = 10, nullable = false)
    public String codiOrdePedi;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiDocuSali;
        public String codiOrdePedi;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiDocuSali, other.codiDocuSali)
                && Objects.equals(codiOrdePedi, other.codiOrdePedi);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiDocuSali, codiOrdePedi);
        }
    }
}
