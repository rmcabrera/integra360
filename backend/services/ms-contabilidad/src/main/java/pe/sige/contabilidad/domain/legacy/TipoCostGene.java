package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_COST_GENE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoCostGene")
@Table(name = "tipo_cost_gene")
public class TipoCostGene extends LegacyEntity {

    /** Legado: CODI_TIPO_COST_GENE */
    @Id
    @Column(name = "codi_tipo_cost_gene", length = 2, nullable = false)
    public String codiTipoCostGene;

    /** Legado: DESC_TIPO_COST_GENE */
    @Column(name = "desc_tipo_cost_gene", length = 50)
    public String descTipoCostGene;

    /** Legado: NEMO */
    @Column(name = "nemo", length = 20)
    public String nemo;

    /** Legado: ORDEN */
    @Column(name = "orden")
    public Short orden;
}
