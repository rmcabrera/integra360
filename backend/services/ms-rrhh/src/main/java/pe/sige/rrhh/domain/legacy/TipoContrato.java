package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_CONTRATO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoContrato")
@Table(name = "tipo_contrato")
public class TipoContrato extends LegacyEntity {

    /** Legado: Codi_Tipo_Cont */
    @Id
    @Column(name = "codi_tipo_cont", nullable = false)
    public Short codiTipoCont;

    /** Legado: Codi_Tipo_Cont_Sunat */
    @Column(name = "codi_tipo_cont_sunat", length = 2, nullable = false)
    public String codiTipoContSunat;

    /** Legado: Desc_Tipo_Cont */
    @Column(name = "desc_tipo_cont", length = 100, nullable = false)
    public String descTipoCont;
}
