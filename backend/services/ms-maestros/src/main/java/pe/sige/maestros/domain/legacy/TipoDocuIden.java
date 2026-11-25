package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_DOCU_IDEN</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoDocuIden")
@Table(name = "tipo_docu_iden")
public class TipoDocuIden extends LegacyEntity {

    /** Legado: Codi_Tipo_Docu_Iden */
    @Id
    @Column(name = "codi_tipo_docu_iden", nullable = false)
    public Short codiTipoDocuIden;

    /** Legado: Codi_Sunat */
    @Column(name = "codi_sunat", nullable = false)
    public Short codiSunat;

    /** Legado: Desc_Tipo_Docu_Iden */
    @Column(name = "desc_tipo_docu_iden", length = 100, nullable = false)
    public String descTipoDocuIden;

    /** Legado: Nemo */
    @Column(name = "nemo", length = 20)
    public String nemo;
}
