package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_DOCUMENTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoDocumento")
@Table(name = "tipo_documento")
public class TipoDocumento extends LegacyEntity {

    /** Legado: CODI_TIPO_DOCU */
    @Id
    @Column(name = "codi_tipo_docu", length = 4, nullable = false)
    public String codiTipoDocu;

    /** Legado: DESC_TIPO_DOCU */
    @Column(name = "desc_tipo_docu", length = 150, nullable = false)
    public String descTipoDocu;

    /** Legado: TIPO_CONT */
    @Column(name = "tipo_cont", length = 1)
    public String tipoCont;

    /** Legado: NEMO */
    @Column(name = "nemo", length = 3)
    public String nemo;

    @Column(name = "forma_pago", length = 3)
    public String formaPago;

    /** Legado: CODI_TIPO_ESSA */
    @Column(name = "codi_tipo_essa")
    public Short codiTipoEssa;

    @Column(name = "tipo_sunat", length = 2)
    public String tipoSunat;

    @Column(name = "codi_sunat", length = 2)
    public String codiSunat;
}
