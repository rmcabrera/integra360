package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ORDEN_COMPRA_ACEITE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "OrdenCompraAceite")
@Table(name = "orden_compra_aceite")
public class OrdenCompraAceite extends LegacyEntity {

    @Id
    @Column(name = "codi_orde", nullable = false)
    public Long codiOrde;

    @Column(name = "nro_orde")
    public Long nroOrde;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    @Column(name = "serie", length = 3)
    public String serie;

    @Column(name = "numero", length = 10)
    public String numero;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "codi_moti_tras", length = 2)
    public String codiMotiTras;

    @Column(name = "tpc", precision = 18, scale = 4)
    public BigDecimal tpc;

    @Column(name = "observacion", length = 250)
    public String observacion;

    @Column(name = "codi_alma_dest", length = 2)
    public String codiAlmaDest;

    @Column(name = "contabilizado", length = 1)
    public String contabilizado;

    @Column(name = "codi_vouc", length = 10)
    public String codiVouc;

    @Column(name = "subt", precision = 18, scale = 2)
    public BigDecimal subt;

    @Column(name = "igv", precision = 18, scale = 2)
    public BigDecimal igv;

    @Column(name = "total", precision = 18, scale = 2)
    public BigDecimal total;

    /** Legado: Productor */
    @Column(name = "productor", length = 5)
    public String productor;

    @Column(name = "transporte", length = 5)
    public String transporte;

    @Column(name = "placa", length = 10)
    public String placa;

    @Column(name = "serfact", length = 5)
    public String serfact;

    @Column(name = "nrofact", length = 10)
    public String nrofact;

    @Column(name = "codi_doc", length = 4)
    public String codiDoc;

    @Column(name = "periodo", length = 4)
    public String periodo;
}
