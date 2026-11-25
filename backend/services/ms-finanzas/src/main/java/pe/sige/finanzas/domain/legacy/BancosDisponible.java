package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.BANCOS_DISPONIBLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "BancosDisponible")
@Table(name = "bancos_disponible")
public class BancosDisponible extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_sec", nullable = false)
    public Long idSec;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Legado: nro_Cuen */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    @Column(name = "contable_s", precision = 18, scale = 2)
    public BigDecimal contableS;

    @Column(name = "contable_d", precision = 18, scale = 2)
    public BigDecimal contableD;

    @Column(name = "disponible_s", precision = 18, scale = 2)
    public BigDecimal disponibleS;

    @Column(name = "disponible_d", precision = 18, scale = 2)
    public BigDecimal disponibleD;
}
