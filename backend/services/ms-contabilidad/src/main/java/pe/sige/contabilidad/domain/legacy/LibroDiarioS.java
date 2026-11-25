package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.LIBRO_DIARIO_S</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "LibroDiarioS")
@Table(name = "libro_diario_s")
public class LibroDiarioS extends LegacyEntity {

    @Id
    @Column(name = "cuenta", length = 7, nullable = false)
    public String cuenta;

    @Column(name = "tipo", length = 2)
    public String tipo;
}
