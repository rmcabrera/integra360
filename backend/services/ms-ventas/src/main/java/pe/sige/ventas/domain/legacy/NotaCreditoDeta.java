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
 * Tabla legado <b>dbo.NOTA_CREDITO_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "NotaCreditoDeta")
@Table(name = "nota_credito_deta")
@IdClass(NotaCreditoDeta.Pk.class)
public class NotaCreditoDeta extends LegacyEntity {

    /** Legado: CODI_NOTA_CRED */
    @Id
    @Column(name = "codi_nota_cred", length = 10, nullable = false)
    public String codiNotaCred;

    /** Legado: CODI_DETA */
    @Id
    @Column(name = "codi_deta", length = 3, nullable = false)
    public String codiDeta;

    /** Legado: DESC_ITEM */
    @Column(name = "desc_item")
    public String descItem;

    /** Legado: CODI_UNID_MEDI */
    @Column(name = "codi_unid_medi", length = 2)
    public String codiUnidMedi;

    /** Legado: CANT_ITEM */
    @Column(name = "cant_item", precision = 12, scale = 3)
    public BigDecimal cantItem;

    /** Legado: PREC_ITEM */
    @Column(name = "prec_item", precision = 12, scale = 3)
    public BigDecimal precItem;

    /** Legado: IMPO_ITEM */
    @Column(name = "impo_item", precision = 12, scale = 3)
    public BigDecimal impoItem;

    /** Legado: CODI_ITEM */
    @Column(name = "codi_item", length = 10)
    public String codiItem;

    @Column(name = "igv", precision = 18, scale = 2)
    public BigDecimal igv;

    @Column(name = "codi_deta_fact", length = 3)
    public String codiDetaFact;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiNotaCred;
        public String codiDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiNotaCred, other.codiNotaCred)
                && Objects.equals(codiDeta, other.codiDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiNotaCred, codiDeta);
        }
    }
}
