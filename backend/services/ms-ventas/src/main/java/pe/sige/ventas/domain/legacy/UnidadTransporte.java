package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Unidad_transporte</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "UnidadTransporte")
@Table(name = "unidad_transporte")
public class UnidadTransporte extends LegacyEntity {

    /** Legado: Codi_unid_Tran */
    @Id
    @Column(name = "codi_unid_tran", length = 4, nullable = false)
    public String codiUnidTran;

    /** Legado: Desc_unid_Tran */
    @Column(name = "desc_unid_tran", length = 100)
    public String descUnidTran;

    /** Legado: Marc_unid_tran */
    @Column(name = "marc_unid_tran", length = 20)
    public String marcUnidTran;

    @Column(name = "plac_unid_tran", length = 10)
    public String placUnidTran;

    @Column(name = "cert_unid_tran", length = 12)
    public String certUnidTran;

    @Column(name = "colo_unid_tran", length = 10)
    public String coloUnidTran;

    @Column(name = "lice_unid_trans", length = 20)
    public String liceUnidTrans;

    @Column(name = "mot_unid_tran", length = 20)
    public String motUnidTran;

    @Column(name = "anio_unid_tran", length = 4)
    public String anioUnidTran;

    @Column(name = "cod_tran_unid_tran", length = 10)
    public String codTranUnidTran;

    @Column(name = "codi_tipo", length = 1)
    public String codiTipo;

    /** Legado: NRO_PLAC_REMO */
    @Column(name = "nro_plac_remo", length = 20)
    public String nroPlacRemo;

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

    /** Legado: INTE_EXTE */
    @Column(name = "inte_exte", length = 1)
    public String inteExte;

    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    @Column(name = "capacidad", precision = 18, scale = 2)
    public BigDecimal capacidad;

    /** Legado: ID_CONF */
    @Column(name = "id_conf")
    public Integer idConf;

    @Column(name = "codi_carreta", length = 5)
    public String codiCarreta;

    @Column(name = "codi_trans", length = 4)
    public String codiTrans;

    @Column(name = "codi_tracto", length = 5)
    public String codiTracto;

    @Column(name = "tipo_unidad", length = 50)
    public String tipoUnidad;

    @Column(name = "permiso", length = 1)
    public String permiso;

    @Column(name = "soat_ini")
    public LocalDateTime soatIni;

    @Column(name = "soat_fin")
    public LocalDateTime soatFin;

    @Column(name = "codi_prop", length = 5)
    public String codiProp;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;
}
