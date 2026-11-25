package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PENSION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Pension")
@Table(name = "pension")
public class Pension extends LegacyEntity {

    /** Legado: Codi_Pension */
    @Id
    @Column(name = "codi_pension", nullable = false)
    public Short codiPension;

    /** Legado: Codi_Pension_Sunat */
    @Column(name = "codi_pension_sunat", nullable = false)
    public Short codiPensionSunat;

    /** Legado: Desc_Pension */
    @Column(name = "desc_pension", length = 150, nullable = false)
    public String descPension;

    /** Legado: Nemo_Pension */
    @Column(name = "nemo_pension", length = 15)
    public String nemoPension;
}
