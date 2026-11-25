package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_EMPRESA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoEmpresa")
@Table(name = "tipo_empresa")
public class TipoEmpresa extends LegacyEntity {

    /** Legado: CODI_TIPO_EMPR */
    @Id
    @Column(name = "codi_tipo_empr", length = 2, nullable = false)
    public String codiTipoEmpr;

    /** Legado: DESC_TIPO_EMPR */
    @Column(name = "desc_tipo_empr", length = 50)
    public String descTipoEmpr;

    /** Legado: NEMO */
    @Column(name = "nemo", length = 20)
    public String nemo;
}
