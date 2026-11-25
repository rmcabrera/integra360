package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SISTEMAS_EMBARCACIONES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SistemasEmbarcaciones")
@Table(name = "sistemas_embarcaciones")
public class SistemasEmbarcaciones extends LegacyEntity {

    /** Legado: CODI_SIST_EMBA */
    @Id
    @Column(name = "codi_sist_emba", length = 2, nullable = false)
    public String codiSistEmba;

    /** Legado: DESC_SIST_EMBA */
    @Column(name = "desc_sist_emba", length = 100)
    public String descSistEmba;

    /** Legado: NEMO_SIST_EMBA */
    @Column(name = "nemo_sist_emba", length = 20)
    public String nemoSistEmba;
}
