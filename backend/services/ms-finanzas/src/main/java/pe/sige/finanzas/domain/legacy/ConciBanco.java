package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CONCI_BANCO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ConciBanco")
@Table(name = "conci_banco")
public class ConciBanco extends LegacyEntity {

    /** Legado: CODI_CONC_BANC */
    @Id
    @Column(name = "codi_conc_banc", length = 10, nullable = false)
    public String codiConcBanc;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    /** Legado: ANIO */
    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    /** Legado: MES */
    @Column(name = "mes", length = 2, nullable = false)
    public String mes;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: SUBDIA */
    @Column(name = "subdia", length = 2)
    public String subdia;

    /** Legado: COMPR */
    @Column(name = "compr", length = 10)
    public String compr;

    /** Legado: FECHA */
    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Legado: CODI_TIPO_DOCU */
    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    /** Legado: NRO_DOCU */
    @Column(name = "nro_docu", length = 10)
    public String nroDocu;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    /** Legado: GLOSA */
    @Column(name = "glosa", length = 200)
    public String glosa;

    /** Legado: IMPORTE */
    @Column(name = "importe", precision = 18, scale = 4)
    public BigDecimal importe;

    /** Legado: SALDO */
    @Column(name = "saldo", precision = 18, scale = 4)
    public BigDecimal saldo;

    /** Legado: CODI_TIPO_SITU_CONC_BANC */
    @Column(name = "codi_tipo_situ_conc_banc", length = 2)
    public String codiTipoSituConcBanc;

    /** Legado: CARGO_ABONO */
    @Column(name = "cargo_abono", length = 1)
    public String cargoAbono;

    /** Legado: ANIO_DOCU */
    @Column(name = "anio_docu", length = 4)
    public String anioDocu;

    /** Legado: MES_DOCU */
    @Column(name = "mes_docu", length = 2)
    public String mesDocu;

    /** Legado: CODI_CONTABLE */
    @Column(name = "codi_contable", length = 10)
    public String codiContable;
}
