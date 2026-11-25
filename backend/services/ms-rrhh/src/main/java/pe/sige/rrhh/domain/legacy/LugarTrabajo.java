package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.LUGAR_TRABAJO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "LugarTrabajo")
@Table(name = "lugar_trabajo")
public class LugarTrabajo extends LegacyEntity {

    /** Legado: CODI_LUGA_TRAB */
    @Id
    @Column(name = "codi_luga_trab", length = 2, nullable = false)
    public String codiLugaTrab;

    /** Legado: NOMB_LUGA_TRAB */
    @Column(name = "nomb_luga_trab", length = 50)
    public String nombLugaTrab;

    /** Legado: ABRE_LUGA_TRAB */
    @Column(name = "abre_luga_trab", length = 20)
    public String abreLugaTrab;
}
