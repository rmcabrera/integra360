package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_TRABAJADOR</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoTrabajador")
@Table(name = "tipo_trabajador")
public class TipoTrabajador extends LegacyEntity {

    /** Legado: CODI_TIPO_PERS */
    @Id
    @Column(name = "codi_tipo_pers", length = 2, nullable = false)
    public String codiTipoPers;

    /** Legado: DESC_TIPO_PERS */
    @Column(name = "desc_tipo_pers", length = 50, nullable = false)
    public String descTipoPers;
}
