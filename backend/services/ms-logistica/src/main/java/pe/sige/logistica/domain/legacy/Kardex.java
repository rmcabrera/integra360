package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.KARDEX</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Kardex")
@Table(name = "kardex")
public class Kardex extends LegacyEntity {

    @Id
    @Column(name = "codi_kard", length = 20, nullable = false)
    public String codiKard;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    @Column(name = "nro_seri", length = 5)
    public String nroSeri;

    @Column(name = "nro_docu", length = 15)
    public String nroDocu;

    @Column(name = "codi_unid_oper_soli", length = 5)
    public String codiUnidOperSoli;

    @Column(name = "codi_unid_oper_dest", length = 5)
    public String codiUnidOperDest;

    @Column(name = "codi_cuen", length = 7)
    public String codiCuen;

    @Column(name = "fech_tran")
    public LocalDateTime fechTran;

    @Column(name = "cant_ingr", precision = 18, scale = 4)
    public BigDecimal cantIngr;

    @Column(name = "cant_sali", precision = 18, scale = 4)
    public BigDecimal cantSali;

    /** Legado: cant_Saldo */
    @Column(name = "cant_saldo", precision = 18, scale = 4)
    public BigDecimal cantSaldo;

    /** Legado: CANT_SALDO_ALMA */
    @Column(name = "cant_saldo_alma", precision = 18, scale = 4)
    public BigDecimal cantSaldoAlma;

    @Column(name = "prec_unit", precision = 12, scale = 4)
    public BigDecimal precUnit;

    @Column(name = "prec_prom", precision = 12, scale = 4)
    public BigDecimal precProm;

    @Column(name = "prec_prom_alma", precision = 18, scale = 4)
    public BigDecimal precPromAlma;

    @Column(name = "valo_ingr", precision = 18, scale = 4)
    public BigDecimal valoIngr;

    @Column(name = "valo_sali", precision = 18, scale = 4)
    public BigDecimal valoSali;

    @Column(name = "valo_saldo", precision = 18, scale = 4)
    public BigDecimal valoSaldo;

    @Column(name = "valo_ingr_alma", precision = 18, scale = 4)
    public BigDecimal valoIngrAlma;

    @Column(name = "valo_sali_alma", precision = 18, scale = 4)
    public BigDecimal valoSaliAlma;

    /** Legado: VALO_SALDO_ALMA */
    @Column(name = "valo_saldo_alma", precision = 18, scale = 4)
    public BigDecimal valoSaldoAlma;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "tipo_camb", precision = 12, scale = 4)
    public BigDecimal tipoCamb;

    /** Legado: I_O */
    @Column(name = "i_o", length = 1)
    public String iO;

    /** Legado: Codi_Docu_I_O */
    @Column(name = "codi_docu_i_o", length = 10)
    public String codiDocuIO;

    @Column(name = "concepto", length = 250)
    public String concepto;

    @Column(name = "nro_guia", length = 15)
    public String nroGuia;

    @Column(name = "periodo")
    public Integer periodo;

    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "item", length = 12)
    public String item;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    /** Legado: ProdServIQF */
    @Column(name = "prodserviqf", length = 50)
    public String prodserviqf;

    /** Legado: Canti_ProdServIQF */
    @Column(name = "canti_prodserviqf", precision = 18, scale = 4)
    public BigDecimal cantiProdserviqf;

    /** Legado: UM_ProdServIQF */
    @Column(name = "um_prodserviqf", length = 2)
    public String umProdserviqf;

    /** Legado: DeseIQF */
    @Column(name = "deseiqf", length = 50)
    public String deseiqf;

    /** Legado: Canti_DeseIQF */
    @Column(name = "canti_deseiqf", precision = 18, scale = 4)
    public BigDecimal cantiDeseiqf;

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

    @Column(name = "creacion")
    public LocalDateTime creacion;
}
