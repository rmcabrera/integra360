package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PLAN_MARKETING</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PlanMarketing")
@Table(name = "plan_marketing")
public class PlanMarketing extends LegacyEntity {

    @Id
    @Column(name = "codi_plan", nullable = false)
    public Long codiPlan;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "mes", length = 2)
    public String mes;

    @Column(name = "sem1", length = 8)
    public String sem1;

    @Column(name = "sem2", length = 8)
    public String sem2;

    @Column(name = "sem3", length = 8)
    public String sem3;

    @Column(name = "sem4", length = 8)
    public String sem4;

    @Column(name = "codi_usua", length = 5)
    public String codiUsua;

    @Column(name = "registro", length = 150)
    public String registro;

    @Column(name = "fecha")
    public LocalDateTime fecha;
}
