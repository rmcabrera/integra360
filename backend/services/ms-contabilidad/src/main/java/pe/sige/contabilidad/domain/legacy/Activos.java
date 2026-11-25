package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Activos</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Activos")
@Table(name = "activos")
public class Activos extends LegacyEntity {

    @Id
    @Column(name = "codi_activo", length = 7, nullable = false)
    public String codiActivo;

    @Column(name = "descri_activo", length = 100)
    public String descriActivo;

    /** Legado: Codi_grup */
    @Column(name = "codi_grup")
    public Long codiGrup;

    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    @Column(name = "fech_ingre")
    public LocalDateTime fechIngre;

    /** Legado: Nro_docu */
    @Column(name = "nro_docu", length = 20)
    public String nroDocu;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "costo", precision = 10, scale = 2)
    public BigDecimal costo;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    /** Legado: TDAT */
    @Column(name = "tdat", precision = 18, scale = 4)
    public BigDecimal tdat;

    /** Legado: TDAC */
    @Column(name = "tdac", precision = 18, scale = 4)
    public BigDecimal tdac;

    /** Legado: Mes */
    @Column(name = "mes", length = 2)
    public String mes;

    /** Legado: Anio */
    @Column(name = "anio", length = 4)
    public String anio;

    /** Legado: Codi_Marca */
    @Column(name = "codi_marca", length = 4)
    public String codiMarca;

    @Column(name = "serie", length = 20)
    public String serie;

    @Column(name = "modelo", length = 50)
    public String modelo;

    @Column(name = "anio_fabr", length = 4)
    public String anioFabr;

    @Column(name = "matricula", length = 50)
    public String matricula;

    @Column(name = "color", length = 50)
    public String color;

    @Column(name = "capacidad", length = 50)
    public String capacidad;

    @Column(name = "ancho", precision = 18, scale = 2)
    public BigDecimal ancho;

    @Column(name = "largo", precision = 18, scale = 2)
    public BigDecimal largo;

    @Column(name = "alto", precision = 18, scale = 2)
    public BigDecimal alto;

    @Column(name = "voltaje", precision = 18, scale = 2)
    public BigDecimal voltaje;

    @Column(name = "amperaje", precision = 18, scale = 2)
    public BigDecimal amperaje;

    @Column(name = "fecha_depre")
    public LocalDateTime fechaDepre;

    /** Legado: FECHA_CONTRATO */
    @Column(name = "fecha_contrato")
    public LocalDateTime fechaContrato;

    /** Legado: NRO_CON_ARRE */
    @Column(name = "nro_con_arre", length = 100)
    public String nroConArre;

    /** Legado: FECHA_INI_ARRE */
    @Column(name = "fecha_ini_arre")
    public LocalDateTime fechaIniArre;

    /** Legado: NRO_CUOTAS */
    @Column(name = "nro_cuotas", length = 10)
    public String nroCuotas;

    /** Legado: MONTO_ARRE */
    @Column(name = "monto_arre", precision = 12, scale = 2)
    public BigDecimal montoArre;

    @Column(name = "fecha_retiro")
    public LocalDateTime fechaRetiro;
}
