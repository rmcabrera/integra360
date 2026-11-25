package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Saldo_Poza</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SaldoPoza")
@Table(name = "saldo_poza")
public class SaldoPoza extends LegacyEntity {

    @Id
    @Column(name = "codi_sald_poza", length = 10, nullable = false)
    public String codiSaldPoza;

    @Column(name = "codi_turn", length = 2, nullable = false)
    public String codiTurn;

    @Column(name = "codi_poza", length = 2, nullable = false)
    public String codiPoza;

    @Column(name = "sald_ante", precision = 12, scale = 3)
    public BigDecimal saldAnte;

    @Column(name = "cant_desc_poza", precision = 12, scale = 3)
    public BigDecimal cantDescPoza;

    @Column(name = "cons_prod", precision = 12, scale = 3)
    public BigDecimal consProd;

    @Column(name = "sald_fina", precision = 12, scale = 3)
    public BigDecimal saldFina;

    @Column(name = "fecha")
    public LocalDateTime fecha;
}
