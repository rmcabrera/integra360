package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.UBIGEO_PROVINCIA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "UbigeoProvincia")
@Table(name = "ubigeo_provincia")
public class UbigeoProvincia extends LegacyEntity {

    /** Legado: Codi_Ubi_Prov */
    @Id
    @Column(name = "codi_ubi_prov", nullable = false)
    public Short codiUbiProv;

    /** Legado: Codi_Ubi_Prov_Sunat */
    @Column(name = "codi_ubi_prov_sunat", length = 4, nullable = false)
    public String codiUbiProvSunat;

    /** Legado: Desc_Ubi_Prov */
    @Column(name = "desc_ubi_prov", length = 100, nullable = false)
    public String descUbiProv;

    /** Legado: Codi_Ubi_Reg_Sunat */
    @Column(name = "codi_ubi_reg_sunat", length = 2)
    public String codiUbiRegSunat;
}
