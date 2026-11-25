package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_REEMBOLSO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoReembolso")
@Table(name = "tipo_reembolso")
public class TipoReembolso extends LegacyEntity {

    @Id
    @Column(name = "tipo_reemb", length = 3, nullable = false)
    public String tipoReemb;

    @Column(name = "desc_reemb", length = 50)
    public String descReemb;

    @Column(name = "cta_con", length = 7)
    public String ctaCon;

    @Column(name = "cta_sin", length = 7)
    public String ctaSin;

    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;
}
