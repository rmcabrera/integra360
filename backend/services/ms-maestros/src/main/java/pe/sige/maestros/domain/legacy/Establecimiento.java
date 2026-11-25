package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ESTABLECIMIENTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Establecimiento")
@Table(name = "establecimiento")
public class Establecimiento extends LegacyEntity {

    /** Legado: Codi_Esta */
    @Id
    @Column(name = "codi_esta", nullable = false)
    public Short codiEsta;

    /** Legado: Codi_Esta_Sunat */
    @Column(name = "codi_esta_sunat", length = 2, nullable = false)
    public String codiEstaSunat;

    /** Legado: Desc_Esta */
    @Column(name = "desc_esta", length = 100, nullable = false)
    public String descEsta;
}
