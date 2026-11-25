package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.VIA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Via")
@Table(name = "via")
public class Via extends LegacyEntity {

    /** Legado: Codi_Via */
    @Id
    @Column(name = "codi_via", nullable = false)
    public Short codiVia;

    /** Legado: Codi_Via_Sunat */
    @Column(name = "codi_via_sunat", length = 2, nullable = false)
    public String codiViaSunat;

    /** Legado: Desc_Via */
    @Column(name = "desc_via", length = 20, nullable = false)
    public String descVia;

    /** Legado: Nemo_Via */
    @Column(name = "nemo_via", length = 5)
    public String nemoVia;
}
