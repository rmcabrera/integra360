package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ESPECIALISTAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Especialistas")
@Table(name = "especialistas")
public class Especialistas extends LegacyEntity {

    /** Legado: CODI_ESPE */
    @Id
    @Column(name = "codi_espe", length = 3, nullable = false)
    public String codiEspe;

    /** Legado: APEL_1 */
    @Column(name = "apel_1", length = 50)
    public String apel1;

    /** Legado: APEL_2 */
    @Column(name = "apel_2", length = 50)
    public String apel2;

    /** Legado: NOMB_1 */
    @Column(name = "nomb_1", length = 50)
    public String nomb1;

    /** Legado: NOMB_2 */
    @Column(name = "nomb_2", length = 50)
    public String nomb2;

    @Column(name = "dni", length = 12)
    public String dni;
}
