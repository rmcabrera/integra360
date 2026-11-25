package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CCNU_SEGMENTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CcnuSegmentos")
@Table(name = "ccnu_segmentos")
public class CcnuSegmentos extends LegacyEntity {

    @Id
    @Column(name = "cod_seg", length = 2, nullable = false)
    public String codSeg;

    @Column(name = "desc_seg", length = 250)
    public String descSeg;
}
