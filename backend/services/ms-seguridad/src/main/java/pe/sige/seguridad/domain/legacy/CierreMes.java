package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CIERRE_MES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CierreMes")
@Table(name = "cierre_mes")
public class CierreMes extends LegacyEntity {

    @Id
    @Column(name = "codi_cierre", nullable = false)
    public Long codiCierre;

    @Column(name = "anio", length = 4)
    public String anio;

    @Column(name = "mes", length = 2)
    public String mes;

    @Column(name = "estado", length = 1)
    public String estado;
}
