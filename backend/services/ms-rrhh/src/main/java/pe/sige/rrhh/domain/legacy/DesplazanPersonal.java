package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DESPLAZAN_PERSONAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DesplazanPersonal")
@Table(name = "desplazan_personal")
public class DesplazanPersonal extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codi_desplazan_pers", nullable = false)
    public Integer codiDesplazanPers;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "codi_acti")
    public Short codiActi;

    @Column(name = "fecha_inic")
    public LocalDateTime fechaInic;

    @Column(name = "fecha_fin")
    public LocalDateTime fechaFin;
}
