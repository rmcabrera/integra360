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
 * Tabla legado <b>dbo.RUBROS_CAJA_DETALLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "RubrosCajaDetalle")
@Table(name = "rubros_caja_detalle")
@IdClass(RubrosCajaDetalle.Pk.class)
public class RubrosCajaDetalle extends LegacyEntity {

    @Id
    @Column(name = "id_rubro", nullable = false)
    public Integer idRubro;

    @Id
    @Column(name = "tipo_reemb", length = 3, nullable = false)
    public String tipoReemb;

    @Column(name = "i_o")
    public Integer iO;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Integer idRubro;
        public String tipoReemb;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(idRubro, other.idRubro)
                && Objects.equals(tipoReemb, other.tipoReemb);
        }

        @Override
        public int hashCode() {
            return Objects.hash(idRubro, tipoReemb);
        }
    }
}
