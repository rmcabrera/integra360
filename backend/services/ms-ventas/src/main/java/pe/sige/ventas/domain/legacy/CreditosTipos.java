package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CREDITOS_TIPOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CreditosTipos")
@Table(name = "creditos_tipos")
public class CreditosTipos extends LegacyEntity {

    @Id
    @Column(name = "codi_tipo_cred", nullable = false)
    public Long codiTipoCred;

    @Column(name = "descripcion", length = 150)
    public String descripcion;
}
