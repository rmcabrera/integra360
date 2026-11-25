package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CUENTAS_REPORTE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CuentasReporte")
@Table(name = "cuentas_reporte")
public class CuentasReporte extends LegacyEntity {

    @Id
    @Column(name = "tipo_cuen", nullable = false)
    public Short tipoCuen;

    @Column(name = "descripcion", length = 255)
    public String descripcion;

    @Column(name = "orden", length = 1)
    public String orden;

    @Column(name = "codi_grupo")
    public Integer codiGrupo;
}
