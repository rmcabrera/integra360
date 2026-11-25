package pe.sige.rrhh.domain.legacy;

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
 * Tabla legado <b>dbo.VALORES_SISTEMA_PENSIONES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ValoresSistemaPensiones")
@Table(name = "valores_sistema_pensiones")
@IdClass(ValoresSistemaPensiones.Pk.class)
public class ValoresSistemaPensiones extends LegacyEntity {

    /** Legado: CODI_SIST_PENS */
    @Id
    @Column(name = "codi_sist_pens", length = 2, nullable = false)
    public String codiSistPens;

    /** Legado: CODI_RUBR */
    @Id
    @Column(name = "codi_rubr", length = 3, nullable = false)
    public String codiRubr;

    /** Legado: ANIO_MES */
    @Id
    @Column(name = "anio_mes", length = 6, nullable = false)
    public String anioMes;

    /** Legado: VALOR */
    @Column(name = "valor", precision = 10, scale = 2, nullable = false)
    public BigDecimal valor;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiSistPens;
        public String codiRubr;
        public String anioMes;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiSistPens, other.codiSistPens)
                && Objects.equals(codiRubr, other.codiRubr)
                && Objects.equals(anioMes, other.anioMes);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiSistPens, codiRubr, anioMes);
        }
    }
}
