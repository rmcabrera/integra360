package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CULTIVOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Cultivos")
@Table(name = "cultivos")
public class Cultivos extends LegacyEntity {

    @Id
    @Column(name = "cod_cultivo", nullable = false)
    public Integer codCultivo;

    @Column(name = "desc_cultivo", length = 100)
    public String descCultivo;

    @Column(name = "nro_dias")
    public Integer nroDias;
}
