package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Dif_camb</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DifCamb")
@Table(name = "dif_camb")
public class DifCamb extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    /** Legado: Codi_Cuenta */
    @Column(name = "codi_cuenta", length = 7)
    public String codiCuenta;

    /** Legado: Cta_Gasto */
    @Column(name = "cta_gasto", length = 7)
    public String ctaGasto;

    /** Legado: Cta_INgreso */
    @Column(name = "cta_ingreso", length = 7)
    public String ctaIngreso;
}
