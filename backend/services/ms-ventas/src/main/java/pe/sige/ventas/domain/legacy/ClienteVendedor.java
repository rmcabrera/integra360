package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CLIENTE_VENDEDOR</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ClienteVendedor")
@Table(name = "cliente_vendedor")
public class ClienteVendedor extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_clie_vende", nullable = false)
    public Long idClieVende;

    @Column(name = "codi_usua", length = 5)
    public String codiUsua;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "estado", length = 1)
    public String estado;
}
