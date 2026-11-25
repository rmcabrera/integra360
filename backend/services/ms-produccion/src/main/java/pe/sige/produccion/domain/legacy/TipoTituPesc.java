package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_TITU_PESC</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoTituPesc")
@Table(name = "tipo_titu_pesc")
public class TipoTituPesc extends LegacyEntity {

    /** Legado: CODI_TIPO_TITU_PESC */
    @Id
    @Column(name = "codi_tipo_titu_pesc", length = 2, nullable = false)
    public String codiTipoTituPesc;

    /** Legado: DESC_TIPO_TITU_PESC */
    @Column(name = "desc_tipo_titu_pesc", length = 50)
    public String descTipoTituPesc;

    /** Legado: ABRE */
    @Column(name = "abre", length = 20)
    public String abre;

    /** Legado: ORDEN */
    @Column(name = "orden")
    public Integer orden;
}
