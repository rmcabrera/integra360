package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Cuentas_Gerencial</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CuentasGerencial")
@Table(name = "cuentas_gerencial")
public class CuentasGerencial extends LegacyEntity {

    /** Legado: Item */
    @Id
    @Column(name = "item", length = 3, nullable = false)
    public String item;

    /** Legado: Nro_cuen */
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    /** Legado: Resumen */
    @Column(name = "resumen", length = 100)
    public String resumen;
}
