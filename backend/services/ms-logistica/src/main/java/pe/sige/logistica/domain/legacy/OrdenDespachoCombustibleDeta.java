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
 * Tabla legado <b>dbo.ORDEN_DESPACHO_COMBUSTIBLE_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "OrdenDespachoCombustibleDeta")
@Table(name = "orden_despacho_combustible_deta")
@IdClass(OrdenDespachoCombustibleDeta.Pk.class)
public class OrdenDespachoCombustibleDeta extends LegacyEntity {

    @Id
    @Column(name = "codi_orden_des", nullable = false)
    public Long codiOrdenDes;

    @Id
    @Column(name = "codi_deta", nullable = false)
    public Long codiDeta;

    @Column(name = "codi_tracto", length = 5)
    public String codiTracto;

    @Column(name = "codi_trans", length = 4)
    public String codiTrans;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "cantidad", precision = 18, scale = 2)
    public BigDecimal cantidad;

    @Column(name = "precio", precision = 18, scale = 2)
    public BigDecimal precio;

    @Column(name = "importe", precision = 18, scale = 2)
    public BigDecimal importe;

    @Column(name = "valor", precision = 18, scale = 2)
    public BigDecimal valor;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiOrdenDes;
        public Long codiDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiOrdenDes, other.codiOrdenDes)
                && Objects.equals(codiDeta, other.codiDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiOrdenDes, codiDeta);
        }
    }
}
