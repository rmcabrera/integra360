package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ABOGADOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Abogados")
@Table(name = "abogados")
public class Abogados extends LegacyEntity {

    @Id
    @Column(name = "codi_abog", length = 3, nullable = false)
    public String codiAbog;

    @Column(name = "apel_1", length = 50)
    public String apel1;

    @Column(name = "apel_2", length = 50)
    public String apel2;

    @Column(name = "nomb_1", length = 50)
    public String nomb1;

    @Column(name = "nomb_2", length = 50)
    public String nomb2;
}
