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
 * Tabla legado <b>dbo.FACTURAS_DETALLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "FacturasDetalle")
@Table(name = "facturas_detalle")
@IdClass(FacturasDetalle.Pk.class)
public class FacturasDetalle extends LegacyEntity {

    /** Legado: Codi_Fact */
    @Id
    @Column(name = "codi_fact", nullable = false)
    public Integer codiFact;

    /** Legado: Item_Fact */
    @Id
    @Column(name = "item_fact", nullable = false)
    public Short itemFact;

    /** Legado: Codi_Prod_Serv */
    @Column(name = "codi_prod_serv", length = 8)
    public String codiProdServ;

    /** Legado: Descripcion */
    @Column(name = "descripcion", length = 150)
    public String descripcion;

    /** Legado: Cantidad */
    @Column(name = "cantidad", precision = 18, scale = 2)
    public BigDecimal cantidad;

    /** Legado: Codi_Unid_Medi */
    @Column(name = "codi_unid_medi", length = 2)
    public String codiUnidMedi;

    /** Legado: Prec_inc_IGV */
    @Column(name = "prec_inc_igv", precision = 18, scale = 8)
    public BigDecimal precIncIgv;

    /** Legado: Prec_Unit */
    @Column(name = "prec_unit", precision = 18, scale = 8)
    public BigDecimal precUnit;

    /** Legado: SubTotal */
    @Column(name = "subtotal", precision = 18, scale = 4)
    public BigDecimal subtotal;

    /** Legado: Origen */
    @Column(name = "origen")
    public Short origen;

    /** P aun no se se remite en Gr, E enviado en guia */
    @Column(name = "estado", length = 1, nullable = false)
    public String estado;

    /** Legado: Codi_Orde_Produc */
    @Column(name = "codi_orde_produc")
    public Integer codiOrdeProduc;

    /** Legado: Codi_Guia */
    @Column(name = "codi_guia")
    public Integer codiGuia;

    /** Legado: Item_Guia */
    @Column(name = "item_guia")
    public Short itemGuia;

    /** Legado: DETALLE */
    @Column(name = "detalle", length = 1000)
    public String detalle;

    /** Legado: DETALLE2 */
    @Column(name = "detalle2", length = 250)
    public String detalle2;

    /** Legado: DETALLE3 */
    @Column(name = "detalle3", length = 250)
    public String detalle3;

    /** Legado: DETALLE4 */
    @Column(name = "detalle4", length = 250)
    public String detalle4;

    /** Legado: DetaDescrip */
    @Column(name = "detadescrip", length = 1000)
    public String detadescrip;

    /** Legado: DESCRIPCION_item */
    @Column(name = "descripcion_item", length = 1000, nullable = false)
    public String descripcionItem;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Integer codiFact;
        public Short itemFact;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiFact, other.codiFact)
                && Objects.equals(itemFact, other.itemFact);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiFact, itemFact);
        }
    }
}
