package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PRODUCTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Productos")
@Table(name = "productos")
public class Productos extends LegacyEntity {

    /** Legado: CODI_PROD */
    @Id
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    /** Legado: DESC_PROD */
    @Column(name = "desc_prod", length = 150, nullable = false)
    public String descProd;

    /** Legado: CODI_SUB_FAMI_PROD */
    @Column(name = "codi_sub_fami_prod", length = 4)
    public String codiSubFamiProd;

    /** Legado: CODI_UNID_MEDI */
    @Column(name = "codi_unid_medi", length = 2)
    public String codiUnidMedi;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: PREC_PROM */
    @Column(name = "prec_prom", precision = 14, scale = 2)
    public BigDecimal precProm;

    /** Legado: STOCK */
    @Column(name = "stock", precision = 9, scale = 2, nullable = false)
    public BigDecimal stock;

    /** Legado: STOC_MINI */
    @Column(name = "stoc_mini", precision = 9, scale = 2)
    public BigDecimal stocMini;

    /** Legado: STOC_MAXI */
    @Column(name = "stoc_maxi", precision = 9, scale = 2)
    public BigDecimal stocMaxi;

    /** Legado: PUNT_REPE */
    @Column(name = "punt_repe", precision = 9, scale = 2)
    public BigDecimal puntRepe;

    /** Legado: FECH_VENC */
    @Column(name = "fech_venc")
    public LocalDateTime fechVenc;

    /** Legado: ESTA_PROD */
    @Column(name = "esta_prod", length = 25)
    public String estaProd;

    /** Legado: STOC_TEMP */
    @Column(name = "stoc_temp", precision = 9, scale = 2)
    public BigDecimal stocTemp;

    /** Legado: UBICACION */
    @Column(name = "ubicacion", length = 50)
    public String ubicacion;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    /** Legado: IQF */
    @Column(name = "iqf")
    public Boolean iqf;

    /** Legado: PORC_DETR */
    @Column(name = "porc_detr", precision = 15, scale = 4)
    public BigDecimal porcDetr;

    /** Legado: POLI_PREC */
    @Column(name = "poli_prec", precision = 18, scale = 4)
    public BigDecimal poliPrec;

    /** Legado: Exonerado */
    @Column(name = "exonerado", length = 1)
    public String exonerado;

    /** Legado: PREC_LIST_1 */
    @Column(name = "prec_list_1", precision = 15, scale = 4)
    public BigDecimal precList1;

    /** Legado: PREC_LIST_2 */
    @Column(name = "prec_list_2", precision = 15, scale = 4)
    public BigDecimal precList2;

    /** Legado: COST_PROD */
    @Column(name = "cost_prod", precision = 15, scale = 4)
    public BigDecimal costProd;

    /** Legado: ANALISIS */
    @Column(name = "analisis")
    public Short analisis;

    /** Legado: Material */
    @Column(name = "material")
    public Short material;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "cod_pres")
    public Integer codPres;

    @Column(name = "fec_registro")
    public LocalDateTime fecRegistro;

    @Column(name = "prec_prov", precision = 19, scale = 4)
    public BigDecimal precProv;

    @Column(name = "descto_compra", precision = 19, scale = 4)
    public BigDecimal desctoCompra;

    @Column(name = "descto_porcenta", precision = 19, scale = 4)
    public BigDecimal desctoPorcenta;

    @Column(name = "cod_impuesto")
    public Integer codImpuesto;

    @Column(name = "tcambio", precision = 9, scale = 3)
    public BigDecimal tcambio;

    @Column(name = "nro_decim_precio")
    public Integer nroDecimPrecio;

    @Column(name = "costo_oper", precision = 18, scale = 2)
    public BigDecimal costoOper;

    @Column(name = "codi_aux", length = 8)
    public String codiAux;

    @Column(name = "id_tipocomi")
    public Integer idTipocomi;

    @Column(name = "codi_tipo_exis", length = 2)
    public String codiTipoExis;

    /** Legado: PESO */
    @Column(name = "peso", precision = 18, scale = 3)
    public BigDecimal peso;

    @Column(name = "rotacion")
    public Integer rotacion;

    @Column(name = "codi_prod_sunat", length = 8)
    public String codiProdSunat;

    @Column(name = "esta_acti", length = 1)
    public String estaActi;
}
