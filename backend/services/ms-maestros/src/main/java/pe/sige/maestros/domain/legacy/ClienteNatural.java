package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Cliente_Natural</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ClienteNatural")
@Table(name = "cliente_natural")
public class ClienteNatural extends LegacyEntity {

    /** Legado: Id_Clie_Natu */
    @Id
    @Column(name = "id_clie_natu", nullable = false)
    public Integer idClieNatu;

    /** Legado: Apellidos */
    @Column(name = "apellidos", length = 50, nullable = false)
    public String apellidos;

    /** Legado: Nombres */
    @Column(name = "nombres", length = 50, nullable = false)
    public String nombres;

    /** Legado: Nro_Docu */
    @Column(name = "nro_docu", length = 20)
    public String nroDocu;

    /** Legado: Direccion */
    @Column(name = "direccion", length = 100)
    public String direccion;

    /** Legado: Codi_Clie_Prov */
    @Column(name = "codi_clie_prov", length = 5, nullable = false)
    public String codiClieProv;
}
