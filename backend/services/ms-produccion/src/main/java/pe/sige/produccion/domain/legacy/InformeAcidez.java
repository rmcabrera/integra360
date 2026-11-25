package pe.sige.produccion.domain.legacy;

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
 * Tabla legado <b>dbo.INFORME_ACIDEZ</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "InformeAcidez")
@Table(name = "informe_acidez")
@IdClass(InformeAcidez.Pk.class)
public class InformeAcidez extends LegacyEntity {

    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    @Id
    @Column(name = "fecha", length = 10, nullable = false)
    public String fecha;

    @Column(name = "peso", precision = 18, scale = 2)
    public BigDecimal peso;

    @Column(name = "superior", precision = 18, scale = 2)
    public BigDecimal superior;

    @Column(name = "medio", precision = 18, scale = 2)
    public BigDecimal medio;

    @Column(name = "compo", precision = 18, scale = 2)
    public BigDecimal compo;

    @Column(name = "fondo", precision = 18, scale = 2)
    public BigDecimal fondo;

    @Column(name = "solidos", precision = 18, scale = 2)
    public BigDecimal solidos;

    @Column(name = "altura", precision = 18, scale = 2)
    public BigDecimal altura;

    @Column(name = "observaciones", length = 100)
    public String observaciones;

    @Column(name = "hora", length = 10)
    public String hora;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiAlma;
        public String fecha;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiAlma, other.codiAlma)
                && Objects.equals(fecha, other.fecha);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiAlma, fecha);
        }
    }
}
