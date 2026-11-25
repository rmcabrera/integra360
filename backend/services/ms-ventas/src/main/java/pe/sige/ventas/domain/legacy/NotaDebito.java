package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.NOTA_DEBITO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "NotaDebito")
@Table(name = "nota_debito")
public class NotaDebito extends LegacyEntity {

    /** Legado: CODI_NOTA_DEBI */
    @Id
    @Column(name = "codi_nota_debi", length = 10, nullable = false)
    public String codiNotaDebi;

    /** Legado: SER_NOTA_DEBI */
    @Column(name = "ser_nota_debi", length = 5, nullable = false)
    public String serNotaDebi;

    /** Legado: NRO_NOTA_DEBI */
    @Column(name = "nro_nota_debi", length = 10, nullable = false)
    public String nroNotaDebi;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5, nullable = false)
    public String codiClieProv;

    /** Legado: FECH_NOTA_DEBI */
    @Column(name = "fech_nota_debi", nullable = false)
    public LocalDateTime fechNotaDebi;

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

    /** Legado: OBSERVACION1 */
    @Column(name = "observacion1", length = 200)
    public String observacion1;

    /** Legado: OBSERVACION2 */
    @Column(name = "observacion2", length = 200)
    public String observacion2;

    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

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

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "codi_fact", length = 10)
    public String codiFact;

    @Column(name = "tipo_oper", length = 4)
    public String tipoOper;

    @Column(name = "fecha_elim")
    public LocalDateTime fechaElim;

    @Column(name = "motivo_elim", length = 100)
    public String motivoElim;
}
