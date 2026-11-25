package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CUEN_X_TIPO_COST</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CuenXTipoCost")
@Table(name = "cuen_x_tipo_cost")
@IdClass(CuenXTipoCost.Pk.class)
public class CuenXTipoCost extends LegacyEntity {

    /** Legado: CODI_TIPO_COST */
    @Id
    @Column(name = "codi_tipo_cost", length = 2, nullable = false)
    public String codiTipoCost;

    /** Legado: NRO_CUEN */
    @Id
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiTipoCost;
        public String nroCuen;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiTipoCost, other.codiTipoCost)
                && Objects.equals(nroCuen, other.nroCuen);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiTipoCost, nroCuen);
        }
    }
}
