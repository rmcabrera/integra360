package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ACTI_ECON_PRIN</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ActiEconPrin")
@Table(name = "acti_econ_prin")
public class ActiEconPrin extends LegacyEntity {

    /** Legado: CODI_ACTI_ECON */
    @Id
    @Column(name = "codi_acti_econ", length = 4, nullable = false)
    public String codiActiEcon;

    /** Legado: DESC_ACTI_ECON */
    @Column(name = "desc_acti_econ", length = 200)
    public String descActiEcon;

    /** Legado: NEMO_ACTI_ECON */
    @Column(name = "nemo_acti_econ", length = 20)
    public String nemoActiEcon;
}
