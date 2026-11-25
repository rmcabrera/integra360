package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.LINEA_FAMILIA_PRO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "LineaFamiliaPro")
@Table(name = "linea_familia_pro")
public class LineaFamiliaPro extends LegacyEntity {

    @Id
    @Column(name = "cod_lin_pro", length = 2, nullable = false)
    public String codLinPro;

    @Column(name = "des_lin_pro", length = 100)
    public String desLinPro;
}
