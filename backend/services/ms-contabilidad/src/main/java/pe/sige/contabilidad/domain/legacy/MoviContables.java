package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Movi_Contables</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "MoviContables")
@Table(name = "movi_contables")
public class MoviContables extends LegacyEntity {

    /** Legado: Codi_Contable */
    @Id
    @Column(name = "codi_contable", length = 10, nullable = false)
    public String codiContable;

    @Column(name = "anio", length = 4)
    public String anio;

    @Column(name = "mes", length = 2)
    public String mes;

    /** Legado: Subdia */
    @Column(name = "subdia", length = 1)
    public String subdia;

    /** Legado: Compr */
    @Column(name = "compr", length = 10)
    public String compr;

    /** Legado: Codi_Mone */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: Fecha */
    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Legado: Nro_Cuen */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    /** Legado: Nro_Sub_Cuen */
    @Column(name = "nro_sub_cuen", length = 7)
    public String nroSubCuen;

    /** Legado: Codi_Clie_Prov */
    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    /** Legado: Serie */
    @Column(name = "serie", length = 5)
    public String serie;

    /** Legado: Nro_Docu */
    @Column(name = "nro_docu", length = 20)
    public String nroDocu;

    /** Legado: Codi_Tipo_Docu */
    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    /** Legado: Importe */
    @Column(name = "importe", precision = 18, scale = 2)
    public BigDecimal importe;

    /** Legado: IGV */
    @Column(name = "igv", precision = 18, scale = 2)
    public BigDecimal igv;

    /** Legado: Otros */
    @Column(name = "otros", precision = 18, scale = 2)
    public BigDecimal otros;

    /** Legado: Total */
    @Column(name = "total", precision = 18, scale = 2)
    public BigDecimal total;

    /** Legado: Importe_d */
    @Column(name = "importe_d", precision = 18, scale = 2)
    public BigDecimal importeD;

    /** Legado: IGV_d */
    @Column(name = "igv_d", precision = 18, scale = 2)
    public BigDecimal igvD;

    /** Legado: Otros_d */
    @Column(name = "otros_d", precision = 18, scale = 2)
    public BigDecimal otrosD;

    /** Legado: Total_d */
    @Column(name = "total_d", precision = 18, scale = 2)
    public BigDecimal totalD;

    /** Legado: Registro */
    @Column(name = "registro", length = 10)
    public String registro;

    /** Legado: Codi_Unid_Oper */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    /** Legado: Glosa */
    @Column(name = "glosa", length = 200)
    public String glosa;

    /** Legado: Cargo_Abono */
    @Column(name = "cargo_abono", length = 1)
    public String cargoAbono;

    /** Legado: Fecha_venc */
    @Column(name = "fecha_venc")
    public LocalDateTime fechaVenc;

    @Column(name = "tipo_cambio", precision = 18, scale = 4)
    public BigDecimal tipoCambio;

    /** Legado: Situ_cheq */
    @Column(name = "situ_cheq", length = 2)
    public String situCheq;

    /** Legado: Tipo_cambio_2 */
    @Column(name = "tipo_cambio_2", precision = 18, scale = 4)
    public BigDecimal tipoCambio2;

    /** Legado: Codi_Vouc */
    @Column(name = "codi_vouc", length = 10)
    public String codiVouc;

    @Column(name = "fecha_spot")
    public LocalDateTime fechaSpot;

    @Column(name = "num_spot", length = 10)
    public String numSpot;

    @Column(name = "codi_pers", length = 5)
    public String codiPers;

    @Column(name = "codi_sema", length = 10)
    public String codiSema;

    @Column(name = "codi_nota_ingr", length = 10)
    public String codiNotaIngr;

    @Column(name = "nro_orde_comp", length = 10)
    public String nroOrdeComp;

    @Column(name = "nro_orde_pedi", length = 10)
    public String nroOrdePedi;

    @Column(name = "codi_pres", length = 4)
    public String codiPres;

    @Column(name = "nro_presu", length = 5)
    public String nroPresu;

    /** Legado: BANCO */
    @Column(name = "banco", length = 7)
    public String banco;

    /** Legado: CARTERA */
    @Column(name = "cartera")
    public Boolean cartera;

    /** Legado: HECHO_POR */
    @Column(name = "hecho_por", length = 5)
    public String hechoPor;

    @Column(name = "itf", length = 1)
    public String itf;

    /** Legado: Compensa */
    @Column(name = "compensa")
    public Boolean compensa;

    /** Legado: Detraccion */
    @Column(name = "detraccion")
    public Boolean detraccion;

    @Column(name = "fech_pago")
    public LocalDateTime fechPago;

    @Column(name = "ref", length = 5)
    public String ref;

    @Column(name = "nro_fact", length = 20)
    public String nroFact;

    @Column(name = "codi_memo")
    public Long codiMemo;

    @Column(name = "tipo_movi", length = 2)
    public String tipoMovi;

    @Column(name = "codi_desti", length = 1)
    public String codiDesti;

    @Column(name = "codi_tasa_detr", length = 5)
    public String codiTasaDetr;

    @Column(name = "retencion")
    public Boolean retencion;

    /** Legado: Codi_Ingr */
    @Column(name = "codi_ingr")
    public Long codiIngr;

    /** Legado: Codi_Alma */
    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    /** Legado: CODI_TIPO_INTAN */
    @Column(name = "codi_tipo_intan", length = 2)
    public String codiTipoIntan;

    /** Legado: CODI_ADUANA */
    @Column(name = "codi_aduana")
    public Short codiAduana;

    /** Legado: ANIO_DUA_DSI */
    @Column(name = "anio_dua_dsi")
    public Short anioDuaDsi;

    /** Legado: NRO_DETRAC */
    @Column(name = "nro_detrac", length = 10)
    public String nroDetrac;

    /** Legado: FECHA_DETRAC */
    @Column(name = "fecha_detrac")
    public LocalDateTime fechaDetrac;

    /** Legado: FECHA_ND_NC */
    @Column(name = "fecha_nd_nc")
    public LocalDateTime fechaNdNc;

    /** Legado: TIPO_DOCU_ND_NC */
    @Column(name = "tipo_docu_nd_nc", length = 4)
    public String tipoDocuNdNc;

    /** Legado: SERIE_ND_NC */
    @Column(name = "serie_nd_nc", length = 5)
    public String serieNdNc;

    /** Legado: NRO_DOCU_ND_NC */
    @Column(name = "nro_docu_nd_nc", length = 10)
    public String nroDocuNdNc;

    /** Legado: TIPO_VENTA */
    @Column(name = "tipo_venta", length = 1)
    public String tipoVenta;

    /** Legado: CODI_LIBRO_REGI */
    @Column(name = "codi_libro_regi")
    public Short codiLibroRegi;

    /** Legado: Codi_Tipo_Medio_Pago */
    @Column(name = "codi_tipo_medio_pago")
    public Short codiTipoMedioPago;

    /** Legado: Banco_aux */
    @Column(name = "banco_aux", length = 2)
    public String bancoAux;

    /** Legado: fecha_Creacion */
    @Column(name = "fecha_creacion")
    public LocalDateTime fechaCreacion;

    @Column(name = "estado_inic")
    public Integer estadoInic;

    @Column(name = "creacion")
    public LocalDateTime creacion;

    @Column(name = "id_flujo")
    public Integer idFlujo;

    @Column(name = "id_tipo_flujo")
    public Integer idTipoFlujo;

    @Column(name = "codi_oper", length = 4)
    public String codiOper;

    @Column(name = "codi_bien_serv", length = 5)
    public String codiBienServ;

    @Column(name = "pdetr", precision = 18, scale = 3)
    public BigDecimal pdetr;

    @Column(name = "valor_refe", precision = 18, scale = 2)
    public BigDecimal valorRefe;

    @Column(name = "placa", length = 100)
    public String placa;

    @Column(name = "nro_refe", length = 10)
    public String nroRefe;
}
