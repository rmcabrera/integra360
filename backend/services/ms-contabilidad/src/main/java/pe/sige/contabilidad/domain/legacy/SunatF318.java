package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SUNAT_F318</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SunatF318")
@Table(name = "sunat_f318")
public class SunatF318 extends LegacyEntity {

    @Id
    @Column(name = "id_tipo_flujo", nullable = false)
    public Integer idTipoFlujo;

    @Column(name = "id_flujo", nullable = false)
    public Integer idFlujo;

    @Column(name = "desc_acti", length = 100)
    public String descActi;

    @Column(name = "desc_flujo", length = 250)
    public String descFlujo;

    @Column(name = "subdia", length = 1)
    public String subdia;

    @Column(name = "orden")
    public Integer orden;
}
