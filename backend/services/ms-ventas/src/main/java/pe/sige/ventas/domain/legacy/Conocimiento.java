package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CONOCIMIENTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Conocimiento")
@Table(name = "conocimiento")
public class Conocimiento extends LegacyEntity {

    @Id
    @Column(name = "codi_con_mer", nullable = false)
    public Long codiConMer;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "cultivo", length = 150)
    public String cultivo;

    @Column(name = "variedad", length = 150)
    public String variedad;

    @Column(name = "epoca", length = 2)
    public String epoca;

    @Column(name = "periodo", precision = 18, scale = 2)
    public BigDecimal periodo;

    @Column(name = "zona", length = 150)
    public String zona;

    @Column(name = "sector", length = 150)
    public String sector;

    @Column(name = "area", length = 150)
    public String area;

    @Column(name = "rendimiento", precision = 18, scale = 2)
    public BigDecimal rendimiento;

    @Column(name = "precio", precision = 18, scale = 2)
    public BigDecimal precio;
}
