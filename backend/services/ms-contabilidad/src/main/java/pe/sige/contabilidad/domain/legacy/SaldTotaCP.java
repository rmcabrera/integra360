package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SALD_TOTA_C_P</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SaldTotaCP")
@Table(name = "sald_tota_c_p")
public class SaldTotaCP extends LegacyEntity {

    /** Legado: CODI_TOTA */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codi_tota", nullable = false)
    public Long codiTota;

    /** Legado: ANIO */
    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    /** Legado: MES */
    @Column(name = "mes", length = 2, nullable = false)
    public String mes;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    /** Legado: DESC_CUEN */
    @Column(name = "desc_cuen", length = 100)
    public String descCuen;

    /** Legado: RUC_PROV */
    @Column(name = "ruc_prov", length = 15)
    public String rucProv;

    /** Legado: DESC_PROV */
    @Column(name = "desc_prov", length = 100)
    public String descProv;

    /** Legado: IMPORTE_C */
    @Column(name = "importe_c", precision = 18, scale = 2, nullable = false)
    public BigDecimal importeC;

    /** Legado: IMPORTE_A */
    @Column(name = "importe_a", precision = 18, scale = 2, nullable = false)
    public BigDecimal importeA;

    /** Legado: IMPORTE_D_C */
    @Column(name = "importe_d_c", precision = 18, scale = 2, nullable = false)
    public BigDecimal importeDC;

    /** Legado: IMPORTE_D_A */
    @Column(name = "importe_d_a", precision = 18, scale = 2, nullable = false)
    public BigDecimal importeDA;
}
