package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Parametro</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Parametro")
@Table(name = "parametro")
public class Parametro extends LegacyEntity {

    /** Legado: Cod_Param */
    @Id
    @Column(name = "cod_param", nullable = false)
    public Short codParam;

    /** Legado: Desc_Param */
    @Column(name = "desc_param", length = 75, nullable = false)
    public String descParam;

    /** Legado: Unid_Medi */
    @Column(name = "unid_medi", length = 15)
    public String unidMedi;

    /** Legado: Nemo */
    @Column(name = "nemo", length = 15, nullable = false)
    public String nemo;

    /** Legado: Orden_Repo */
    @Column(name = "orden_repo")
    public Short ordenRepo;

    /** Legado: LimiteMin */
    @Column(name = "limitemin", precision = 18, scale = 2, nullable = false)
    public BigDecimal limitemin;

    /** Legado: LimiteMax */
    @Column(name = "limitemax", precision = 18, scale = 2, nullable = false)
    public BigDecimal limitemax;

    /** el valor optimo es hacia 1 arriba 0 abajo */
    @Column(name = "optimo", nullable = false)
    public Short optimo;

    /** Legado: Codi_Prod */
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    /** 0 valor 1 porcentaje */
    @Column(name = "tipo", nullable = false)
    public Short tipo;

    /** Legado: Calculable */
    @Column(name = "calculable", nullable = false)
    public Short calculable;
}
