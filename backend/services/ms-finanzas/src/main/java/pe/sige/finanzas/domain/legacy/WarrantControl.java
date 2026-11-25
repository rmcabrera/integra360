package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.WARRANT_CONTROL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "WarrantControl")
@Table(name = "warrant_control")
public class WarrantControl extends LegacyEntity {

    @Id
    @Column(name = "codi_warr", nullable = false)
    public Long codiWarr;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "almacenera", length = 5)
    public String almacenera;

    @Column(name = "banco_nro", length = 20)
    public String bancoNro;

    @Column(name = "codi_banc", length = 7)
    public String codiBanc;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "nro_warr", length = 50)
    public String nroWarr;

    @Column(name = "tm_alma", precision = 18, scale = 3)
    public BigDecimal tmAlma;

    @Column(name = "ingr_warr", precision = 18, scale = 3)
    public BigDecimal ingrWarr;

    @Column(name = "sali_cant", precision = 18, scale = 3)
    public BigDecimal saliCant;

    @Column(name = "stock", precision = 18, scale = 3)
    public BigDecimal stock;

    @Column(name = "valor_warr", precision = 18, scale = 3)
    public BigDecimal valorWarr;

    @Column(name = "i_o", length = 1)
    public String iO;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "tpc", precision = 18, scale = 4)
    public BigDecimal tpc;

    @Column(name = "disponible", precision = 18, scale = 3)
    public BigDecimal disponible;

    @Column(name = "periodo", length = 4)
    public String periodo;

    @Column(name = "broker", length = 5)
    public String broker;

    @Column(name = "comprador", length = 5)
    public String comprador;

    @Column(name = "fecha_emba")
    public LocalDateTime fechaEmba;

    @Column(name = "codi_tpago")
    public Integer codiTpago;

    @Column(name = "num_pago", length = 50)
    public String numPago;

    @Column(name = "valor_fina", precision = 18, scale = 3)
    public BigDecimal valorFina;

    @Column(name = "tm_cred", precision = 18, scale = 3)
    public BigDecimal tmCred;

    @Column(name = "valor_cred", precision = 18, scale = 3)
    public BigDecimal valorCred;
}
