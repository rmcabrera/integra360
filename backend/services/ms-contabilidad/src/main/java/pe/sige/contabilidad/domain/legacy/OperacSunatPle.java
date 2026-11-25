package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.OPERAC_SUNAT_PLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "OperacSunatPle")
@Table(name = "operac_sunat_ple")
public class OperacSunatPle extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_sec", nullable = false)
    public Integer idSec;

    @Column(name = "anio")
    public Integer anio;

    @Column(name = "mes")
    public Integer mes;

    @Column(name = "compr", length = 10)
    public String compr;

    @Column(name = "anio_regis", length = 4)
    public String anioRegis;

    @Column(name = "mes_regis", length = 2)
    public String mesRegis;

    @Column(name = "subdia_regis", length = 1)
    public String subdiaRegis;

    @Column(name = "estado", length = 1)
    public String estado;
}
