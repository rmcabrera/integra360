package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.GASTO_OPERATIVO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "GastoOperativo")
@Table(name = "gasto_operativo")
public class GastoOperativo extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codi_gasto", nullable = false)
    public Long codiGasto;

    @Column(name = "anio", length = 4)
    public String anio;

    @Column(name = "mes", length = 2)
    public String mes;

    @Column(name = "valor", precision = 18, scale = 2)
    public BigDecimal valor;
}
