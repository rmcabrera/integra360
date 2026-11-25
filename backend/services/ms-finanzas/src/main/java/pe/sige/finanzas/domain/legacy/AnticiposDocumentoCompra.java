package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ANTICIPOS_DOCUMENTO_COMPRA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AnticiposDocumentoCompra")
@Table(name = "anticipos_documento_compra")
@IdClass(AnticiposDocumentoCompra.Pk.class)
public class AnticiposDocumentoCompra extends LegacyEntity {

    /** Legado: CODI_ANTI */
    @Id
    @Column(name = "codi_anti", length = 20, nullable = false)
    public String codiAnti;

    /** Legado: CODI_TIPO_DOCU */
    @Column(name = "codi_tipo_docu", length = 4, nullable = false)
    public String codiTipoDocu;

    /** Legado: CODI_DOCU_CV */
    @Id
    @Column(name = "codi_docu_cv", length = 10, nullable = false)
    public String codiDocuCv;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiAnti;
        public String codiDocuCv;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiAnti, other.codiAnti)
                && Objects.equals(codiDocuCv, other.codiDocuCv);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiAnti, codiDocuCv);
        }
    }
}
