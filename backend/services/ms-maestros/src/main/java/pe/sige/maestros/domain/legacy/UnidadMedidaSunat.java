package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.UNIDAD_MEDIDA_SUNAT</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "UnidadMedidaSunat")
@Table(name = "unidad_medida_sunat")
public class UnidadMedidaSunat extends LegacyEntity {

    /** Legado: CODIGO */
    @Id
    @Column(name = "codigo", length = 2, nullable = false)
    public String codigo;

    /** Legado: DESC_UNID */
    @Column(name = "desc_unid", length = 50)
    public String descUnid;
}
