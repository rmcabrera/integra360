package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Terceros</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Terceros")
@Table(name = "terceros")
public class Terceros extends LegacyEntity {

    /** Legado: DNI */
    @Id
    @Column(name = "dni", length = 10, nullable = false)
    public String dni;

    /** Legado: Datos */
    @Column(name = "datos", length = 100)
    public String datos;

    /** Legado: Codi_carg */
    @Column(name = "codi_carg", length = 4)
    public String codiCarg;
}
