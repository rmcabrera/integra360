package pe.sige.logistica.domain.legacy;

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
 * Tabla legado <b>dbo.compromisos_pactados_deta</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CompromisosPactadosDeta")
@Table(name = "compromisos_pactados_deta")
@IdClass(CompromisosPactadosDeta.Pk.class)
public class CompromisosPactadosDeta extends LegacyEntity {

    @Id
    @Column(name = "codi_comp", nullable = false)
    public Long codiComp;

    @Id
    @Column(name = "codi_deta", nullable = false)
    public Integer codiDeta;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "cantidad", precision = 18, scale = 3)
    public BigDecimal cantidad;

    @Column(name = "p_unit", precision = 18, scale = 3)
    public BigDecimal pUnit;

    @Column(name = "total", precision = 18, scale = 3)
    public BigDecimal total;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiComp;
        public Integer codiDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiComp, other.codiComp)
                && Objects.equals(codiDeta, other.codiDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiComp, codiDeta);
        }
    }
}
