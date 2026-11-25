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
 * Tabla legado <b>dbo.DETALLE_ORDEN_SERVICIO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DetalleOrdenServicio")
@Table(name = "detalle_orden_servicio")
@IdClass(DetalleOrdenServicio.Pk.class)
public class DetalleOrdenServicio extends LegacyEntity {

    /** Legado: CODI_DETA_ORDE_COMP */
    @Id
    @Column(name = "codi_deta_orde_comp", length = 12, nullable = false)
    public String codiDetaOrdeComp;

    /** Legado: CODI_ORDE_COMP */
    @Id
    @Column(name = "codi_orde_comp", length = 10, nullable = false)
    public String codiOrdeComp;

    /** Legado: CODI_PROD */
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    /** Legado: DESC_SERV */
    @Column(name = "desc_serv", length = 250)
    public String descServ;

    /** Legado: CANTIDAD */
    @Column(name = "cantidad", precision = 18, scale = 4)
    public BigDecimal cantidad;

    /** Legado: PRECIO */
    @Column(name = "precio", precision = 12, scale = 4)
    public BigDecimal precio;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    /** Legado: TIPO_DESC */
    @Column(name = "tipo_desc")
    public Boolean tipoDesc;

    /** Legado: DESCUENTO */
    @Column(name = "descuento", precision = 12, scale = 4)
    public BigDecimal descuento;

    /** Legado: PREC_ORIG */
    @Column(name = "prec_orig", precision = 12, scale = 4)
    public BigDecimal precOrig;

    /** Legado: CODI_DETA_ORDE_PEDI */
    @Column(name = "codi_deta_orde_pedi", length = 12)
    public String codiDetaOrdePedi;

    /** Legado: CODI_UNID_MEDI */
    @Column(name = "codi_unid_medi", length = 2)
    public String codiUnidMedi;

    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiDetaOrdeComp;
        public String codiOrdeComp;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiDetaOrdeComp, other.codiDetaOrdeComp)
                && Objects.equals(codiOrdeComp, other.codiOrdeComp);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiDetaOrdeComp, codiOrdeComp);
        }
    }
}
