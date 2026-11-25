package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CONCEPTO_BALANCE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ConceptoBalance")
@Table(name = "concepto_balance")
public class ConceptoBalance extends LegacyEntity {

    /** Legado: Codi_Concepto */
    @Id
    @Column(name = "codi_concepto", nullable = false)
    public Short codiConcepto;

    /** Legado: Desc_Concepto */
    @Column(name = "desc_concepto", length = 200, nullable = false)
    public String descConcepto;

    /** Legado: Cod_Cta */
    @Column(name = "cod_cta", length = 1, nullable = false)
    public String codCta;

    /** Legado: Orden */
    @Column(name = "orden", nullable = false)
    public Short orden;
}
