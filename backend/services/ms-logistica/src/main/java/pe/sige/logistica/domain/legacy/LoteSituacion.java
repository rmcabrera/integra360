package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.LOTE_SITUACION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "LoteSituacion")
@Table(name = "lote_situacion")
public class LoteSituacion extends LegacyEntity {

    @Id
    @Column(name = "id_situ", nullable = false)
    public Integer idSitu;

    @Column(name = "descripcion", length = 100)
    public String descripcion;
}
