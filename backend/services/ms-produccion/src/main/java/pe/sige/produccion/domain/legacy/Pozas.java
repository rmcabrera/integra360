package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.POZAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Pozas")
@Table(name = "pozas")
public class Pozas extends LegacyEntity {

    @Id
    @Column(name = "codi_poza", length = 2, nullable = false)
    public String codiPoza;

    @Column(name = "desc_poza", length = 50, nullable = false)
    public String descPoza;
}
