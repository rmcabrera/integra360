package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.NOTA_CREDITO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "NotaCredito")
@Table(name = "nota_credito")
public class NotaCredito extends LegacyEntity {

    /** Legado: CODI_NOTA_CRED */
    @Id
    @Column(name = "codi_nota_cred", length = 10, nullable = false)
    public String codiNotaCred;

    /** Legado: SER_NOTA_CRED */
    @Column(name = "ser_nota_cred", length = 5, nullable = false)
    public String serNotaCred;

    /** Legado: NRO_NOTA_CRED */
    @Column(name = "nro_nota_cred", length = 10, nullable = false)
    public String nroNotaCred;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5, nullable = false)
    public String codiClieProv;

    /** Legado: FECH_NOTA_CRED */
    @Column(name = "fech_nota_cred", nullable = false)
    public LocalDateTime fechNotaCred;

    /** Legado: VALO_VENT */
    @Column(name = "valo_vent", precision = 12, scale = 3, nullable = false)
    public BigDecimal valoVent;

    /** Legado: IGV */
    @Column(name = "igv", precision = 12, scale = 3, nullable = false)
    public BigDecimal igv;

    /** Legado: PREC_VENT */
    @Column(name = "prec_vent", precision = 12, scale = 3, nullable = false)
    public BigDecimal precVent;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2, nullable = false)
    public String codiMone;

    /** Legado: OBSERVACION */
    @Column(name = "observacion", length = 250)
    public String observacion;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    /** Legado: CODI_SEMA */
    @Column(name = "codi_sema", length = 8)
    public String codiSema;

    /** Legado: CODI_DETA_ZARP */
    @Column(name = "codi_deta_zarp", length = 15)
    public String codiDetaZarp;

    /** Legado: Estado */
    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "cuenta1", length = 7)
    public String cuenta1;

    @Column(name = "cuenta2", length = 7)
    public String cuenta2;

    @Column(name = "cuenta3", length = 7)
    public String cuenta3;

    @Column(name = "contabilizado", length = 1)
    public String contabilizado;

    @Column(name = "codi_tipo", length = 2)
    public String codiTipo;

    @Column(name = "razon_social", length = 150)
    public String razonSocial;

    @Column(name = "direccion", length = 150)
    public String direccion;

    @Column(name = "ruc", length = 12)
    public String ruc;

    @Column(name = "codi_vouc", length = 10)
    public String codiVouc;

    @Column(name = "exonerado", length = 1)
    public String exonerado;

    @Column(name = "codi_fact", length = 10)
    public String codiFact;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "id_moti")
    public Integer idMoti;

    @Column(name = "moti_otro", length = 50)
    public String motiOtro;

    @Column(name = "tipo_oper", length = 4)
    public String tipoOper;

    @Column(name = "fecha_elim")
    public LocalDateTime fechaElim;

    @Column(name = "motivo_elim", length = 100)
    public String motivoElim;

    @Column(name = "tipo_impr", length = 1)
    public String tipoImpr;
}
