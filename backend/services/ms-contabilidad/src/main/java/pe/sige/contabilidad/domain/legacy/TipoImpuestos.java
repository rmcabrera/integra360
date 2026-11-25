package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_IMPUESTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoImpuestos")
@Table(name = "tipo_impuestos")
public class TipoImpuestos extends LegacyEntity {

    @Id
    @Column(name = "cod_imp", nullable = false)
    public Integer codImp;

    @Column(name = "desc_imp", length = 30)
    public String descImp;
}
