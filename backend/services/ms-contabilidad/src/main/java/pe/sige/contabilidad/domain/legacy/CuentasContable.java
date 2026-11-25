package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CUENTAS_CONTABLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CuentasContable")
@Table(name = "cuentas_contable")
public class CuentasContable extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    /** Legado: DESC_CUEN */
    @Column(name = "desc_cuen", length = 100)
    public String descCuen;

    /** Legado: NRO_SUB_CUEN */
    @Column(name = "nro_sub_cuen", length = 7)
    public String nroSubCuen;

    /** Legado: CODI_LCC */
    @Column(name = "codi_lcc", length = 5, nullable = false)
    public String codiLcc;
}
