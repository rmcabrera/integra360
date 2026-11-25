package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TRANSACCIONES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Transacciones")
@Table(name = "transacciones")
public class Transacciones extends LegacyEntity {

    @Id
    @Column(name = "codi_tran", length = 3, nullable = false)
    public String codiTran;

    @Column(name = "desc_tran", length = 20, nullable = false)
    public String descTran;
}
