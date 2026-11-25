package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PUNTO_EQUILIBRIO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PuntoEquilibrio")
@Table(name = "punto_equilibrio")
public class PuntoEquilibrio extends LegacyEntity {

    @Id
    @Column(name = "mesanio", length = 6, nullable = false)
    public String mesanio;

    @Column(name = "costo_fijo", precision = 18, scale = 2)
    public BigDecimal costoFijo;

    @Column(name = "costo_vari", precision = 18, scale = 2)
    public BigDecimal costoVari;

    @Column(name = "costo_tota", precision = 18, scale = 2)
    public BigDecimal costoTota;

    /** Legado: Toneladas */
    @Column(name = "toneladas", precision = 18, scale = 3)
    public BigDecimal toneladas;

    @Column(name = "ventas", precision = 18, scale = 2)
    public BigDecimal ventas;

    /** Legado: Costo_vari_uni */
    @Column(name = "costo_vari_uni", precision = 20, scale = 12)
    public BigDecimal costoVariUni;

    /** Legado: Precio_vari_unit */
    @Column(name = "precio_vari_unit", precision = 20, scale = 12)
    public BigDecimal precioVariUnit;

    /** Legado: PEUnidades */
    @Column(name = "peunidades", precision = 38, scale = 12)
    public BigDecimal peunidades;

    /** Legado: PEventas */
    @Column(name = "peventas", precision = 38, scale = 12)
    public BigDecimal peventas;

    /** Legado: Marg_segu */
    @Column(name = "marg_segu", precision = 18, scale = 2)
    public BigDecimal margSegu;
}
