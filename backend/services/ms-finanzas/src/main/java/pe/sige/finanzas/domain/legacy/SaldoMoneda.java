package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SALDO_MONEDA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SaldoMoneda")
@Table(name = "saldo_moneda")
public class SaldoMoneda extends LegacyEntity {

    @Id
    @Column(name = "id", nullable = false)
    public Long id;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "moneda", precision = 18, scale = 3)
    public BigDecimal moneda;

    @Column(name = "cant_s")
    public Integer cantS;

    @Column(name = "cant_d")
    public Integer cantD;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;
}
