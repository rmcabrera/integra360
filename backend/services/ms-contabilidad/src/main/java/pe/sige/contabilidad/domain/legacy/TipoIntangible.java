package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_INTANGIBLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoIntangible")
@Table(name = "tipo_intangible")
public class TipoIntangible extends LegacyEntity {

    /** Legado: Codi_Tipo_Intan */
    @Id
    @Column(name = "codi_tipo_intan", length = 2, nullable = false)
    public String codiTipoIntan;

    /** Legado: Desc_Tipo_Intan */
    @Column(name = "desc_tipo_intan", length = 100, nullable = false)
    public String descTipoIntan;
}
