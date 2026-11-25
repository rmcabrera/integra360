package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.KITS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Kits")
@Table(name = "kits")
public class Kits extends LegacyEntity {

    /** Legado: CODI_KIT_INTE */
    @Id
    @Column(name = "codi_kit_inte", length = 4, nullable = false)
    public String codiKitInte;

    /** Legado: CODI_KIT_MARC */
    @Column(name = "codi_kit_marc", length = 15, nullable = false)
    public String codiKitMarc;

    /** Legado: DESC_KIT */
    @Column(name = "desc_kit", length = 150)
    public String descKit;

    /** Legado: MARC_KIT */
    @Column(name = "marc_kit", length = 50)
    public String marcKit;

    /** Legado: ABRE_KIT */
    @Column(name = "abre_kit", length = 20)
    public String abreKit;
}
