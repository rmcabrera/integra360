package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.VALORES_UNITARIOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ValoresUnitarios")
@Table(name = "valores_unitarios")
public class ValoresUnitarios extends LegacyEntity {

    /** Legado: CODI_VALO_UNIT */
    @Id
    @Column(name = "codi_valo_unit", nullable = false)
    public Integer codiValoUnit;

    /** Legado: DESC_VALO_UNIT */
    @Column(name = "desc_valo_unit", length = 50)
    public String descValoUnit;

    @Column(name = "nemo", length = 4)
    public String nemo;
}
