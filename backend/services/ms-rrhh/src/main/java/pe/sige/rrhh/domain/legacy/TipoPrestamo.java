package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TIPO_PRESTAMO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoPrestamo")
@Table(name = "tipo_prestamo")
public class TipoPrestamo extends LegacyEntity {

    /** Legado: CODI_TIPO_PRES */
    @Id
    @Column(name = "codi_tipo_pres", length = 2, nullable = false)
    public String codiTipoPres;

    /** Legado: DESC_TIPO_PRES */
    @Column(name = "desc_tipo_pres", length = 50)
    public String descTipoPres;

    /** Legado: NEMO_TIPO_PRES */
    @Column(name = "nemo_tipo_pres", length = 10)
    public String nemoTipoPres;
}
