package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.RATIOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Ratios")
@Table(name = "ratios")
public class Ratios extends LegacyEntity {

    /** Legado: CODI_RATI */
    @Id
    @Column(name = "codi_rati", length = 2, nullable = false)
    public String codiRati;

    /** Legado: DESC_RATI */
    @Column(name = "desc_rati", length = 60, nullable = false)
    public String descRati;
}
