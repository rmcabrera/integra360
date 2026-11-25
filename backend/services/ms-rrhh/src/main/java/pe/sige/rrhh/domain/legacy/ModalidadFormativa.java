package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.MODALIDAD_FORMATIVA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ModalidadFormativa")
@Table(name = "modalidad_formativa")
public class ModalidadFormativa extends LegacyEntity {

    /** Legado: Codi_Moda_Forma */
    @Id
    @Column(name = "codi_moda_forma", nullable = false)
    public Short codiModaForma;

    /** Legado: Codi_Moda_Forma_Sunat */
    @Column(name = "codi_moda_forma_sunat", length = 2, nullable = false)
    public String codiModaFormaSunat;

    /** Legado: Desc_Moda_Forma */
    @Column(name = "desc_moda_forma", length = 100, nullable = false)
    public String descModaForma;
}
