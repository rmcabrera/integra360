package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CLASE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Clase")
@Table(name = "clase")
public class Clase extends LegacyEntity {

    /** Legado: Cod_clase */
    @Id
    @Column(name = "cod_clase", length = 3, nullable = false)
    public String codClase;

    /** Legado: Nomb_clase */
    @Column(name = "nomb_clase", length = 40, nullable = false)
    public String nombClase;

    /** Legado: Nomb_grupo */
    @Column(name = "nomb_grupo", length = 10)
    public String nombGrupo;

    /** Legado: Estado */
    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "unidad_negocio", length = 10)
    public String unidadNegocio;

    @Column(name = "modalidad", length = 8)
    public String modalidad;

    /** Legado: Co_Orde_Serv */
    @Column(name = "co_orde_serv", length = 20)
    public String coOrdeServ;
}
