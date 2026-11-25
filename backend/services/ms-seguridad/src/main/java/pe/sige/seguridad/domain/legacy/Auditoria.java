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
 * Tabla legado <b>dbo.AUDITORIA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Auditoria")
@Table(name = "auditoria")
public class Auditoria extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    /** Legado: Anio */
    @Column(name = "anio", nullable = false)
    public Short anio;

    /** Legado: Mes */
    @Column(name = "mes", nullable = false)
    public Short mes;

    /** Legado: Fecha */
    @Column(name = "fecha", nullable = false)
    public LocalDateTime fecha;

    /** Legado: Maquina */
    @Column(name = "maquina", length = 50, nullable = false)
    public String maquina;

    /** Legado: Aplicacion */
    @Column(name = "aplicacion", length = 100, nullable = false)
    public String aplicacion;

    /** Legado: Codi_Usua */
    @Column(name = "codi_usua", length = 5, nullable = false)
    public String codiUsua;

    /** Legado: Accion */
    @Column(name = "accion", length = 1, nullable = false)
    public String accion;

    /** Legado: Objeto */
    @Column(name = "objeto", length = 100)
    public String objeto;

    /** Legado: Codigo */
    @Column(name = "codigo", length = 50)
    public String codigo;

    /** Legado: Observacion */
    @Column(name = "observacion", length = 300)
    public String observacion;
}
