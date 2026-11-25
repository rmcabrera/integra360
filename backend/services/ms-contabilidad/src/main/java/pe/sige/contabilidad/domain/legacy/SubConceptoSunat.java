package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SUB_CONCEPTO_SUNAT</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SubConceptoSunat")
@Table(name = "sub_concepto_sunat")
public class SubConceptoSunat extends LegacyEntity {

    /** Legado: Codi_Sub_Concep */
    @Id
    @Column(name = "codi_sub_concep", nullable = false)
    public Short codiSubConcep;

    /** Legado: Desc_Sub_Concep_Sunat */
    @Column(name = "desc_sub_concep_sunat", length = 200, nullable = false)
    public String descSubConcepSunat;

    /** Legado: Codi_Concep_Sunat */
    @Column(name = "codi_concep_sunat", nullable = false)
    public Short codiConcepSunat;
}
