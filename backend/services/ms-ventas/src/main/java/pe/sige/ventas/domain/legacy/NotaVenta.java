package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.NOTA_VENTA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "NotaVenta")
@Table(name = "nota_venta")
public class NotaVenta extends LegacyEntity {

    @Id
    @Column(name = "codi_nota_venta", nullable = false)
    public Long codiNotaVenta;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "nro_nota_venta")
    public Long nroNotaVenta;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: TCAMBIO */
    @Column(name = "tcambio", precision = 19, scale = 4)
    public BigDecimal tcambio;

    @Column(name = "creacion")
    public LocalDateTime creacion;

    /** Legado: CODI_TIPO_PAGO */
    @Column(name = "codi_tipo_pago")
    public Integer codiTipoPago;

    /** Legado: TIPO_CREDITO */
    @Column(name = "tipo_credito")
    public Short tipoCredito;

    @Column(name = "codi_usua", length = 5)
    public String codiUsua;

    /** Legado: COD_IMP */
    @Column(name = "cod_imp")
    public Integer codImp;

    /** Legado: COD_SIEMBRA */
    @Column(name = "cod_siembra")
    public Long codSiembra;

    /** Legado: COD_CULTIVO */
    @Column(name = "cod_cultivo")
    public Integer codCultivo;

    /** Legado: COD_ZONA */
    @Column(name = "cod_zona")
    public Long codZona;

    /** Legado: COD_USUA_RECETISTA */
    @Column(name = "cod_usua_recetista", length = 5)
    public String codUsuaRecetista;

    @Column(name = "hectarea", precision = 18, scale = 3)
    public BigDecimal hectarea;

    @Column(name = "nro_dias")
    public Integer nroDias;

    @Column(name = "fec_pago")
    public LocalDateTime fecPago;

    @Column(name = "venc_fact")
    public LocalDateTime vencFact;

    @Column(name = "codi_fact", length = 10)
    public String codiFact;

    /** Legado: VALOR_IGV */
    @Column(name = "valor_igv", precision = 12, scale = 2)
    public BigDecimal valorIgv;

    /** Legado: VALO_FACT */
    @Column(name = "valo_fact", precision = 12, scale = 3)
    public BigDecimal valoFact;

    /** Legado: SUBTOTA_FACT */
    @Column(name = "subtota_fact", precision = 19, scale = 4)
    public BigDecimal subtotaFact;

    /** Legado: IGV_FACT */
    @Column(name = "igv_fact", precision = 12, scale = 3)
    public BigDecimal igvFact;

    @Column(name = "tota_exonerado", precision = 19, scale = 4)
    public BigDecimal totaExonerado;

    /** Legado: TOTA_FACT */
    @Column(name = "tota_fact", precision = 12, scale = 3)
    public BigDecimal totaFact;

    @Column(name = "estado", length = 1)
    public String estado;
}
