package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CARGOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Cargos")
@Table(name = "cargos")
public class Cargos extends LegacyEntity {

    /** Legado: CODI_CARG */
    @Id
    @Column(name = "codi_carg", length = 4, nullable = false)
    public String codiCarg;

    /** Legado: TIPO_CARG */
    @Column(name = "tipo_carg", length = 50)
    public String tipoCarg;

    /** Legado: DESC_CARGO */
    @Column(name = "desc_cargo", length = 150)
    public String descCargo;

    /** Legado: Abrev */
    @Column(name = "abrev", length = 2)
    public String abrev;

    @Column(name = "carg_mostrar", length = 100)
    public String cargMostrar;

    @Column(name = "jera")
    public Short jera;

    @Column(name = "codi_ocu")
    public Short codiOcu;
}
