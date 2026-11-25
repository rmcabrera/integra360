package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ESTADOS_FINANCIEROS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "EstadosFinancieros")
@Table(name = "estados_financieros")
public class EstadosFinancieros extends LegacyEntity {

    @Id
    @Column(name = "id", nullable = false)
    public Short id;

    /** Legado: Descripcion */
    @Column(name = "descripcion", length = 50, nullable = false)
    public String descripcion;

    /** Legado: Orden */
    @Column(name = "orden")
    public Short orden;

    /** 1 funcion 2 naturaleza */
    @Column(name = "tipo")
    public Short tipo;
}
