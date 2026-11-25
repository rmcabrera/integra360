package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DETALLE_COTIZACION_PEDIDO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DetalleCotizacionPedido")
@Table(name = "detalle_cotizacion_pedido")
public class DetalleCotizacionPedido extends LegacyEntity {

    /** Legado: CODI_DETA_COTI */
    @Id
    @Column(name = "codi_deta_coti", length = 12, nullable = false)
    public String codiDetaCoti;

    /** Legado: CODI_COTI */
    @Column(name = "codi_coti", length = 10)
    public String codiCoti;

    /** Legado: CODI_PROD */
    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    /** Legado: CANTIDAD */
    @Column(name = "cantidad", precision = 9, scale = 2)
    public BigDecimal cantidad;

    /** Legado: CODI_UNID_MEDI_TIEM */
    @Column(name = "codi_unid_medi_tiem", length = 2)
    public String codiUnidMediTiem;

    /** Legado: TIEM_RESP */
    @Column(name = "tiem_resp", precision = 18, scale = 2)
    public BigDecimal tiemResp;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: PREC_UNIT */
    @Column(name = "prec_unit", precision = 18, scale = 2)
    public BigDecimal precUnit;
}
