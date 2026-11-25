package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ACTIVIDAD</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Actividad")
@Table(name = "actividad")
public class Actividad extends LegacyEntity {

    /** Legado: Codi_Acti */
    @Id
    @Column(name = "codi_acti", nullable = false)
    public Short codiActi;

    /** Legado: Codi_Acti_Sunat */
    @Column(name = "codi_acti_sunat", length = 5, nullable = false)
    public String codiActiSunat;

    /** Legado: Desc_Acti */
    @Column(name = "desc_acti", length = 100, nullable = false)
    public String descActi;
}
