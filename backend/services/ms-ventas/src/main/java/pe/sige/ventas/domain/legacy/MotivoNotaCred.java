package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.MOTIVO_NOTA_CRED</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "MotivoNotaCred")
@Table(name = "motivo_nota_cred")
public class MotivoNotaCred extends LegacyEntity {

    @Id
    @Column(name = "id_moti", nullable = false)
    public Integer idMoti;

    @Column(name = "desc_moti", length = 50)
    public String descMoti;

    @Column(name = "codi_sunat", length = 2)
    public String codiSunat;
}
