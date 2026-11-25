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
 * Tabla legado <b>dbo.FACTURA_DETALLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "FacturaDetalle")
@Table(name = "factura_detalle")
@IdClass(FacturaDetalle.Pk.class)
public class FacturaDetalle extends LegacyEntity {

    /** Legado: CODI_FACT */
    @Id
    @Column(name = "codi_fact", length = 10, nullable = false)
    public String codiFact;

    /** Legado: CODI_DETA */
    @Id
    @Column(name = "codi_deta", length = 3, nullable = false)
    public String codiDeta;

    /** Legado: CODI_ALMA */
    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    /** Legado: CODI_ITEM */
    @Column(name = "codi_item", length = 10)
    public String codiItem;

    /** Legado: CODI_PROD */
    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    /** Legado: DESC_ITEM */
    @Column(name = "desc_item", length = 300)
    public String descItem;

    /** Legado: CODI_UNID_MEDI */
    @Column(name = "codi_unid_medi", length = 2)
    public String codiUnidMedi;

    /** Legado: CANT_ITEM */
    @Column(name = "cant_item", precision = 12, scale = 3)
    public BigDecimal cantItem;

    /** Legado: PREC_ITEM */
    @Column(name = "prec_item", precision = 18, scale = 7)
    public BigDecimal precItem;

    /** Legado: PREC_LISTA */
    @Column(name = "prec_lista", precision = 18, scale = 7)
    public BigDecimal precLista;

    /** Legado: DSCTO_PREC */
    @Column(name = "dscto_prec", precision = 19, scale = 4)
    public BigDecimal dsctoPrec;

    /** Legado: DSCTO_ITEM */
    @Column(name = "dscto_item", precision = 19, scale = 4)
    public BigDecimal dsctoItem;

    /** Legado: IMPO_ITEM */
    @Column(name = "impo_item", precision = 12, scale = 3)
    public BigDecimal impoItem;

    @Column(name = "igv", precision = 18, scale = 3)
    public BigDecimal igv;

    @Column(name = "codi_mate", length = 10)
    public String codiMate;

    /** Legado: CANT_SALDO */
    @Column(name = "cant_saldo")
    public Long cantSaldo;

    @Column(name = "codi_imp")
    public Integer codiImp;

    /** Legado: PREC_COSTO */
    @Column(name = "prec_costo", precision = 19, scale = 4)
    public BigDecimal precCosto;

    /** Legado: INCL_IGV */
    @Column(name = "incl_igv", length = 1)
    public String inclIgv;

    @Column(name = "saldo_conv", precision = 18, scale = 2)
    public BigDecimal saldoConv;

    @Column(name = "prod_ofer", length = 1)
    public String prodOfer;

    /** Legado: codi_Desc_deta */
    @Column(name = "codi_desc_deta", length = 2)
    public String codiDescDeta;

    /** Legado: codi_Tipo_afec */
    @Column(name = "codi_tipo_afec", length = 2)
    public String codiTipoAfec;

    @Column(name = "tipo_rot", length = 7)
    public String tipoRot;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiFact;
        public String codiDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiFact, other.codiFact)
                && Objects.equals(codiDeta, other.codiDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiFact, codiDeta);
        }
    }
}
