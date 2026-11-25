package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Transportistas</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Transportistas")
@Table(name = "transportistas")
public class Transportistas extends LegacyEntity {

    /** Legado: Codi_Trans */
    @Id
    @Column(name = "codi_trans", length = 4, nullable = false)
    public String codiTrans;

    /** Legado: Desc_Trans */
    @Column(name = "desc_trans", length = 100)
    public String descTrans;

    /** Legado: Iden */
    @Column(name = "iden", length = 20)
    public String iden;

    /** Legado: Direccion */
    @Column(name = "direccion", length = 150)
    public String direccion;

    /** Legado: NRO_LICE_COND */
    @Column(name = "nro_lice_cond", length = 25)
    public String nroLiceCond;

    @Column(name = "nextel", length = 15)
    public String nextel;
}
