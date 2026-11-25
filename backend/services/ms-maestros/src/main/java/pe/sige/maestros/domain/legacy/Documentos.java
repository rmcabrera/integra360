package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Documentos</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Documentos")
@Table(name = "documentos")
@IdClass(Documentos.Pk.class)
public class Documentos extends LegacyEntity {

    /** Legado: Codi_Tipo_Docu */
    @Id
    @Column(name = "codi_tipo_docu", length = 4, nullable = false)
    public String codiTipoDocu;

    /** Legado: Serie */
    @Id
    @Column(name = "serie", nullable = false)
    public Short serie;

    /** Legado: Nro_Actual */
    @Column(name = "nro_actual", nullable = false)
    public Integer nroActual;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiTipoDocu;
        public Short serie;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiTipoDocu, other.codiTipoDocu)
                && Objects.equals(serie, other.serie);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiTipoDocu, serie);
        }
    }
}
