package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_INGR_SALI</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoIngrSali")
@Table(name = "tipo_ingr_sali")
public class TipoIngrSali extends LegacyEntity {

    /** Legado: CODI_TIPO_IS */
    @Id
    @Column(name = "codi_tipo_is", length = 2, nullable = false)
    public String codiTipoIs;

    /** Legado: DESC_TIPO_IS */
    @Column(name = "desc_tipo_is", length = 100)
    public String descTipoIs;

    /** Legado: NEMO_TIPO_IS */
    @Column(name = "nemo_tipo_is", length = 15)
    public String nemoTipoIs;

    /** Legado: I_S */
    @Column(name = "i_s", length = 1)
    public String iS;

    /** Legado: CODI_SUNAT_MOTI_TRAS */
    @Column(name = "codi_sunat_moti_tras", length = 2)
    public String codiSunatMotiTras;

    /** Legado: DESC_SUNAT_MOTI_TRAS */
    @Column(name = "desc_sunat_moti_tras", length = 50)
    public String descSunatMotiTras;

    /** Legado: CONTABILIZAR */
    @Column(name = "contabilizar")
    public Short contabilizar;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;
}
