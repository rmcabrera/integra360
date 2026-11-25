package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SEGUROS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Seguros")
@Table(name = "seguros")
public class Seguros extends LegacyEntity {

    /** Legado: CODI_SEGU */
    @Id
    @Column(name = "codi_segu", nullable = false)
    public Short codiSegu;

    /** Legado: DESC_SEGU */
    @Column(name = "desc_segu", length = 50, nullable = false)
    public String descSegu;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;
}
