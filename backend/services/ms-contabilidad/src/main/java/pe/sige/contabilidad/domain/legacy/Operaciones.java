package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.operaciones</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Operaciones")
@Table(name = "operaciones")
public class Operaciones extends LegacyEntity {

    @Id
    @Column(name = "codi_oper", length = 2, nullable = false)
    public String codiOper;

    @Column(name = "desc_oper", length = 250)
    public String descOper;

    @Column(name = "nemo_oper", length = 50)
    public String nemoOper;
}
