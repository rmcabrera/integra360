package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.COSTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Costo")
@Table(name = "costo")
public class Costo extends LegacyEntity {

    /** Legado: Codi_Costo */
    @Id
    @Column(name = "codi_costo", nullable = false)
    public Short codiCosto;

    /** Legado: Desc_Costo */
    @Column(name = "desc_costo", length = 100, nullable = false)
    public String descCosto;
}
