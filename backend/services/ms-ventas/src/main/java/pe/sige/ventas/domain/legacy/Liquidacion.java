package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.LIQUIDACION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Liquidacion")
@Table(name = "liquidacion")
public class Liquidacion extends LegacyEntity {

    @Id
    @Column(name = "codi_liqu", nullable = false)
    public Long codiLiqu;

    @Column(name = "serie", length = 5)
    public String serie;

    @Column(name = "nro", length = 10)
    public String nro;

    @Column(name = "codi_trans", length = 5)
    public String codiTrans;

    @Column(name = "gastos", precision = 12, scale = 3)
    public BigDecimal gastos;

    @Column(name = "flete", precision = 12, scale = 3)
    public BigDecimal flete;

    @Column(name = "zona_part", length = 150)
    public String zonaPart;

    @Column(name = "zona_dest", length = 150)
    public String zonaDest;

    @Column(name = "mercaderia", length = 150)
    public String mercaderia;

    @Column(name = "placa_tracto", length = 5)
    public String placaTracto;

    @Column(name = "placa_carreta", length = 5)
    public String placaCarreta;

    @Column(name = "fecha_sal")
    public LocalDateTime fechaSal;

    @Column(name = "fecha_lleg")
    public LocalDateTime fechaLleg;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "nro_recibo", length = 10)
    public String nroRecibo;

    @Column(name = "total", precision = 12, scale = 3)
    public BigDecimal total;

    @Column(name = "rendir", length = 1)
    public String rendir;

    @Column(name = "combustible", precision = 12, scale = 3)
    public BigDecimal combustible;

    @Column(name = "costo_comb", precision = 12, scale = 3)
    public BigDecimal costoComb;

    @Column(name = "saldo", precision = 12, scale = 3)
    public BigDecimal saldo;

    @Column(name = "codi_orden_soli")
    public Long codiOrdenSoli;
}
