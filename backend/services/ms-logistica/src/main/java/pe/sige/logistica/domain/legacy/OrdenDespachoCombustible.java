package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ORDEN_DESPACHO_COMBUSTIBLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "OrdenDespachoCombustible")
@Table(name = "orden_despacho_combustible")
@IdClass(OrdenDespachoCombustible.Pk.class)
public class OrdenDespachoCombustible extends LegacyEntity {

    @Id
    @Column(name = "codi_orden_des", nullable = false)
    public Long codiOrdenDes;

    @Id
    @Column(name = "nro_orden_des", nullable = false)
    public Long nroOrdenDes;

    @Column(name = "codi_orden_soli")
    public Long codiOrdenSoli;

    @Column(name = "tipo", length = 1)
    public String tipo;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "elabora_por", length = 5)
    public String elaboraPor;

    @Column(name = "autoriza_por", length = 5)
    public String autorizaPor;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiOrdenDes;
        public Long nroOrdenDes;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiOrdenDes, other.codiOrdenDes)
                && Objects.equals(nroOrdenDes, other.nroOrdenDes);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiOrdenDes, nroOrdenDes);
        }
    }
}
