package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.REPORTE_EEFF_GRUPO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ReporteEeffGrupo")
@Table(name = "reporte_eeff_grupo")
public class ReporteEeffGrupo extends LegacyEntity {

    @Id
    @Column(name = "codi_grupo", nullable = false)
    public Integer codiGrupo;

    @Column(name = "desc_grupo", length = 100)
    public String descGrupo;

    @Column(name = "codi_repo")
    public Integer codiRepo;

    @Column(name = "orden", length = 1)
    public String orden;
}
