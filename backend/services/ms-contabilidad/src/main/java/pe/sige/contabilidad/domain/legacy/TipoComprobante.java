package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_COMPROBANTE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoComprobante")
@Table(name = "tipo_comprobante")
public class TipoComprobante extends LegacyEntity {

    /** Legado: Codi_Compr */
    @Id
    @Column(name = "codi_compr", length = 1, nullable = false)
    public String codiCompr;

    /** Legado: Desc_Compr */
    @Column(name = "desc_compr", length = 50, nullable = false)
    public String descCompr;
}
