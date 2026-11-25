package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_SUSPENSION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoSuspension")
@Table(name = "tipo_suspension")
public class TipoSuspension extends LegacyEntity {

    /** Legado: Codi_Tipo_Susp_Labo */
    @Id
    @Column(name = "codi_tipo_susp_labo", nullable = false)
    public Short codiTipoSuspLabo;

    /** Legado: Codi_Tipo_Susp_Labo_Sunat */
    @Column(name = "codi_tipo_susp_labo_sunat", length = 2, nullable = false)
    public String codiTipoSuspLaboSunat;

    /** Legado: Desc_Tipo_Susp_Labo */
    @Column(name = "desc_tipo_susp_labo", length = 200, nullable = false)
    public String descTipoSuspLabo;

    /** Legado: Tipo */
    @Column(name = "tipo", nullable = false)
    public Short tipo;
}
