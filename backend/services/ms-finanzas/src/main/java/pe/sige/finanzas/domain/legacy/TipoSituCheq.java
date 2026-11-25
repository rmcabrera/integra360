package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Tipo_Situ_Cheq</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoSituCheq")
@Table(name = "tipo_situ_cheq")
public class TipoSituCheq extends LegacyEntity {

    /** Legado: Codi_Situ_cheq */
    @Id
    @Column(name = "codi_situ_cheq", length = 2, nullable = false)
    public String codiSituCheq;

    /** Legado: Desc_Situ_Cheq */
    @Column(name = "desc_situ_cheq", length = 50)
    public String descSituCheq;

    /** Legado: Tipo_Situ_Letra */
    @Column(name = "tipo_situ_letra", length = 1)
    public String tipoSituLetra;
}
