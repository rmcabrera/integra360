package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SISTEMA_PENSIONES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SistemaPensiones")
@Table(name = "sistema_pensiones")
public class SistemaPensiones extends LegacyEntity {

    /** Legado: CODI_SIST_PENS */
    @Id
    @Column(name = "codi_sist_pens", length = 2, nullable = false)
    public String codiSistPens;

    /** Legado: DESC_SIST_PENS */
    @Column(name = "desc_sist_pens", length = 50)
    public String descSistPens;

    /** Legado: NEMO */
    @Column(name = "nemo", length = 10)
    public String nemo;

    /** Legado: CODI_RELA */
    @Column(name = "codi_rela", length = 5)
    public String codiRela;

    @Column(name = "codi_pension")
    public Short codiPension;

    @Column(name = "afpnet", length = 2)
    public String afpnet;
}
