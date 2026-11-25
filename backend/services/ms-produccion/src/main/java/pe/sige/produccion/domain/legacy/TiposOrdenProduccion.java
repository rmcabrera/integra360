package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPOS_ORDEN_PRODUCCION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TiposOrdenProduccion")
@Table(name = "tipos_orden_produccion")
public class TiposOrdenProduccion extends LegacyEntity {

    @Id
    @Column(name = "codi_tipo_op", nullable = false)
    public Integer codiTipoOp;

    @Column(name = "desc_tipo_op", length = 50)
    public String descTipoOp;

    @Column(name = "nemo", length = 20)
    public String nemo;
}
