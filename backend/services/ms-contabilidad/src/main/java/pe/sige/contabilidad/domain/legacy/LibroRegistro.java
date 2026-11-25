package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.LIBRO_REGISTRO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "LibroRegistro")
@Table(name = "libro_registro")
public class LibroRegistro extends LegacyEntity {

    /** Legado: CODI_LIBRO_REGI */
    @Id
    @Column(name = "codi_libro_regi", nullable = false)
    public Short codiLibroRegi;

    /** Legado: DESC_LIBRO_REGI */
    @Column(name = "desc_libro_regi", length = 200, nullable = false)
    public String descLibroRegi;
}
