package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SUB_CLAS_CUEN</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SubClasCuen")
@Table(name = "sub_clas_cuen")
public class SubClasCuen extends LegacyEntity {

    /** Legado: CODI_SUBC */
    @Id
    @Column(name = "codi_subc", length = 3, nullable = false)
    public String codiSubc;

    /** Legado: DESC_SUBC */
    @Column(name = "desc_subc", length = 100, nullable = false)
    public String descSubc;

    /** Legado: CODI_CLAS_CUEN */
    @Column(name = "codi_clas_cuen", length = 2)
    public String codiClasCuen;
}
