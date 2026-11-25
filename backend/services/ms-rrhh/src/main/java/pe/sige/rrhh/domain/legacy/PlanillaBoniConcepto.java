package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PLANILLA_BONI_CONCEPTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PlanillaBoniConcepto")
@Table(name = "planilla_boni_concepto")
public class PlanillaBoniConcepto extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    /** Legado: CODI_PLAN_BONI */
    @Column(name = "codi_plan_boni", length = 10, nullable = false)
    public String codiPlanBoni;

    /** Legado: CODI_CONC */
    @Column(name = "codi_conc", length = 6, nullable = false)
    public String codiConc;

    /** Legado: AFECTO */
    @Column(name = "afecto", length = 1, nullable = false)
    public String afecto;

    /** Legado: VALOR */
    @Column(name = "valor", precision = 12, scale = 2)
    public BigDecimal valor;

    /** Legado: MONTO */
    @Column(name = "monto", precision = 12, scale = 2)
    public BigDecimal monto;
}
