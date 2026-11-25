package pe.sige.logistica.domain.legacy;

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
 * Tabla legado <b>dbo.ORDEN_COMPRA_DETALLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "OrdenCompraDetalle")
@Table(name = "orden_compra_detalle")
@IdClass(OrdenCompraDetalle.Pk.class)
public class OrdenCompraDetalle extends LegacyEntity {

    @Id
    @Column(name = "codi_orde", nullable = false)
    public Long codiOrde;

    @Id
    @Column(name = "item", nullable = false)
    public Integer item;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "cantidad", precision = 18, scale = 4)
    public BigDecimal cantidad;

    @Column(name = "precio", precision = 18, scale = 4)
    public BigDecimal precio;

    @Column(name = "codi_unid_medi", length = 2)
    public String codiUnidMedi;

    @Column(name = "total", precision = 18, scale = 2)
    public BigDecimal total;

    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    @Column(name = "saldo", precision = 18, scale = 4)
    public BigDecimal saldo;

    /** Legado: Igv */
    @Column(name = "igv", precision = 18, scale = 2)
    public BigDecimal igv;

    /** Legado: Venta */
    @Column(name = "venta", precision = 18, scale = 2)
    public BigDecimal venta;

    @Column(name = "valorigv", precision = 18, scale = 2)
    public BigDecimal valorigv;

    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "exonerado", length = 1)
    public String exonerado;

    @Column(name = "acidez", precision = 18, scale = 3)
    public BigDecimal acidez;

    @Column(name = "serguia", length = 5)
    public String serguia;

    @Column(name = "nroguia", length = 10)
    public String nroguia;

    @Column(name = "transporte", length = 5)
    public String transporte;

    @Column(name = "placa", length = 10)
    public String placa;

    @Column(name = "codi_moti_tras", length = 2)
    public String codiMotiTras;

    @Column(name = "pesocolp", precision = 18, scale = 4)
    public BigDecimal pesocolp;

    @Column(name = "ticket", length = 10)
    public String ticket;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiOrde;
        public Integer item;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiOrde, other.codiOrde)
                && Objects.equals(item, other.item);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiOrde, item);
        }
    }
}
