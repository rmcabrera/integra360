package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ACCESO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Acceso")
@Table(name = "acceso")
public class Acceso extends LegacyEntity {

    @Id
    @Column(name = "cod_acceso", nullable = false)
    public Long codAcceso;

    @Column(name = "codi_usua", length = 5, nullable = false)
    public String codiUsua;

    @Column(name = "fecha_acce", nullable = false)
    public LocalDateTime fechaAcce;

    @Column(name = "hora", nullable = false)
    public LocalDateTime hora;

    @Column(name = "tipo", length = 1, nullable = false)
    public String tipo;

    @Column(name = "glosa", length = 150, nullable = false)
    public String glosa;
}
