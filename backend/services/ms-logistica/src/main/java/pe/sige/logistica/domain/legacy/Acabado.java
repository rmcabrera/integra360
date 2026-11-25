package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ACABADO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Acabado")
@Table(name = "acabado")
public class Acabado extends LegacyEntity {

    /** Legado: Codi_Acab */
    @Id
    @Column(name = "codi_acab", nullable = false)
    public Short codiAcab;

    /** Legado: Desc_Acab */
    @Column(name = "desc_acab", length = 100, nullable = false)
    public String descAcab;

    /** Legado: Nemo_Aca */
    @Column(name = "nemo_aca", length = 50)
    public String nemoAca;
}
