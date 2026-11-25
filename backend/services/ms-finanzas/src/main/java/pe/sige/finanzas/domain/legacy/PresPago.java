package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PRES_PAGO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PresPago")
@Table(name = "pres_pago")
public class PresPago extends LegacyEntity {

    /** Legado: CODI_PRES */
    @Id
    @Column(name = "codi_pres", length = 4, nullable = false)
    public String codiPres;

    /** Legado: DESC_PRES */
    @Column(name = "desc_pres", length = 40)
    public String descPres;

    /** Legado: CODI_GRUP */
    @Column(name = "codi_grup", length = 2, nullable = false)
    public String codiGrup;
}
