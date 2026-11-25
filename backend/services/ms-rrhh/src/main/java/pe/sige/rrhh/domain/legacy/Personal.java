package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PERSONAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Personal")
@Table(name = "personal")
public class Personal extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: CODI_TIPO_DOCU */
    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    /** Legado: NRO_DOCU_IDEN */
    @Column(name = "nro_docu_iden", length = 20)
    public String nroDocuIden;

    /** Legado: APEL_1 */
    @Column(name = "apel_1", length = 50)
    public String apel1;

    /** Legado: APEL_2 */
    @Column(name = "apel_2", length = 50)
    public String apel2;

    /** Legado: NOMB_1 */
    @Column(name = "nomb_1", length = 50)
    public String nomb1;

    /** Legado: NOMB_2 */
    @Column(name = "nomb_2", length = 50)
    public String nomb2;

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

    /** Legado: SUEL_BASI */
    @Column(name = "suel_basi", precision = 18, scale = 2)
    public BigDecimal suelBasi;

    /** Legado: FECH_INGRE */
    @Column(name = "fech_ingre")
    public LocalDateTime fechIngre;

    /** Legado: ESSALUD */
    @Column(name = "essalud")
    public Boolean essalud;

    /** Legado: CARN_ESSALUD */
    @Column(name = "carn_essalud", length = 30)
    public String carnEssalud;

    /** Legado: ESTA_CIVI */
    @Column(name = "esta_civi", length = 1)
    public String estaCivi;

    /** Legado: FECH_NACI */
    @Column(name = "fech_naci")
    public LocalDateTime fechNaci;

    /** Legado: ASIG_FAMI */
    @Column(name = "asig_fami")
    public Boolean asigFami;

    /** Legado: ESTA_ACTI */
    @Column(name = "esta_acti", nullable = false)
    public Boolean estaActi;

    /** Legado: SCRT */
    @Column(name = "scrt")
    public Boolean scrt;

    /** Legado: COMI_PESC */
    @Column(name = "comi_pesc")
    public Boolean comiPesc;

    /** Legado: NRO_CUPSS */
    @Column(name = "nro_cupss", length = 20)
    public String nroCupss;

    /** Legado: AFIL_SIND */
    @Column(name = "afil_sind")
    public Boolean afilSind;

    /** Legado: NRO_CENSO */
    @Column(name = "nro_censo", length = 20)
    public String nroCenso;

    /** Legado: TIPO_CONT */
    @Column(name = "tipo_cont", length = 1)
    public String tipoCont;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Legado: SUEL_NETO */
    @Column(name = "suel_neto", precision = 18, scale = 2)
    public BigDecimal suelNeto;

    /** Legado: CARG_FAMI */
    @Column(name = "carg_fami")
    public Boolean cargFami;

    /** Legado: SEXO */
    @Column(name = "sexo", length = 1)
    public String sexo;

    /** Legado: NACIONALIDAD */
    @Column(name = "nacionalidad", length = 50)
    public String nacionalidad;

    /** Legado: DIRECCION */
    @Column(name = "direccion", length = 150)
    public String direccion;

    /** Legado: E_MAIL */
    @Column(name = "e_mail", length = 50)
    public String eMail;

    /** Legado: TIPO_SITU_LABO */
    @Column(name = "tipo_situ_labo", length = 1)
    public String tipoSituLabo;

    /** Legado: SEGU_VIDA_LEY */
    @Column(name = "segu_vida_ley")
    public Boolean seguVidaLey;

    /** Legado: NRO_LIB_EMB */
    @Column(name = "nro_lib_emb", length = 15)
    public String nroLibEmb;

    /** Legado: FECH_CESE */
    @Column(name = "fech_cese")
    public LocalDateTime fechCese;

    /** Legado: CLAVE */
    @Column(name = "clave", length = 4)
    public String clave;

    /** Legado: JUBILADO */
    @Column(name = "jubilado", nullable = false)
    public Boolean jubilado;

    /** Legado: FORM_PAGO */
    @Column(name = "form_pago", length = 20)
    public String formPago;

    /** Legado: CODI_ANTI */
    @Column(name = "codi_anti", length = 10)
    public String codiAnti;

    /** Legado: MONT_PAGO_COME */
    @Column(name = "mont_pago_come", precision = 9, scale = 2)
    public BigDecimal montPagoCome;

    /** Legado: HORA_LABO */
    @Column(name = "hora_labo", precision = 9, scale = 2)
    public BigDecimal horaLabo;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    /** Legado: FECH_INIC_JUBI */
    @Column(name = "fech_inic_jubi")
    public LocalDateTime fechInicJubi;

    /** Legado: CODI_RELA */
    @Column(name = "codi_rela", length = 5)
    public String codiRela;

    /** Legado: MOTI_CESE */
    @Column(name = "moti_cese", length = 200)
    public String motiCese;

    /** Legado: PROVINCIA */
    @Column(name = "provincia", length = 70)
    public String provincia;

    /** Legado: DISTRITO */
    @Column(name = "distrito", length = 30)
    public String distrito;

    /** Legado: VCMTO */
    @Column(name = "vcmto")
    public LocalDateTime vcmto;

    /** Legado: DEPARTAMENTO */
    @Column(name = "departamento", length = 60)
    public String departamento;

    /** Legado: OBSERVACIONES */
    @Column(name = "observaciones", length = 200)
    public String observaciones;

    /** Legado: CODI_TIPO_RIES */
    @Column(name = "codi_tipo_ries", length = 2)
    public String codiTipoRies;

    /** Legado: UBIGEO */
    @Column(name = "ubigeo", length = 10)
    public String ubigeo;

    /** Legado: FOTO_SI_NO */
    @Column(name = "foto_si_no")
    public Boolean fotoSiNo;

    /** Legado: FECH_INIC_AFIL */
    @Column(name = "fech_inic_afil")
    public LocalDateTime fechInicAfil;

    /** Legado: DIST_NACI */
    @Column(name = "dist_naci", length = 100)
    public String distNaci;

    /** Legado: PROV_NACI */
    @Column(name = "prov_naci", length = 100)
    public String provNaci;

    /** Legado: CODI_AREA_GRUP */
    @Column(name = "codi_area_grup", length = 2)
    public String codiAreaGrup;

    /** Legado: CODI_SUB_AREA_GRUP */
    @Column(name = "codi_sub_area_grup", length = 4)
    public String codiSubAreaGrup;

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

    @Column(name = "tipo_sangr", length = 5)
    public String tipoSangr;

    @Column(name = "peso_kilo", precision = 9, scale = 2)
    public BigDecimal pesoKilo;

    @Column(name = "tall_metr", precision = 9, scale = 2)
    public BigDecimal tallMetr;

    /** Legado: Codi_Elem_Costo */
    @Column(name = "codi_elem_costo")
    public Short codiElemCosto;

    /** Legado: Codi_Tipo_Docu_Iden */
    @Column(name = "codi_tipo_docu_iden")
    public Short codiTipoDocuIden;

    /** Legado: Codi_Nacion */
    @Column(name = "codi_nacion")
    public Short codiNacion;

    /** Legado: Codi_Via */
    @Column(name = "codi_via")
    public Short codiVia;

    /** Legado: Nomb_via */
    @Column(name = "nomb_via", length = 20)
    public String nombVia;

    /** Legado: Num_via */
    @Column(name = "num_via", length = 4)
    public String numVia;

    /** Legado: Interior_via */
    @Column(name = "interior_via", length = 4)
    public String interiorVia;

    /** Legado: Codi_Zona */
    @Column(name = "codi_zona")
    public Short codiZona;

    /** Legado: Nomb_Zona */
    @Column(name = "nomb_zona", length = 20)
    public String nombZona;

    /** Legado: Codi_Ubi_Reg */
    @Column(name = "codi_ubi_reg")
    public Short codiUbiReg;

    /** Legado: Codi_Ubi_Prov */
    @Column(name = "codi_ubi_prov")
    public Short codiUbiProv;

    /** Legado: Codi_Ubi_Dist */
    @Column(name = "codi_ubi_dist")
    public Short codiUbiDist;

    /** Legado: Telefono */
    @Column(name = "telefono", length = 8)
    public String telefono;

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

    @Column(name = "ruc", length = 11)
    public String ruc;

    @Column(name = "labora_sabado", length = 1)
    public String laboraSabado;

    @Column(name = "refe_zona", length = 40)
    public String refeZona;

    @Column(name = "codi_empre_estab")
    public Integer codiEmpreEstab;

    @Column(name = "codi_pais_emi", length = 3)
    public String codiPaisEmi;
}
