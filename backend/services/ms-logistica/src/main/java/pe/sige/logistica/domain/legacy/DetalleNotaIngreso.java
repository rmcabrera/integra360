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
 * Tabla legado <b>dbo.DETALLE_NOTA_INGRESO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DetalleNotaIngreso")
@Table(name = "detalle_nota_ingreso")
@IdClass(DetalleNotaIngreso.Pk.class)
public class DetalleNotaIngreso extends LegacyEntity {

    /** Legado: CODI_NOTA_INGR */
    @Id
    @Column(name = "codi_nota_ingr", length = 10, nullable = false)
    public String codiNotaIngr;

    /** Legado: NRO_ITEM_NOTA_INGR */
    @Id
    @Column(name = "nro_item_nota_ingr", length = 12, nullable = false)
    public String nroItemNotaIngr;

    /** Legado: CODI_PROD */
    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    /** Legado: CANTIDAD */
    @Column(name = "cantidad", precision = 18, scale = 4)
    public BigDecimal cantidad;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Precio compra u otros aplicado el descuento compras */
    @Column(name = "prec_unit", precision = 18, scale = 4)
    public BigDecimal precUnit;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    /** Legado: PREC_KARD */
    @Column(name = "prec_kard", precision = 18, scale = 4)
    public BigDecimal precKard;

    /** Legado: STOC_ULTI */
    @Column(name = "stoc_ulti", precision = 15, scale = 4)
    public BigDecimal stocUlti;

    /** Legado: STOC_TEMP_ULTI */
    @Column(name = "stoc_temp_ulti", precision = 15, scale = 4)
    public BigDecimal stocTempUlti;

    /** Legado: PREC_ULTI */
    @Column(name = "prec_ulti", precision = 18, scale = 4)
    public BigDecimal precUlti;

    /** Legado: PORC_DETR */
    @Column(name = "porc_detr", precision = 15, scale = 4)
    public BigDecimal porcDetr;

    @Column(name = "codi_deta_orde_comp", length = 12)
    public String codiDetaOrdeComp;

    @Column(name = "codi_mone_ulti_prec", length = 2)
    public String codiMoneUltiPrec;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    /** Legado: CODI_DETA_ORDE_PEDI */
    @Column(name = "codi_deta_orde_pedi", length = 12)
    public String codiDetaOrdePedi;

    /** Legado: Codi_Tipo_Enva */
    @Column(name = "codi_tipo_enva")
    public Short codiTipoEnva;

    /** Legado: Num_Enva */
    @Column(name = "num_enva")
    public Short numEnva;

    /** Legado: Exceso */
    @Column(name = "exceso", precision = 18, scale = 4)
    public BigDecimal exceso;

    /** Legado: Faltante */
    @Column(name = "faltante", precision = 18, scale = 4)
    public BigDecimal faltante;

    /** Legado: Observaciones */
    @Column(name = "observaciones", length = 50)
    public String observaciones;

    /** Legado: Concen_IQF */
    @Column(name = "concen_iqf", precision = 18, scale = 2)
    public BigDecimal concenIqf;

    /** Descuento en porcentaje del producto en compras */
    @Column(name = "dscto_porcentaje", precision = 18, scale = 3)
    public BigDecimal dsctoPorcentaje;

    /** Precio compra mas el descuento */
    @Column(name = "prec_compra", precision = 18, scale = 4)
    public BigDecimal precCompra;

    @Column(name = "tipo_compra", length = 1)
    public String tipoCompra;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiNotaIngr;
        public String nroItemNotaIngr;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiNotaIngr, other.codiNotaIngr)
                && Objects.equals(nroItemNotaIngr, other.nroItemNotaIngr);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiNotaIngr, nroItemNotaIngr);
        }
    }
}
