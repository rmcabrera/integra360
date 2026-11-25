package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Pers_Soli</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PersSoli")
@Table(name = "pers_soli")
public class PersSoli extends LegacyEntity {

    /** Legado: Codi_Pers */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: Apel_Pers */
    @Column(name = "apel_pers", length = 100)
    public String apelPers;
}
