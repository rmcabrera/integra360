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
 * Tabla legado <b>dbo.NOTAS_POSITS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "NotasPosits")
@Table(name = "notas_posits")
public class NotasPosits extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idd_nota", nullable = false)
    public Long iddNota;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "descripcion", length = 250)
    public String descripcion;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "estado", length = 1)
    public String estado;
}
