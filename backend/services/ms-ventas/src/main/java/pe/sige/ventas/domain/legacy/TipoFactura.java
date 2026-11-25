package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Tipo_Factura</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoFactura")
@Table(name = "tipo_factura")
public class TipoFactura extends LegacyEntity {

    @Id
    @Column(name = "codi_tipo", length = 2, nullable = false)
    public String codiTipo;

    @Column(name = "descrip", length = 30, nullable = false)
    public String descrip;

    @Column(name = "tipo", length = 1)
    public String tipo;
}
