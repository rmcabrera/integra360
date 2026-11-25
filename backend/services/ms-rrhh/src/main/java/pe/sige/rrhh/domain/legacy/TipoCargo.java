package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_CARGO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoCargo")
@Table(name = "tipo_cargo")
public class TipoCargo extends LegacyEntity {

    /** Legado: CODI_TIPO_CARG */
    @Id
    @Column(name = "codi_tipo_carg", length = 2, nullable = false)
    public String codiTipoCarg;

    /** Legado: DESC_TIPO_CARG */
    @Column(name = "desc_tipo_carg", length = 50)
    public String descTipoCarg;
}
