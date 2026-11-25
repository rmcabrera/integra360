package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.FACTURAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Facturas")
@Table(name = "facturas")
public class Facturas extends LegacyEntity {

    /** Legado: Codi_Fact */
    @Id
    @Column(name = "codi_fact", nullable = false)
    public Integer codiFact;

    /** Legado: Serie_Fact */
    @Column(name = "serie_fact", nullable = false)
    public Short serieFact;

    /** Legado: Nro_Fact */
    @Column(name = "nro_fact", nullable = false)
    public Integer nroFact;

    /** Legado: Fecha_Fact */
    @Column(name = "fecha_fact", nullable = false)
    public LocalDateTime fechaFact;

    /** Legado: Tipo_Pers */
    @Column(name = "tipo_pers", length = 1)
    public String tipoPers;

    /** Legado: Codi_Clie */
    @Column(name = "codi_clie", length = 5, nullable = false)
    public String codiClie;

    /** Legado: Id_Clie_Natu_f */
    @Column(name = "id_clie_natu_f")
    public Integer idClieNatuF;

    /** Legado: ValorVenta */
    @Column(name = "valorventa", precision = 18, scale = 2, nullable = false)
    public BigDecimal valorventa;

    /** Legado: Igv */
    @Column(name = "igv", precision = 18, scale = 2, nullable = false)
    public BigDecimal igv;

    /** Legado: Total */
    @Column(name = "total", precision = 18, scale = 2, nullable = false)
    public BigDecimal total;

    /** Legado: Estado */
    @Column(name = "estado", length = 1, nullable = false)
    public String estado;

    /** Legado: Codi_Usua */
    @Column(name = "codi_usua", length = 5, nullable = false)
    public String codiUsua;

    /** Legado: Observaciones */
    @Column(name = "observaciones", length = 200)
    public String observaciones;

    /** Legado: Exonerado */
    @Column(name = "exonerado", nullable = false)
    public Short exonerado;

    /** Legado: Codi_Mone */
    @Column(name = "codi_mone", length = 2, nullable = false)
    public String codiMone;

    /** Legado: Codi_Tipo_Docu */
    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    /** Legado: Tipo_Cambio */
    @Column(name = "tipo_cambio", precision = 18, scale = 4)
    public BigDecimal tipoCambio;

    /** Legado: Entrega */
    @Column(name = "entrega")
    public Short entrega;

    /** Legado: Tipo */
    @Column(name = "tipo")
    public Short tipo;

    /** Legado: Nro_OC_Clie */
    @Column(name = "nro_oc_clie", length = 25)
    public String nroOcClie;

    /** Legado: Impreso */
    @Column(name = "impreso", nullable = false)
    public Short impreso;

    /** Legado: Cliente */
    @Column(name = "cliente", length = 75)
    public String cliente;

    /** Legado: Direccion */
    @Column(name = "direccion", length = 75)
    public String direccion;

    @Column(name = "nro_docu", length = 20)
    public String nroDocu;

    /** S ervicio Producto */
    @Column(name = "serv_prod", length = 1)
    public String servProd;

    /** 0 no 1 si */
    @Column(name = "cancelada")
    public Short cancelada;

    /** 0 no 1 si */
    @Column(name = "provisionada")
    public Short provisionada;

    /** Legado: Codi_Vouc */
    @Column(name = "codi_vouc", length = 10)
    public String codiVouc;

    @Column(name = "fechareg")
    public LocalDateTime fechareg;
}
