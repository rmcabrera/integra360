package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ADELANTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Adelantos")
@Table(name = "adelantos")
public class Adelantos extends LegacyEntity {

    /** Legado: CODI_ADEL */
    @Id
    @Column(name = "codi_adel", length = 6, nullable = false)
    public String codiAdel;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: NRO_ADEL */
    @Column(name = "nro_adel", nullable = false)
    public Integer nroAdel;

    /** Legado: FECH_ADEL */
    @Column(name = "fech_adel", nullable = false)
    public LocalDateTime fechAdel;

    /** Legado: MOTI_ADEL */
    @Column(name = "moti_adel", length = 100)
    public String motiAdel;

    /** Legado: ESTA_PAGO */
    @Column(name = "esta_pago", nullable = false)
    public Boolean estaPago;

    /** Legado: CODI_MONE_ADEL */
    @Column(name = "codi_mone_adel", length = 2, nullable = false)
    public String codiMoneAdel;

    /** Legado: MONT_ADEL */
    @Column(name = "mont_adel", precision = 12, scale = 2, nullable = false)
    public BigDecimal montAdel;

    /** Legado: TIPO_ADEL */
    @Column(name = "tipo_adel", length = 5)
    public String tipoAdel;

    /** Legado: INTE_TIEM_DESC */
    @Column(name = "inte_tiem_desc", length = 20)
    public String inteTiemDesc;

    /** Legado: MONT_PAGO */
    @Column(name = "mont_pago", precision = 12, scale = 2)
    public BigDecimal montPago;

    /** Legado: SALDO */
    @Column(name = "saldo", precision = 12, scale = 2)
    public BigDecimal saldo;

    @Column(name = "regi_adel", length = 10)
    public String regiAdel;
}
