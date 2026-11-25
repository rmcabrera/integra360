package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.personal_saludos</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PersonalSaludos")
@Table(name = "personal_saludos")
public class PersonalSaludos extends LegacyEntity {

    /** Legado: Codi_Pers */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: Saludo_1 */
    @Column(name = "saludo_1", length = 75)
    public String saludo1;

    /** Legado: Saludo_2 */
    @Column(name = "saludo_2", length = 75)
    public String saludo2;

    /** Legado: Saludo_3 */
    @Column(name = "saludo_3", length = 75)
    public String saludo3;

    /** Legado: Saludo_4 */
    @Column(name = "saludo_4", length = 75)
    public String saludo4;
}
