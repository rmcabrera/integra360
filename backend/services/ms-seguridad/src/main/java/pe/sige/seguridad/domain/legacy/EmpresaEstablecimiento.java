package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.EMPRESA_ESTABLECIMIENTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "EmpresaEstablecimiento")
@Table(name = "empresa_establecimiento")
public class EmpresaEstablecimiento extends LegacyEntity {

    @Id
    @Column(name = "codi_empre_estab", nullable = false)
    public Integer codiEmpreEstab;

    @Column(name = "codi_empre")
    public Integer codiEmpre;

    @Column(name = "codigo_denomi", length = 4)
    public String codigoDenomi;

    @Column(name = "denominacion", length = 50, nullable = false)
    public String denominacion;

    @Column(name = "codi_tipo_estab", nullable = false)
    public Short codiTipoEstab;

    @Column(name = "centro_riesgo", length = 1, nullable = false)
    public String centroRiesgo;
}
