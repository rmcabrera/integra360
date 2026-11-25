package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.COTIZACION_DE_PEDIDOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CotizacionDePedidos")
@Table(name = "cotizacion_de_pedidos")
public class CotizacionDePedidos extends LegacyEntity {

    /** Legado: CODI_COTI */
    @Id
    @Column(name = "codi_coti", length = 10, nullable = false)
    public String codiCoti;

    /** Legado: FECH_COTI */
    @Column(name = "fech_coti")
    public LocalDateTime fechCoti;

    /** Legado: TIEM_PLAZ_CRED */
    @Column(name = "tiem_plaz_cred")
    public Integer tiemPlazCred;

    /** Legado: CODI_UNID_MEDI */
    @Column(name = "codi_unid_medi", length = 2)
    public String codiUnidMedi;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: PREC_TOTA_COTI */
    @Column(name = "prec_tota_coti", precision = 12, scale = 2)
    public BigDecimal precTotaCoti;

    /** Legado: CODI_ORDE_PEDI */
    @Column(name = "codi_orde_pedi", length = 10)
    public String codiOrdePedi;

    /** Legado: CODI_LIST_REQU_ORIG */
    @Column(name = "codi_list_requ_orig", length = 8)
    public String codiListRequOrig;
}
