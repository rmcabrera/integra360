package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CUENTAS_PLAN_PROV</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CuentasPlanProv")
@Table(name = "cuentas_plan_prov")
public class CuentasPlanProv extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    @Column(name = "codi_item", length = 3, nullable = false)
    public String codiItem;

    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    @Column(name = "cargo", length = 1, nullable = false)
    public String cargo;

    @Column(name = "grupo", length = 1, nullable = false)
    public String grupo;

    @Column(name = "tipo_plan", length = 2)
    public String tipoPlan;
}
