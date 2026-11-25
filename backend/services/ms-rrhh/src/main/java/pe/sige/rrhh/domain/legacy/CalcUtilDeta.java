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
 * Tabla legado <b>dbo.CALC_UTIL_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CalcUtilDeta")
@Table(name = "calc_util_deta")
@IdClass(CalcUtilDeta.Pk.class)
public class CalcUtilDeta extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: ANIO */
    @Id
    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    /** Legado: CODI_CONC */
    @Id
    @Column(name = "codi_conc", length = 7, nullable = false)
    public String codiConc;

    /** Legado: VALOR */
    @Column(name = "valor", precision = 18, scale = 2)
    public BigDecimal valor;

    /** Legado: MONTO */
    @Column(name = "monto", precision = 18, scale = 2)
    public BigDecimal monto;

    /** Legado: CODI_AUXI */
    @Column(name = "codi_auxi", length = 10)
    public String codiAuxi;

    @Column(name = "nro_pago")
    public Integer nroPago;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public String anio;
        public String codiConc;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(anio, other.anio)
                && Objects.equals(codiConc, other.codiConc);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, anio, codiConc);
        }
    }
}
