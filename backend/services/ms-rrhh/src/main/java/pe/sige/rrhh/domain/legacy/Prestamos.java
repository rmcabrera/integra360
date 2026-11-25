package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PRESTAMOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Prestamos")
@Table(name = "prestamos")
public class Prestamos extends LegacyEntity {

    /** Legado: CODI_PRES */
    @Id
    @Column(name = "codi_pres", length = 6, nullable = false)
    public String codiPres;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: NRO_PRES */
    @Column(name = "nro_pres", nullable = false)
    public Integer nroPres;

    /** Legado: FECH_PRES */
    @Column(name = "fech_pres", nullable = false)
    public LocalDateTime fechPres;

    /** Legado: MOTI_PRES */
    @Column(name = "moti_pres", length = 100)
    public String motiPres;

    /** Legado: ESTA_ACTI */
    @Column(name = "esta_acti", nullable = false)
    public Boolean estaActi;

    /** Legado: TIPO_DESC */
    @Column(name = "tipo_desc", nullable = false)
    public Boolean tipoDesc;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2, nullable = false)
    public String codiMone;

    /** Legado: MONTO */
    @Column(name = "monto", precision = 12, scale = 2, nullable = false)
    public BigDecimal monto;

    /** Legado: MONT_DESC */
    @Column(name = "mont_desc", precision = 12, scale = 2)
    public BigDecimal montDesc;

    /** Legado: INTE_TIEM_DESC */
    @Column(name = "inte_tiem_desc", length = 20)
    public String inteTiemDesc;

    /** Legado: SALDO */
    @Column(name = "saldo", precision = 12, scale = 2)
    public BigDecimal saldo;

    /** Legado: PRESUPUESTO */
    @Column(name = "presupuesto", length = 10)
    public String presupuesto;

    /** Legado: CODI_BAZA */
    @Column(name = "codi_baza", length = 2)
    public String codiBaza;

    /** Legado: REGISTRO */
    @Column(name = "registro", length = 10)
    public String registro;

    @Column(name = "codi_tipo_pres", length = 2)
    public String codiTipoPres;
}
