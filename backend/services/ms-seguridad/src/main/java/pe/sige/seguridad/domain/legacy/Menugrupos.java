package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.MenuGrupos</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Menugrupos")
@Table(name = "menugrupos")
public class Menugrupos extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    @Column(name = "codi_menu", nullable = false)
    public Integer codiMenu;

    @Column(name = "nomb_menu", length = 150, nullable = false)
    public String nombMenu;

    @Column(name = "codi_grup", nullable = false)
    public Integer codiGrup;

    @Column(name = "activo", nullable = false)
    public Integer activo;

    /** Legado: Nivel */
    @Column(name = "nivel")
    public Integer nivel;

    @Column(name = "clase", length = 50)
    public String clase;
}
