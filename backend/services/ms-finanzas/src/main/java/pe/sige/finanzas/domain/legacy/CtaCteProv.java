package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CTA_CTE_PROV</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CtaCteProv")
@Table(name = "cta_cte_prov")
public class CtaCteProv extends LegacyEntity {

    /** Legado: CODI_CTA_CTE */
    @Id
    @Column(name = "codi_cta_cte", length = 6, nullable = false)
    public String codiCtaCte;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5, nullable = false)
    public String codiClieProv;

    /** Legado: CODI_BANC */
    @Column(name = "codi_banc", length = 2)
    public String codiBanc;

    /** Legado: NRO_CTA_CTE */
    @Column(name = "nro_cta_cte", length = 20, nullable = false)
    public String nroCtaCte;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: TIPO_CTA_BANC */
    @Column(name = "tipo_cta_banc", length = 2)
    public String tipoCtaBanc;

    /** Legado: OBSE */
    @Column(name = "obse", length = 200)
    public String obse;

    /** Legado: DETRACCION */
    @Column(name = "detraccion")
    public Boolean detraccion;
}
