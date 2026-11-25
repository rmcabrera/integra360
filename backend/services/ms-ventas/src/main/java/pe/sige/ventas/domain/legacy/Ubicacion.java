package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.UBICACION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Ubicacion")
@Table(name = "ubicacion")
public class Ubicacion extends LegacyEntity {

    @Id
    @Column(name = "codi_ubi", nullable = false)
    public Long codiUbi;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "zona", length = 150)
    public String zona;

    @Column(name = "sector", length = 250)
    public String sector;

    @Column(name = "subsector", length = 250)
    public String subsector;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "codi_usua", length = 5)
    public String codiUsua;
}
