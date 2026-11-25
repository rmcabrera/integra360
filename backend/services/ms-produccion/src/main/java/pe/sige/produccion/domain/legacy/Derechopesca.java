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
 * Tabla legado <b>dbo.DERECHOPESCA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Derechopesca")
@Table(name = "derechopesca")
@IdClass(Derechopesca.Pk.class)
public class Derechopesca extends LegacyEntity {

    @Id
    @Column(name = "mesanio", length = 6, nullable = false)
    public String mesanio;

    @Id
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    @Column(name = "captura", precision = 12, scale = 3)
    public BigDecimal captura;

    @Column(name = "factor", precision = 12, scale = 3)
    public BigDecimal factor;

    @Column(name = "derecho", precision = 12, scale = 3)
    public BigDecimal derecho;

    @Column(name = "porcentaje", precision = 12, scale = 3)
    public BigDecimal porcentaje;

    @Column(name = "derechopor", precision = 12, scale = 3)
    public BigDecimal derechopor;

    @Column(name = "credito", precision = 12, scale = 3)
    public BigDecimal credito;

    @Column(name = "deducion", precision = 12, scale = 3)
    public BigDecimal deducion;

    @Column(name = "total", precision = 12, scale = 3)
    public BigDecimal total;

    @Column(name = "aplicar", length = 1)
    public String aplicar;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String mesanio;
        public String codiUnidOper;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(mesanio, other.mesanio)
                && Objects.equals(codiUnidOper, other.codiUnidOper);
        }

        @Override
        public int hashCode() {
            return Objects.hash(mesanio, codiUnidOper);
        }
    }
}
