package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.INGRESOS_QUINTA_CATEG</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "IngresosQuintaCateg")
@Table(name = "ingresos_quinta_categ")
public class IngresosQuintaCateg extends LegacyEntity {

    @Id
    @Column(name = "codi_ingre", nullable = false)
    public Long codiIngre;

    @Column(name = "codi_pers", length = 5)
    public String codiPers;

    /** Legado: año */
    @Column(name = "ano", length = 4)
    public String ano;

    @Column(name = "mes", length = 2)
    public String mes;

    @Column(name = "monto", precision = 18, scale = 2)
    public BigDecimal monto;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "reten", precision = 12, scale = 2)
    public BigDecimal reten;

    @Column(name = "renta_reten", precision = 12, scale = 2)
    public BigDecimal rentaReten;
}
