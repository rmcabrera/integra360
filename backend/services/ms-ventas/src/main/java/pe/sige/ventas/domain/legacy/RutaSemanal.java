package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.RUTA_SEMANAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "RutaSemanal")
@Table(name = "ruta_semanal")
public class RutaSemanal extends LegacyEntity {

    @Id
    @Column(name = "codi_ruta", nullable = false)
    public Long codiRuta;

    @Column(name = "zona", length = 150)
    public String zona;

    @Column(name = "cliente", length = 150)
    public String cliente;

    @Column(name = "cultivo", length = 150)
    public String cultivo;

    @Column(name = "area", length = 150)
    public String area;

    @Column(name = "etapa", length = 150)
    public String etapa;

    @Column(name = "observacion", length = 150)
    public String observacion;

    @Column(name = "codi_usua", length = 5)
    public String codiUsua;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "zona_aux", length = 150)
    public String zonaAux;
}
