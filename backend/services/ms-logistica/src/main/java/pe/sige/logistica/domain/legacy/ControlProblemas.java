package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CONTROL_PROBLEMAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ControlProblemas")
@Table(name = "control_problemas")
public class ControlProblemas extends LegacyEntity {

    @Id
    @Column(name = "id_control", nullable = false)
    public Long idControl;

    @Column(name = "nro_control")
    public Long nroControl;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "descripcion", length = 255)
    public String descripcion;

    @Column(name = "hecho_por", length = 5)
    public String hechoPor;
}
