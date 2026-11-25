package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.EMBA_VENC_CERT</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "EmbaVencCert")
@Table(name = "emba_venc_cert")
public class EmbaVencCert extends LegacyEntity {

    /** Legado: CODI_VENC_CERT */
    @Id
    @Column(name = "codi_venc_cert", length = 6, nullable = false)
    public String codiVencCert;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    /** Legado: CODI_TIPO_CERT */
    @Column(name = "codi_tipo_cert", length = 2)
    public String codiTipoCert;

    /** Legado: FECH_INIC */
    @Column(name = "fech_inic", nullable = false)
    public LocalDateTime fechInic;

    /** Legado: FECH_TERM */
    @Column(name = "fech_term")
    public LocalDateTime fechTerm;

    /** Legado: PERIODO */
    @Column(name = "periodo", length = 10)
    public String periodo;

    /** Legado: OBSERVACION */
    @Column(name = "observacion", length = 200)
    public String observacion;
}
