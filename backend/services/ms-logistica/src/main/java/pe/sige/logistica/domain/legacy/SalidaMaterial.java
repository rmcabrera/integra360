package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SALIDA_MATERIAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SalidaMaterial")
@Table(name = "salida_material")
public class SalidaMaterial extends LegacyEntity {

    /** Legado: CODI_DOCU_SALI */
    @Id
    @Column(name = "codi_docu_sali", length = 10, nullable = false)
    public String codiDocuSali;

    /** Legado: NRO_SERI */
    @Column(name = "nro_seri", length = 3)
    public String nroSeri;

    /** Legado: NRO_DOCU_SALI */
    @Column(name = "nro_docu_sali", length = 7)
    public String nroDocuSali;

    /** Legado: CODI_TIPO_DOCU */
    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    /** Legado: FECH_EMIS */
    @Column(name = "fech_emis", nullable = false)
    public LocalDateTime fechEmis;

    /** Legado: FECH_INIC_TRAS */
    @Column(name = "fech_inic_tras")
    public LocalDateTime fechInicTras;

    /** Legado: CODI_DOMI_PART */
    @Column(name = "codi_domi_part", length = 4)
    public String codiDomiPart;

    /** Legado: DOMI_PART_DIST */
    @Column(name = "domi_part_dist", length = 30)
    public String domiPartDist;

    /** Legado: DOMI_PART_PROV */
    @Column(name = "domi_part_prov", length = 30)
    public String domiPartProv;

    /** Legado: DOMI_PART_DEPA */
    @Column(name = "domi_part_depa", length = 30)
    public String domiPartDepa;

    /** Legado: DOMI_PART_DIRE */
    @Column(name = "domi_part_dire", length = 200)
    public String domiPartDire;

    /** Legado: DEST_CODI_CLIE_PROV */
    @Column(name = "dest_codi_clie_prov", length = 5)
    public String destCodiClieProv;

    /** Legado: DEST_APEL_O_RAZO_SOCI */
    @Column(name = "dest_apel_o_razo_soci", length = 200)
    public String destApelORazoSoci;

    /** Legado: DEST_DIRE */
    @Column(name = "dest_dire", length = 200)
    public String destDire;

    /** Legado: DEST_IDEN */
    @Column(name = "dest_iden", length = 15)
    public String destIden;

    /** Legado: DEST_TIPO_DOCU_IDEN */
    @Column(name = "dest_tipo_docu_iden", length = 4)
    public String destTipoDocuIden;

    /** Legado: CODI_DOMI_LLEG */
    @Column(name = "codi_domi_lleg", length = 4)
    public String codiDomiLleg;

    /** Legado: DOMI_LLEG_DIST */
    @Column(name = "domi_lleg_dist", length = 30)
    public String domiLlegDist;

    /** Legado: DOMI_LLEG_PROV */
    @Column(name = "domi_lleg_prov", length = 30)
    public String domiLlegProv;

    /** Legado: DOMI_LLEG_DEPA */
    @Column(name = "domi_lleg_depa", length = 30)
    public String domiLlegDepa;

    /** Legado: DOMI_LLEG_DIRE */
    @Column(name = "domi_lleg_dire", length = 200)
    public String domiLlegDire;

    /** Legado: CODI_UNID_TRAN */
    @Column(name = "codi_unid_tran", length = 4)
    public String codiUnidTran;

    /** Legado: CODI_TRANS */
    @Column(name = "codi_trans", length = 4)
    public String codiTrans;

    /** Legado: CODI_TIPO_DOCU_COMP_PAGO */
    @Column(name = "codi_tipo_docu_comp_pago", length = 4)
    public String codiTipoDocuCompPago;

    /** Legado: COMP_PAGO_SERI */
    @Column(name = "comp_pago_seri", length = 5)
    public String compPagoSeri;

    /** Legado: COMP_PAGO_NRO */
    @Column(name = "comp_pago_nro", length = 15)
    public String compPagoNro;

    /** Legado: CODI_MOTI_TRAS */
    @Column(name = "codi_moti_tras", length = 2)
    public String codiMotiTras;

    /** Legado: MOTI_TRAS_DESC */
    @Column(name = "moti_tras_desc", length = 200)
    public String motiTrasDesc;

    /** Legado: CODI_MONE_COST */
    @Column(name = "codi_mone_cost", length = 2)
    public String codiMoneCost;

    /** Legado: COST_MINI */
    @Column(name = "cost_mini", precision = 15, scale = 4)
    public BigDecimal costMini;

    /** Legado: CODI_UNID_MEDI_PESO */
    @Column(name = "codi_unid_medi_peso", length = 4)
    public String codiUnidMediPeso;

    /** Legado: PESO_TOTA */
    @Column(name = "peso_tota", precision = 15, scale = 4)
    public BigDecimal pesoTota;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: TIPO_GENE */
    @Column(name = "tipo_gene", length = 1)
    public String tipoGene;

    /** Legado: CODI_PERS_EMIT_GUIA */
    @Column(name = "codi_pers_emit_guia", length = 5)
    public String codiPersEmitGuia;

    /** Legado: CODI_PERS_RECI_GUIA */
    @Column(name = "codi_pers_reci_guia", length = 5)
    public String codiPersReciGuia;

    /** Legado: APEL_1_RECI_GUIA */
    @Column(name = "apel_1_reci_guia", length = 50)
    public String apel1ReciGuia;

    /** Legado: APEL_2_RECI_GUIA */
    @Column(name = "apel_2_reci_guia", length = 50)
    public String apel2ReciGuia;

    /** Legado: NOMB_1_RECI_GUIA */
    @Column(name = "nomb_1_reci_guia", length = 50)
    public String nomb1ReciGuia;

    /** Legado: NOMB_2_RECI_GUIA */
    @Column(name = "nomb_2_reci_guia", length = 50)
    public String nomb2ReciGuia;

    /** Legado: CODI_UNID_OPER_RECE */
    @Column(name = "codi_unid_oper_rece", length = 5)
    public String codiUnidOperRece;

    /** Legado: OBSERVACION */
    @Column(name = "observacion", length = 200)
    public String observacion;

    /** Legado: MOTI_SALI */
    @Column(name = "moti_sali", length = 200)
    public String motiSali;

    /** Legado: APEL_1_CHOF */
    @Column(name = "apel_1_chof", length = 30)
    public String apel1Chof;

    /** Legado: APEL_2_CHOF */
    @Column(name = "apel_2_chof", length = 30)
    public String apel2Chof;

    /** Legado: NOMB_1_CHOF */
    @Column(name = "nomb_1_chof", length = 30)
    public String nomb1Chof;

    /** Legado: NOMB_2_CHOF */
    @Column(name = "nomb_2_chof", length = 30)
    public String nomb2Chof;

    /** Legado: LICE_COND_CHOF */
    @Column(name = "lice_cond_chof", length = 20)
    public String liceCondChof;

    /** Legado: DNI_CHOF */
    @Column(name = "dni_chof", length = 20)
    public String dniChof;

    /** Legado: CON_RETO */
    @Column(name = "con_reto", length = 1)
    public String conReto;

    /** Legado: INDI_RETO */
    @Column(name = "indi_reto", length = 1)
    public String indiReto;

    /** Legado: INDI_DEVO_MATE_EMBA */
    @Column(name = "indi_devo_mate_emba", length = 1)
    public String indiDevoMateEmba;

    /** Legado: CIMT */
    @Column(name = "cimt", length = 20)
    public String cimt;

    /** Legado: CODI_ALMA */
    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    /** Legado: MARCA_TRANSPO */
    @Column(name = "marca_transpo", length = 20)
    public String marcaTranspo;

    /** Legado: NRO_PLACA_TRANSPO */
    @Column(name = "nro_placa_transpo", length = 20)
    public String nroPlacaTranspo;

    /** Legado: EMPRE_TRANS_RAZO_SOCI */
    @Column(name = "empre_trans_razo_soci", length = 50)
    public String empreTransRazoSoci;

    /** Legado: EMPRE_TRANS_RUC */
    @Column(name = "empre_trans_ruc", length = 15)
    public String empreTransRuc;

    /** Legado: EMPRE_TRANS_DOMICI */
    @Column(name = "empre_trans_domici", length = 50)
    public String empreTransDomici;
}
