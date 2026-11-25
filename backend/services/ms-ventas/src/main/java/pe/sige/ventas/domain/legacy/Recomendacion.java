package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.RECOMENDACION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Recomendacion")
@Table(name = "recomendacion")
public class Recomendacion extends LegacyEntity {

    @Id
    @Column(name = "codi_rec", nullable = false)
    public Long codiRec;

    @Column(name = "diagnostico", length = 250)
    public String diagnostico;

    @Column(name = "recomendacion", length = 250)
    public String recomendacion;

    @Column(name = "nro_rec")
    public Long nroRec;
}
