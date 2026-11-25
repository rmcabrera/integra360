package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_SITU_CONC_BANC</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoSituConcBanc")
@Table(name = "tipo_situ_conc_banc")
public class TipoSituConcBanc extends LegacyEntity {

    /** Legado: CODI_TIPO_SITU_CONC_BANC */
    @Id
    @Column(name = "codi_tipo_situ_conc_banc", length = 2, nullable = false)
    public String codiTipoSituConcBanc;

    /** Legado: DESC_TIPO_SITU_CONC_BANC */
    @Column(name = "desc_tipo_situ_conc_banc", length = 50)
    public String descTipoSituConcBanc;

    /** Legado: SIMB_TIPO_SITU_CONC_BANC */
    @Column(name = "simb_tipo_situ_conc_banc", length = 3)
    public String simbTipoSituConcBanc;
}
