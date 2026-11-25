package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_EEFF</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoEeff")
@Table(name = "tipo_eeff")
public class TipoEeff extends LegacyEntity {

    /** Legado: CODI_TIPO_EEFF */
    @Id
    @Column(name = "codi_tipo_eeff", length = 2, nullable = false)
    public String codiTipoEeff;

    /** Legado: DESC_TIPO_EEFF */
    @Column(name = "desc_tipo_eeff", length = 100)
    public String descTipoEeff;

    /** Legado: NEMO_TIPO_EEFF */
    @Column(name = "nemo_tipo_eeff", length = 10)
    public String nemoTipoEeff;
}
