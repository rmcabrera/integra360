package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.EVENTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Evento")
@Table(name = "evento")
public class Evento extends LegacyEntity {

    @Id
    @Column(name = "codi_plan", nullable = false)
    public Long codiPlan;

    @Column(name = "nro_even", length = 12)
    public String nroEven;

    @Column(name = "evento", length = 100)
    public String evento;

    @Column(name = "tipo", length = 20)
    public String tipo;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "duracion")
    public LocalDateTime duracion;

    @Column(name = "h_ini")
    public LocalDateTime hIni;

    @Column(name = "h_fin")
    public LocalDateTime hFin;

    @Column(name = "ubicacion", length = 150)
    public String ubicacion;

    @Column(name = "notas")
    public String notas;

    @Column(name = "informe")
    public String informe;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "codi_pers", length = 5)
    public String codiPers;
}
