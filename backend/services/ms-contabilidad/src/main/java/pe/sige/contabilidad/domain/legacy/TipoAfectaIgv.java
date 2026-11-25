package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_AFECTA_IGV</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoAfectaIgv")
@Table(name = "tipo_afecta_igv")
public class TipoAfectaIgv extends LegacyEntity {

    @Id
    @Column(name = "codi_tipo_afec", length = 2, nullable = false)
    public String codiTipoAfec;

    /** Legado: desc_tipo_Afec */
    @Column(name = "desc_tipo_afec", length = 150)
    public String descTipoAfec;

    @Column(name = "tipo_afec", length = 50)
    public String tipoAfec;

    @Column(name = "cod_imp")
    public Integer codImp;
}
