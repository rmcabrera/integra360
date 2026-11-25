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
 * Tabla legado <b>dbo.ORDEN_SOLICITUD_SERVICIO_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "OrdenSolicitudServicioDeta")
@Table(name = "orden_solicitud_servicio_deta")
@IdClass(OrdenSolicitudServicioDeta.Pk.class)
public class OrdenSolicitudServicioDeta extends LegacyEntity {

    @Id
    @Column(name = "codi_orden_soli", nullable = false)
    public Long codiOrdenSoli;

    @Id
    @Column(name = "codi_deta", nullable = false)
    public Long codiDeta;

    @Column(name = "codi_tracto", length = 5)
    public String codiTracto;

    @Column(name = "codi_carreta", length = 5)
    public String codiCarreta;

    @Column(name = "codi_trans", length = 4)
    public String codiTrans;

    @Column(name = "codi_carga", length = 4)
    public String codiCarga;

    @Column(name = "cantidad", precision = 18, scale = 2)
    public BigDecimal cantidad;

    @Column(name = "codi_unid_medi", length = 2)
    public String codiUnidMedi;

    @Column(name = "precio", precision = 18, scale = 2)
    public BigDecimal precio;

    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "observacion", length = 150)
    public String observacion;

    @Column(name = "importe", precision = 18, scale = 2)
    public BigDecimal importe;

    @Column(name = "id_guia")
    public Long idGuia;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiOrdenSoli;
        public Long codiDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiOrdenSoli, other.codiOrdenSoli)
                && Objects.equals(codiDeta, other.codiDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiOrdenSoli, codiDeta);
        }
    }
}
