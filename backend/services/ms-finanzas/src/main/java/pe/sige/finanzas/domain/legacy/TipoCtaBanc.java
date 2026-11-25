package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_CTA_BANC</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoCtaBanc")
@Table(name = "tipo_cta_banc")
public class TipoCtaBanc extends LegacyEntity {

    /** Legado: CODI_TIPO_CUEN_BANC */
    @Id
    @Column(name = "codi_tipo_cuen_banc", length = 2, nullable = false)
    public String codiTipoCuenBanc;

    /** Legado: DESC_TIPO_CUEN_BANC */
    @Column(name = "desc_tipo_cuen_banc", length = 50)
    public String descTipoCuenBanc;

    /** Legado: NEMO */
    @Column(name = "nemo", length = 10)
    public String nemo;

    /** Legado: NRO_CERO_TC */
    @Column(name = "nro_cero_tc")
    public Short nroCeroTc;

    /** Legado: TIPO_CUEN_TC */
    @Column(name = "tipo_cuen_tc", length = 2)
    public String tipoCuenTc;
}
