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
 * Tabla legado <b>dbo.CALC_UTIL_PERS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CalcUtilPers")
@Table(name = "calc_util_pers")
@IdClass(CalcUtilPers.Pk.class)
public class CalcUtilPers extends LegacyEntity {

    /** Legado: Anio */
    @Id
    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    /** Legado: Codi_Pers */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: Apellidos */
    @Column(name = "apellidos", length = 50)
    public String apellidos;

    /** Legado: Nombres */
    @Column(name = "nombres", length = 50)
    public String nombres;

    /** Legado: Remu_Perc */
    @Column(name = "remu_perc", precision = 18, scale = 2)
    public BigDecimal remuPerc;

    /** Legado: Dias_Labo */
    @Column(name = "dias_labo")
    public Long diasLabo;

    /** Legado: Liq_Remu_Perc */
    @Column(name = "liq_remu_perc", precision = 18, scale = 2)
    public BigDecimal liqRemuPerc;

    /** Legado: Liq_Dias_Labo */
    @Column(name = "liq_dias_labo", precision = 18, scale = 2)
    public BigDecimal liqDiasLabo;

    /** Legado: Liq_Tota */
    @Column(name = "liq_tota", precision = 18, scale = 2)
    public BigDecimal liqTota;

    /** Legado: MES */
    @Column(name = "mes", length = 2)
    public String mes;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String anio;
        public String codiPers;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(anio, other.anio)
                && Objects.equals(codiPers, other.codiPers);
        }

        @Override
        public int hashCode() {
            return Objects.hash(anio, codiPers);
        }
    }
}
