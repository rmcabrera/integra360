package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_SITU_HORA_TRAB</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoSituHoraTrab")
@Table(name = "tipo_situ_hora_trab")
public class TipoSituHoraTrab extends LegacyEntity {

    /** Legado: CODI_TIPO_SITU_HORA */
    @Id
    @Column(name = "codi_tipo_situ_hora", length = 2, nullable = false)
    public String codiTipoSituHora;

    /** Legado: DESC_SITU_HORA */
    @Column(name = "desc_situ_hora", length = 50)
    public String descSituHora;

    /** Legado: ABRE_SITU_HORA */
    @Column(name = "abre_situ_hora", length = 20)
    public String abreSituHora;
}
