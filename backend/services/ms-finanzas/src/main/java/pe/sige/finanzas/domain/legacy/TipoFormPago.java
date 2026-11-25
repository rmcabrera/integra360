package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_FORM_PAGO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoFormPago")
@Table(name = "tipo_form_pago")
public class TipoFormPago extends LegacyEntity {

    /** Legado: CODI_FORM_PAGO */
    @Id
    @Column(name = "codi_form_pago", length = 2, nullable = false)
    public String codiFormPago;

    /** Legado: DESC_FORM_PAGO */
    @Column(name = "desc_form_pago", length = 100)
    public String descFormPago;

    /** Legado: NEMO_FORM_PAGO */
    @Column(name = "nemo_form_pago", length = 20)
    public String nemoFormPago;

    @Column(name = "codi_tipo_pago")
    public Short codiTipoPago;
}
