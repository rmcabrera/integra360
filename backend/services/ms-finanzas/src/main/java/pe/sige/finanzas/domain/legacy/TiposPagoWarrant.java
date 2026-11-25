package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPOS_PAGO_WARRANT</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TiposPagoWarrant")
@Table(name = "tipos_pago_warrant")
public class TiposPagoWarrant extends LegacyEntity {

    @Id
    @Column(name = "codi_tpago", nullable = false)
    public Integer codiTpago;

    @Column(name = "desc_tipo", length = 50)
    public String descTipo;

    @Column(name = "nemo_tipo", length = 50)
    public String nemoTipo;
}
