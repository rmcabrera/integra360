package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CLASES_CUENTAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ClasesCuentas")
@Table(name = "clases_cuentas")
public class ClasesCuentas extends LegacyEntity {

    /** Legado: CODI_CLAS_CUEN */
    @Id
    @Column(name = "codi_clas_cuen", length = 2, nullable = false)
    public String codiClasCuen;

    /** Legado: DESC_CLAS_CUEN */
    @Column(name = "desc_clas_cuen", length = 100)
    public String descClasCuen;

    /** Legado: A_P */
    @Column(name = "a_p", length = 1)
    public String aP;
}
