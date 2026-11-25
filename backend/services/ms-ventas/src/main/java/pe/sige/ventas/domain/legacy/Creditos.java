package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CREDITOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Creditos")
@Table(name = "creditos")
public class Creditos extends LegacyEntity {

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

    @Column(name = "codi_usua_autoriza", length = 5, nullable = false)
    public String codiUsuaAutoriza;

    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "codi_usua_responsa", length = 5)
    public String codiUsuaResponsa;

    @Column(name = "tipo_cred", length = 1)
    public String tipoCred;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "multi_credito", length = 1)
    public String multiCredito;

    @Column(name = "tipo_pago")
    public Long tipoPago;

    @Column(name = "doc_garantia", length = 1)
    public String docGarantia;

    @Column(name = "interes", precision = 18, scale = 2)
    public BigDecimal interes;

    @Column(name = "igv", precision = 18, scale = 2)
    public BigDecimal igv;

    @Column(name = "gastos", precision = 18, scale = 2)
    public BigDecimal gastos;

    @Column(name = "total", precision = 18, scale = 2)
    public BigDecimal total;

    @Column(name = "codi_lin_cred")
    public Long codiLinCred;

    @Column(name = "codi_proy", length = 10)
    public String codiProy;

    @Column(name = "codi_clie_fav", length = 5)
    public String codiClieFav;

    @Column(name = "periodo", length = 2)
    public String periodo;
}
