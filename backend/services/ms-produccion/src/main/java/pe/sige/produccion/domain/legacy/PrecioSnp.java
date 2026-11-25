package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PRECIO_SNP</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PrecioSnp")
@Table(name = "precio_snp")
public class PrecioSnp extends LegacyEntity {

    /** Legado: CODI_PREC */
    @Id
    @Column(name = "codi_prec", length = 10, nullable = false)
    public String codiPrec;

    /** Legado: CODI_SEMA */
    @Column(name = "codi_sema", length = 8, nullable = false)
    public String codiSema;

    /** Legado: CODI_ESPE */
    @Column(name = "codi_espe", length = 2)
    public String codiEspe;

    /** Legado: PRECIO */
    @Column(name = "precio", precision = 12, scale = 3, nullable = false)
    public BigDecimal precio;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2, nullable = false)
    public String codiMone;

    /** Legado: JUEVES */
    @Column(name = "jueves", precision = 18, scale = 2)
    public BigDecimal jueves;

    /** Legado: VIERNES */
    @Column(name = "viernes", precision = 18, scale = 2)
    public BigDecimal viernes;

    /** Legado: SABADO */
    @Column(name = "sabado", precision = 18, scale = 2)
    public BigDecimal sabado;

    /** Legado: DOMINGO */
    @Column(name = "domingo", precision = 18, scale = 2)
    public BigDecimal domingo;

    /** Legado: LUNES */
    @Column(name = "lunes", precision = 18, scale = 2)
    public BigDecimal lunes;

    /** Legado: MARTES */
    @Column(name = "martes", precision = 18, scale = 2)
    public BigDecimal martes;

    /** Legado: MIERCOLES */
    @Column(name = "miercoles", precision = 18, scale = 2)
    public BigDecimal miercoles;
}
