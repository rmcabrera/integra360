package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_GASTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoGasto")
@Table(name = "tipo_gasto")
public class TipoGasto extends LegacyEntity {

    /** Legado: CODI_TIPO_GAST */
    @Id
    @Column(name = "codi_tipo_gast", length = 1, nullable = false)
    public String codiTipoGast;

    /** Legado: DESC_TIPO_GAST */
    @Column(name = "desc_tipo_gast", length = 30)
    public String descTipoGast;
}
