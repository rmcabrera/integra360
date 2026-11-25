package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.COTIZACION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Cotizacion")
@Table(name = "cotizacion")
public class Cotizacion extends LegacyEntity {

    @Id
    @Column(name = "codi_coti", nullable = false)
    public Long codiCoti;

    @Column(name = "nro_cotiza")
    public Long nroCotiza;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "lugar_ent", length = 250)
    public String lugarEnt;

    @Column(name = "tiempo_ent", length = 250)
    public String tiempoEnt;

    @Column(name = "observaciones", length = 250)
    public String observaciones;

    @Column(name = "fecha_venc")
    public LocalDateTime fechaVenc;

    @Column(name = "forma_pago", length = 2)
    public String formaPago;

    @Column(name = "fact_dias")
    public Integer factDias;
}
