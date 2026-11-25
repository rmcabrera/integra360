package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ALMACEN_DOCUMENTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AlmacenDocumentos")
@Table(name = "almacen_documentos")
@IdClass(AlmacenDocumentos.Pk.class)
public class AlmacenDocumentos extends LegacyEntity {

    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    @Id
    @Column(name = "codi_tipo_docu", length = 4, nullable = false)
    public String codiTipoDocu;

    @Id
    @Column(name = "serie_alma", length = 5, nullable = false)
    public String serieAlma;

    @Column(name = "nro_docu_empieza")
    public Long nroDocuEmpieza;

    @Column(name = "nro_actual")
    public Long nroActual;

    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "tipo_fact", length = 1)
    public String tipoFact;

    @Column(name = "codi_cont_docu")
    public Long codiContDocu;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiAlma;
        public String codiTipoDocu;
        public String serieAlma;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiAlma, other.codiAlma)
                && Objects.equals(codiTipoDocu, other.codiTipoDocu)
                && Objects.equals(serieAlma, other.serieAlma);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiAlma, codiTipoDocu, serieAlma);
        }
    }
}
