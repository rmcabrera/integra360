package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.cabecera_detraccion</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CabeceraDetraccion")
@Table(name = "cabecera_detraccion")
public class CabeceraDetraccion extends LegacyEntity {

    @Id
    @Column(name = "codi_lote_detr", length = 10, nullable = false)
    public String codiLoteDetr;

    /** Legado: Nro_lote_detrac */
    @Column(name = "nro_lote_detrac", length = 6, nullable = false)
    public String nroLoteDetrac;

    /** Legado: Importe */
    @Column(name = "importe", precision = 15, scale = 2)
    public BigDecimal importe;

    @Column(name = "anio", length = 4)
    public String anio;

    @Column(name = "nro")
    public Integer nro;

    @Column(name = "fech_gene")
    public LocalDateTime fechGene;

    @Column(name = "mes", length = 2)
    public String mes;
}
