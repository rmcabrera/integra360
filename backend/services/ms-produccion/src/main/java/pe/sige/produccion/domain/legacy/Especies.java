package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ESPECIES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Especies")
@Table(name = "especies")
public class Especies extends LegacyEntity {

    /** Legado: CODI_ESPE */
    @Id
    @Column(name = "codi_espe", length = 2, nullable = false)
    public String codiEspe;

    /** Legado: DESC_ESPE */
    @Column(name = "desc_espe", length = 50)
    public String descEspe;

    @Column(name = "descuento", precision = 18, scale = 3)
    public BigDecimal descuento;

    @Column(name = "tipo_cons", length = 1)
    public String tipoCons;
}
