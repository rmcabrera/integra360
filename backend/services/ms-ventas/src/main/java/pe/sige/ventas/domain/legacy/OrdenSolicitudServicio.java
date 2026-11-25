package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ORDEN_SOLICITUD_SERVICIO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "OrdenSolicitudServicio")
@Table(name = "orden_solicitud_servicio")
public class OrdenSolicitudServicio extends LegacyEntity {

    @Id
    @Column(name = "codi_orden_soli", nullable = false)
    public Long codiOrdenSoli;

    @Column(name = "nro_orden_soli")
    public Long nroOrdenSoli;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "codi_ruta", length = 5)
    public String codiRuta;

    @Column(name = "contacto", length = 150)
    public String contacto;

    @Column(name = "telefono", length = 20)
    public String telefono;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "condicion", length = 1)
    public String condicion;

    @Column(name = "codi_aux")
    public Long codiAux;

    @Column(name = "facturado", length = 1)
    public String facturado;

    @Column(name = "responsable", length = 5)
    public String responsable;

    @Column(name = "flete", precision = 18, scale = 2)
    public BigDecimal flete;

    @Column(name = "igv", precision = 18, scale = 2)
    public BigDecimal igv;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "tipo", length = 1)
    public String tipo;
}
