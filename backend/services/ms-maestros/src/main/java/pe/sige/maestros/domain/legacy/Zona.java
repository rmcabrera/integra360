package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ZONA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Zona")
@Table(name = "zona")
public class Zona extends LegacyEntity {

    /** Legado: Codi_Zona */
    @Id
    @Column(name = "codi_zona", nullable = false)
    public Short codiZona;

    /** Legado: Codi_Zona_Sunat */
    @Column(name = "codi_zona_sunat", length = 2, nullable = false)
    public String codiZonaSunat;

    /** Legado: Desc_Zona */
    @Column(name = "desc_zona", length = 50, nullable = false)
    public String descZona;

    /** Legado: Nemo_Zona */
    @Column(name = "nemo_zona", length = 5)
    public String nemoZona;
}
