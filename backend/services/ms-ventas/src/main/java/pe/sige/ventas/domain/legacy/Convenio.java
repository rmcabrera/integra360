package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.convenio</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Convenio")
@Table(name = "convenio")
public class Convenio extends LegacyEntity {

    @Id
    @Column(name = "codi_conv", nullable = false)
    public Long codiConv;

    @Column(name = "codi_fact", length = 10)
    public String codiFact;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "nro")
    public Long nro;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "estado", length = 1)
    public String estado;
}
