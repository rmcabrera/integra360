package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_ACEPTACION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoAceptacion")
@Table(name = "tipo_aceptacion")
public class TipoAceptacion extends LegacyEntity {

    /** Legado: CODI_TIPO_ACEP */
    @Id
    @Column(name = "codi_tipo_acep", length = 2, nullable = false)
    public String codiTipoAcep;

    /** Legado: DESC_ACEP_REQU */
    @Column(name = "desc_acep_requ", length = 50)
    public String descAcepRequ;

    /** Legado: NEMO */
    @Column(name = "nemo", length = 4)
    public String nemo;
}
