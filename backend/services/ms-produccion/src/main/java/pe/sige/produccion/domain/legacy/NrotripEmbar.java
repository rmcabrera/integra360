package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.NroTrip_Embar</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "NrotripEmbar")
@Table(name = "nrotrip_embar")
public class NrotripEmbar extends LegacyEntity {

    @Id
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    @Column(name = "nro_trip", nullable = false)
    public Integer nroTrip;
}
