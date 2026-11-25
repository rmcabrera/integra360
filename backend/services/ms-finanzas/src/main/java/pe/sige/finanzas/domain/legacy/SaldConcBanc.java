package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SALD_CONC_BANC</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SaldConcBanc")
@Table(name = "sald_conc_banc")
public class SaldConcBanc extends LegacyEntity {

    /** Legado: CODI_SALD_BANC */
    @Id
    @Column(name = "codi_sald_banc", length = 10, nullable = false)
    public String codiSaldBanc;

    /** Legado: ANIO */
    @Column(name = "anio", length = 4)
    public String anio;

    /** Legado: MES */
    @Column(name = "mes", length = 2)
    public String mes;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    /** Legado: SALD_LIBR */
    @Column(name = "sald_libr", precision = 18, scale = 4)
    public BigDecimal saldLibr;

    /** Legado: ESTA_CUEN */
    @Column(name = "esta_cuen", precision = 18, scale = 4)
    public BigDecimal estaCuen;

    /** Legado: SALD_ANTE */
    @Column(name = "sald_ante", precision = 18, scale = 4)
    public BigDecimal saldAnte;
}
