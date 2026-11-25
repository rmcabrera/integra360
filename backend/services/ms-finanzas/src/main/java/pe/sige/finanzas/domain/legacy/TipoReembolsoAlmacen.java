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
 * Tabla legado <b>dbo.TIPO_REEMBOLSO_ALMACEN</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoReembolsoAlmacen")
@Table(name = "tipo_reembolso_almacen")
@IdClass(TipoReembolsoAlmacen.Pk.class)
public class TipoReembolsoAlmacen extends LegacyEntity {

    @Id
    @Column(name = "tipo_reemb", length = 3, nullable = false)
    public String tipoReemb;

    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String tipoReemb;
        public String codiAlma;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(tipoReemb, other.tipoReemb)
                && Objects.equals(codiAlma, other.codiAlma);
        }

        @Override
        public int hashCode() {
            return Objects.hash(tipoReemb, codiAlma);
        }
    }
}
