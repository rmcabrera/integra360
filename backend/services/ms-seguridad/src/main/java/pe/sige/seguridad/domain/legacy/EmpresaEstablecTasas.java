package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.EMPRESA_ESTABLEC_TASAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "EmpresaEstablecTasas")
@Table(name = "empresa_establec_tasas")
public class EmpresaEstablecTasas extends LegacyEntity {

    @Id
    @Column(name = "codi_tasa", nullable = false)
    public Integer codiTasa;

    @Column(name = "codi_empre_estab", nullable = false)
    public Integer codiEmpreEstab;

    @Column(name = "tasa", nullable = false)
    public Long tasa;

    @Column(name = "estado", length = 1)
    public String estado;
}
