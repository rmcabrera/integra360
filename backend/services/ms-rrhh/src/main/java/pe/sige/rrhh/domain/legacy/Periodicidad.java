package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PERIODICIDAD</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Periodicidad")
@Table(name = "periodicidad")
public class Periodicidad extends LegacyEntity {

    /** Legado: Codi_Periodo */
    @Id
    @Column(name = "codi_periodo", nullable = false)
    public Short codiPeriodo;

    /** Legado: Codi_Periodo_Sunat */
    @Column(name = "codi_periodo_sunat", nullable = false)
    public Short codiPeriodoSunat;

    /** Legado: Desc_Periodo */
    @Column(name = "desc_periodo", length = 50, nullable = false)
    public String descPeriodo;
}
