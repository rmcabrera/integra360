package pe.sige.contabilidad.domain.legacy;

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
 * Tabla legado <b>dbo.Retencion</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Retencion")
@Table(name = "retencion")
@IdClass(Retencion.Pk.class)
public class Retencion extends LegacyEntity {

    @Id
    @Column(name = "serie", nullable = false)
    public Long serie;

    /** Legado: Num */
    @Id
    @Column(name = "num", nullable = false)
    public Long num;

    /** Legado: Subdia */
    @Column(name = "subdia", length = 1)
    public String subdia;

    /** Legado: Compr */
    @Column(name = "compr", length = 4)
    public String compr;

    /** Legado: Mes */
    @Column(name = "mes", length = 2)
    public String mes;

    /** Legado: Anio */
    @Column(name = "anio", length = 4)
    public String anio;

    /** Legado: Banco */
    @Column(name = "banco", length = 7)
    public String banco;

    @Column(name = "monto", precision = 18, scale = 2)
    public BigDecimal monto;

    @Column(name = "anulado", length = 1)
    public String anulado;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long serie;
        public Long num;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(serie, other.serie)
                && Objects.equals(num, other.num);
        }

        @Override
        public int hashCode() {
            return Objects.hash(serie, num);
        }
    }
}
