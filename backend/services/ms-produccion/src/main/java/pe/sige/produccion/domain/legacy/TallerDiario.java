package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Taller_Diario</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TallerDiario")
@Table(name = "taller_diario")
@IdClass(TallerDiario.Pk.class)
public class TallerDiario extends LegacyEntity {

    @Column(name = "codi_tall", length = 2, nullable = false)
    public String codiTall;

    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    @Id
    @Column(name = "codi_item", length = 3, nullable = false)
    public String codiItem;

    @Id
    @Column(name = "fecha", nullable = false)
    public LocalDateTime fecha;

    @Column(name = "descripcion", length = 150)
    public String descripcion;

    @Column(name = "monto", precision = 12, scale = 2)
    public BigDecimal monto;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiItem;
        public LocalDateTime fecha;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiItem, other.codiItem)
                && Objects.equals(fecha, other.fecha);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiItem, fecha);
        }
    }
}
