package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CUENTAS_PLAN_PROV_CONCEP</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CuentasPlanProvConcep")
@Table(name = "cuentas_plan_prov_concep")
public class CuentasPlanProvConcep extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    /** Legado: CODI_ITEM */
    @Column(name = "codi_item", length = 3, nullable = false)
    public String codiItem;

    /** Legado: CODI_DETA */
    @Column(name = "codi_deta", length = 3, nullable = false)
    public String codiDeta;

    /** Legado: CODI_CONC */
    @Column(name = "codi_conc", length = 6, nullable = false)
    public String codiConc;

    /** Legado: CODI_CONC_FIN */
    @Column(name = "codi_conc_fin", length = 6, nullable = false)
    public String codiConcFin;
}
