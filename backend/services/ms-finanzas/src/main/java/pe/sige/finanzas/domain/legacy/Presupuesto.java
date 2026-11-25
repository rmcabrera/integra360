package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Presupuesto</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Presupuesto")
@Table(name = "presupuesto")
public class Presupuesto extends LegacyEntity {

    /** Legado: Codi_Presu */
    @Id
    @Column(name = "codi_presu", length = 5, nullable = false)
    public String codiPresu;

    /** Legado: Desc_Presu */
    @Column(name = "desc_presu", length = 50)
    public String descPresu;

    /** Legado: Fecha */
    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Legado: Nro_Cuen */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;
}
