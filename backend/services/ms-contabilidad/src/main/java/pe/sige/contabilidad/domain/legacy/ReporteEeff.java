package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.REPORTE_EEFF</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ReporteEeff")
@Table(name = "reporte_eeff")
public class ReporteEeff extends LegacyEntity {

    @Id
    @Column(name = "codi_repo", nullable = false)
    public Integer codiRepo;

    @Column(name = "desc_repo", length = 100)
    public String descRepo;
}
