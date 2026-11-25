package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PERSONAL_OTROS_EMPLE_QTA_CAT</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PersonalOtrosEmpleQtaCat")
@Table(name = "personal_otros_emple_qta_cat")
public class PersonalOtrosEmpleQtaCat extends LegacyEntity {

    @Id
    @Column(name = "codi_poe", nullable = false)
    public Long codiPoe;

    @Column(name = "codi_pers_categ", nullable = false)
    public Long codiPersCateg;

    @Column(name = "ruc", length = 11, nullable = false)
    public String ruc;

    @Column(name = "razon_social", length = 60, nullable = false)
    public String razonSocial;
}
