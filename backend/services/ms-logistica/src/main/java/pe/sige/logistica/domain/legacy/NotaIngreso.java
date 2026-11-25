package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.NOTA_INGRESO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "NotaIngreso")
@Table(name = "nota_ingreso")
public class NotaIngreso extends LegacyEntity {

    /** Legado: CODI_NOTA_INGR */
    @Id
    @Column(name = "codi_nota_ingr", length = 10, nullable = false)
    public String codiNotaIngr;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    /** Legado: CODI_TIPO_DOCU */
    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    /** Legado: NRO_SERI */
    @Column(name = "nro_seri", length = 5)
    public String nroSeri;

    /** Legado: NRO_DOCU */
    @Column(name = "nro_docu", length = 15)
    public String nroDocu;

    /** Legado: CODI_UNID_OPER_SOLI */
    @Column(name = "codi_unid_oper_soli", length = 5)
    public String codiUnidOperSoli;

    /** Legado: CODI_UNID_OPER_DEST */
    @Column(name = "codi_unid_oper_dest", length = 5)
    public String codiUnidOperDest;

    /** Legado: FECH_NOTA_INGR */
    @Column(name = "fech_nota_ingr")
    public LocalDateTime fechNotaIngr;

    /** Legado: TIPO_NOTA_INGR */
    @Column(name = "tipo_nota_ingr", length = 20)
    public String tipoNotaIngr;

    /** Legado: IMPORTE */
    @Column(name = "importe", precision = 12, scale = 4)
    public BigDecimal importe;

    /** Legado: CODI_PERS_VIST_BUEN */
    @Column(name = "codi_pers_vist_buen", length = 5)
    public String codiPersVistBuen;

    /** Legado: CODI_PERS_ELAB */
    @Column(name = "codi_pers_elab", length = 5)
    public String codiPersElab;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: PREC_TOTA */
    @Column(name = "prec_tota", precision = 12, scale = 4)
    public BigDecimal precTota;

    /** Legado: OBSERVACIONES */
    @Column(name = "observaciones", length = 100)
    public String observaciones;

    /** Legado: CODI_TURN */
    @Column(name = "codi_turn", length = 2)
    public String codiTurn;

    /** Legado: CODI_UNID_NEGO */
    @Column(name = "codi_unid_nego", length = 2)
    public String codiUnidNego;

    /** Legado: NRO_SERI_DOCU_CONT */
    @Column(name = "nro_seri_docu_cont", length = 5)
    public String nroSeriDocuCont;

    /** Legado: NRO_DOCU_CONT */
    @Column(name = "nro_docu_cont", length = 15)
    public String nroDocuCont;

    /** Legado: CODI_TIPO_DOCU_CONT */
    @Column(name = "codi_tipo_docu_cont", length = 4)
    public String codiTipoDocuCont;

    /** Legado: FECH_GUIA_REMI */
    @Column(name = "fech_guia_remi")
    public LocalDateTime fechGuiaRemi;

    /** Legado: FECH_REG_FACT */
    @Column(name = "fech_reg_fact")
    public LocalDateTime fechRegFact;

    /** Legado: FECH_PROCESO */
    @Column(name = "fech_proceso")
    public LocalDateTime fechProceso;

    /** Legado: CONTAB */
    @Column(name = "contab")
    public Boolean contab;

    /** Legado: TIPO_CAMB */
    @Column(name = "tipo_camb", precision = 15, scale = 4)
    public BigDecimal tipoCamb;

    @Column(name = "afecto")
    public Boolean afecto;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: CODI_SEMA */
    @Column(name = "codi_sema", length = 8)
    public String codiSema;

    /** Legado: PROV_PESC */
    @Column(name = "prov_pesc", length = 5)
    public String provPesc;

    /** Legado: VIVERES */
    @Column(name = "viveres")
    public Boolean viveres;

    /** Legado: CODI_EMBA */
    @Column(name = "codi_emba", length = 5)
    public String codiEmba;

    /** Legado: NRO_NOTA_INGR */
    @Column(name = "nro_nota_ingr", length = 10)
    public String nroNotaIngr;

    /** Legado: IGV */
    @Column(name = "igv", precision = 18, scale = 4)
    public BigDecimal igv;

    /** Legado: OTRO_AFEC */
    @Column(name = "otro_afec", precision = 18, scale = 4)
    public BigDecimal otroAfec;

    /** Legado: OTRO_NO_AFEC */
    @Column(name = "otro_no_afec", precision = 18, scale = 4)
    public BigDecimal otroNoAfec;

    /** Legado: Codi_Alma */
    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "codi_alma_desti", length = 2)
    public String codiAlmaDesti;

    @Column(name = "codi_docu_sali", length = 10)
    public String codiDocuSali;

    /** codigo de tabla cliente proveedor */
    @Column(name = "codi_transportista", length = 5)
    public String codiTransportista;

    @Column(name = "registro", length = 10)
    public String registro;

    @Column(name = "fech_venc_fact")
    public LocalDateTime fechVencFact;

    @Column(name = "codi_chof", length = 4)
    public String codiChof;

    @Column(name = "codi_alma_dest", length = 2)
    public String codiAlmaDest;
}
