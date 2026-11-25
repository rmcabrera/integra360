package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PERSONAL_VALORES_DEFECTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PersonalValoresDefecto")
@Table(name = "personal_valores_defecto")
public class PersonalValoresDefecto extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    /** Legado: CODI_TIPO_DOCU */
    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    /** Legado: CODI_SIST_PENS */
    @Column(name = "codi_sist_pens", length = 2)
    public String codiSistPens;

    /** Legado: CODI_CARG */
    @Column(name = "codi_carg", length = 4)
    public String codiCarg;

    /** Legado: CODI_AREA */
    @Column(name = "codi_area", length = 2)
    public String codiArea;

    /** Legado: CODI_MONE_BASI */
    @Column(name = "codi_mone_basi", length = 2)
    public String codiMoneBasi;

    /** Legado: ESSALUD */
    @Column(name = "essalud")
    public Boolean essalud;

    /** Legado: ESTA_CIVI */
    @Column(name = "esta_civi", length = 1)
    public String estaCivi;

    /** Legado: ESTA_ACTI */
    @Column(name = "esta_acti")
    public Boolean estaActi;

    /** Legado: SCRT */
    @Column(name = "scrt")
    public Boolean scrt;

    /** Legado: COMI_PESC */
    @Column(name = "comi_pesc")
    public Boolean comiPesc;

    /** Legado: AFIL_SIND */
    @Column(name = "afil_sind")
    public Boolean afilSind;

    /** Legado: TIPO_CONT */
    @Column(name = "tipo_cont", length = 2)
    public String tipoCont;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: CARG_FAMI */
    @Column(name = "carg_fami")
    public Boolean cargFami;

    /** Legado: SEXO */
    @Column(name = "sexo", length = 1)
    public String sexo;

    /** Legado: TIPO_SITU_LABO */
    @Column(name = "tipo_situ_labo", length = 1)
    public String tipoSituLabo;

    /** Legado: SEGU_VIDA_LEY */
    @Column(name = "segu_vida_ley")
    public Boolean seguVidaLey;

    /** Legado: JUBILADO */
    @Column(name = "jubilado")
    public Boolean jubilado;

    /** Legado: FORM_PAGO */
    @Column(name = "form_pago", length = 20)
    public String formPago;

    /** Legado: HORA_LABO */
    @Column(name = "hora_labo", precision = 9, scale = 2)
    public BigDecimal horaLabo;

    /** Legado: CODI_TIPO_RIES */
    @Column(name = "codi_tipo_ries", length = 2)
    public String codiTipoRies;

    /** Legado: FOTO_SI_NO */
    @Column(name = "foto_si_no")
    public Boolean fotoSiNo;

    /** Legado: HORA_AUTO */
    @Column(name = "hora_auto", precision = 9, scale = 2)
    public BigDecimal horaAuto;

    /** Legado: GRAT */
    @Column(name = "grat")
    public Boolean grat;

    /** Legado: VACA */
    @Column(name = "vaca")
    public Boolean vaca;

    @Column(name = "codi_luga_trab", length = 2)
    public String codiLugaTrab;

    /** Legado: AFECTO_LEY */
    @Column(name = "afecto_ley")
    public Boolean afectoLey;

    @Column(name = "fotocheck")
    public Integer fotocheck;

    @Column(name = "horario")
    public Short horario;

    /** Legado: CODI_CATE_TRAB */
    @Column(name = "codi_cate_trab")
    public Short codiCateTrab;

    @Column(name = "apor_essa")
    public Boolean aporEssa;

    @Column(name = "apor_sena")
    public Boolean aporSena;

    @Column(name = "apor_senc")
    public Boolean aporSenc;

    @Column(name = "apor_cona")
    public Boolean aporCona;

    /** Legado: Codi_Elem_Costo */
    @Column(name = "codi_elem_costo")
    public Short codiElemCosto;

    /** Legado: Codi_Tipo_Docu_Iden */
    @Column(name = "codi_tipo_docu_iden")
    public Short codiTipoDocuIden;

    /** Legado: Codi_Nacion */
    @Column(name = "codi_nacion")
    public Short codiNacion;

    /** Legado: Codi_Ubi_Dist */
    @Column(name = "codi_ubi_dist")
    public Short codiUbiDist;

    /** Legado: Condi_Domi */
    @Column(name = "condi_domi")
    public Short condiDomi;

    /** Legado: Codi_Pension */
    @Column(name = "codi_pension")
    public Short codiPension;

    /** Legado: Codi_Situ_Trab_Pens */
    @Column(name = "codi_situ_trab_pens")
    public Short codiSituTrabPens;

    /** Legado: Codi_Moti_Fin_Peri */
    @Column(name = "codi_moti_fin_peri")
    public Short codiMotiFinPeri;

    @Column(name = "labora_sabado", length = 1)
    public String laboraSabado;

    /** Legado: Regi_Labo */
    @Column(name = "regi_labo")
    public Short regiLabo;

    @Column(name = "infor_otros_ingr_qta_cat")
    public Short inforOtrosIngrQtaCat;

    @Column(name = "renta_qta_cat_exo_inaf")
    public Short rentaQtaCatExoInaf;

    @Column(name = "afi_eps_serv_prop")
    public Short afiEpsServProp;

    @Column(name = "sujeto_jornada_max")
    public Short sujetoJornadaMax;

    /** Legado: Codi_Periodo */
    @Column(name = "codi_periodo")
    public Short codiPeriodo;

    @Column(name = "sctr_pension")
    public Short sctrPension;

    @Column(name = "sctr_salud")
    public Short sctrSalud;
}
