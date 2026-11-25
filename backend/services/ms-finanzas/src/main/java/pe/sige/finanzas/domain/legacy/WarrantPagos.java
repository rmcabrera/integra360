package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.WARRANT_PAGOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "WarrantPagos")
@Table(name = "warrant_pagos")
public class WarrantPagos extends LegacyEntity {

    @Id
    @Column(name = "codi_pwarr", nullable = false)
    public Long codiPwarr;

    @Column(name = "nro_warr", length = 50)
    public String nroWarr;

    @Column(name = "fecha_pago")
    public LocalDateTime fechaPago;

    @Column(name = "canti_cancel", precision = 18, scale = 3)
    public BigDecimal cantiCancel;

    @Column(name = "monto_paga", precision = 18, scale = 3)
    public BigDecimal montoPaga;

    @Column(name = "periodo", length = 4)
    public String periodo;
}
