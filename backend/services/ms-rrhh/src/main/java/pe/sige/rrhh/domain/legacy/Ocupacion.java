package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.OCUPACION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Ocupacion")
@Table(name = "ocupacion")
public class Ocupacion extends LegacyEntity {

    /** Legado: Codi_Ocu */
    @Id
    @Column(name = "codi_ocu", nullable = false)
    public Short codiOcu;

    /** Legado: Codi_Ocu_Sunat */
    @Column(name = "codi_ocu_sunat", length = 6, nullable = false)
    public String codiOcuSunat;

    /** Legado: Desc_Ocu */
    @Column(name = "desc_ocu", length = 250)
    public String descOcu;

    /** Legado: Nemo_Ocu */
    @Column(name = "nemo_ocu", length = 30)
    public String nemoOcu;
}
