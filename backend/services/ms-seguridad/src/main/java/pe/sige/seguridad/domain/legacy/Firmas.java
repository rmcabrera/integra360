package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Firmas</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Firmas")
@Table(name = "firmas")
public class Firmas extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    /** Legado: F1 */
    @Column(name = "f1", length = 30)
    public String f1;

    /** Legado: F2 */
    @Column(name = "f2", length = 30)
    public String f2;

    /** Legado: F3 */
    @Column(name = "f3", length = 30)
    public String f3;

    /** Legado: F4 */
    @Column(name = "f4", length = 30)
    public String f4;

    /** Legado: F5 */
    @Column(name = "f5", length = 30)
    public String f5;
}
