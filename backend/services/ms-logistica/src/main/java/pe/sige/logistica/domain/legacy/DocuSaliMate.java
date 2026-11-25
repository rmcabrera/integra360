package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DOCU_SALI_MATE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DocuSaliMate")
@Table(name = "docu_sali_mate")
public class DocuSaliMate extends LegacyEntity {

    /** Legado: CODI_DOCU_SALI */
    @Id
    @Column(name = "codi_docu_sali", length = 10, nullable = false)
    public String codiDocuSali;

    /** Legado: CODI_UNID_OPER_RECE */
    @Column(name = "codi_unid_oper_rece", length = 5)
    public String codiUnidOperRece;

    /** Legado: CODI_TIPO_DOCU_SALI */
    @Column(name = "codi_tipo_docu_sali", length = 4)
    public String codiTipoDocuSali;

    /** Legado: CODI_ORDE_PEDI */
    @Column(name = "codi_orde_pedi", length = 10)
    public String codiOrdePedi;

    /** Legado: CODI_PERS_EMIS */
    @Column(name = "codi_pers_emis", length = 5)
    public String codiPersEmis;

    /** Legado: CODI_PERS_RECE */
    @Column(name = "codi_pers_rece", length = 5)
    public String codiPersRece;

    /** Legado: FECH_EMIS */
    @Column(name = "fech_emis", nullable = false)
    public LocalDateTime fechEmis;

    /** Legado: CODI_TURN */
    @Column(name = "codi_turn", length = 2)
    public String codiTurn;

    /** Legado: CODI_UNID_NEGO */
    @Column(name = "codi_unid_nego", length = 2)
    public String codiUnidNego;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    /** Legado: NRO_SERI_DOCU_SALI */
    @Column(name = "nro_seri_docu_sali", length = 5)
    public String nroSeriDocuSali;

    /** Legado: NRO_DOCU_SALI */
    @Column(name = "nro_docu_sali", length = 10)
    public String nroDocuSali;

    /** Legado: MOTIVO */
    @Column(name = "motivo", length = 150)
    public String motivo;

    /** Legado: OBSERVACION */
    @Column(name = "observacion", length = 150)
    public String observacion;

    /** Legado: TIPO_SALI */
    @Column(name = "tipo_sali", length = 20)
    public String tipoSali;

    /** Legado: TIPO_DEST */
    @Column(name = "tipo_dest", length = 2)
    public String tipoDest;

    /** Legado: CODI_PERS_RECI_MATE */
    @Column(name = "codi_pers_reci_mate", length = 5)
    public String codiPersReciMate;

    /** Legado: MOTI_SALI */
    @Column(name = "moti_sali", length = 10)
    public String motiSali;

    /** Legado: CODI_PUER_SALI */
    @Column(name = "codi_puer_sali", length = 2)
    public String codiPuerSali;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: VIVERES */
    @Column(name = "viveres")
    public Boolean viveres;

    /** Legado: CODI_EMBA */
    @Column(name = "codi_emba", length = 5)
    public String codiEmba;

    /** Legado: CODI_SEMA_PESC */
    @Column(name = "codi_sema_pesc", length = 5)
    public String codiSemaPesc;

    /** Legado: NRO_SALI */
    @Column(name = "nro_sali", length = 10)
    public String nroSali;

    @Column(name = "kilometraje", precision = 18, scale = 2)
    public BigDecimal kilometraje;

    @Column(name = "kilo_mill", precision = 18, scale = 2)
    public BigDecimal kiloMill;

    /** Legado: Codi_Alma */
    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    /** Legado: CODI_ALMA_DESTI */
    @Column(name = "codi_alma_desti", length = 2)
    public String codiAlmaDesti;

    /** Legado: CODI_FACT */
    @Column(name = "codi_fact", length = 10)
    public String codiFact;

    /** P=Pendiente de ingreso, A=Aceptado por sucursal */
    @Column(name = "condicion", length = 1)
    public String condicion;

    @Column(name = "fech_reg_fact")
    public LocalDateTime fechRegFact;

    @Column(name = "codi_tipo_docu_cont", length = 4)
    public String codiTipoDocuCont;

    @Column(name = "nro_seri_docu_cont", length = 5)
    public String nroSeriDocuCont;

    @Column(name = "nro_docu_cont", length = 10)
    public String nroDocuCont;

    @Column(name = "importe", precision = 18, scale = 4)
    public BigDecimal importe;

    @Column(name = "igv", precision = 18, scale = 4)
    public BigDecimal igv;

    @Column(name = "prec_tota", precision = 18, scale = 4)
    public BigDecimal precTota;

    @Column(name = "contab")
    public Integer contab;
}
