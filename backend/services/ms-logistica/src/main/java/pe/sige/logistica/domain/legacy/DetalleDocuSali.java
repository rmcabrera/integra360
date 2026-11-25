package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DETALLE_DOCU_SALI</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DetalleDocuSali")
@Table(name = "detalle_docu_sali")
public class DetalleDocuSali extends LegacyEntity {

    /** Legado: CODI_DETA_DOCU_SALI */
    @Id
    @Column(name = "codi_deta_docu_sali", length = 12, nullable = false)
    public String codiDetaDocuSali;

    /** Legado: CODI_DOCU_SALI */
    @Column(name = "codi_docu_sali", length = 10, nullable = false)
    public String codiDocuSali;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    /** Legado: CODI_PROD */
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    /** Legado: CANTIDAD */
    @Column(name = "cantidad", precision = 10, scale = 4)
    public BigDecimal cantidad;

    /** Legado: PREC_COSTO */
    @Column(name = "prec_costo", precision = 18, scale = 4)
    public BigDecimal precCosto;

    /** Legado: PREC_PROM */
    @Column(name = "prec_prom", precision = 12, scale = 4)
    public BigDecimal precProm;

    /** Legado: STOC_SALI */
    @Column(name = "stoc_sali", precision = 12, scale = 4)
    public BigDecimal stocSali;

    /** Legado: FECH_ULTI_SALI */
    @Column(name = "fech_ulti_sali")
    public LocalDateTime fechUltiSali;

    /** Legado: CANT_ULTI_SALI */
    @Column(name = "cant_ulti_sali", precision = 12, scale = 4)
    public BigDecimal cantUltiSali;

    /** Legado: CODI_ORDE_PEDI */
    @Column(name = "codi_orde_pedi", length = 10)
    public String codiOrdePedi;

    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "codi_alma_desti", length = 2)
    public String codiAlmaDesti;

    @Column(name = "codi_deta_orde_pedi", length = 12)
    public String codiDetaOrdePedi;

    @Column(name = "prec_kard", precision = 18, scale = 4)
    public BigDecimal precKard;

    /** Legado: Concen_IQF */
    @Column(name = "concen_iqf")
    public Long concenIqf;

    /** Legado: ProdServIQF */
    @Column(name = "prodserviqf", length = 50)
    public String prodserviqf;

    /** Legado: Canti_ProdServIQF */
    @Column(name = "canti_prodserviqf")
    public Long cantiProdserviqf;

    /** Legado: UM_ProdServIQF */
    @Column(name = "um_prodserviqf", length = 2)
    public String umProdserviqf;

    /** Legado: DeseIQF */
    @Column(name = "deseiqf", length = 50)
    public String deseiqf;

    /** Legado: Canti_DeseIQF */
    @Column(name = "canti_deseiqf")
    public Long cantiDeseiqf;

    /** Legado: UM_DeseIQF */
    @Column(name = "um_deseiqf", length = 2)
    public String umDeseiqf;

    /** Legado: Canti_RHPM_IQF */
    @Column(name = "canti_rhpm_iqf")
    public Long cantiRhpmIqf;

    /** Legado: UM_RHPM_IQF */
    @Column(name = "um_rhpm_iqf", length = 2)
    public String umRhpmIqf;

    /** Legado: Moti_RHPM_IQF */
    @Column(name = "moti_rhpm_iqf", length = 50)
    public String motiRhpmIqf;

    /** Legado: Observaciones */
    @Column(name = "observaciones", length = 50)
    public String observaciones;

    /** Legado: PREC_UNIT */
    @Column(name = "prec_unit", precision = 18, scale = 6)
    public BigDecimal precUnit;

    /** Legado: NRO_CUEN_NI */
    @Column(name = "nro_cuen_ni", length = 7)
    public String nroCuenNi;
}
