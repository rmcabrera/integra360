package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.acta_entrega</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ActaEntrega")
@Table(name = "acta_entrega")
public class ActaEntrega extends LegacyEntity {

    @Id
    @Column(name = "codi_act", nullable = false)
    public Long codiAct;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "nro")
    public Long nro;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "persona_responsable", length = 200)
    public String personaResponsable;

    @Column(name = "dni", length = 15)
    public String dni;

    @Column(name = "domicilio", length = 200)
    public String domicilio;
}
