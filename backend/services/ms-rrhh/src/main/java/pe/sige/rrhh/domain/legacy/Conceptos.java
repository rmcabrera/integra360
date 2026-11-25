package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CONCEPTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Conceptos")
@Table(name = "conceptos")
public class Conceptos extends LegacyEntity {

    /** Legado: CODI_CONC */
    @Id
    @Column(name = "codi_conc", length = 6, nullable = false)
    public String codiConc;

    /** Legado: DESC_CONC */
    @Column(name = "desc_conc", length = 60)
    public String descConc;

    /** Legado: ESTA_ACTI */
    @Column(name = "esta_acti")
    public Boolean estaActi;

    /** Legado: NEMO */
    @Column(name = "nemo", length = 20)
    public String nemo;

    /** Legado: Codi_Sub_Concep_Sunat */
    @Column(name = "codi_sub_concep_sunat")
    public Short codiSubConcepSunat;

    /** Legado: VARIABLE */
    @Column(name = "variable", length = 3)
    public String variable;
}
