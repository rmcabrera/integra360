package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ANTICIPOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Anticipos")
@Table(name = "anticipos")
public class Anticipos extends LegacyEntity {

    /** Legado: CODI_ANTI */
    @Id
    @Column(name = "codi_anti", length = 20, nullable = false)
    public String codiAnti;

    /** Legado: PORCENTAJE */
    @Column(name = "porcentaje")
    public Long porcentaje;

    /** Legado: FECH_ANTI */
    @Column(name = "fech_anti")
    public Long fechAnti;

    /** Legado: CODI_TIPO_DOCU_PAGO */
    @Column(name = "codi_tipo_docu_pago", length = 4)
    public String codiTipoDocuPago;

    /** Legado: NRO_DOCU */
    @Column(name = "nro_docu", length = 20)
    public String nroDocu;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    /** Legado: CODI_TIPO_DOCU_SOLI */
    @Column(name = "codi_tipo_docu_soli", length = 4)
    public String codiTipoDocuSoli;
}
