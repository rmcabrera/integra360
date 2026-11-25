package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.UBIGEO_DISTRITO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "UbigeoDistrito")
@Table(name = "ubigeo_distrito")
public class UbigeoDistrito extends LegacyEntity {

    /** Legado: Codi_Ubi_Dist */
    @Id
    @Column(name = "codi_ubi_dist", nullable = false)
    public Short codiUbiDist;

    /** Legado: Codi_Ubi_Dist_Sunat */
    @Column(name = "codi_ubi_dist_sunat", length = 6, nullable = false)
    public String codiUbiDistSunat;

    /** Legado: Desc_Ubi_Dist */
    @Column(name = "desc_ubi_dist", length = 100, nullable = false)
    public String descUbiDist;

    /** Legado: Codi_Ubi_Prov_Sunat */
    @Column(name = "codi_ubi_prov_sunat", length = 4)
    public String codiUbiProvSunat;
}
