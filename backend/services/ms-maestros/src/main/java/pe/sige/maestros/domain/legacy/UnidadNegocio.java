package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.UNIDAD_NEGOCIO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "UnidadNegocio")
@Table(name = "unidad_negocio")
public class UnidadNegocio extends LegacyEntity {

    @Id
    @Column(name = "codi_unid_nego", length = 2, nullable = false)
    public String codiUnidNego;

    @Column(name = "desc_unid_nego", length = 50, nullable = false)
    public String descUnidNego;
}
