package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SUB_CLASE_CONT_4</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SubClaseCont4")
@Table(name = "sub_clase_cont_4")
public class SubClaseCont4 extends LegacyEntity {

    @Id
    @Column(name = "codi_subc_4", length = 4, nullable = false)
    public String codiSubc4;

    @Column(name = "desc_sub_4", length = 250)
    public String descSub4;

    /** Legado: CODI_SUBC */
    @Column(name = "codi_subc", length = 3)
    public String codiSubc;
}
