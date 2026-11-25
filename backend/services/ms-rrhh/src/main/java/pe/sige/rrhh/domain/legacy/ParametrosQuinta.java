package pe.sige.rrhh.domain.legacy;

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
 * Tabla legado <b>dbo.PARAMETROS_QUINTA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ParametrosQuinta")
@Table(name = "parametros_quinta")
@IdClass(ParametrosQuinta.Pk.class)
public class ParametrosQuinta extends LegacyEntity {

    /** Legado: NRO_PARA */
    @Id
    @Column(name = "nro_para", nullable = false)
    public Short nroPara;

    /** Legado: FECH_PARA */
    @Id
    @Column(name = "fech_para", nullable = false)
    public LocalDateTime fechPara;

    /** Legado: ESTA_PARA */
    @Column(name = "esta_para", nullable = false)
    public Boolean estaPara;

    /** Legado: NRO_MINI_UIT */
    @Column(name = "nro_mini_uit", nullable = false)
    public Integer nroMiniUit;

    /** Legado: NRO_MAXI_UIT */
    @Column(name = "nro_maxi_uit", nullable = false)
    public Integer nroMaxiUit;

    /** Legado: PORCENTAJE */
    @Column(name = "porcentaje", precision = 9, scale = 2, nullable = false)
    public BigDecimal porcentaje;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Short nroPara;
        public LocalDateTime fechPara;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(nroPara, other.nroPara)
                && Objects.equals(fechPara, other.fechPara);
        }

        @Override
        public int hashCode() {
            return Objects.hash(nroPara, fechPara);
        }
    }
}
