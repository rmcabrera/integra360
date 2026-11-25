package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ORDEN_DE_COMPRA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "OrdenDeCompra")
@Table(name = "orden_de_compra")
public class OrdenDeCompra extends LegacyEntity {

    /** Legado: CODI_ORDE_COMP */
    @Id
    @Column(name = "codi_orde_comp", length = 10, nullable = false)
    public String codiOrdeComp;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5, nullable = false)
    public String codiClieProv;

    /** Legado: FECHA */
    @Column(name = "fecha", nullable = false)
    public LocalDateTime fecha;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: IMPORTE */
    @Column(name = "importe", precision = 18, scale = 4)
    public BigDecimal importe;

    /** Legado: CODI_UNID_OPER_SOLI */
    @Column(name = "codi_unid_oper_soli", length = 5)
    public String codiUnidOperSoli;

    /** Legado: CODI_UNID_OPER_DEST */
    @Column(name = "codi_unid_oper_dest", length = 5)
    public String codiUnidOperDest;

    /** Legado: COND_PAGO */
    @Column(name = "cond_pago", length = 10)
    public String condPago;

    /** Legado: FECH_ENTR */
    @Column(name = "fech_entr")
    public LocalDateTime fechEntr;

    /** Legado: LUGA_ENTR */
    @Column(name = "luga_entr", length = 100)
    public String lugaEntr;

    /** Legado: CODI_UNID_MEDI */
    @Column(name = "codi_unid_medi", length = 2)
    public String codiUnidMedi;

    /** Legado: TIEM_PLAZ_CRED */
    @Column(name = "tiem_plaz_cred")
    public Long tiemPlazCred;

    /** Legado: ATENCION */
    @Column(name = "atencion", length = 100)
    public String atencion;

    /** Legado: NRO_COTI */
    @Column(name = "nro_coti", length = 20)
    public String nroCoti;

    /** Legado: TIPO_DESC */
    @Column(name = "tipo_desc")
    public Boolean tipoDesc;

    /** Legado: DESCUENTO */
    @Column(name = "descuento", precision = 18, scale = 4)
    public BigDecimal descuento;

    /** Legado: SUB_TOTA */
    @Column(name = "sub_tota", precision = 18, scale = 4)
    public BigDecimal subTota;

    /** Legado: CODI_TIPO_DOCU_CONT */
    @Column(name = "codi_tipo_docu_cont", length = 4)
    public String codiTipoDocuCont;

    /** Legado: IGV */
    @Column(name = "igv", precision = 18, scale = 4)
    public BigDecimal igv;

    /** Legado: RENT_CUAR_CATE */
    @Column(name = "rent_cuar_cate", precision = 18, scale = 4)
    public BigDecimal rentCuarCate;

    /** Legado: IES */
    @Column(name = "ies", precision = 18, scale = 4)
    public BigDecimal ies;

    /** Legado: TOTAL */
    @Column(name = "total", precision = 18, scale = 4)
    public BigDecimal total;

    /** Legado: PEDI_TRAB */
    @Column(name = "pedi_trab", length = 1)
    public String pediTrab;

    /** Legado: DETRACCION */
    @Column(name = "detraccion")
    public Boolean detraccion;

    /** Legado: TOTA_DETR */
    @Column(name = "tota_detr", precision = 18, scale = 4)
    public BigDecimal totaDetr;

    /** Legado: NRO_ORDE_COMP */
    @Column(name = "nro_orde_comp", length = 10)
    public String nroOrdeComp;

    /** Legado: CONTAB */
    @Column(name = "contab")
    public Boolean contab;

    /** Legado: TIPO_GENE */
    @Column(name = "tipo_gene", length = 1)
    public String tipoGene;

    /** Legado: OBSE_1 */
    @Column(name = "obse_1", length = 255)
    public String obse1;

    /** Legado: OBSE_2 */
    @Column(name = "obse_2", length = 250)
    public String obse2;

    /** Legado: OBSE_3 */
    @Column(name = "obse_3", length = 250)
    public String obse3;

    /** Legado: OBSE_4 */
    @Column(name = "obse_4", length = 250)
    public String obse4;

    /** Legado: OBSE_5 */
    @Column(name = "obse_5", length = 250)
    public String obse5;

    /** Legado: OBSE_6 */
    @Column(name = "obse_6", length = 250)
    public String obse6;

    /** Legado: OBSE_7 */
    @Column(name = "obse_7", length = 250)
    public String obse7;

    /** Legado: OBSE_8 */
    @Column(name = "obse_8", length = 250)
    public String obse8;

    /** Legado: OBSE_9 */
    @Column(name = "obse_9", length = 250)
    public String obse9;

    /** Legado: OBSE_10 */
    @Column(name = "obse_10", length = 250)
    public String obse10;

    /** Legado: VALO_VENT */
    @Column(name = "valo_vent")
    public Boolean valoVent;

    /** Legado: NRO_GUIA */
    @Column(name = "nro_guia", length = 20)
    public String nroGuia;

    /** Legado: NRO_FACT */
    @Column(name = "nro_fact", length = 20)
    public String nroFact;

    /** Legado: AFEC_RETE */
    @Column(name = "afec_rete")
    public Boolean afecRete;

    /** Legado: HECH_POR */
    @Column(name = "hech_por", length = 5)
    public String hechPor;

    /** Legado: MODI_POR */
    @Column(name = "modi_por", length = 5)
    public String modiPor;

    /** Legado: AUTO_POR */
    @Column(name = "auto_por", length = 5)
    public String autoPor;

    /** Legado: SOLI_POR */
    @Column(name = "soli_por", length = 5)
    public String soliPor;

    /** Legado: NRO_PRES */
    @Column(name = "nro_pres", length = 50)
    public String nroPres;

    /** Legado: DESC_COND_PAGO */
    @Column(name = "desc_cond_pago", length = 100)
    public String descCondPago;

    @Column(name = "nro_seri", length = 5)
    public String nroSeri;

    /** Legado: Codi_Alma */
    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "otro_no_afec")
    public Long otroNoAfec;

    @Column(name = "codi_bien_serv", length = 5)
    public String codiBienServ;

    @Column(name = "porc_detra", precision = 12, scale = 2)
    public BigDecimal porcDetra;

    @Column(name = "apro_por", length = 5)
    public String aproPor;

    @Column(name = "codi_ofi")
    public Long codiOfi;

    @Column(name = "anulado", length = 1)
    public String anulado;

    @Column(name = "motivo", length = 255)
    public String motivo;

    @Column(name = "fech_docu_cont")
    public LocalDateTime fechDocuCont;

    @Column(name = "anio", length = 4)
    public String anio;

    @Column(name = "factor")
    public Integer factor;

    @Column(name = "nro_comp")
    public Long nroComp;

    @Column(name = "codi_trans", length = 4)
    public String codiTrans;

    @Column(name = "dias")
    public Integer dias;

    @Column(name = "codi_luga", length = 2)
    public String codiLuga;
}
