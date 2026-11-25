package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_COSTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoCosto")
@Table(name = "tipo_costo")
public class TipoCosto extends LegacyEntity {

    /** Legado: CODI_TIPO_COST */
    @Id
    @Column(name = "codi_tipo_cost", length = 2, nullable = false)
    public String codiTipoCost;

    /** Legado: DESC_TIPO_COST */
    @Column(name = "desc_tipo_cost", length = 100)
    public String descTipoCost;

    /** Legado: NEMO */
    @Column(name = "nemo", length = 20)
    public String nemo;

    /** Legado: ORDEN */
    @Column(name = "orden")
    public Short orden;

    /** Legado: CF_CV */
    @Column(name = "cf_cv", length = 2)
    public String cfCv;

    /** Legado: TCG */
    @Column(name = "tcg", length = 2)
    public String tcg;
}
