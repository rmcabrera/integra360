package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DETALLE_SALIDA_MATERIALES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DetalleSalidaMateriales")
@Table(name = "detalle_salida_materiales")
public class DetalleSalidaMateriales extends LegacyEntity {

    /** Legado: CODI_DETA_DOCU_SALI */
    @Id
    @Column(name = "codi_deta_docu_sali", length = 12, nullable = false)
    public String codiDetaDocuSali;

    /** Legado: CODI_DOCU_SALI */
    @Column(name = "codi_docu_sali", length = 10, nullable = false)
    public String codiDocuSali;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    /** Legado: CODI_PROD */
    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    /** Legado: DESC_PROD */
    @Column(name = "desc_prod", length = 250)
    public String descProd;

    /** Legado: CODI_UNID_MEDI_PROD */
    @Column(name = "codi_unid_medi_prod", length = 2)
    public String codiUnidMediProd;

    /** Legado: CANTIDAD */
    @Column(name = "cantidad", precision = 18, scale = 4)
    public BigDecimal cantidad;

    /** Legado: PESO */
    @Column(name = "peso", precision = 18, scale = 4)
    public BigDecimal peso;

    /** Legado: CODI_UNID_MEDI_PESO */
    @Column(name = "codi_unid_medi_peso", length = 2)
    public String codiUnidMediPeso;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    @Column(name = "con_reto", length = 1)
    public String conReto;

    @Column(name = "indi_reto", length = 1)
    public String indiReto;

    /** Legado: CODI_DETA_ORIG */
    @Column(name = "codi_deta_orig", length = 12)
    public String codiDetaOrig;

    /** Legado: TIPO_ORIG */
    @Column(name = "tipo_orig", length = 1)
    public String tipoOrig;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;
}
