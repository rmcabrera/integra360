package pe.sige.ventas.domain.legacy;

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
 * Tabla legado <b>dbo.HOJA_VIDA_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "HojaVidaDeta")
@Table(name = "hoja_vida_deta")
@IdClass(HojaVidaDeta.Pk.class)
public class HojaVidaDeta extends LegacyEntity {

    @Id
    @Column(name = "codi_hoja", nullable = false)
    public Long codiHoja;

    @Id
    @Column(name = "codi_deta", nullable = false)
    public Integer codiDeta;

    @Column(name = "diagnostico", length = 150)
    public String diagnostico;

    @Column(name = "recomendacion", length = 150)
    public String recomendacion;

    @Column(name = "dosis", precision = 18, scale = 3)
    public BigDecimal dosis;

    @Column(name = "gasto", precision = 18, scale = 3)
    public BigDecimal gasto;

    @Column(name = "gasto_agro", precision = 18, scale = 3)
    public BigDecimal gastoAgro;

    @Column(name = "gasto_total", precision = 18, scale = 3)
    public BigDecimal gastoTotal;

    @Column(name = "etapa", length = 50)
    public String etapa;

    @Column(name = "fecha_prog")
    public LocalDateTime fechaProg;

    @Column(name = "fecha_vis")
    public LocalDateTime fechaVis;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiHoja;
        public Integer codiDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiHoja, other.codiHoja)
                && Objects.equals(codiDeta, other.codiDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiHoja, codiDeta);
        }
    }
}
