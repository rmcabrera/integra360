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
 * Tabla legado <b>dbo.DESPLAZO_PERSONAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DesplazoPersonal")
@Table(name = "desplazo_personal")
public class DesplazoPersonal extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codi_despla_pers", nullable = false)
    public Integer codiDesplaPers;

    @Column(name = "fecha_inicio")
    public LocalDateTime fechaInicio;

    @Column(name = "fecha_fin")
    public LocalDateTime fechaFin;

    @Column(name = "codi_estable", length = 4)
    public String codiEstable;

    @Column(name = "indicador", length = 1)
    public String indicador;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "codi_acti")
    public Short codiActi;
}
