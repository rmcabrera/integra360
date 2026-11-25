package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Domicilio</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Domicilio")
@Table(name = "domicilio")
public class Domicilio extends LegacyEntity {

    /** Legado: Codi_Domi */
    @Id
    @Column(name = "codi_domi", length = 4, nullable = false)
    public String codiDomi;

    /** Legado: Desc_Domi */
    @Column(name = "desc_domi", length = 150)
    public String descDomi;

    /** Legado: Distrito */
    @Column(name = "distrito", length = 30)
    public String distrito;

    /** Legado: Provincia */
    @Column(name = "provincia", length = 30)
    public String provincia;

    /** Legado: Departamento */
    @Column(name = "departamento", length = 30)
    public String departamento;
}
