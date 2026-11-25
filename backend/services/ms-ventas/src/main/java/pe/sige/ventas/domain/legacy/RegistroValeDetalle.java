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
 * Tabla legado <b>dbo.REGISTRO_VALE_DETALLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "RegistroValeDetalle")
@Table(name = "registro_vale_detalle")
@IdClass(RegistroValeDetalle.Pk.class)
public class RegistroValeDetalle extends LegacyEntity {

    /** Legado: CODI_VALE */
    @Id
    @Column(name = "codi_vale", nullable = false)
    public Long codiVale;

    /** Legado: ID_SEC */
    @Id
    @Column(name = "id_sec", nullable = false)
    public Long idSec;

    /** Legado: CODI_PROD */
    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "cantidad", precision = 18, scale = 4)
    public BigDecimal cantidad;

    /** Legado: PREC_ITEM */
    @Column(name = "prec_item", precision = 12, scale = 4)
    public BigDecimal precItem;

    /** Legado: PREC_LISTA */
    @Column(name = "prec_lista", precision = 19, scale = 4)
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

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "codi_imp")
    public Integer codiImp;

    /** Legado: DESC_ITEM */
    @Column(name = "desc_item", length = 150)
    public String descItem;

    /** Legado: PREC_COSTO */
    @Column(name = "prec_costo", precision = 19, scale = 4)
    public BigDecimal precCosto;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiVale;
        public Long idSec;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiVale, other.codiVale)
                && Objects.equals(idSec, other.idSec);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiVale, idSec);
        }
    }
}
