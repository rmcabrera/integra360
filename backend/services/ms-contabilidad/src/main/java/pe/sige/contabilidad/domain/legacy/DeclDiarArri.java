package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DECL_DIAR_ARRI</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DeclDiarArri")
@Table(name = "decl_diar_arri")
public class DeclDiarArri extends LegacyEntity {

    /** Legado: CODI_DECL_DIAR_ARRI */
    @Id
    @Column(name = "codi_decl_diar_arri", length = 10, nullable = false)
    public String codiDeclDiarArri;

    /** Legado: NUME_ARRI */
    @Column(name = "nume_arri", length = 10)
    public String numeArri;

    /** Legado: FECHA */
    @Column(name = "fecha", nullable = false)
    public LocalDateTime fecha;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    /** Legado: NRO_MATRI */
    @Column(name = "nro_matri", length = 15)
    public String nroMatri;

    /** Legado: CODI_DECL_DIAR_ZARP */
    @Column(name = "codi_decl_diar_zarp", length = 10)
    public String codiDeclDiarZarp;

    /** Legado: CODI_PUER_ARRI */
    @Column(name = "codi_puer_arri", length = 2)
    public String codiPuerArri;

    /** Legado: FECH_ARRI */
    @Column(name = "fech_arri")
    public LocalDateTime fechArri;

    /** Legado: ZONA_PESC */
    @Column(name = "zona_pesc", length = 100)
    public String zonaPesc;

    /** Legado: LATITUD */
    @Column(name = "latitud", length = 20)
    public String latitud;

    /** Legado: LONGITUD */
    @Column(name = "longitud", length = 20)
    public String longitud;

    /** Legado: TIEMPO */
    @Column(name = "tiempo", length = 20)
    public String tiempo;

    /** Legado: TIEM_NAVE */
    @Column(name = "tiem_nave", length = 100)
    public String tiemNave;

    /** Legado: CODI_ESPE_1 */
    @Column(name = "codi_espe_1", length = 2)
    public String codiEspe1;

    /** Legado: CODI_ESPE_2 */
    @Column(name = "codi_espe_2", length = 2)
    public String codiEspe2;

    /** Legado: CODI_ESPE_3 */
    @Column(name = "codi_espe_3", length = 2)
    public String codiEspe3;

    /** Legado: CANT_ESPE_1 */
    @Column(name = "cant_espe_1", precision = 9, scale = 4)
    public BigDecimal cantEspe1;

    /** Legado: CANT_ESPE_2 */
    @Column(name = "cant_espe_2", precision = 9, scale = 4)
    public BigDecimal cantEspe2;

    /** Legado: CANT_ESPE_3 */
    @Column(name = "cant_espe_3", precision = 9, scale = 4)
    public BigDecimal cantEspe3;

    /** Legado: CODI_PLAN_DESC */
    @Column(name = "codi_plan_desc", length = 5)
    public String codiPlanDesc;

    /** Legado: CODI_PLAN_COMP */
    @Column(name = "codi_plan_comp", length = 5)
    public String codiPlanComp;

    /** Legado: OBSE_1 */
    @Column(name = "obse_1", length = 150)
    public String obse1;

    /** Legado: OBSE_2 */
    @Column(name = "obse_2", length = 150)
    public String obse2;

    /** Legado: OBSE_3 */
    @Column(name = "obse_3", length = 150)
    public String obse3;

    /** Legado: OBSE_4 */
    @Column(name = "obse_4", length = 150)
    public String obse4;

    /** Legado: OBSE_5 */
    @Column(name = "obse_5", length = 150)
    public String obse5;

    /** Legado: OBSE_6 */
    @Column(name = "obse_6", length = 150)
    public String obse6;

    /** Legado: OBSE_7 */
    @Column(name = "obse_7", length = 150)
    public String obse7;

    /** Legado: OBSE_8 */
    @Column(name = "obse_8", length = 150)
    public String obse8;

    /** Legado: CODI_PATR */
    @Column(name = "codi_patr", length = 5)
    public String codiPatr;
}
