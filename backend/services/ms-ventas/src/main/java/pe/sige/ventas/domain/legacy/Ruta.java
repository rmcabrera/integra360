package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.RUTA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Ruta")
@Table(name = "ruta")
public class Ruta extends LegacyEntity {

    @Id
    @Column(name = "codi_ruta", nullable = false)
    public Long codiRuta;

    @Column(name = "zona", length = 150)
    public String zona;

    @Column(name = "dia_l", length = 150)
    public String diaL;

    @Column(name = "dia_m", length = 150)
    public String diaM;

    @Column(name = "dia_mc", length = 150)
    public String diaMc;

    @Column(name = "dia_j", length = 150)
    public String diaJ;

    @Column(name = "dia_v", length = 150)
    public String diaV;

    @Column(name = "dia_sa", length = 150)
    public String diaSa;

    @Column(name = "codi_usua", length = 5)
    public String codiUsua;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "fecha_sal")
    public LocalDateTime fechaSal;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;
}
