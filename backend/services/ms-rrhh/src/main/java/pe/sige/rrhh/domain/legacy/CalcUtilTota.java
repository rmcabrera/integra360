package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CALC_UTIL_TOTA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CalcUtilTota")
@Table(name = "calc_util_tota")
public class CalcUtilTota extends LegacyEntity {

    /** Legado: Anio */
    @Id
    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    /** Legado: Renta_Neta */
    @Column(name = "renta_neta", precision = 18, scale = 2)
    public BigDecimal rentaNeta;

    /** Legado: Participacion */
    @Column(name = "participacion", precision = 18, scale = 2)
    public BigDecimal participacion;

    /** Legado: Remu_Perc_Tota */
    @Column(name = "remu_perc_tota", precision = 18, scale = 2)
    public BigDecimal remuPercTota;

    /** Legado: Dias_Labo_Tota */
    @Column(name = "dias_labo_tota")
    public Long diasLaboTota;
}
