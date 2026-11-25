package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_PERSONAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoPersonal")
@Table(name = "tipo_personal")
public class TipoPersonal extends LegacyEntity {

    /** Legado: Codi_Tipo_Pers */
    @Id
    @Column(name = "codi_tipo_pers", nullable = false)
    public Short codiTipoPers;

    /** Legado: Codi_Tipo_Pers_Sunat */
    @Column(name = "codi_tipo_pers_sunat", length = 2, nullable = false)
    public String codiTipoPersSunat;

    /** Legado: Desc_Tipo_Pers */
    @Column(name = "desc_tipo_pers", length = 100, nullable = false)
    public String descTipoPers;

    /** Legado: Nemo_Tipo_Pers */
    @Column(name = "nemo_tipo_pers", length = 50)
    public String nemoTipoPers;
}
