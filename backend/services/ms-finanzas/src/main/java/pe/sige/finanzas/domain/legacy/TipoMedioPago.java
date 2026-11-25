package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_MEDIO_PAGO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoMedioPago")
@Table(name = "tipo_medio_pago")
public class TipoMedioPago extends LegacyEntity {

    /** Legado: Codi_Tipo_Medio_Pago */
    @Id
    @Column(name = "codi_tipo_medio_pago", nullable = false)
    public Short codiTipoMedioPago;

    /** Legado: Codi_Sunat */
    @Column(name = "codi_sunat", length = 3, nullable = false)
    public String codiSunat;

    /** Legado: Desc_Tipo_Medio_Pago */
    @Column(name = "desc_tipo_medio_pago", length = 250, nullable = false)
    public String descTipoMedioPago;

    /** Legado: Nemo */
    @Column(name = "nemo", length = 30)
    public String nemo;
}
