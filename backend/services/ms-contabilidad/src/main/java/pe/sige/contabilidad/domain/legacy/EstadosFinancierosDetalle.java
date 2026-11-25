package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ESTADOS_FINANCIEROS_DETALLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "EstadosFinancierosDetalle")
@Table(name = "estados_financieros_detalle")
public class EstadosFinancierosDetalle extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sige_id", nullable = false)
    public Long sigeId;

    /** Legado: Id */
    @Column(name = "id", nullable = false)
    public Short id;

    /** Legado: Nro_cuen */
    @Column(name = "nro_cuen", length = 3, nullable = false)
    public String nroCuen;

    /** Legado: Orden */
    @Column(name = "orden", nullable = false)
    public Short orden;
}
