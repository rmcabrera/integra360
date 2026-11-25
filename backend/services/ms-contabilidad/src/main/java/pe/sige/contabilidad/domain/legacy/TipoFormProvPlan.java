package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_FORM_PROV_PLAN</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoFormProvPlan")
@Table(name = "tipo_form_prov_plan")
public class TipoFormProvPlan extends LegacyEntity {

    /** Legado: CODI_TIPO_PROV */
    @Id
    @Column(name = "codi_tipo_prov", length = 2, nullable = false)
    public String codiTipoProv;

    /** Legado: DESC_TIPO_PROV */
    @Column(name = "desc_tipo_prov", length = 50)
    public String descTipoProv;
}
