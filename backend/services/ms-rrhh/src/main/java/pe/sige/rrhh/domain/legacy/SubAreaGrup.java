package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SUB_AREA_GRUP</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SubAreaGrup")
@Table(name = "sub_area_grup")
public class SubAreaGrup extends LegacyEntity {

    /** Legado: CODI_SUB_AREA_GRUP */
    @Id
    @Column(name = "codi_sub_area_grup", length = 4, nullable = false)
    public String codiSubAreaGrup;

    /** Legado: DESC_SUB_AREA_GRUP */
    @Column(name = "desc_sub_area_grup", length = 200)
    public String descSubAreaGrup;

    /** Legado: NEMO_SUB_AREA_GRUP */
    @Column(name = "nemo_sub_area_grup", length = 30)
    public String nemoSubAreaGrup;

    /** Legado: NRO_JERA */
    @Column(name = "nro_jera")
    public Integer nroJera;

    /** Legado: CODI_AREA_GRUP */
    @Column(name = "codi_area_grup", length = 2)
    public String codiAreaGrup;
}
