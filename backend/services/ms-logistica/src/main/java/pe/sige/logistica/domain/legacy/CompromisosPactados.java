package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.compromisos_pactados</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CompromisosPactados")
@Table(name = "compromisos_pactados")
public class CompromisosPactados extends LegacyEntity {

    @Id
    @Column(name = "codi_comp", nullable = false)
    public Long codiComp;

    @Column(name = "nro_comp")
    public Long nroComp;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "tipo", length = 1)
    public String tipo;

    @Column(name = "observaciones", length = 250)
    public String observaciones;

    @Column(name = "fecha_venc")
    public LocalDateTime fechaVenc;

    @Column(name = "lugar", length = 50)
    public String lugar;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;
}
