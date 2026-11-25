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
 * Tabla legado <b>dbo.Analisis_Parametro</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AnalisisParametro")
@Table(name = "analisis_parametro")
@IdClass(AnalisisParametro.Pk.class)
public class AnalisisParametro extends LegacyEntity {

    /** Legado: Cod_Analisis */
    @Id
    @Column(name = "cod_analisis", nullable = false)
    public Long codAnalisis;

    /** Legado: Cod_Param */
    @Id
    @Column(name = "cod_param", nullable = false)
    public Short codParam;

    /** Legado: Valor */
    @Column(name = "valor", precision = 18, scale = 2)
    public BigDecimal valor;

    /** Legado: Estado */
    @Column(name = "estado")
    public Short estado;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codAnalisis;
        public Short codParam;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codAnalisis, other.codAnalisis)
                && Objects.equals(codParam, other.codParam);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codAnalisis, codParam);
        }
    }
}
