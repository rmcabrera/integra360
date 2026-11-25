package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_RIESGO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoRiesgo")
@Table(name = "tipo_riesgo")
public class TipoRiesgo extends LegacyEntity {

    /** Legado: CODI_TIPO_RIES */
    @Id
    @Column(name = "codi_tipo_ries", length = 2, nullable = false)
    public String codiTipoRies;

    /** Legado: DESC_TIPO_RIES */
    @Column(name = "desc_tipo_ries", length = 200)
    public String descTipoRies;

    /** Legado: NEMO */
    @Column(name = "nemo", length = 10)
    public String nemo;
}
