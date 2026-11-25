package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_CERT_EMBA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoCertEmba")
@Table(name = "tipo_cert_emba")
public class TipoCertEmba extends LegacyEntity {

    /** Legado: CODI_TIPO_CERT */
    @Id
    @Column(name = "codi_tipo_cert", length = 2, nullable = false)
    public String codiTipoCert;

    /** Legado: DESC_TIPO_CERT */
    @Column(name = "desc_tipo_cert", length = 100)
    public String descTipoCert;

    /** Legado: NEMO_TIPO_CERT */
    @Column(name = "nemo_tipo_cert", length = 20)
    public String nemoTipoCert;
}
