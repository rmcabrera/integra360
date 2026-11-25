package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DETALLE_ZARPE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DetalleZarpe")
@Table(name = "detalle_zarpe")
public class DetalleZarpe extends LegacyEntity {

    /** Legado: CODI_DETA_ZARP */
    @Id
    @Column(name = "codi_deta_zarp", length = 15, nullable = false)
    public String codiDetaZarp;

    /** Legado: CODI_ZARP */
    @Column(name = "codi_zarp", length = 10, nullable = false)
    public String codiZarp;

    /** Legado: CODI_ESPE */
    @Column(name = "codi_espe", length = 2, nullable = false)
    public String codiEspe;

    /** Legado: CANTIDAD */
    @Column(name = "cantidad", precision = 12, scale = 3)
    public BigDecimal cantidad;

    /** Legado: CODI_UNID_MEDI_CANT */
    @Column(name = "codi_unid_medi_cant", length = 2)
    public String codiUnidMediCant;

    /** Legado: TAMA_MINI_ESPE */
    @Column(name = "tama_mini_espe", precision = 12, scale = 2)
    public BigDecimal tamaMiniEspe;

    /** Legado: TAMA_MAXI_ESPE */
    @Column(name = "tama_maxi_espe", precision = 12, scale = 2)
    public BigDecimal tamaMaxiEspe;

    /** Legado: CODI_UNID_MEDI_TAMA */
    @Column(name = "codi_unid_medi_tama", length = 2)
    public String codiUnidMediTama;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    /** Legado: SERI_GUIA */
    @Column(name = "seri_guia", length = 5)
    public String seriGuia;

    /** Legado: NRO_GUIA */
    @Column(name = "nro_guia", length = 10)
    public String nroGuia;

    /** Legado: PREC_PACT */
    @Column(name = "prec_pact", precision = 12, scale = 3)
    public BigDecimal precPact;

    /** Legado: TIPO_DOCU */
    @Column(name = "tipo_docu", length = 2)
    public String tipoDocu;

    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: IncIgV */
    @Column(name = "incigv", length = 1)
    public String incigv;
}
