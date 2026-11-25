package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.JUZGADOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Juzgados")
@Table(name = "juzgados")
public class Juzgados extends LegacyEntity {

    @Id
    @Column(name = "codi_juzg", length = 2, nullable = false)
    public String codiJuzg;

    @Column(name = "desc_juzg", length = 200)
    public String descJuzg;

    @Column(name = "ubicacion", length = 20)
    public String ubicacion;

    @Column(name = "direccion", length = 200)
    public String direccion;
}
