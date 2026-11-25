package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Centro_costo</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CentroCosto")
@Table(name = "centro_costo")
public class CentroCosto extends LegacyEntity {

    /** Legado: Codi_cc */
    @Id
    @Column(name = "codi_cc", nullable = false)
    public Long codiCc;

    @Column(name = "nombre_cc", length = 120)
    public String nombreCc;
}
