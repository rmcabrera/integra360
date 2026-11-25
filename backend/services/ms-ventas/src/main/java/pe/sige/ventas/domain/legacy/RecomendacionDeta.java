package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.RECOMENDACION_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "RecomendacionDeta")
@Table(name = "recomendacion_deta")
@IdClass(RecomendacionDeta.Pk.class)
public class RecomendacionDeta extends LegacyEntity {

    @Id
    @Column(name = "codi_rec", nullable = false)
    public Long codiRec;

    @Id
    @Column(name = "codi_deta", nullable = false)
    public Long codiDeta;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "dosis", length = 100)
    public String dosis;

    @Column(name = "descripcion", length = 100)
    public String descripcion;

    @Column(name = "dosis_cant", precision = 18, scale = 2)
    public BigDecimal dosisCant;

    @Column(name = "prec_espe", precision = 18, scale = 2)
    public BigDecimal precEspe;

    @Column(name = "cant_unidad", precision = 12, scale = 3)
    public BigDecimal cantUnidad;

    @Column(name = "total_val", precision = 12, scale = 2)
    public BigDecimal totalVal;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiRec;
        public Long codiDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiRec, other.codiRec)
                && Objects.equals(codiDeta, other.codiDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiRec, codiDeta);
        }
    }
}
