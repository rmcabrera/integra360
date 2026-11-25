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
 * Tabla legado <b>dbo.CUENTAS_PARTIDA_REPORTE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CuentasPartidaReporte")
@Table(name = "cuentas_partida_reporte")
@IdClass(CuentasPartidaReporte.Pk.class)
public class CuentasPartidaReporte extends LegacyEntity {

    @Id
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    @Id
    @Column(name = "codi_partida", length = 4, nullable = false)
    public String codiPartida;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String nroCuen;
        public String codiPartida;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(nroCuen, other.nroCuen)
                && Objects.equals(codiPartida, other.codiPartida);
        }

        @Override
        public int hashCode() {
            return Objects.hash(nroCuen, codiPartida);
        }
    }
}
