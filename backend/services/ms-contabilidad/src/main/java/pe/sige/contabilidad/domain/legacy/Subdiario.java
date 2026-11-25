package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SUBDIARIO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Subdiario")
@Table(name = "subdiario")
public class Subdiario extends LegacyEntity {

    /** Legado: CODI_SUBD */
    @Id
    @Column(name = "codi_subd", length = 2, nullable = false)
    public String codiSubd;

    /** Legado: NEMOTEC */
    @Column(name = "nemotec", length = 1)
    public String nemotec;

    /** Legado: DESCRIP */
    @Column(name = "descrip", length = 40)
    public String descrip;

    /** Legado: ORDEN */
    @Column(name = "orden")
    public Integer orden;

    /** Legado: CENTRAL */
    @Column(name = "central", length = 1)
    public String central;

    @Column(name = "codi_libro")
    public Integer codiLibro;
}
