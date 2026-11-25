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
 * Tabla legado <b>dbo.REGISTRO_PAGOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "RegistroPagos")
@Table(name = "registro_pagos")
public class RegistroPagos extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_sec", nullable = false)
    public Long idSec;

    @Column(name = "fecha_reg")
    public LocalDateTime fechaReg;

    @Column(name = "numero")
    public Long numero;

    @Column(name = "documento", length = 50)
    public String documento;

    @Column(name = "medio_pago", length = 50)
    public String medioPago;

    @Column(name = "cuota", length = 25)
    public String cuota;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "concepto", length = 250)
    public String concepto;

    @Column(name = "codigo", length = 35)
    public String codigo;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "importe", precision = 18, scale = 2)
    public BigDecimal importe;

    @Column(name = "comentario", length = 255)
    public String comentario;

    @Column(name = "fecha_pago")
    public LocalDateTime fechaPago;

    @Column(name = "observaciones", length = 255)
    public String observaciones;

    @Column(name = "activo", length = 1)
    public String activo;

    @Column(name = "condicion", length = 1)
    public String condicion;

    @Column(name = "codi_clie_pers", length = 5)
    public String codiCliePers;

    @Column(name = "clie_pers", length = 150)
    public String cliePers;
}
