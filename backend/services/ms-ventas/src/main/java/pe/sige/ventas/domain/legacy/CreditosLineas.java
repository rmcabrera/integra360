package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CREDITOS_LINEAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CreditosLineas")
@Table(name = "creditos_lineas")
public class CreditosLineas extends LegacyEntity {

    @Id
    @Column(name = "codi_lin_cred", nullable = false)
    public Long codiLinCred;

    @Column(name = "descripcion", length = 150)
    public String descripcion;
}
