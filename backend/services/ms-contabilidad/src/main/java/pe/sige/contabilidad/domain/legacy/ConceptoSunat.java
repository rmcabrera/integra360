package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CONCEPTO_SUNAT</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ConceptoSunat")
@Table(name = "concepto_sunat")
public class ConceptoSunat extends LegacyEntity {

    /** Legado: Codi_Concep_Sunat */
    @Id
    @Column(name = "codi_concep_sunat", nullable = false)
    public Short codiConcepSunat;

    /** Legado: Desc_Concep_Sunat */
    @Column(name = "desc_concep_sunat", length = 100, nullable = false)
    public String descConcepSunat;
}
