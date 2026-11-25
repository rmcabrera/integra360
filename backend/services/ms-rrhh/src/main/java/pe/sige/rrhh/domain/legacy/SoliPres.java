package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SOLI_PRES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SoliPres")
@Table(name = "soli_pres")
public class SoliPres extends LegacyEntity {

    /** Legado: CODI_SOLI_PRES */
    @Id
    @Column(name = "codi_soli_pres", length = 10, nullable = false)
    public String codiSoliPres;

    /** Legado: NRO_SOLI_PRES */
    @Column(name = "nro_soli_pres")
    public Integer nroSoliPres;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5)
    public String codiPers;

    /** Legado: FECH_SOLI */
    @Column(name = "fech_soli")
    public LocalDateTime fechSoli;

    /** Legado: IMPO_SOLI */
    @Column(name = "impo_soli", precision = 15, scale = 4)
    public BigDecimal impoSoli;

    /** Legado: SITU_ACTU */
    @Column(name = "situ_actu", length = 50)
    public String situActu;

    /** Legado: CODI_USUA_DATO */
    @Column(name = "codi_usua_dato", length = 5)
    public String codiUsuaDato;

    /** Legado: FECH_REGI_DATO */
    @Column(name = "fech_regi_dato")
    public LocalDateTime fechRegiDato;

    /** Legado: IMPO_OTOR */
    @Column(name = "impo_otor", precision = 15, scale = 4)
    public BigDecimal impoOtor;

    /** Legado: FORM_DESC */
    @Column(name = "form_desc", length = 50)
    public String formDesc;

    /** Legado: NRO_SEMA_DESC */
    @Column(name = "nro_sema_desc")
    public Short nroSemaDesc;

    /** Legado: PERI_DESC */
    @Column(name = "peri_desc")
    public Integer periDesc;

    /** Legado: MES_DESC */
    @Column(name = "mes_desc")
    public Short mesDesc;

    /** Legado: PLAZ_PAGO */
    @Column(name = "plaz_pago", length = 50)
    public String plazPago;

    /** Legado: FECH_PRIM_PAGO */
    @Column(name = "fech_prim_pago")
    public LocalDateTime fechPrimPago;

    /** Legado: NRO_CUOTAS */
    @Column(name = "nro_cuotas")
    public Short nroCuotas;

    /** Legado: OBSERVACION */
    @Column(name = "observacion", length = 250)
    public String observacion;

    /** Legado: OBSERVACION1 */
    @Column(name = "observacion1", length = 250)
    public String observacion1;

    /** Legado: DESC_PRES */
    @Column(name = "desc_pres", length = 1)
    public String descPres;
}
