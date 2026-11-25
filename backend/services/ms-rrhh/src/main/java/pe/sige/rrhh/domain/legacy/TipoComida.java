package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_COMIDA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoComida")
@Table(name = "tipo_comida")
public class TipoComida extends LegacyEntity {

    /** Legado: CODI_TIPO_COMI */
    @Id
    @Column(name = "codi_tipo_comi", length = 2, nullable = false)
    public String codiTipoComi;

    /** Legado: DESC_TIPO_COMI */
    @Column(name = "desc_tipo_comi", length = 25)
    public String descTipoComi;
}
