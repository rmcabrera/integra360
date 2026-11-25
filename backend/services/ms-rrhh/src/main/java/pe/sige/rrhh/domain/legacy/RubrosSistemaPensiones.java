package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.RUBROS_SISTEMA_PENSIONES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "RubrosSistemaPensiones")
@Table(name = "rubros_sistema_pensiones")
public class RubrosSistemaPensiones extends LegacyEntity {

    /** Legado: CODI_RUBR */
    @Id
    @Column(name = "codi_rubr", length = 3, nullable = false)
    public String codiRubr;

    /** Legado: DESC_RUBR */
    @Column(name = "desc_rubr", length = 50, nullable = false)
    public String descRubr;

    /** Legado: TIPO_CANT */
    @Column(name = "tipo_cant", length = 1)
    public String tipoCant;

    /** Legado: ESTA_RUBR */
    @Column(name = "esta_rubr")
    public Boolean estaRubr;
}
