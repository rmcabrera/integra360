package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ADUANA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Aduana")
@Table(name = "aduana")
public class Aduana extends LegacyEntity {

    /** Legado: Codi_Aduana */
    @Id
    @Column(name = "codi_aduana", nullable = false)
    public Short codiAduana;

    /** Legado: Codi_Sunat */
    @Column(name = "codi_sunat", length = 3, nullable = false)
    public String codiSunat;

    /** Legado: Desc_Aduana */
    @Column(name = "desc_aduana", length = 200, nullable = false)
    public String descAduana;
}
