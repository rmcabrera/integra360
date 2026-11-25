package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TURNOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Turnos")
@Table(name = "turnos")
public class Turnos extends LegacyEntity {

    /** Legado: CODI_TURN */
    @Id
    @Column(name = "codi_turn", length = 2, nullable = false)
    public String codiTurn;

    /** Legado: DESC_TURN */
    @Column(name = "desc_turn", length = 50)
    public String descTurn;

    @Column(name = "hora_ini")
    public LocalDateTime horaIni;

    @Column(name = "hora_ter")
    public LocalDateTime horaTer;
}
