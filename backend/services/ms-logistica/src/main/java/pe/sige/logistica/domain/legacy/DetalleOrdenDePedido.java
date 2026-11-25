package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DETALLE_ORDEN_DE_PEDIDO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DetalleOrdenDePedido")
@Table(name = "detalle_orden_de_pedido")
public class DetalleOrdenDePedido extends LegacyEntity {

    /** Legado: CODI_DETA_ORDE_PEDI */
    @Id
    @Column(name = "codi_deta_orde_pedi", length = 12, nullable = false)
    public String codiDetaOrdePedi;

    /** Legado: CODI_ORDE_PEDI */
    @Column(name = "codi_orde_pedi", length = 10, nullable = false)
    public String codiOrdePedi;

    /** Legado: CODI_PROD */
    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    /** Legado: CANTIDAD */
    @Column(name = "cantidad", precision = 10, scale = 4)
    public BigDecimal cantidad;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: PREC_PROM */
    @Column(name = "prec_prom", precision = 12, scale = 3)
    public BigDecimal precProm;

    /** Legado: PREC_ULTI */
    @Column(name = "prec_ulti", precision = 12, scale = 3)
    public BigDecimal precUlti;

    /** Legado: CODI_MONE_PREC_ULTI */
    @Column(name = "codi_mone_prec_ulti", length = 2)
    public String codiMonePrecUlti;

    /** Legado: CODI_CLIE_PROV_ULTI */
    @Column(name = "codi_clie_prov_ulti", length = 5)
    public String codiClieProvUlti;

    /** Legado: STOC_ULTI */
    @Column(name = "stoc_ulti", precision = 15, scale = 4)
    public BigDecimal stocUlti;

    /** Legado: STOC_TEMP_ULTI */
    @Column(name = "stoc_temp_ulti", precision = 15, scale = 4)
    public BigDecimal stocTempUlti;

    /** Legado: NRO_ULTI_SALI */
    @Column(name = "nro_ulti_sali", length = 10)
    public String nroUltiSali;

    /** Legado: FECH_ULTI_SALI */
    @Column(name = "fech_ulti_sali")
    public LocalDateTime fechUltiSali;

    /** Legado: CANT_ULTI_SALI */
    @Column(name = "cant_ulti_sali", precision = 15, scale = 4)
    public BigDecimal cantUltiSali;

    /** Legado: CONS_PROM */
    @Column(name = "cons_prom", precision = 15, scale = 4)
    public BigDecimal consProm;

    /** Legado: CUEN_COST */
    @Column(name = "cuen_cost", length = 7)
    public String cuenCost;

    /** Legado: LUGA_ATEN */
    @Column(name = "luga_aten", length = 4)
    public String lugaAten;

    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    /** Legado: PREC_VENTA */
    @Column(name = "prec_venta", precision = 18, scale = 3)
    public BigDecimal precVenta;
}
