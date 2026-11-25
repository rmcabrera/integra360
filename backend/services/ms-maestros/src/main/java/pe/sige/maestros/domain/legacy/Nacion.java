package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.NACION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Nacion")
@Table(name = "nacion")
public class Nacion extends LegacyEntity {

    /** Legado: Codi_Nacion */
    @Id
    @Column(name = "codi_nacion", nullable = false)
    public Short codiNacion;

    /** Legado: Codi_Nacion_Sunat */
    @Column(name = "codi_nacion_sunat", length = 4, nullable = false)
    public String codiNacionSunat;

    /** Legado: Desc_Nacion */
    @Column(name = "desc_nacion", length = 150, nullable = false)
    public String descNacion;
}
