package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PLANILLA_BONI_MOTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PlanillaBoniMoto")
@Table(name = "planilla_boni_moto")
public class PlanillaBoniMoto extends LegacyEntity {

    @Id
    @Column(name = "codi_plan_boni", length = 10, nullable = false)
    public String codiPlanBoni;

    @Column(name = "mesanio", length = 6, nullable = false)
    public String mesanio;

    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    @Column(name = "importe", precision = 12, scale = 2)
    public BigDecimal importe;

    @Column(name = "fech_pago")
    public LocalDateTime fechPago;

    @Column(name = "form_pago", length = 15)
    public String formPago;

    @Column(name = "nro_cheque", length = 15)
    public String nroCheque;

    /** Legado: Tipo */
    @Column(name = "tipo", length = 1)
    public String tipo;
}
