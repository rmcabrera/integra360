package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CTA_CTE_PERSONAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CtaCtePersonal")
@Table(name = "cta_cte_personal")
public class CtaCtePersonal extends LegacyEntity {

    /** Legado: CODI_CTA_CTE */
    @Id
    @Column(name = "codi_cta_cte", length = 6, nullable = false)
    public String codiCtaCte;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    /** Legado: CODI_BANC */
    @Column(name = "codi_banc", length = 2)
    public String codiBanc;

    /** Legado: NRO_CTA_CTE */
    @Column(name = "nro_cta_cte", length = 30, nullable = false)
    public String nroCtaCte;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: TIPO_CTA_CTE */
    @Column(name = "tipo_cta_cte", length = 10)
    public String tipoCtaCte;

    /** Legado: TIPO_CTA_BANC */
    @Column(name = "tipo_cta_banc", length = 2)
    public String tipoCtaBanc;
}
