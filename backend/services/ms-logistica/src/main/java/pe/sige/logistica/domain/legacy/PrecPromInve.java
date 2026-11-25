package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.prec_prom_inve</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PrecPromInve")
@Table(name = "prec_prom_inve")
public class PrecPromInve extends LegacyEntity {

    @Id
    @Column(name = "prod", length = 8, nullable = false)
    public String prod;

    @Column(name = "precio", precision = 15, scale = 4, nullable = false)
    public BigDecimal precio;
}
