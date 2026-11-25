package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CIERRE_MES_USER</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CierreMesUser")
@Table(name = "cierre_mes_user")
public class CierreMesUser extends LegacyEntity {

    @Id
    @Column(name = "codi_cierre", nullable = false)
    public Long codiCierre;

    @Column(name = "codi_usua", length = 5)
    public String codiUsua;

    @Column(name = "mes", length = 2)
    public String mes;

    @Column(name = "anio", length = 4)
    public String anio;
}
