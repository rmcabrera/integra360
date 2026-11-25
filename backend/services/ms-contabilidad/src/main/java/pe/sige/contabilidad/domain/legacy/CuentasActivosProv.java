package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CUENTAS_ACTIVOS_PROV</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CuentasActivosProv")
@Table(name = "cuentas_activos_prov")
public class CuentasActivosProv extends LegacyEntity {

    @Id
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    @Column(name = "cuent_cargo", length = 7)
    public String cuentCargo;

    @Column(name = "cuent_abono", length = 7)
    public String cuentAbono;
}
