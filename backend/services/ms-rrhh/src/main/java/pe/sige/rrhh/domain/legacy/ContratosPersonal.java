package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CONTRATOS_PERSONAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ContratosPersonal")
@Table(name = "contratos_personal")
public class ContratosPersonal extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: CODI_CONT_PERS */
    @Id
    @Column(name = "codi_cont_pers", length = 5, nullable = false)
    public String codiContPers;

    /** Legado: FECH_INIC_CONT */
    @Column(name = "fech_inic_cont", nullable = false)
    public LocalDateTime fechInicCont;

    /** Legado: FECH_FIN_CONT */
    @Column(name = "fech_fin_cont")
    public LocalDateTime fechFinCont;

    /** Legado: FECH_SALI */
    @Column(name = "fech_sali")
    public LocalDateTime fechSali;

    /** Legado: ESTA_CONT */
    @Column(name = "esta_cont")
    public Boolean estaCont;

    /** Legado: SUEL_BASI */
    @Column(name = "suel_basi", precision = 18, scale = 2)
    public BigDecimal suelBasi;

    /** Legado: OBSERVACION */
    @Column(name = "observacion", length = 100)
    public String observacion;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    /** Legado: CODI_CARG */
    @Column(name = "codi_carg", length = 4)
    public String codiCarg;

    /** Legado: TIPO_CONT */
    @Column(name = "tipo_cont", length = 10)
    public String tipoCont;

    /** Legado: GRUP_OCUP */
    @Column(name = "grup_ocup", length = 50)
    public String grupOcup;

    /** Legado: MODA_CONT */
    @Column(name = "moda_cont", length = 50)
    public String modaCont;

    /** Legado: ARTI_MODA */
    @Column(name = "arti_moda", length = 6)
    public String artiModa;

    /** Legado: COMP_ASEG */
    @Column(name = "comp_aseg", length = 150)
    public String compAseg;

    /** Legado: TIPO_PRAC */
    @Column(name = "tipo_prac", length = 20)
    public String tipoPrac;

    /** Legado: CENT_ESTU_PRAC */
    @Column(name = "cent_estu_prac", length = 150)
    public String centEstuPrac;

    /** Legado: HORA_LABO_DIAR */
    @Column(name = "hora_labo_diar")
    public Short horaLaboDiar;

    /** Legado: HORA_PRAC */
    @Column(name = "hora_prac")
    public Short horaPrac;

    /** Legado: HORA_TEOR */
    @Column(name = "hora_teor")
    public Short horaTeor;

    /** Legado: HORA_ENTR_1 */
    @Column(name = "hora_entr_1")
    public LocalDateTime horaEntr1;

    /** Legado: HORA_SALI_1 */
    @Column(name = "hora_sali_1")
    public LocalDateTime horaSali1;

    /** Legado: HORA_ENTR_2 */
    @Column(name = "hora_entr_2")
    public LocalDateTime horaEntr2;

    /** Legado: HORA_SALI_2 */
    @Column(name = "hora_sali_2")
    public LocalDateTime horaSali2;

    /** Legado: TITU_PRAC */
    @Column(name = "titu_prac", length = 250)
    public String tituPrac;

    /** Legado: HORA_DIAS */
    @Column(name = "hora_dias", length = 250)
    public String horaDias;

    /** Legado: DENO_CENT_ESTU_PRAC */
    @Column(name = "deno_cent_estu_prac", length = 50)
    public String denoCentEstuPrac;

    /** Legado: FECH_PRES_PRAC */
    @Column(name = "fech_pres_prac")
    public LocalDateTime fechPresPrac;

    /** Legado: TIEM_DURA */
    @Column(name = "tiem_dura", length = 100)
    public String tiemDura;
}
