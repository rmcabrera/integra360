package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_FORM_MOST_EEFF</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoFormMostEeff")
@Table(name = "tipo_form_most_eeff")
@IdClass(TipoFormMostEeff.Pk.class)
public class TipoFormMostEeff extends LegacyEntity {

    /** Legado: CODI_TIPO_EEFF */
    @Id
    @Column(name = "codi_tipo_eeff", length = 2, nullable = false)
    public String codiTipoEeff;

    /** Legado: CODI_CLAS_CUEN */
    @Id
    @Column(name = "codi_clas_cuen", length = 2, nullable = false)
    public String codiClasCuen;

    /** Legado: TIPO_FORM_MOST */
    @Column(name = "tipo_form_most", length = 2)
    public String tipoFormMost;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiTipoEeff;
        public String codiClasCuen;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiTipoEeff, other.codiTipoEeff)
                && Objects.equals(codiClasCuen, other.codiClasCuen);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiTipoEeff, codiClasCuen);
        }
    }
}
