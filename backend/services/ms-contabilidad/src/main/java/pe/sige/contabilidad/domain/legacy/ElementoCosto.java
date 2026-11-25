package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ELEMENTO_COSTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ElementoCosto")
@Table(name = "elemento_costo")
public class ElementoCosto extends LegacyEntity {

    /** Legado: Codi_Elem_Costo */
    @Id
    @Column(name = "codi_elem_costo", nullable = false)
    public Short codiElemCosto;

    /** Legado: Desc_Elem_Costo */
    @Column(name = "desc_elem_costo", length = 150, nullable = false)
    public String descElemCosto;

    /** Legado: Nemo */
    @Column(name = "nemo", length = 50)
    public String nemo;

    /** Legado: CODI_TIPO_GAST */
    @Column(name = "codi_tipo_gast", length = 2, nullable = false)
    public String codiTipoGast;

    /** Legado: Uso */
    @Column(name = "uso", length = 1)
    public String uso;
}
