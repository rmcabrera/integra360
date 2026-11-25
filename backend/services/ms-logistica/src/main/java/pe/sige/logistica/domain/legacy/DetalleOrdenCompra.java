package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DETALLE_ORDEN_COMPRA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DetalleOrdenCompra")
@Table(name = "detalle_orden_compra")
public class DetalleOrdenCompra extends LegacyEntity {

    /** Legado: CODI_DETA_ORDE_COMP */
    @Id
    @Column(name = "codi_deta_orde_comp", length = 12, nullable = false)
    public String codiDetaOrdeComp;

    /** Legado: CODI_ORDE_COMP */
    @Column(name = "codi_orde_comp", length = 10, nullable = false)
    public String codiOrdeComp;

    /** Legado: CODI_PROD */
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    /** Legado: CANTIDAD */
    @Column(name = "cantidad", precision = 18, scale = 4)
    public BigDecimal cantidad;

    /** Legado: PRECIO */
    @Column(name = "precio", precision = 18, scale = 4)
    public BigDecimal precio;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    /** Legado: TIPO_DESC */
    @Column(name = "tipo_desc")
    public Integer tipoDesc;

    /** Legado: DESCUENTO */
    @Column(name = "descuento", precision = 12, scale = 4)
    public BigDecimal descuento;

    /** Legado: PREC_ORIG */
    @Column(name = "prec_orig", precision = 18, scale = 4)
    public BigDecimal precOrig;

    /** Legado: CODI_DETA_ORDE_PEDI */
    @Column(name = "codi_deta_orde_pedi", length = 12)
    public String codiDetaOrdePedi;

    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "proc_pedi", length = 1)
    public String procPedi;

    @Column(name = "fecha_venc")
    public LocalDateTime fechaVenc;

    @Column(name = "tipo_compra", length = 1)
    public String tipoCompra;

    @Column(name = "codi_unid_medi_orde", length = 2)
    public String codiUnidMediOrde;

    /** Legado: TIPO_PROD */
    @Column(name = "tipo_prod", length = 5)
    public String tipoProd;
}
