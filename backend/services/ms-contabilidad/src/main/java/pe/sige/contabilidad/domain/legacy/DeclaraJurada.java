package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DECLARA_JURADA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DeclaraJurada")
@Table(name = "declara_jurada")
public class DeclaraJurada extends LegacyEntity {

    @Id
    @Column(name = "codi_decla", nullable = false)
    public Long codiDecla;

    @Column(name = "codi_pers", length = 5)
    public String codiPers;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "fecha_decla")
    public LocalDateTime fechaDecla;

    @Column(name = "direccion", length = 150)
    public String direccion;

    @Column(name = "lugar", length = 50)
    public String lugar;
}
