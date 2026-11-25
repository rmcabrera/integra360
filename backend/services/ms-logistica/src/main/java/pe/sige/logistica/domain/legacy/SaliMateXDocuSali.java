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
 * Tabla legado <b>dbo.SALI_MATE_X_DOCU_SALI</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SaliMateXDocuSali")
@Table(name = "sali_mate_x_docu_sali")
@IdClass(SaliMateXDocuSali.Pk.class)
public class SaliMateXDocuSali extends LegacyEntity {

    /** Legado: CODI_DOCU_SALI_MATE */
    @Id
    @Column(name = "codi_docu_sali_mate", length = 10, nullable = false)
    public String codiDocuSaliMate;

    /** Legado: CODI_DOCU_SALI */
    @Id
    @Column(name = "codi_docu_sali", length = 10, nullable = false)
    public String codiDocuSali;

    @Id
    @Column(name = "tipo_docu_orig_sali", length = 2, nullable = false)
    public String tipoDocuOrigSali;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiDocuSaliMate;
        public String codiDocuSali;
        public String tipoDocuOrigSali;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiDocuSaliMate, other.codiDocuSaliMate)
                && Objects.equals(codiDocuSali, other.codiDocuSali)
                && Objects.equals(tipoDocuOrigSali, other.tipoDocuOrigSali);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiDocuSaliMate, codiDocuSali, tipoDocuOrigSali);
        }
    }
}
