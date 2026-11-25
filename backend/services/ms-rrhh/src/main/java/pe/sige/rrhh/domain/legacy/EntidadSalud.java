package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ENTIDAD_SALUD</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "EntidadSalud")
@Table(name = "entidad_salud")
public class EntidadSalud extends LegacyEntity {

    /** Legado: Codi_Enti */
    @Id
    @Column(name = "codi_enti", nullable = false)
    public Short codiEnti;

    /** Legado: Codi_Enti_Sunat */
    @Column(name = "codi_enti_sunat", nullable = false)
    public Short codiEntiSunat;

    /** Legado: Ruc */
    @Column(name = "ruc", length = 11, nullable = false)
    public String ruc;

    /** Legado: Desc_Enti */
    @Column(name = "desc_enti", length = 150, nullable = false)
    public String descEnti;
}
