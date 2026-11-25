package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PERSONAL_CATEGORIA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PersonalCategoria")
@Table(name = "personal_categoria")
public class PersonalCategoria extends LegacyEntity {

    /** Legado: CODI_PERS_CATEG */
    @Id
    @Column(name = "codi_pers_categ", nullable = false)
    public Long codiPersCateg;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    @Column(name = "tipo_cat_trab", length = 1)
    public String tipoCatTrab;

    @Column(name = "essalud")
    public Short essalud;

    /** Legado: RUC */
    @Column(name = "ruc", length = 11)
    public String ruc;

    /** Legado: Codi_Elem_Costo */
    @Column(name = "codi_elem_costo")
    public Short codiElemCosto;

    /** Legado: Codi_Tipo_Docu_Iden */
    @Column(name = "codi_tipo_docu_iden")
    public Short codiTipoDocuIden;

    /** Legado: Codi_Tipo_Cont */
    @Column(name = "codi_tipo_cont")
    public Short codiTipoCont;

    /** Legado: Condi_Domi */
    @Column(name = "condi_domi")
    public Short condiDomi;

    /** Legado: Codi_Tipo_Pers */
    @Column(name = "codi_tipo_pers")
    public Short codiTipoPers;

    /** Legado: Codi_Nivel */
    @Column(name = "codi_nivel")
    public Short codiNivel;

    /** Legado: Codi_Ocu */
    @Column(name = "codi_ocu")
    public Short codiOcu;

    /** Legado: Discapacidad */
    @Column(name = "discapacidad")
    public Short discapacidad;

    /** Legado: Codi_Pension */
    @Column(name = "codi_pension")
    public Short codiPension;

    /** Legado: FECH_INGRE */
    @Column(name = "fech_ingre")
    public LocalDateTime fechIngre;

    /** Legado: NRO_CUPSS */
    @Column(name = "nro_cupss", length = 20)
    public String nroCupss;

    /** Legado: SCRT */
    @Column(name = "scrt")
    public Short scrt;

    /** Legado: SCTR_PENSION */
    @Column(name = "sctr_pension")
    public Short sctrPension;

    @Column(name = "sujeto_reg_alter")
    public Short sujetoRegAlter;

    @Column(name = "sujeto_jornada_max")
    public Short sujetoJornadaMax;

    @Column(name = "horario_noctur")
    public Short horarioNoctur;

    /** Legado: Sindicalizado */
    @Column(name = "sindicalizado")
    public Short sindicalizado;

    /** Legado: Codi_Periodo */
    @Column(name = "codi_periodo")
    public Short codiPeriodo;

    /** Legado: Codi_Enti */
    @Column(name = "codi_enti")
    public Short codiEnti;

    /** Legado: Codi_Situ_Trab_Pens */
    @Column(name = "codi_situ_trab_pens")
    public Short codiSituTrabPens;

    @Column(name = "renta_qta_cat_exo_inaf")
    public Short rentaQtaCatExoInaf;

    /** Legado: Regi_Labo */
    @Column(name = "regi_labo")
    public Short regiLabo;

    @Column(name = "form_pago", length = 20)
    public String formPago;

    @Column(name = "tipo_seg_med")
    public Short tipoSegMed;

    @Column(name = "madre_resp_fam")
    public Short madreRespFam;

    @Column(name = "centro_form_prof")
    public Short centroFormProf;

    @Column(name = "codi_cate_trab")
    public Short codiCateTrab;

    /** Legado: CODI_SIST_PENS */
    @Column(name = "codi_sist_pens", length = 2)
    public String codiSistPens;

    @Column(name = "infor_otros_ingr_qta_cat")
    public Short inforOtrosIngrQtaCat;

    @Column(name = "afi_eps_serv_prop")
    public Short afiEpsServProp;

    @Column(name = "codi_tipo_medio_pago")
    public Short codiTipoMedioPago;

    @Column(name = "cod_categ_ocup")
    public Integer codCategOcup;

    @Column(name = "cod_conv_evita_dob_tribu")
    public Integer codConvEvitaDobTribu;

    @Column(name = "afilia_asegura_pension")
    public Integer afiliaAseguraPension;

    @Column(name = "codi_regi_labo", length = 2)
    public String codiRegiLabo;

    @Column(name = "afp_mixta")
    public Integer afpMixta;
}
