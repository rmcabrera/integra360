package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Adelanto_EP_terceros</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AdelantoEpTerceros")
@Table(name = "adelanto_ep_terceros")
public class AdelantoEpTerceros extends LegacyEntity {

    /** Legado: CODI_ADEL_TERC */
    @Id
    @Column(name = "codi_adel_terc", length = 6, nullable = false)
    public String codiAdelTerc;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

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

    /** Legado: CODI_SEMA */
    @Column(name = "codi_sema", length = 8)
    public String codiSema;
}
