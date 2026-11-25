package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SITU_EMBA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SituEmba")
@Table(name = "situ_emba")
public class SituEmba extends LegacyEntity {

    /** Legado: CODI_SITU */
    @Id
    @Column(name = "codi_situ", length = 2, nullable = false)
    public String codiSitu;

    /** Legado: DESC_SITU */
    @Column(name = "desc_situ", length = 50)
    public String descSitu;

    /** Legado: NEMO_SITU */
    @Column(name = "nemo_situ", length = 10)
    public String nemoSitu;
}
