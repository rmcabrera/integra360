package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.VISOR_DE_EVENTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "VisorDeEventos")
@Table(name = "visor_de_eventos")
public class VisorDeEventos extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    @Column(name = "opcion", length = 50)
    public String opcion;

    @Column(name = "usuario", length = 5)
    public String usuario;

    @Column(name = "accion", length = 1)
    public String accion;

    @Column(name = "informacion")
    public String informacion;

    @Column(name = "computer", length = 20)
    public String computer;

    @Column(name = "fecha")
    public LocalDateTime fecha;
}
