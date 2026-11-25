package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.LUGAR_ORIGEN</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "LugarOrigen")
@Table(name = "lugar_origen")
public class LugarOrigen extends LegacyEntity {

    @Id
    @Column(name = "codi_luga", length = 3, nullable = false)
    public String codiLuga;

    @Column(name = "desc_luga", length = 200)
    public String descLuga;
}
