package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_CARGA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoCarga")
@Table(name = "tipo_carga")
public class TipoCarga extends LegacyEntity {

    @Id
    @Column(name = "codi_carga", length = 4, nullable = false)
    public String codiCarga;

    @Column(name = "descripcion", length = 150)
    public String descripcion;
}
