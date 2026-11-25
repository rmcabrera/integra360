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
 * Tabla legado <b>dbo.CUOTAS_SUCURSAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CuotasSucursal")
@Table(name = "cuotas_sucursal")
@IdClass(CuotasSucursal.Pk.class)
public class CuotasSucursal extends LegacyEntity {

    @Id
    @Column(name = "anio", nullable = false)
    public Integer anio;

    @Id
    @Column(name = "mes", nullable = false)
    public Integer mes;

    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    @Column(name = "monto", precision = 18, scale = 2)
    public BigDecimal monto;

    @Id
    @Column(name = "cod_lin_pro", length = 2, nullable = false)
    public String codLinPro;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Integer anio;
        public Integer mes;
        public String codiAlma;
        public String codLinPro;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(anio, other.anio)
                && Objects.equals(mes, other.mes)
                && Objects.equals(codiAlma, other.codiAlma)
                && Objects.equals(codLinPro, other.codLinPro);
        }

        @Override
        public int hashCode() {
            return Objects.hash(anio, mes, codiAlma, codLinPro);
        }
    }
}
