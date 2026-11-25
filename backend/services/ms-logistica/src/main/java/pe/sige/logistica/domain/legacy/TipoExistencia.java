package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_EXISTENCIA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoExistencia")
@Table(name = "tipo_existencia")
public class TipoExistencia extends LegacyEntity {

    /** Legado: Codi_Tipo_Exis */
    @Id
    @Column(name = "codi_tipo_exis", length = 2, nullable = false)
    public String codiTipoExis;

    /** Legado: Codi_Sunat */
    @Column(name = "codi_sunat", length = 2, nullable = false)
    public String codiSunat;

    /** Legado: Desc_Tipo_Exis */
    @Column(name = "desc_tipo_exis", length = 100, nullable = false)
    public String descTipoExis;

    /** Legado: Nemo */
    @Column(name = "nemo", length = 30)
    public String nemo;
}
