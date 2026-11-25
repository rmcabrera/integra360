package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.GUIA_DETALLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "GuiaDetalle")
@Table(name = "guia_detalle")
@IdClass(GuiaDetalle.Pk.class)
public class GuiaDetalle extends LegacyEntity {

    /** Legado: Codi_Guia */
    @Id
    @Column(name = "codi_guia", nullable = false)
    public Long codiGuia;

    /** Legado: Item_Guia */
    @Id
    @Column(name = "item_guia", nullable = false)
    public Integer itemGuia;

    /** Legado: Codi_Prod */
    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    /** Legado: Cantidad */
    @Column(name = "cantidad", precision = 18, scale = 4)
    public BigDecimal cantidad;

    /** Legado: Codi_Unid_Medi */
    @Column(name = "codi_unid_medi", length = 2)
    public String codiUnidMedi;

    /** Legado: Descripcion */
    @Column(name = "descripcion", length = 100)
    public String descripcion;

    @Column(name = "prec_unit", precision = 18, scale = 4)
    public BigDecimal precUnit;

    @Column(name = "valor_venta", precision = 18, scale = 4)
    public BigDecimal valorVenta;

    @Column(name = "descuento", precision = 12, scale = 2)
    public BigDecimal descuento;

    @Column(name = "prec_venta", precision = 12, scale = 4)
    public BigDecimal precVenta;

    @Column(name = "peso_total", precision = 12, scale = 2)
    public BigDecimal pesoTotal;

    @Column(name = "observaciones", length = 150)
    public String observaciones;

    @Column(name = "doc", length = 5)
    public String doc;

    @Column(name = "ser", length = 5)
    public String ser;

    @Column(name = "nro", length = 10)
    public String nro;

    @Column(name = "prec_compra", precision = 18, scale = 4)
    public BigDecimal precCompra;

    @Column(name = "codi_deta_orde_pedi", length = 12)
    public String codiDetaOrdePedi;

    @Column(name = "prec_venta_real", precision = 12, scale = 4)
    public BigDecimal precVentaReal;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiGuia;
        public Integer itemGuia;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiGuia, other.codiGuia)
                && Objects.equals(itemGuia, other.itemGuia);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiGuia, itemGuia);
        }
    }
}
