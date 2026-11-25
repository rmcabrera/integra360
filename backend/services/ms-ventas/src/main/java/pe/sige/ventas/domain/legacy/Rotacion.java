package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ROTACION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Rotacion")
@Table(name = "rotacion")
public class Rotacion extends LegacyEntity {

    @Id
    @Column(name = "codi_rota", nullable = false)
    public Long codiRota;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "cantidad", precision = 12, scale = 2)
    public BigDecimal cantidad;

    @Column(name = "lote", length = 150)
    public String lote;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "tipo", length = 1)
    public String tipo;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "fecha_venc")
    public LocalDateTime fechaVenc;

    @Column(name = "observaciones", length = 255)
    public String observaciones;
}
