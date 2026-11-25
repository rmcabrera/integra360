package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.detalle_detraccion</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DetalleDetraccion")
@Table(name = "detalle_detraccion")
@IdClass(DetalleDetraccion.Pk.class)
public class DetalleDetraccion extends LegacyEntity {

    @Id
    @Column(name = "codi_lote_detr", length = 10, nullable = false)
    public String codiLoteDetr;

    /** Legado: Nro_detalle */
    @Id
    @Column(name = "nro_detalle", length = 3, nullable = false)
    public String nroDetalle;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "nro_proforma", length = 9)
    public String nroProforma;

    @Column(name = "codi_bien_serv", length = 3)
    public String codiBienServ;

    @Column(name = "codi_cta_cte", length = 6)
    public String codiCtaCte;

    @Column(name = "importe_deposito", precision = 15, scale = 2)
    public BigDecimal importeDeposito;

    @Column(name = "codi_oper", length = 2)
    public String codiOper;

    @Column(name = "nro_cta_cte", length = 20)
    public String nroCtaCte;

    @Column(name = "codi_fact", length = 10)
    public String codiFact;

    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    @Column(name = "serie", length = 5)
    public String serie;

    @Column(name = "nro_docu", length = 10)
    public String nroDocu;

    @Column(name = "registro", length = 10)
    public String registro;

    @Column(name = "fecha_spot")
    public LocalDateTime fechaSpot;

    @Column(name = "num_spot", length = 100)
    public String numSpot;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiLoteDetr;
        public String nroDetalle;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiLoteDetr, other.codiLoteDetr)
                && Objects.equals(nroDetalle, other.nroDetalle);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiLoteDetr, nroDetalle);
        }
    }
}
