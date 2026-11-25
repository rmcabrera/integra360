package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CUENTAS_PARTIDA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CuentasPartida")
@Table(name = "cuentas_partida")
public class CuentasPartida extends LegacyEntity {

    @Id
    @Column(name = "codi_partida", length = 4, nullable = false)
    public String codiPartida;

    @Column(name = "descripcion", length = 255)
    public String descripcion;

    @Column(name = "tipo_cuen")
    public Short tipoCuen;

    @Column(name = "orden")
    public Integer orden;
}
