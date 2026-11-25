package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PRESENTACION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Presentacion")
@Table(name = "presentacion")
public class Presentacion extends LegacyEntity {

    @Id
    @Column(name = "cod_pres", nullable = false)
    public Integer codPres;

    @Column(name = "desc_pres", length = 50)
    public String descPres;

    /** Legado: UM */
    @Column(name = "um", length = 2)
    public String um;
}
