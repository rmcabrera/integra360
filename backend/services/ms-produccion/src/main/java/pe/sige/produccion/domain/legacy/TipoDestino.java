package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_DESTINO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoDestino")
@Table(name = "tipo_destino")
public class TipoDestino extends LegacyEntity {

    /** Legado: CODI_TIPO_DEST */
    @Id
    @Column(name = "codi_tipo_dest", length = 2, nullable = false)
    public String codiTipoDest;

    /** Legado: DESC_TIPO_DEST */
    @Column(name = "desc_tipo_dest", length = 100)
    public String descTipoDest;

    /** Legado: NEMO */
    @Column(name = "nemo", length = 4)
    public String nemo;
}
