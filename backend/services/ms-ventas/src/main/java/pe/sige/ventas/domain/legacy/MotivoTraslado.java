package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.MOTIVO_TRASLADO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "MotivoTraslado")
@Table(name = "motivo_traslado")
public class MotivoTraslado extends LegacyEntity {

    /** Legado: CODI_MOTI_TRAS */
    @Id
    @Column(name = "codi_moti_tras", length = 2, nullable = false)
    public String codiMotiTras;

    /** Legado: DESC_MOTI_TRAS */
    @Column(name = "desc_moti_tras", length = 200)
    public String descMotiTras;

    /** Legado: NEMO_MOTI_TRAS */
    @Column(name = "nemo_moti_tras", length = 30)
    public String nemoMotiTras;

    @Column(name = "codi_tipo_is", length = 2)
    public String codiTipoIs;

    @Column(name = "codi_sunat_elec", length = 2)
    public String codiSunatElec;
}
