package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CLIENTE_CREDITOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ClienteCreditos")
@Table(name = "cliente_creditos")
public class ClienteCreditos extends LegacyEntity {

    @Id
    @Column(name = "codi_credito", nullable = false)
    public Long codiCredito;

    @Column(name = "codi_clie_prov", length = 5, nullable = false)
    public String codiClieProv;

    @Column(name = "fec_inic_cred", nullable = false)
    public LocalDateTime fecInicCred;

    @Column(name = "codi_mone", length = 2, nullable = false)
    public String codiMone;

    @Column(name = "monto_cred", precision = 19, scale = 4, nullable = false)
    public BigDecimal montoCred;

    @Column(name = "fec_fin_cred")
    public LocalDateTime fecFinCred;

    @Column(name = "observa_cred", length = 100)
    public String observaCred;

    /** Persona que autoriza el credito */
    @Column(name = "codi_usua_autoriza", length = 5, nullable = false)
    public String codiUsuaAutoriza;

    /** 1=Activo,0=Cerrado */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Persona responsable  */
    @Column(name = "codi_usua_responsa", length = 5)
    public String codiUsuaResponsa;

    /** 1=Siembras,2=Siembras Varias */
    @Column(name = "tipo_cred", length = 1)
    public String tipoCred;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "multi_credito", length = 1)
    public String multiCredito;

    @Column(name = "tipo_pago", length = 1)
    public String tipoPago;

    @Column(name = "doc_garantia", length = 2)
    public String docGarantia;

    @Column(name = "fec_pago")
    public LocalDateTime fecPago;

    @Column(name = "fec_icomp")
    public LocalDateTime fecIcomp;

    @Column(name = "fconyuge")
    public Boolean fconyuge;

    @Column(name = "faval")
    public Boolean faval;

    @Column(name = "cdnicliente")
    public Boolean cdnicliente;

    @Column(name = "cdniconyuge")
    public Boolean cdniconyuge;

    @Column(name = "ccontrarrend")
    public Boolean ccontrarrend;

    @Column(name = "crecserv", length = 100)
    public String crecserv;

    @Column(name = "ctitprop", length = 100)
    public String ctitprop;

    @Column(name = "terrprop", length = 255)
    public String terrprop;

    @Column(name = "casa", length = 255)
    public String casa;

    @Column(name = "vehiculo", length = 255)
    public String vehiculo;

    @Column(name = "negocio", length = 255)
    public String negocio;

    @Column(name = "referencias", length = 255)
    public String referencias;

    @Column(name = "fec_csf")
    public LocalDateTime fecCsf;

    @Column(name = "codigosf", length = 20)
    public String codigosf;

    @Column(name = "calificacion", length = 50)
    public String calificacion;

    @Column(name = "capital", precision = 18, scale = 2)
    public BigDecimal capital;

    @Column(name = "intereses", precision = 18, scale = 2)
    public BigDecimal intereses;

    @Column(name = "total", precision = 18, scale = 2)
    public BigDecimal total;

    @Column(name = "vae1", precision = 18, scale = 2)
    public BigDecimal vae1;

    @Column(name = "vae2", precision = 18, scale = 2)
    public BigDecimal vae2;

    @Column(name = "vae3", precision = 18, scale = 2)
    public BigDecimal vae3;

    @Column(name = "vac1", precision = 18, scale = 2)
    public BigDecimal vac1;

    @Column(name = "vac2", precision = 18, scale = 2)
    public BigDecimal vac2;

    @Column(name = "vac3", precision = 18, scale = 2)
    public BigDecimal vac3;

    @Column(name = "infocorp", length = 1)
    public String infocorp;
}
