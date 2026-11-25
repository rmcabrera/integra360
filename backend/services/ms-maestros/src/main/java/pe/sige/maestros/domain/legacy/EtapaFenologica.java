package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ETAPA_FENOLOGICA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "EtapaFenologica")
@Table(name = "etapa_fenologica")
public class EtapaFenologica extends LegacyEntity {

    @Id
    @Column(name = "cod_eta", nullable = false)
    public Long codEta;

    @Column(name = "desc_eta", length = 100)
    public String descEta;
}
