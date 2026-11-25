package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.FACTURA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Factura")
@Table(name = "factura")
public class Factura extends LegacyEntity {

    /** Legado: CODI_FACT */
    @Id
    @Column(name = "codi_fact", length = 10, nullable = false)
    public String codiFact;

    /** Legado: CODI_ALMA */
    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5, nullable = false)
    public String codiClieProv;

    /** Legado: FECH_FACT */
    @Column(name = "fech_fact", nullable = false)
    public LocalDateTime fechFact;

    /** Legado: CODI_TIPO_DOCU */
    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    /** Legado: SER_FACT */
    @Column(name = "ser_fact", length = 5, nullable = false)
    public String serFact;

    /** Legado: NRO_FACT */
    @Column(name = "nro_fact", length = 10, nullable = false)
    public String nroFact;

    /** Legado: ORDE_FACT */
    @Column(name = "orde_fact", length = 30)
    public String ordeFact;

    /** Legado: TELE_FACT */
    @Column(name = "tele_fact", length = 50)
    public String teleFact;

    /** Legado: GUIA_FACT */
    @Column(name = "guia_fact", length = 250)
    public String guiaFact;

    /** Legado: VENC_FACT */
    @Column(name = "venc_fact")
    public LocalDateTime vencFact;

    /** Legado: TIPO_FACT */
    @Column(name = "tipo_fact", length = 2)
    public String tipoFact;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: TCAMBIO */
    @Column(name = "tcambio", precision = 19, scale = 4)
    public BigDecimal tcambio;

    /** Legado: CODI_TIPO_PAGO */
    @Column(name = "codi_tipo_pago")
    public Integer codiTipoPago;

    /** 1=Credito por Campaña,2=Credito Normal */
    @Column(name = "tipo_credito")
    public Short tipoCredito;

    /** Legado: VALO_FACT */
    @Column(name = "valo_fact", precision = 12, scale = 3)
    public BigDecimal valoFact;

    /** Legado: DSCTO_FACT */
    @Column(name = "dscto_fact", precision = 19, scale = 4)
    public BigDecimal dsctoFact;

    /** Legado: SUBTOTA_FACT */
    @Column(name = "subtota_fact", precision = 19, scale = 4)
    public BigDecimal subtotaFact;

    /** Legado: TOTA_EXONERADO */
    @Column(name = "tota_exonerado", precision = 19, scale = 4)
    public BigDecimal totaExonerado;

    /** Legado: VALOR_IGV */
    @Column(name = "valor_igv", precision = 12, scale = 2)
    public BigDecimal valorIgv;

    /** Legado: IGV_FACT */
    @Column(name = "igv_fact", precision = 12, scale = 3)
    public BigDecimal igvFact;

    /** Legado: TOTA_FACT */
    @Column(name = "tota_fact", precision = 12, scale = 3)
    public BigDecimal totaFact;

    /** Legado: CODI_ORDE_GRUA */
    @Column(name = "codi_orde_grua", length = 10)
    public String codiOrdeGrua;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    @Column(name = "codi_vouc", length = 10)
    public String codiVouc;

    @Column(name = "contabilizado", length = 1)
    public String contabilizado;

    @Column(name = "aplica_igv", length = 1)
    public String aplicaIgv;

    /** Legado: COD_IMP */
    @Column(name = "cod_imp")
    public Integer codImp;

    /** Persona que registra la venta */
    @Column(name = "cod_usua", length = 5)
    public String codUsua;

    /** 1=Si,0=No */
    @Column(name = "impreso", length = 1)
    public String impreso;

    /** Vendedor acargo de la venta */
    @Column(name = "cod_usua_vende", length = 5)
    public String codUsuaVende;

    /** Legado: COD_SIEMBRA */
    @Column(name = "cod_siembra")
    public Long codSiembra;

    /** Legado: FEC_PAGO */
    @Column(name = "fec_pago")
    public LocalDateTime fecPago;

    /** Legado: COD_CULTIVO */
    @Column(name = "cod_cultivo")
    public Integer codCultivo;

    /** Legado: COD_ZONA */
    @Column(name = "cod_zona")
    public Long codZona;

    /** Personal que va al campo (ingeniero) */
    @Column(name = "cod_usua_recetista", length = 5)
    public String codUsuaRecetista;

    @Column(name = "prov_canc", length = 1)
    public String provCanc;

    @Column(name = "creacion")
    public LocalDateTime creacion;

    @Column(name = "hectarea", precision = 18, scale = 3)
    public BigDecimal hectarea;

    @Column(name = "hecho_por", length = 5)
    public String hechoPor;

    @Column(name = "nro_dias")
    public Integer nroDias;

    @Column(name = "codi_conv")
    public Long codiConv;

    @Column(name = "fecha_siembra")
    public LocalDateTime fechaSiembra;

    @Column(name = "detra", length = 1)
    public String detra;

    @Column(name = "codi_bien_serv", length = 5)
    public String codiBienServ;

    @Column(name = "printer_name", length = 250)
    public String printerName;

    @Column(name = "dias_fact")
    public Long diasFact;

    @Column(name = "mes", insertable = false, updatable = false)
    public Integer mes;

    @Column(name = "anio", insertable = false, updatable = false)
    public Integer anio;

    @Column(name = "codi_oper", length = 4)
    public String codiOper;

    @Column(name = "cod_usua_modi", length = 5)
    public String codUsuaModi;

    @Column(name = "total_gratuita", precision = 12, scale = 2)
    public BigDecimal totalGratuita;

    @Column(name = "fecha_elim")
    public LocalDateTime fechaElim;

    @Column(name = "motivo_elim", length = 100)
    public String motivoElim;

    @Column(name = "codi_desc", length = 2)
    public String codiDesc;

    @Column(name = "dscto_global", precision = 12, scale = 2)
    public BigDecimal dsctoGlobal;

    @Column(name = "factor_dscto", precision = 12, scale = 2)
    public BigDecimal factorDscto;

    /** Legado: NRO_CUOTAS */
    @Column(name = "nro_cuotas")
    public Integer nroCuotas;

    /** Legado: CODI_GUIA_REM */
    @Column(name = "codi_guia_rem")
    public Long codiGuiaRem;

    @Column(name = "tipo_impr", length = 1)
    public String tipoImpr;

    @Column(name = "pdetr", precision = 18, scale = 3)
    public BigDecimal pdetr;
}
