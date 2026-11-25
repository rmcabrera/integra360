package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.RUTA_ORDEN</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "RutaOrden")
@Table(name = "ruta_orden")
public class RutaOrden extends LegacyEntity {

    @Id
    @Column(name = "codi_ruta", length = 5, nullable = false)
    public String codiRuta;

    @Column(name = "descripcion", length = 150)
    public String descripcion;

    @Column(name = "destino", length = 150)
    public String destino;

    @Column(name = "distancia", precision = 18, scale = 2)
    public BigDecimal distancia;

    @Column(name = "origen", length = 150)
    public String origen;

    @Column(name = "codi_ori")
    public Integer codiOri;

    @Column(name = "codi_des")
    public Integer codiDes;

    @Column(name = "valor", precision = 18, scale = 2)
    public BigDecimal valor;
}
