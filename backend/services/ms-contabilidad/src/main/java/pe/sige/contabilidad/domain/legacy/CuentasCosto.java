package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CUENTAS_COSTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CuentasCosto")
@Table(name = "cuentas_costo")
public class CuentasCosto extends LegacyEntity {

    @Id
    @Column(name = "codi_cuen_cost", length = 2, nullable = false)
    public String codiCuenCost;

    @Column(name = "codi_clas_cuen", length = 2)
    public String codiClasCuen;
}
