package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_CTA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoCta")
@Table(name = "tipo_cta")
public class TipoCta extends LegacyEntity {

    /** Legado: Cod_cta */
    @Id
    @Column(name = "cod_cta", length = 1, nullable = false)
    public String codCta;

    @Column(name = "desc_cta", length = 20)
    public String descCta;

    @Column(name = "grupo", length = 1)
    public String grupo;

    @Column(name = "orden")
    public Short orden;

    /** Legado: DescGrupo */
    @Column(name = "descgrupo", length = 50)
    public String descgrupo;
}
