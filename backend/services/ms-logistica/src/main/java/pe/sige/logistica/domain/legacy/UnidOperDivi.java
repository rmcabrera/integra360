package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.UNID_OPER_DIVI</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "UnidOperDivi")
@Table(name = "unid_oper_divi")
public class UnidOperDivi extends LegacyEntity {

    @Id
    @Column(name = "codi_divi_unid_oper", length = 3, nullable = false)
    public String codiDiviUnidOper;

    @Column(name = "desc_divi_unid_oper", length = 200)
    public String descDiviUnidOper;

    @Column(name = "codi_tipo_unid_oper", length = 2)
    public String codiTipoUnidOper;
}
