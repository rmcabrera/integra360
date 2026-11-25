package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_VACACIONES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoVacaciones")
@Table(name = "tipo_vacaciones")
public class TipoVacaciones extends LegacyEntity {

    /** Legado: CODI_TIPO_VACA */
    @Id
    @Column(name = "codi_tipo_vaca", length = 2, nullable = false)
    public String codiTipoVaca;

    /** Legado: DESC_TIPO_VACA */
    @Column(name = "desc_tipo_vaca", length = 50)
    public String descTipoVaca;
}
