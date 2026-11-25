package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Recibo_egreso</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ReciboEgreso")
@Table(name = "recibo_egreso")
public class ReciboEgreso extends LegacyEntity {

    /** Legado: Codi_Recibo */
    @Id
    @Column(name = "codi_recibo", length = 6, nullable = false)
    public String codiRecibo;

    /** Legado: Fecha_Recibo */
    @Column(name = "fecha_recibo")
    public LocalDateTime fechaRecibo;

    /** Legado: Fecha */
    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Legado: Nro_Cuen */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    /** Legado: Nro_Docu */
    @Column(name = "nro_docu", length = 20)
    public String nroDocu;

    /** Legado: Importe */
    @Column(name = "importe", precision = 18, scale = 2)
    public BigDecimal importe;

    /** Legado: Importe_d */
    @Column(name = "importe_d", precision = 18, scale = 2)
    public BigDecimal importeD;

    /** Legado: Glosa */
    @Column(name = "glosa", length = 500)
    public String glosa;

    /** Legado: Tipo_Cambio */
    @Column(name = "tipo_cambio", precision = 18, scale = 4)
    public BigDecimal tipoCambio;

    /** Legado: Codi_Pers */
    @Column(name = "codi_pers", length = 5)
    public String codiPers;

    @Column(name = "codi_orde_comp", length = 10)
    public String codiOrdeComp;
}
