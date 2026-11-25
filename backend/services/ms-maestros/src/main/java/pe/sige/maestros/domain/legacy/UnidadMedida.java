package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.UNIDAD_MEDIDA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "UnidadMedida")
@Table(name = "unidad_medida")
public class UnidadMedida extends LegacyEntity {

    /** Legado: CODI_UNID_MEDI */
    @Id
    @Column(name = "codi_unid_medi", length = 2, nullable = false)
    public String codiUnidMedi;

    /** Legado: DESC_UNID_MEDI */
    @Column(name = "desc_unid_medi", length = 100)
    public String descUnidMedi;

    /** Legado: TIPO_UNID_MEDI */
    @Column(name = "tipo_unid_medi", length = 50)
    public String tipoUnidMedi;

    /** Legado: SIMB_UNID_MEDI */
    @Column(name = "simb_unid_medi", length = 3)
    public String simbUnidMedi;

    /** Legado: CODI_SUNAT */
    @Column(name = "codi_sunat", length = 2, nullable = false)
    public String codiSunat;

    @Column(name = "unid_medi_inte", length = 3)
    public String unidMediInte;
}
