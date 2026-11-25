package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SALDO_TANQUES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SaldoTanques")
@Table(name = "saldo_tanques")
public class SaldoTanques extends LegacyEntity {

    @Id
    @Column(name = "codi_sald_tanq", length = 10, nullable = false)
    public String codiSaldTanq;

    @Column(name = "codi_tanq_auxi", length = 3, nullable = false)
    public String codiTanqAuxi;

    @Column(name = "codi_turn", length = 2, nullable = false)
    public String codiTurn;

    @Column(name = "petr_ante", precision = 12, scale = 3)
    public BigDecimal petrAnte;

    @Column(name = "petr_ingr", precision = 12, scale = 3)
    public BigDecimal petrIngr;

    @Column(name = "petr_sali", precision = 12, scale = 3)
    public BigDecimal petrSali;

    @Column(name = "petr_fina", precision = 12, scale = 3)
    public BigDecimal petrFina;

    @Column(name = "fecha")
    public LocalDateTime fecha;
}
