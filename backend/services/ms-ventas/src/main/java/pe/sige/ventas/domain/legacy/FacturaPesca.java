package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.FACTURA_PESCA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "FacturaPesca")
@Table(name = "factura_pesca")
public class FacturaPesca extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    /** Legado: CODI_FACT_PESC */
    @Column(name = "codi_fact_pesc", length = 10, nullable = false)
    public String codiFactPesc;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5, nullable = false)
    public String codiClieProv;

    /** Legado: FECH_EMIS */
    @Column(name = "fech_emis", nullable = false)
    public LocalDateTime fechEmis;

    /** Legado: VALO_VENT */
    @Column(name = "valo_vent", precision = 12, scale = 3, nullable = false)
    public BigDecimal valoVent;

    /** Legado: IGV */
    @Column(name = "igv", precision = 12, scale = 3, nullable = false)
    public BigDecimal igv;

    /** Legado: VALO_TOTA */
    @Column(name = "valo_tota", precision = 12, scale = 3, nullable = false)
    public BigDecimal valoTota;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: SER_FACT */
    @Column(name = "ser_fact", length = 3)
    public String serFact;

    /** Legado: NRO_FACT */
    @Column(name = "nro_fact", length = 10)
    public String nroFact;

    /** Legado: TIPO_FACT */
    @Column(name = "tipo_fact", length = 2)
    public String tipoFact;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    /** Legado: DETR_TOTA */
    @Column(name = "detr_tota", precision = 12, scale = 3)
    public BigDecimal detrTota;

    /** Legado: CODI_SEMA */
    @Column(name = "codi_sema", length = 8)
    public String codiSema;

    /** Legado: PORC_DETR */
    @Column(name = "porc_detr", precision = 12, scale = 3)
    public BigDecimal porcDetr;
}
