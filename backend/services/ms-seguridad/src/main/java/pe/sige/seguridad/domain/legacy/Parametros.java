package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Parametros</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Parametros")
@Table(name = "parametros")
public class Parametros extends LegacyEntity {

    @Id
    @Column(name = "id_parm", nullable = false)
    public Integer idParm;

    @Column(name = "desc_parm", length = 50)
    public String descParm;

    @Column(name = "valor_parm", length = 100)
    public String valorParm;

    @Column(name = "valor1")
    public Long valor1;

    @Column(name = "valor2")
    public Long valor2;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;
}
