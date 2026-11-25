package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CONFIGURACION_VEHICULAR</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ConfiguracionVehicular")
@Table(name = "configuracion_vehicular")
public class ConfiguracionVehicular extends LegacyEntity {

    /** Legado: ID_CONF */
    @Id
    @Column(name = "id_conf", nullable = false)
    public Integer idConf;

    /** Legado: DESC_CONF */
    @Column(name = "desc_conf", length = 50)
    public String descConf;

    /** Legado: CARGA_UTIL */
    @Column(name = "carga_util", precision = 18, scale = 3)
    public BigDecimal cargaUtil;
}
