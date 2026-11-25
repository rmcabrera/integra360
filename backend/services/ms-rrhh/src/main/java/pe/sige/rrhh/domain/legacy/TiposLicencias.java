package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPOS_LICENCIAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TiposLicencias")
@Table(name = "tipos_licencias")
public class TiposLicencias extends LegacyEntity {

    /** Legado: CODI_TIPO_LICE */
    @Id
    @Column(name = "codi_tipo_lice", length = 3, nullable = false)
    public String codiTipoLice;

    /** Legado: DESC_LICE */
    @Column(name = "desc_lice", length = 100)
    public String descLice;

    /** Legado: NRO_DIAS_REMU */
    @Column(name = "nro_dias_remu")
    public Integer nroDiasRemu;
}
