package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CUENTAS_PROVISION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CuentasProvision")
@Table(name = "cuentas_provision")
public class CuentasProvision extends LegacyEntity {

    /** Legado: Codigo */
    @Id
    @Column(name = "codigo", length = 2, nullable = false)
    public String codigo;

    /** Legado: Descripcion */
    @Column(name = "descripcion", length = 50, nullable = false)
    public String descripcion;

    /** Legado: Cuenta */
    @Column(name = "cuenta", length = 7, nullable = false)
    public String cuenta;

    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;
}
