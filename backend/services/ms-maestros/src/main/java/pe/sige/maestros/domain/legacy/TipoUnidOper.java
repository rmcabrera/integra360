package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_UNID_OPER</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoUnidOper")
@Table(name = "tipo_unid_oper")
public class TipoUnidOper extends LegacyEntity {

    /** Legado: CODI_TIPO_UNID_OPER */
    @Id
    @Column(name = "codi_tipo_unid_oper", length = 2, nullable = false)
    public String codiTipoUnidOper;

    /** Legado: DESC_TIPO_UNID_OPER */
    @Column(name = "desc_tipo_unid_oper", length = 100)
    public String descTipoUnidOper;

    /** Legado: NEMO */
    @Column(name = "nemo", length = 4)
    public String nemo;
}
