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
 * Tabla legado <b>dbo.METAS_LINEA_ROTA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "MetasLineaRota")
@Table(name = "metas_linea_rota")
@IdClass(MetasLineaRota.Pk.class)
public class MetasLineaRota extends LegacyEntity {

    @Id
    @Column(name = "cod_lin_pro", length = 2, nullable = false)
    public String codLinPro;

    @Id
    @Column(name = "codi_rota", nullable = false)
    public Integer codiRota;

    @Column(name = "meta1", precision = 18, scale = 2)
    public BigDecimal meta1;

    @Column(name = "meta2", precision = 18, scale = 2)
    public BigDecimal meta2;

    @Column(name = "meta3", precision = 18, scale = 2)
    public BigDecimal meta3;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codLinPro;
        public Integer codiRota;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codLinPro, other.codLinPro)
                && Objects.equals(codiRota, other.codiRota);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codLinPro, codiRota);
        }
    }
}
