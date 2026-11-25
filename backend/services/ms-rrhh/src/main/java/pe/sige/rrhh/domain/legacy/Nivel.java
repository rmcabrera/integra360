package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.NIVEL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Nivel")
@Table(name = "nivel")
public class Nivel extends LegacyEntity {

    /** Legado: Codi_Nivel */
    @Id
    @Column(name = "codi_nivel", nullable = false)
    public Short codiNivel;

    /** Legado: Codi_Nivel_Sunat */
    @Column(name = "codi_nivel_sunat", length = 2, nullable = false)
    public String codiNivelSunat;

    /** Legado: Desc_Nivel */
    @Column(name = "desc_nivel", length = 150, nullable = false)
    public String descNivel;

    /** Legado: Nemo_Nivel */
    @Column(name = "nemo_nivel", length = 20)
    public String nemoNivel;
}
