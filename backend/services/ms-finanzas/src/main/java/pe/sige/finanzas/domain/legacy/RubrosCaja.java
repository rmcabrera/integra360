package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.RUBROS_CAJA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "RubrosCaja")
@Table(name = "rubros_caja")
public class RubrosCaja extends LegacyEntity {

    @Id
    @Column(name = "id_rubro", nullable = false)
    public Integer idRubro;

    @Column(name = "desc_rubro", length = 100)
    public String descRubro;

    /** Legado: I_O */
    @Column(name = "i_o")
    public Integer iO;
}
