package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CULTIVOS_PRINCIPAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CultivosPrincipal")
@Table(name = "cultivos_principal")
public class CultivosPrincipal extends LegacyEntity {

    @Id
    @Column(name = "codi_culti", nullable = false)
    public Long codiCulti;

    @Column(name = "cultivo", length = 150)
    public String cultivo;

    @Column(name = "periodo", length = 150)
    public String periodo;

    @Column(name = "epoca", length = 150)
    public String epoca;

    @Column(name = "zona", length = 250)
    public String zona;

    @Column(name = "rendimiento", precision = 18, scale = 3)
    public BigDecimal rendimiento;

    @Column(name = "porc_parti", precision = 18, scale = 3)
    public BigDecimal porcParti;

    @Column(name = "codi_usua", length = 5)
    public String codiUsua;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "nro_peri", precision = 18, scale = 3)
    public BigDecimal nroPeri;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;
}
