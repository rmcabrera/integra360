package pe.sige.rrhh.domain.legacy;

import jakarta.enterprise.context.ApplicationScoped;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import pe.sige.common.catalog.EntityCatalog;
import pe.sige.common.catalog.EntityMeta;
import pe.sige.common.catalog.FieldMeta;

/** Catalogo de entidades legado de ms-rrhh (123 tablas). Generado: no editar. */
@ApplicationScoped
public class LegacyCatalog implements EntityCatalog {

    private final Map<String, EntityMeta> entities = new LinkedHashMap<>();

    public LegacyCatalog() {
        load0();
        load1();
        load2();
        load3();
        load4();
    }

    private void add(EntityMeta m) {
        entities.put(m.name(), m);
    }

    private static FieldMeta f(String field, String column, String type, int length, boolean required, boolean id, boolean generated, String label) {
        return new FieldMeta(field, column, type, length, required, id, generated, label);
    }

    private void load0() {
        add(new EntityMeta("turnos", "TURNOS", "Turnos", Turnos.class, null, List.of(
                f("codiTurn", "codi_turn", "String", 2, true, true, false, "Codi Turn"),
                f("descTurn", "desc_turn", "String", 50, false, false, false, "Desc Turn"),
                f("horaIni", "hora_ini", "LocalDateTime", 0, false, false, false, "Hora Ini"),
                f("horaTer", "hora_ter", "LocalDateTime", 0, false, false, false, "Hora Ter"))));
        add(new EntityMeta("regimen_laboral", "REGIMEN_LABORAL", "Regimen Laboral", RegimenLaboral.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("codigo", "codigo", "String", 2, true, false, false, "Codigo"),
                f("descripcion", "descripcion", "String", 200, false, false, false, "Descripcion"),
                f("abreviada", "abreviada", "String", 100, false, false, false, "Abreviada"),
                f("privado", "privado", "String", 1, false, false, false, "Privado"),
                f("publico", "publico", "String", 1, false, false, false, "Publico"),
                f("otros", "otros", "String", 1, false, false, false, "Otros"))));
        add(new EntityMeta("sindicatos_personal", "SINDICATOS_PERSONAL", "Sindicatos Personal", SindicatosPersonal.class, SindicatosPersonal.Pk.class, List.of(
                f("codiSind", "codi_sind", "String", 2, true, true, false, "Codi Sind"),
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"))));
        add(new EntityMeta("sindicatos", "SINDICATOS", "Sindicatos", Sindicatos.class, null, List.of(
                f("codiSind", "codi_sind", "String", 2, true, true, false, "Codi Sind"),
                f("descrip", "descrip", "String", 100, true, false, false, "Descrip"),
                f("tipo", "tipo", "String", 1, false, false, false, "Tipo"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("porcentaje", "porcentaje", "Long", 0, false, false, false, "Porcentaje"),
                f("tipoValor", "tipo_valor", "String", 1, false, false, false, "Tipo Valor"),
                f("nemo", "nemo", "String", 30, false, false, false, "Nemo"))));
        add(new EntityMeta("lugar_trabajo", "LUGAR_TRABAJO", "Lugar Trabajo", LugarTrabajo.class, null, List.of(
                f("codiLugaTrab", "codi_luga_trab", "String", 2, true, true, false, "Codi Luga Trab"),
                f("nombLugaTrab", "nomb_luga_trab", "String", 50, false, false, false, "Nomb Luga Trab"),
                f("abreLugaTrab", "abre_luga_trab", "String", 20, false, false, false, "Abre Luga Trab"))));
        add(new EntityMeta("ocupacion", "OCUPACION", "Ocupacion", Ocupacion.class, null, List.of(
                f("codiOcu", "codi_ocu", "Short", 0, true, true, false, "Codi Ocu"),
                f("codiOcuSunat", "codi_ocu_sunat", "String", 6, true, false, false, "Codi Ocu Sunat"),
                f("descOcu", "desc_ocu", "String", 250, false, false, false, "Desc Ocu"),
                f("nemoOcu", "nemo_ocu", "String", 30, false, false, false, "Nemo Ocu"))));
        add(new EntityMeta("constancia_juicios", "CONSTANCIA_JUICIOS", "Constancia Juicios", ConstanciaJuicios.class, ConstanciaJuicios.Pk.class, List.of(
                f("codiJuic", "codi_juic", "String", 6, true, true, false, "Codi Juic"),
                f("nroPago", "nro_pago", "String", 4, true, true, false, "Nro Pago"),
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("registro", "registro", "String", 10, false, false, false, "Registro"),
                f("beneJuic", "bene_juic", "String", 200, false, false, false, "Bene Juic"),
                f("nroReso", "nro_reso", "String", 50, false, false, false, "Nro Reso"),
                f("juzgado", "juzgado", "String", 200, false, false, false, "Juzgado"),
                f("valor", "valor", "BigDecimal", 0, false, false, false, "Valor"),
                f("semana", "semana", "String", 8, true, true, false, "Semana"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("dni", "dni", "String", 11, false, false, false, "Dni"),
                f("nroAsis", "nro_asis", "String", 1, false, false, false, "Nro Asis"),
                f("tipo", "tipo", "String", 1, false, false, false, "Tipo"),
                f("mesanio", "mesanio", "String", 6, false, false, false, "Mesanio"))));
        add(new EntityMeta("horas_laboradas", "HORAS_LABORADAS", "Horas Laboradas", HorasLaboradas.class, HorasLaboradas.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, true, true, false, "Fech Inic"),
                f("d01", "d_01", "BigDecimal", 0, true, false, false, "D 01"),
                f("d02", "d_02", "BigDecimal", 0, true, false, false, "D 02"),
                f("d03", "d_03", "BigDecimal", 0, true, false, false, "D 03"),
                f("d04", "d_04", "BigDecimal", 0, true, false, false, "D 04"),
                f("d05", "d_05", "BigDecimal", 0, true, false, false, "D 05"),
                f("d06", "d_06", "BigDecimal", 0, true, false, false, "D 06"),
                f("d07", "d_07", "BigDecimal", 0, true, false, false, "D 07"),
                f("d08", "d_08", "BigDecimal", 0, true, false, false, "D 08"),
                f("d09", "d_09", "BigDecimal", 0, true, false, false, "D 09"),
                f("d10", "d_10", "BigDecimal", 0, true, false, false, "D 10"),
                f("d11", "d_11", "BigDecimal", 0, true, false, false, "D 11"),
                f("d12", "d_12", "BigDecimal", 0, true, false, false, "D 12"),
                f("d13", "d_13", "BigDecimal", 0, true, false, false, "D 13"),
                f("d14", "d_14", "BigDecimal", 0, true, false, false, "D 14"),
                f("d15", "d_15", "BigDecimal", 0, true, false, false, "D 15"),
                f("d16", "d_16", "BigDecimal", 0, true, false, false, "D 16"),
                f("d17", "d_17", "BigDecimal", 0, true, false, false, "D 17"),
                f("d18", "d_18", "BigDecimal", 0, true, false, false, "D 18"),
                f("d19", "d_19", "BigDecimal", 0, true, false, false, "D 19"),
                f("d20", "d_20", "BigDecimal", 0, true, false, false, "D 20"),
                f("d21", "d_21", "BigDecimal", 0, true, false, false, "D 21"),
                f("d22", "d_22", "BigDecimal", 0, true, false, false, "D 22"),
                f("d23", "d_23", "BigDecimal", 0, true, false, false, "D 23"),
                f("d24", "d_24", "BigDecimal", 0, true, false, false, "D 24"),
                f("d25", "d_25", "BigDecimal", 0, true, false, false, "D 25"),
                f("d26", "d_26", "BigDecimal", 0, true, false, false, "D 26"),
                f("d27", "d_27", "BigDecimal", 0, true, false, false, "D 27"),
                f("d28", "d_28", "BigDecimal", 0, true, false, false, "D 28"),
                f("d29", "d_29", "BigDecimal", 0, true, false, false, "D 29"),
                f("d30", "d_30", "BigDecimal", 0, true, false, false, "D 30"),
                f("d31", "d_31", "BigDecimal", 0, true, false, false, "D 31"),
                f("horaReinNorm", "hora_rein_norm", "BigDecimal", 0, false, false, false, "Hora Rein Norm"),
                f("hora25ReinNorm", "hora_25_rein_norm", "BigDecimal", 0, false, false, false, "Hora 25 Rein Norm"),
                f("hora35ReinNorm", "hora_35_rein_norm", "BigDecimal", 0, false, false, false, "Hora 35 Rein Norm"),
                f("horaReinDomi", "hora_rein_domi", "BigDecimal", 0, false, false, false, "Hora Rein Domi"),
                f("hora25ReinDomi", "hora_25_rein_domi", "BigDecimal", 0, false, false, false, "Hora 25 Rein Domi"),
                f("hora35ReinDomi", "hora_35_rein_domi", "BigDecimal", 0, false, false, false, "Hora 35 Rein Domi"),
                f("horaReinFeri", "hora_rein_feri", "BigDecimal", 0, false, false, false, "Hora Rein Feri"),
                f("hora25ReinFeri", "hora_25_rein_feri", "BigDecimal", 0, false, false, false, "Hora 25 Rein Feri"),
                f("hora35ReinFeri", "hora_35_rein_feri", "BigDecimal", 0, false, false, false, "Hora 35 Rein Feri"),
                f("observaciones", "observaciones", "String", 250, false, false, false, "Observaciones"),
                f("indiTiem", "indi_tiem", "String", 1, false, false, false, "Indi Tiem"))));
        add(new EntityMeta("horario", "HORARIO", "Horario", Horario.class, null, List.of(
                f("codiHora", "codi_hora", "Short", 0, true, true, false, "Codi Hora"),
                f("descripcion", "descripcion", "String", 50, false, false, false, "Descripcion"),
                f("he1n", "he1n", "LocalDateTime", 0, false, false, false, "He1n"),
                f("hs1n", "hs1n", "LocalDateTime", 0, false, false, false, "Hs1n"),
                f("he2n", "he2n", "LocalDateTime", 0, false, false, false, "He2n"),
                f("hs2n", "hs2n", "LocalDateTime", 0, false, false, false, "Hs2n"),
                f("he1s", "he1s", "LocalDateTime", 0, false, false, false, "He1s"),
                f("hs1s", "hs1s", "LocalDateTime", 0, false, false, false, "Hs1s"),
                f("he2s", "he2s", "LocalDateTime", 0, false, false, false, "He2s"),
                f("hs2s", "hs2s", "LocalDateTime", 0, false, false, false, "Hs2s"),
                f("horaLaboDia", "hora_labo_dia", "BigDecimal", 0, false, false, false, "Hora Labo Dia"),
                f("horaLaboDiaSaba", "hora_labo_dia_saba", "BigDecimal", 0, false, false, false, "Hora Labo Dia Saba"))));
        add(new EntityMeta("hora_plan_vaca_grat", "HORA_PLAN_VACA_GRAT", "Hora Plan Vaca Grat", HoraPlanVacaGrat.class, HoraPlanVacaGrat.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, true, true, false, "Fech Inic"),
                f("codiTipoPlan", "codi_tipo_plan", "String", 2, true, true, false, "Codi Tipo Plan"),
                f("fechTerm", "fech_term", "LocalDateTime", 0, false, false, false, "Fech Term"),
                f("anio", "anio", "String", 4, false, false, false, "Anio"),
                f("mes", "mes", "String", 2, false, false, false, "Mes"),
                f("promRemuHora25", "prom_remu_hora_25", "BigDecimal", 0, false, false, false, "Prom Remu Hora 25"),
                f("promRemuHora35", "prom_remu_hora_35", "BigDecimal", 0, false, false, false, "Prom Remu Hora 35"),
                f("remuOtroIngr", "remu_otro_ingr", "BigDecimal", 0, false, false, false, "Remu Otro Ingr"),
                f("nroMesePaga", "nro_mese_paga", "Short", 0, false, false, false, "Nro Mese Paga"),
                f("nroDiasPaga", "nro_dias_paga", "Short", 0, false, false, false, "Nro Dias Paga"),
                f("motiObse", "moti_obse", "String", 200, false, false, false, "Moti Obse"))));
        add(new EntityMeta("hora_labo_sema", "HORA_LABO_SEMA", "Hora Labo Sema", HoraLaboSema.class, HoraLaboSema.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, true, true, false, "Fech Inic"),
                f("fechTerm", "fech_term", "LocalDateTime", 0, true, false, false, "Fech Term"),
                f("d01", "d_01", "BigDecimal", 0, true, false, false, "D 01"),
                f("d02", "d_02", "BigDecimal", 0, true, false, false, "D 02"),
                f("d03", "d_03", "BigDecimal", 0, true, false, false, "D 03"),
                f("d04", "d_04", "BigDecimal", 0, true, false, false, "D 04"),
                f("d05", "d_05", "BigDecimal", 0, true, false, false, "D 05"),
                f("d06", "d_06", "BigDecimal", 0, true, false, false, "D 06"),
                f("d07", "d_07", "BigDecimal", 0, true, false, false, "D 07"),
                f("anio", "anio", "String", 4, true, true, false, "Anio"),
                f("mes", "mes", "String", 2, true, true, false, "Mes"),
                f("horaReinNorm", "hora_rein_norm", "BigDecimal", 0, false, false, false, "Hora Rein Norm"),
                f("hora25ReinNorm", "hora_25_rein_norm", "BigDecimal", 0, false, false, false, "Hora 25 Rein Norm"),
                f("hora35ReinNorm", "hora_35_rein_norm", "BigDecimal", 0, false, false, false, "Hora 35 Rein Norm"),
                f("horaReinDomi", "hora_rein_domi", "BigDecimal", 0, false, false, false, "Hora Rein Domi"),
                f("hora25ReinDomi", "hora_25_rein_domi", "BigDecimal", 0, false, false, false, "Hora 25 Rein Domi"),
                f("hora35ReinDomi", "hora_35_rein_domi", "BigDecimal", 0, false, false, false, "Hora 35 Rein Domi"),
                f("horaReinFeri", "hora_rein_feri", "BigDecimal", 0, false, false, false, "Hora Rein Feri"),
                f("hora25ReinFeri", "hora_25_rein_feri", "BigDecimal", 0, false, false, false, "Hora 25 Rein Feri"),
                f("hora35ReinFeri", "hora_35_rein_feri", "BigDecimal", 0, false, false, false, "Hora 35 Rein Feri"),
                f("observaciones", "observaciones", "String", 250, false, false, false, "Observaciones"),
                f("indiTiem", "indi_tiem", "String", 1, false, false, false, "Indi Tiem"),
                f("codiTipoPers", "codi_tipo_pers", "String", 2, false, false, false, "Codi Tipo Pers"),
                f("semana", "semana", "Short", 0, false, false, false, "Semana"))));
        add(new EntityMeta("moti_fin_periodo", "MOTI_FIN_PERIODO", "Moti Fin Periodo", MotiFinPeriodo.class, null, List.of(
                f("codiMotiFinPeri", "codi_moti_fin_peri", "Short", 0, true, true, false, "Codi Moti Fin Peri"),
                f("codiMotiFinPeriSunat", "codi_moti_fin_peri_sunat", "String", 2, true, false, false, "Codi Moti Fin Peri Sunat"),
                f("descMotiFinPeri", "desc_moti_fin_peri", "String", 100, true, false, false, "Desc Moti Fin Peri"))));
        add(new EntityMeta("moti_baja_dh", "MOTI_BAJA_DH", "Moti Baja Dh", MotiBajaDh.class, null, List.of(
                f("codiMotiBajaDh", "codi_moti_baja_dh", "Short", 0, true, true, false, "Codi Moti Baja Dh"),
                f("codiMotiBajaDhSunat", "codi_moti_baja_dh_sunat", "Short", 0, true, false, false, "Codi Moti Baja Dh Sunat"),
                f("descMotiBajaDh", "desc_moti_baja_dh", "String", 100, true, false, false, "Desc Moti Baja Dh"))));
        add(new EntityMeta("planilla_grati_vaca", "PLANILLA_GRATI_VACA", "Planilla Grati Vaca", PlanillaGratiVaca.class, null, List.of(
                f("codiPlanGrva", "codi_plan_grva", "String", 10, true, true, false, "Codi Plan Grva"),
                f("codiSema", "codi_sema", "String", 8, false, false, false, "Codi Sema"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"),
                f("codiTipoPlan", "codi_tipo_plan", "String", 2, false, false, false, "Codi Tipo Plan"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("formPago", "form_pago", "String", 20, false, false, false, "Form Pago"),
                f("nroCheq", "nro_cheq", "String", 30, false, false, false, "Nro Cheq"),
                f("fechPago", "fech_pago", "LocalDateTime", 0, false, false, false, "Fech Pago"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("nroAsis", "nro_asis", "String", 1, false, false, false, "Nro Asis"),
                f("mesanio", "mesanio", "String", 6, false, false, false, "Mesanio"))));
        add(new EntityMeta("personal_valores_defecto", "PERSONAL_VALORES_DEFECTO", "Personal Valores Defecto", PersonalValoresDefecto.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"),
                f("codiSistPens", "codi_sist_pens", "String", 2, false, false, false, "Codi Sist Pens"),
                f("codiCarg", "codi_carg", "String", 4, false, false, false, "Codi Carg"),
                f("codiArea", "codi_area", "String", 2, false, false, false, "Codi Area"),
                f("codiMoneBasi", "codi_mone_basi", "String", 2, false, false, false, "Codi Mone Basi"),
                f("essalud", "essalud", "Boolean", 0, false, false, false, "Essalud"),
                f("estaCivi", "esta_civi", "String", 1, false, false, false, "Esta Civi"),
                f("estaActi", "esta_acti", "Boolean", 0, false, false, false, "Esta Acti"),
                f("scrt", "scrt", "Boolean", 0, false, false, false, "Scrt"),
                f("comiPesc", "comi_pesc", "Boolean", 0, false, false, false, "Comi Pesc"),
                f("afilSind", "afil_sind", "Boolean", 0, false, false, false, "Afil Sind"),
                f("tipoCont", "tipo_cont", "String", 2, false, false, false, "Tipo Cont"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("cargFami", "carg_fami", "Boolean", 0, false, false, false, "Carg Fami"),
                f("sexo", "sexo", "String", 1, false, false, false, "Sexo"),
                f("tipoSituLabo", "tipo_situ_labo", "String", 1, false, false, false, "Tipo Situ Labo"),
                f("seguVidaLey", "segu_vida_ley", "Boolean", 0, false, false, false, "Segu Vida Ley"),
                f("jubilado", "jubilado", "Boolean", 0, false, false, false, "Jubilado"),
                f("formPago", "form_pago", "String", 20, false, false, false, "Form Pago"),
                f("horaLabo", "hora_labo", "BigDecimal", 0, false, false, false, "Hora Labo"),
                f("codiTipoRies", "codi_tipo_ries", "String", 2, false, false, false, "Codi Tipo Ries"),
                f("fotoSiNo", "foto_si_no", "Boolean", 0, false, false, false, "Foto Si No"),
                f("horaAuto", "hora_auto", "BigDecimal", 0, false, false, false, "Hora Auto"),
                f("grat", "grat", "Boolean", 0, false, false, false, "Grat"),
                f("vaca", "vaca", "Boolean", 0, false, false, false, "Vaca"),
                f("codiLugaTrab", "codi_luga_trab", "String", 2, false, false, false, "Codi Luga Trab"),
                f("afectoLey", "afecto_ley", "Boolean", 0, false, false, false, "Afecto Ley"),
                f("fotocheck", "fotocheck", "Integer", 0, false, false, false, "Fotocheck"),
                f("horario", "horario", "Short", 0, false, false, false, "Horario"),
                f("codiCateTrab", "codi_cate_trab", "Short", 0, false, false, false, "Codi Cate Trab"),
                f("aporEssa", "apor_essa", "Boolean", 0, false, false, false, "Apor Essa"),
                f("aporSena", "apor_sena", "Boolean", 0, false, false, false, "Apor Sena"),
                f("aporSenc", "apor_senc", "Boolean", 0, false, false, false, "Apor Senc"),
                f("aporCona", "apor_cona", "Boolean", 0, false, false, false, "Apor Cona"),
                f("codiElemCosto", "codi_elem_costo", "Short", 0, false, false, false, "Codi Elem Costo"),
                f("codiTipoDocuIden", "codi_tipo_docu_iden", "Short", 0, false, false, false, "Codi Tipo Docu Iden"),
                f("codiNacion", "codi_nacion", "Short", 0, false, false, false, "Codi Nacion"),
                f("codiUbiDist", "codi_ubi_dist", "Short", 0, false, false, false, "Codi Ubi Dist"),
                f("condiDomi", "condi_domi", "Short", 0, false, false, false, "Condi Domi"),
                f("codiPension", "codi_pension", "Short", 0, false, false, false, "Codi Pension"),
                f("codiSituTrabPens", "codi_situ_trab_pens", "Short", 0, false, false, false, "Codi Situ Trab Pens"),
                f("codiMotiFinPeri", "codi_moti_fin_peri", "Short", 0, false, false, false, "Codi Moti Fin Peri"),
                f("laboraSabado", "labora_sabado", "String", 1, false, false, false, "Labora Sabado"),
                f("regiLabo", "regi_labo", "Short", 0, false, false, false, "Regi Labo"),
                f("inforOtrosIngrQtaCat", "infor_otros_ingr_qta_cat", "Short", 0, false, false, false, "Infor Otros Ingr Qta Cat"),
                f("rentaQtaCatExoInaf", "renta_qta_cat_exo_inaf", "Short", 0, false, false, false, "Renta Qta Cat Exo Inaf"),
                f("afiEpsServProp", "afi_eps_serv_prop", "Short", 0, false, false, false, "Afi Eps Serv Prop"),
                f("sujetoJornadaMax", "sujeto_jornada_max", "Short", 0, false, false, false, "Sujeto Jornada Max"),
                f("codiPeriodo", "codi_periodo", "Short", 0, false, false, false, "Codi Periodo"),
                f("sctrPension", "sctr_pension", "Short", 0, false, false, false, "Sctr Pension"),
                f("sctrSalud", "sctr_salud", "Short", 0, false, false, false, "Sctr Salud"))));
        add(new EntityMeta("vinculo_familiar", "VINCULO_FAMILIAR", "Vinculo Familiar", VinculoFamiliar.class, null, List.of(
                f("codiVincFami", "codi_vinc_fami", "Short", 0, true, true, false, "Codi Vinc Fami"),
                f("codiVincFamiSunat", "codi_vinc_fami_sunat", "Short", 0, true, false, false, "Codi Vinc Fami Sunat"),
                f("descVincFami", "desc_vinc_fami", "String", 50, true, false, false, "Desc Vinc Fami"))));
        add(new EntityMeta("tipo_riesgo", "TIPO_RIESGO", "Tipo Riesgo", TipoRiesgo.class, null, List.of(
                f("codiTipoRies", "codi_tipo_ries", "String", 2, true, true, false, "Codi Tipo Ries"),
                f("descTipoRies", "desc_tipo_ries", "String", 200, false, false, false, "Desc Tipo Ries"),
                f("nemo", "nemo", "String", 10, false, false, false, "Nemo"))));
        add(new EntityMeta("tipo_ries_tasa", "TIPO_RIES_TASA", "Tipo Ries Tasa", TipoRiesTasa.class, TipoRiesTasa.Pk.class, List.of(
                f("codiTipoRies", "codi_tipo_ries", "String", 2, true, true, false, "Codi Tipo Ries"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, true, true, false, "Fech Inic"),
                f("fechFin", "fech_fin", "LocalDateTime", 0, false, false, false, "Fech Fin"),
                f("codiTipoPers", "codi_tipo_pers", "String", 2, true, true, false, "Codi Tipo Pers"),
                f("tasa", "tasa", "BigDecimal", 0, false, false, false, "Tasa"))));
        add(new EntityMeta("tipo_prestamo", "TIPO_PRESTAMO", "Tipo Prestamo", TipoPrestamo.class, null, List.of(
                f("codiTipoPres", "codi_tipo_pres", "String", 2, true, true, false, "Codi Tipo Pres"),
                f("descTipoPres", "desc_tipo_pres", "String", 50, false, false, false, "Desc Tipo Pres"),
                f("nemoTipoPres", "nemo_tipo_pres", "String", 10, false, false, false, "Nemo Tipo Pres"))));
        add(new EntityMeta("tipo_plan_nemo", "TIPO_PLAN_NEMO", "Tipo Plan Nemo", TipoPlanNemo.class, null, List.of(
                f("codiNemoPlan", "codi_nemo_plan", "String", 2, true, true, false, "Codi Nemo Plan"),
                f("nemoPlan", "nemo_plan", "String", 2, false, false, false, "Nemo Plan"),
                f("descNemoPlan", "desc_nemo_plan", "String", 100, false, false, false, "Desc Nemo Plan"),
                f("codiTipoPlan", "codi_tipo_plan", "String", 2, false, false, false, "Codi Tipo Plan"),
                f("codiTipoPers", "codi_tipo_pers", "String", 2, false, false, false, "Codi Tipo Pers"))));
        add(new EntityMeta("tipo_personal", "TIPO_PERSONAL", "Tipo Personal", TipoPersonal.class, null, List.of(
                f("codiTipoPers", "codi_tipo_pers", "Short", 0, true, true, false, "Codi Tipo Pers"),
                f("codiTipoPersSunat", "codi_tipo_pers_sunat", "String", 2, true, false, false, "Codi Tipo Pers Sunat"),
                f("descTipoPers", "desc_tipo_pers", "String", 100, true, false, false, "Desc Tipo Pers"),
                f("nemoTipoPers", "nemo_tipo_pers", "String", 50, false, false, false, "Nemo Tipo Pers"))));
        add(new EntityMeta("tipo_contrato", "TIPO_CONTRATO", "Tipo Contrato", TipoContrato.class, null, List.of(
                f("codiTipoCont", "codi_tipo_cont", "Short", 0, true, true, false, "Codi Tipo Cont"),
                f("codiTipoContSunat", "codi_tipo_cont_sunat", "String", 2, true, false, false, "Codi Tipo Cont Sunat"),
                f("descTipoCont", "desc_tipo_cont", "String", 100, true, false, false, "Desc Tipo Cont"))));
        add(new EntityMeta("tipo_conceptos", "TIPO_CONCEPTOS", "Tipo Conceptos", TipoConceptos.class, null, List.of(
                f("codiTipo", "codi_tipo", "String", 1, true, true, false, "Codi Tipo"),
                f("descripcion", "descripcion", "String", 20, false, false, false, "Descripcion"))));
        add(new EntityMeta("tipo_comida", "TIPO_COMIDA", "Tipo Comida", TipoComida.class, null, List.of(
                f("codiTipoComi", "codi_tipo_comi", "String", 2, true, true, false, "Codi Tipo Comi"),
                f("descTipoComi", "desc_tipo_comi", "String", 25, false, false, false, "Desc Tipo Comi"))));
        add(new EntityMeta("tipo_cargo", "TIPO_CARGO", "Tipo Cargo", TipoCargo.class, null, List.of(
                f("codiTipoCarg", "codi_tipo_carg", "String", 2, true, true, false, "Codi Tipo Carg"),
                f("descTipoCarg", "desc_tipo_carg", "String", 50, false, false, false, "Desc Tipo Carg"))));
    }

    private void load1() {
        add(new EntityMeta("personal_saludos", "personal_saludos", "Personal Saludos", PersonalSaludos.class, null, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("saludo1", "saludo_1", "String", 75, false, false, false, "Saludo 1"),
                f("saludo2", "saludo_2", "String", 75, false, false, false, "Saludo 2"),
                f("saludo3", "saludo_3", "String", 75, false, false, false, "Saludo 3"),
                f("saludo4", "saludo_4", "String", 75, false, false, false, "Saludo 4"))));
        add(new EntityMeta("dias_trab", "Dias_Trab", "Dias Trab", DiasTrab.class, DiasTrab.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, true, false, "Codi Unid Oper"),
                f("codiSema", "codi_sema", "String", 8, true, true, false, "Codi Sema"),
                f("dias", "dias", "Long", 0, false, false, false, "Dias"))));
        add(new EntityMeta("sub_area_grup", "SUB_AREA_GRUP", "Sub Area Grup", SubAreaGrup.class, null, List.of(
                f("codiSubAreaGrup", "codi_sub_area_grup", "String", 4, true, true, false, "Codi Sub Area Grup"),
                f("descSubAreaGrup", "desc_sub_area_grup", "String", 200, false, false, false, "Desc Sub Area Grup"),
                f("nemoSubAreaGrup", "nemo_sub_area_grup", "String", 30, false, false, false, "Nemo Sub Area Grup"),
                f("nroJera", "nro_jera", "Integer", 0, false, false, false, "Nro Jera"),
                f("codiAreaGrup", "codi_area_grup", "String", 2, false, false, false, "Codi Area Grup"))));
        add(new EntityMeta("asistencia_personal", "ASISTENCIA_PERSONAL", "Asistencia Personal", AsistenciaPersonal.class, AsistenciaPersonal.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("fecha", "fecha", "String", 10, true, true, false, "Fecha"),
                f("turno", "turno", "Integer", 0, true, true, false, "Turno"),
                f("he1", "he1", "LocalDateTime", 0, false, false, false, "He1"),
                f("hs1", "hs1", "LocalDateTime", 0, false, false, false, "Hs1"),
                f("codiUsua", "codi_usua", "String", 5, false, false, false, "Codi Usua"),
                f("codiUsuaModi", "codi_usua_modi", "String", 5, false, false, false, "Codi Usua Modi"))));
        add(new EntityMeta("asistencia_motorista", "ASISTENCIA_MOTORISTA", "Asistencia Motorista", AsistenciaMotorista.class, AsistenciaMotorista.Pk.class, List.of(
                f("mesanio", "mesanio", "String", 6, true, true, false, "Mesanio"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, true, false, "Codi Unid Oper"),
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("codiCarg", "codi_carg", "String", 4, true, false, false, "Codi Carg"),
                f("diasTrabaQuin", "dias_traba_quin", "Integer", 0, false, false, false, "Dias Traba Quin"),
                f("diasTrabaMens", "dias_traba_mens", "Integer", 0, false, false, false, "Dias Traba Mens"))));
        add(new EntityMeta("asistencia_maqui_motor", "ASISTENCIA_MAQUI_MOTOR", "Asistencia Maqui Motor", AsistenciaMaquiMotor.class, AsistenciaMaquiMotor.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("fechAsis", "fech_asis", "LocalDateTime", 0, true, true, false, "Fech Asis"),
                f("asisPers", "asis_pers", "Boolean", 0, false, false, false, "Asis Pers"))));
        add(new EntityMeta("areas", "AREAS", "Areas", Areas.class, null, List.of(
                f("codiArea", "codi_area", "String", 2, true, true, false, "Codi Area"),
                f("nombArea", "nomb_area", "String", 50, false, false, false, "Nomb Area"),
                f("ubica", "ubica", "String", 50, false, false, false, "Ubica"),
                f("areaGrup", "area_grup", "String", 2, false, false, false, "Area Grup"))));
        add(new EntityMeta("util_pers_anual", "UTIL_PERS_ANUAL", "Util Pers Anual", UtilPersAnual.class, UtilPersAnual.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("periodo", "periodo", "String", 4, true, true, false, "Periodo"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"))));
        add(new EntityMeta("categoria_trabajador", "CATEGORIA_TRABAJADOR", "Categoria Trabajador", CategoriaTrabajador.class, null, List.of(
                f("codiCateTrab", "codi_cate_trab", "Short", 0, true, true, false, "0=Ninguno,1=Personal Direccion,2=Personal Confianza"),
                f("descCateTrab", "desc_cate_trab", "String", 50, true, false, false, "Desc Cate Trab"),
                f("abreCateTrab", "abre_cate_trab", "String", 12, false, false, false, "Abre Cate Trab"),
                f("ordeCateTrab", "orde_cate_trab", "Short", 0, false, false, false, "Orde Cate Trab"),
                f("codiSunat", "codi_sunat", "Integer", 0, false, false, false, "Codi Sunat"))));
        add(new EntityMeta("categoria_ocupacional", "CATEGORIA_OCUPACIONAL", "Categoria Ocupacional", CategoriaOcupacional.class, null, List.of(
                f("codCategOcup", "cod_categ_ocup", "Integer", 0, true, true, false, "Cod Categ Ocup"),
                f("descCategOcup", "desc_categ_ocup", "String", 100, false, false, false, "Desc Categ Ocup"),
                f("codigoSunat", "codigo_sunat", "Integer", 0, false, false, false, "Codigo Sunat"),
                f("privador", "privador", "String", 1, false, false, false, "Privador"),
                f("publico", "publico", "String", 1, false, false, false, "Publico"),
                f("otro", "otro", "String", 1, false, false, false, "Otro"))));
        add(new EntityMeta("cargos", "CARGOS", "Cargos", Cargos.class, null, List.of(
                f("codiCarg", "codi_carg", "String", 4, true, true, false, "Codi Carg"),
                f("tipoCarg", "tipo_carg", "String", 50, false, false, false, "Tipo Carg"),
                f("descCargo", "desc_cargo", "String", 150, false, false, false, "Desc Cargo"),
                f("abrev", "abrev", "String", 2, false, false, false, "Abrev"),
                f("cargMostrar", "carg_mostrar", "String", 100, false, false, false, "Carg Mostrar"),
                f("jera", "jera", "Short", 0, false, false, false, "Jera"),
                f("codiOcu", "codi_ocu", "Short", 0, false, false, false, "Codi Ocu"))));
        add(new EntityMeta("abogados", "ABOGADOS", "Abogados", Abogados.class, null, List.of(
                f("codiAbog", "codi_abog", "String", 3, true, true, false, "Codi Abog"),
                f("apel1", "apel_1", "String", 50, false, false, false, "Apel 1"),
                f("apel2", "apel_2", "String", 50, false, false, false, "Apel 2"),
                f("nomb1", "nomb_1", "String", 50, false, false, false, "Nomb 1"),
                f("nomb2", "nomb_2", "String", 50, false, false, false, "Nomb 2"))));
        add(new EntityMeta("actividad", "ACTIVIDAD", "Actividad", Actividad.class, null, List.of(
                f("codiActi", "codi_acti", "Short", 0, true, true, false, "Codi Acti"),
                f("codiActiSunat", "codi_acti_sunat", "String", 5, true, false, false, "Codi Acti Sunat"),
                f("descActi", "desc_acti", "String", 100, true, false, false, "Desc Acti"))));
        add(new EntityMeta("rubros_sistema_pensiones", "RUBROS_SISTEMA_PENSIONES", "Rubros Sistema Pensiones", RubrosSistemaPensiones.class, null, List.of(
                f("codiRubr", "codi_rubr", "String", 3, true, true, false, "Codi Rubr"),
                f("descRubr", "desc_rubr", "String", 50, true, false, false, "Desc Rubr"),
                f("tipoCant", "tipo_cant", "String", 1, false, false, false, "Tipo Cant"),
                f("estaRubr", "esta_rubr", "Boolean", 0, false, false, false, "Esta Rubr"))));
        add(new EntityMeta("pagos_adelantos", "PAGOS_ADELANTOS", "Pagos Adelantos", PagosAdelantos.class, PagosAdelantos.Pk.class, List.of(
                f("codiAdel", "codi_adel", "String", 6, true, true, false, "Codi Adel"),
                f("nroPago", "nro_pago", "String", 4, true, true, false, "Nro Pago"),
                f("fechPago", "fech_pago", "LocalDateTime", 0, true, false, false, "Fech Pago"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"),
                f("observacion", "observacion", "String", 150, false, false, false, "Observacion"))));
        add(new EntityMeta("soli_pres_ingr_desc", "SOLI_PRES_INGR_DESC", "Soli Pres Ingr Desc", SoliPresIngrDesc.class, SoliPresIngrDesc.Pk.class, List.of(
                f("codiSoliPres", "codi_soli_pres", "String", 10, true, true, false, "Codi Soli Pres"),
                f("nroItem", "nro_item", "Short", 0, true, true, false, "Nro Item"),
                f("tipoMont", "tipo_mont", "String", 1, false, false, false, "Tipo Mont"),
                f("descMont", "desc_mont", "String", 100, false, false, false, "Desc Mont"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"))));
        add(new EntityMeta("soli_pres_cron_devo", "SOLI_PRES_CRON_DEVO", "Soli Pres Cron Devo", SoliPresCronDevo.class, SoliPresCronDevo.Pk.class, List.of(
                f("codiSoliPres", "codi_soli_pres", "String", 10, true, true, false, "Codi Soli Pres"),
                f("nroItem", "nro_item", "Short", 0, true, true, false, "Nro Item"),
                f("nroCuot", "nro_cuot", "Short", 0, false, false, false, "Nro Cuot"),
                f("fechVenc", "fech_venc", "LocalDateTime", 0, false, false, false, "Fech Venc"),
                f("montCuot", "mont_cuot", "BigDecimal", 0, false, false, false, "Mont Cuot"))));
        add(new EntityMeta("soli_pres", "SOLI_PRES", "Soli Pres", SoliPres.class, null, List.of(
                f("codiSoliPres", "codi_soli_pres", "String", 10, true, true, false, "Codi Soli Pres"),
                f("nroSoliPres", "nro_soli_pres", "Integer", 0, false, false, false, "Nro Soli Pres"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"),
                f("fechSoli", "fech_soli", "LocalDateTime", 0, false, false, false, "Fech Soli"),
                f("impoSoli", "impo_soli", "BigDecimal", 0, false, false, false, "Impo Soli"),
                f("situActu", "situ_actu", "String", 50, false, false, false, "Situ Actu"),
                f("codiUsuaDato", "codi_usua_dato", "String", 5, false, false, false, "Codi Usua Dato"),
                f("fechRegiDato", "fech_regi_dato", "LocalDateTime", 0, false, false, false, "Fech Regi Dato"),
                f("impoOtor", "impo_otor", "BigDecimal", 0, false, false, false, "Impo Otor"),
                f("formDesc", "form_desc", "String", 50, false, false, false, "Form Desc"),
                f("nroSemaDesc", "nro_sema_desc", "Short", 0, false, false, false, "Nro Sema Desc"),
                f("periDesc", "peri_desc", "Integer", 0, false, false, false, "Peri Desc"),
                f("mesDesc", "mes_desc", "Short", 0, false, false, false, "Mes Desc"),
                f("plazPago", "plaz_pago", "String", 50, false, false, false, "Plaz Pago"),
                f("fechPrimPago", "fech_prim_pago", "LocalDateTime", 0, false, false, false, "Fech Prim Pago"),
                f("nroCuotas", "nro_cuotas", "Short", 0, false, false, false, "Nro Cuotas"),
                f("observacion", "observacion", "String", 250, false, false, false, "Observacion"),
                f("observacion1", "observacion1", "String", 250, false, false, false, "Observacion1"),
                f("descPres", "desc_pres", "String", 1, false, false, false, "Desc Pres"))));
        add(new EntityMeta("situ_trab_pens", "SITU_TRAB_PENS", "Situ Trab Pens", SituTrabPens.class, null, List.of(
                f("codiSituTrabPens", "codi_situ_trab_pens", "Short", 0, true, true, false, "Codi Situ Trab Pens"),
                f("codiSituTrabPensSunat", "codi_situ_trab_pens_sunat", "Short", 0, true, false, false, "Codi Situ Trab Pens Sunat"),
                f("afiliadoEps", "afiliado_eps", "Short", 0, true, false, false, "Afiliado Eps"),
                f("descSituTrabPens", "desc_situ_trab_pens", "String", 150, true, false, false, "Desc Situ Trab Pens"),
                f("codiSituTrabPensPlame", "codi_situ_trab_pens_plame", "Short", 0, false, false, false, "Codi Situ Trab Pens Plame"))));
        add(new EntityMeta("sistema_pensiones", "SISTEMA_PENSIONES", "Sistema Pensiones", SistemaPensiones.class, null, List.of(
                f("codiSistPens", "codi_sist_pens", "String", 2, true, true, false, "Codi Sist Pens"),
                f("descSistPens", "desc_sist_pens", "String", 50, false, false, false, "Desc Sist Pens"),
                f("nemo", "nemo", "String", 10, false, false, false, "Nemo"),
                f("codiRela", "codi_rela", "String", 5, false, false, false, "Codi Rela"),
                f("codiPension", "codi_pension", "Short", 0, false, false, false, "Codi Pension"),
                f("afpnet", "afpnet", "String", 2, false, false, false, "Afpnet"))));
        add(new EntityMeta("especialistas", "ESPECIALISTAS", "Especialistas", Especialistas.class, null, List.of(
                f("codiEspe", "codi_espe", "String", 3, true, true, false, "Codi Espe"),
                f("apel1", "apel_1", "String", 50, false, false, false, "Apel 1"),
                f("apel2", "apel_2", "String", 50, false, false, false, "Apel 2"),
                f("nomb1", "nomb_1", "String", 50, false, false, false, "Nomb 1"),
                f("nomb2", "nomb_2", "String", 50, false, false, false, "Nomb 2"),
                f("dni", "dni", "String", 12, false, false, false, "Dni"))));
        add(new EntityMeta("entidad_salud", "ENTIDAD_SALUD", "Entidad Salud", EntidadSalud.class, null, List.of(
                f("codiEnti", "codi_enti", "Short", 0, true, true, false, "Codi Enti"),
                f("codiEntiSunat", "codi_enti_sunat", "Short", 0, true, false, false, "Codi Enti Sunat"),
                f("ruc", "ruc", "String", 11, true, false, false, "Ruc"),
                f("descEnti", "desc_enti", "String", 150, true, false, false, "Desc Enti"))));
        add(new EntityMeta("modalidad_formativa", "MODALIDAD_FORMATIVA", "Modalidad Formativa", ModalidadFormativa.class, null, List.of(
                f("codiModaForma", "codi_moda_forma", "Short", 0, true, true, false, "Codi Moda Forma"),
                f("codiModaFormaSunat", "codi_moda_forma_sunat", "String", 2, true, false, false, "Codi Moda Forma Sunat"),
                f("descModaForma", "desc_moda_forma", "String", 100, true, false, false, "Desc Moda Forma"))));
        add(new EntityMeta("tipos_licencias", "TIPOS_LICENCIAS", "Tipos Licencias", TiposLicencias.class, null, List.of(
                f("codiTipoLice", "codi_tipo_lice", "String", 3, true, true, false, "Codi Tipo Lice"),
                f("descLice", "desc_lice", "String", 100, false, false, false, "Desc Lice"),
                f("nroDiasRemu", "nro_dias_remu", "Integer", 0, false, false, false, "Nro Dias Remu"))));
        add(new EntityMeta("tipo_vacaciones", "TIPO_VACACIONES", "Tipo Vacaciones", TipoVacaciones.class, null, List.of(
                f("codiTipoVaca", "codi_tipo_vaca", "String", 2, true, true, false, "Codi Tipo Vaca"),
                f("descTipoVaca", "desc_tipo_vaca", "String", 50, false, false, false, "Desc Tipo Vaca"))));
    }

    private void load2() {
        add(new EntityMeta("tipo_trabajador", "TIPO_TRABAJADOR", "Tipo Trabajador", TipoTrabajador.class, null, List.of(
                f("codiTipoPers", "codi_tipo_pers", "String", 2, true, true, false, "Codi Tipo Pers"),
                f("descTipoPers", "desc_tipo_pers", "String", 50, true, false, false, "Desc Tipo Pers"))));
        add(new EntityMeta("tipo_suspension", "TIPO_SUSPENSION", "Tipo Suspension", TipoSuspension.class, null, List.of(
                f("codiTipoSuspLabo", "codi_tipo_susp_labo", "Short", 0, true, true, false, "Codi Tipo Susp Labo"),
                f("codiTipoSuspLaboSunat", "codi_tipo_susp_labo_sunat", "String", 2, true, false, false, "Codi Tipo Susp Labo Sunat"),
                f("descTipoSuspLabo", "desc_tipo_susp_labo", "String", 200, true, false, false, "Desc Tipo Susp Labo"),
                f("tipo", "tipo", "Short", 0, true, false, false, "Tipo"))));
        add(new EntityMeta("tipo_situ_hora_trab", "TIPO_SITU_HORA_TRAB", "Tipo Situ Hora Trab", TipoSituHoraTrab.class, null, List.of(
                f("codiTipoSituHora", "codi_tipo_situ_hora", "String", 2, true, true, false, "Codi Tipo Situ Hora"),
                f("descSituHora", "desc_situ_hora", "String", 50, false, false, false, "Desc Situ Hora"),
                f("abreSituHora", "abre_situ_hora", "String", 20, false, false, false, "Abre Situ Hora"))));
        add(new EntityMeta("area_grup", "AREA_GRUP", "Area Grup", AreaGrup.class, null, List.of(
                f("codiAreaGrup", "codi_area_grup", "String", 2, true, true, false, "Codi Area Grup"),
                f("descAreaGrup", "desc_area_grup", "String", 100, false, false, false, "Desc Area Grup"),
                f("jeraArea", "jera_area", "Short", 0, false, false, false, "Jera Area"))));
        add(new EntityMeta("deta_ingr_grat_trip", "DETA_INGR_GRAT_TRIP", "Deta Ingr Grat Trip", DetaIngrGratTrip.class, DetaIngrGratTrip.Pk.class, List.of(
                f("codiSema", "codi_sema", "String", 8, true, true, false, "Codi Sema"),
                f("anio", "anio", "String", 4, true, true, false, "Anio"),
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("codiCarg", "codi_carg", "String", 5, false, false, false, "Codi Carg"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, true, false, "Codi Unid Oper"),
                f("grati", "grati", "BigDecimal", 0, false, false, false, "Grati"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("porcPart", "porc_part", "BigDecimal", 0, false, false, false, "Porc Part"),
                f("nroSema", "nro_sema", "Short", 0, false, false, false, "Nro Sema"),
                f("codiTipoPlan", "codi_tipo_plan", "String", 2, true, true, false, "Codi Tipo Plan"),
                f("mesanioProv", "mesanio_prov", "String", 6, false, false, false, "Mesanio Prov"),
                f("codiPlanOrig", "codi_plan_orig", "String", 2, true, true, false, "Codi Plan Orig"),
                f("mes", "mes", "String", 2, true, true, false, "Mes"),
                f("tipoCamb", "tipo_camb", "BigDecimal", 0, false, false, false, "Tipo Camb"))));
        add(new EntityMeta("desplazo_personal", "DESPLAZO_PERSONAL", "Desplazo Personal", DesplazoPersonal.class, null, List.of(
                f("codiDesplaPers", "codi_despla_pers", "Integer", 0, true, true, true, "Codi Despla Pers"),
                f("fechaInicio", "fecha_inicio", "LocalDateTime", 0, false, false, false, "Fecha Inicio"),
                f("fechaFin", "fecha_fin", "LocalDateTime", 0, false, false, false, "Fecha Fin"),
                f("codiEstable", "codi_estable", "String", 4, false, false, false, "Codi Estable"),
                f("indicador", "indicador", "String", 1, false, false, false, "Indicador"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("codiActi", "codi_acti", "Short", 0, false, false, false, "Codi Acti"))));
        add(new EntityMeta("desplazan_personal", "DESPLAZAN_PERSONAL", "Desplazan Personal", DesplazanPersonal.class, null, List.of(
                f("codiDesplazanPers", "codi_desplazan_pers", "Integer", 0, true, true, true, "Codi Desplazan Pers"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("codiActi", "codi_acti", "Short", 0, false, false, false, "Codi Acti"),
                f("fechaInic", "fecha_inic", "LocalDateTime", 0, false, false, false, "Fecha Inic"),
                f("fechaFin", "fecha_fin", "LocalDateTime", 0, false, false, false, "Fecha Fin"))));
        add(new EntityMeta("nivel", "NIVEL", "Nivel", Nivel.class, null, List.of(
                f("codiNivel", "codi_nivel", "Short", 0, true, true, false, "Codi Nivel"),
                f("codiNivelSunat", "codi_nivel_sunat", "String", 2, true, false, false, "Codi Nivel Sunat"),
                f("descNivel", "desc_nivel", "String", 150, true, false, false, "Desc Nivel"),
                f("nemoNivel", "nemo_nivel", "String", 20, false, false, false, "Nemo Nivel"))));
        add(new EntityMeta("periodicidad", "PERIODICIDAD", "Periodicidad", Periodicidad.class, null, List.of(
                f("codiPeriodo", "codi_periodo", "Short", 0, true, true, false, "Codi Periodo"),
                f("codiPeriodoSunat", "codi_periodo_sunat", "Short", 0, true, false, false, "Codi Periodo Sunat"),
                f("descPeriodo", "desc_periodo", "String", 50, true, false, false, "Desc Periodo"))));
        add(new EntityMeta("pension", "PENSION", "Pension", Pension.class, null, List.of(
                f("codiPension", "codi_pension", "Short", 0, true, true, false, "Codi Pension"),
                f("codiPensionSunat", "codi_pension_sunat", "Short", 0, true, false, false, "Codi Pension Sunat"),
                f("descPension", "desc_pension", "String", 150, true, false, false, "Desc Pension"),
                f("nemoPension", "nemo_pension", "String", 15, false, false, false, "Nemo Pension"))));
        add(new EntityMeta("pers_trip_vige_cert", "PERS_TRIP_VIGE_CERT", "Pers Trip Vige Cert", PersTripVigeCert.class, null, List.of(
                f("codiVigeCertTrip", "codi_vige_cert_trip", "String", 6, true, true, false, "Codi Vige Cert Trip"),
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("fechInicVige", "fech_inic_vige", "LocalDateTime", 0, false, false, false, "Fech Inic Vige"),
                f("fechTermVige", "fech_term_vige", "LocalDateTime", 0, false, false, false, "Fech Term Vige"),
                f("nroMatr", "nro_matr", "String", 12, false, false, false, "Nro Matr"),
                f("codiCarg", "codi_carg", "String", 4, false, false, false, "Codi Carg"),
                f("tipoTitu", "tipo_titu", "String", 2, false, false, false, "Tipo Titu"))));
        add(new EntityMeta("pers_soli", "Pers_Soli", "Pers Soli", PersSoli.class, null, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("apelPers", "apel_pers", "String", 100, false, false, false, "Apel Pers"))));
        add(new EntityMeta("pers_refe_labo", "PERS_REFE_LABO", "Pers Refe Labo", PersRefeLabo.class, PersRefeLabo.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 10, true, true, false, "Codi Pers"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, true, true, false, "Fech Inic"),
                f("fechTerm", "fech_term", "LocalDateTime", 0, false, false, false, "Fech Term"),
                f("empresa", "empresa", "String", 100, false, false, false, "Empresa"),
                f("cargo", "cargo", "String", 100, false, false, false, "Cargo"))));
        add(new EntityMeta("documento_vinculo", "DOCUMENTO_VINCULO", "Documento Vinculo", DocumentoVinculo.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("codiDocuVinculo", "codi_docu_vinculo", "Integer", 0, true, false, false, "Codi Docu Vinculo"),
                f("codiDocuVinculoSunat", "codi_docu_vinculo_sunat", "String", 3, false, false, false, "Codi Docu Vinculo Sunat"),
                f("descipcionDocu", "descipcion_docu", "String", 100, false, false, false, "Descipcion Docu"),
                f("descripcionAbre", "descripcion_abre", "String", 100, false, false, false, "Descripcion Abre"),
                f("vinculo", "vinculo", "String", 5, false, false, false, "Vinculo"))));
        add(new EntityMeta("jueces", "JUECES", "Jueces", Jueces.class, null, List.of(
                f("codiJuez", "codi_juez", "String", 3, true, true, false, "Codi Juez"),
                f("apel1", "apel_1", "String", 50, false, false, false, "Apel 1"),
                f("apel2", "apel_2", "String", 50, false, false, false, "Apel 2"),
                f("nomb1", "nomb_1", "String", 50, false, false, false, "Nomb 1"),
                f("nomb2", "nomb_2", "String", 50, false, false, false, "Nomb 2"),
                f("dni", "dni", "String", 12, false, false, false, "Dni"),
                f("cargo", "cargo", "String", 50, false, false, false, "Cargo"))));
        add(new EntityMeta("tipos_planillas", "TIPOS_PLANILLAS", "Tipos Planillas", TiposPlanillas.class, null, List.of(
                f("codiTipoPlan", "codi_tipo_plan", "String", 2, true, true, false, "Codi Tipo Plan"),
                f("descTipoPlan", "desc_tipo_plan", "String", 50, true, false, false, "Desc Tipo Plan"))));
        add(new EntityMeta("ingresos_quinta_categ", "INGRESOS_QUINTA_CATEG", "Ingresos Quinta Categ", IngresosQuintaCateg.class, null, List.of(
                f("codiIngre", "codi_ingre", "Long", 0, true, true, false, "Codi Ingre"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"),
                f("ano", "ano", "String", 4, false, false, false, "Ano"),
                f("mes", "mes", "String", 2, false, false, false, "Mes"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("reten", "reten", "BigDecimal", 0, false, false, false, "Reten"),
                f("rentaReten", "renta_reten", "BigDecimal", 0, false, false, false, "Renta Reten"))));
        add(new EntityMeta("convenio_evita_doble_tributacion", "CONVENIO_EVITA_DOBLE_TRIBUTACION", "Convenio Evita Doble Tributacion", ConvenioEvitaDobleTributacion.class, null, List.of(
                f("codConvEvitaDobTribu", "cod_conv_evita_dob_tribu", "Integer", 0, true, true, false, "Cod Conv Evita Dob Tribu"),
                f("descConvEvitaDobTribu", "desc_conv_evita_dob_tribu", "String", 50, false, false, false, "Desc Conv Evita Dob Tribu"),
                f("codSunat", "cod_sunat", "Integer", 0, false, false, false, "Cod Sunat"))));
        add(new EntityMeta("personal_periodo", "PERSONAL_PERIODO", "Personal Periodo", PersonalPeriodo.class, null, List.of(
                f("codiPeriodo", "codi_periodo", "Long", 0, true, true, false, "Codi Periodo"),
                f("codiPersCateg", "codi_pers_categ", "Long", 0, true, false, false, "Codi Pers Categ"),
                f("fechInicio", "fech_inicio", "LocalDateTime", 0, true, false, false, "Fech Inicio"),
                f("fechFin", "fech_fin", "LocalDateTime", 0, false, false, false, "Fech Fin"),
                f("codiMotiFinPeri", "codi_moti_fin_peri", "Short", 0, false, false, false, "Codi Moti Fin Peri"),
                f("codiModaForma", "codi_moda_forma", "Short", 0, false, false, false, "Codi Moda Forma"),
                f("nroOperacion", "nro_operacion", "String", 15, false, false, false, "Nro Operacion"),
                f("anio", "anio", "Short", 0, false, false, false, "Anio"),
                f("medioPresenta", "medio_presenta", "Short", 0, false, false, false, "Medio Presenta"))));
        add(new EntityMeta("personal_otros_emple_qta_cat", "PERSONAL_OTROS_EMPLE_QTA_CAT", "Personal Otros Emple Qta Cat", PersonalOtrosEmpleQtaCat.class, null, List.of(
                f("codiPoe", "codi_poe", "Long", 0, true, true, false, "Codi Poe"),
                f("codiPersCateg", "codi_pers_categ", "Long", 0, true, false, false, "Codi Pers Categ"),
                f("ruc", "ruc", "String", 11, true, false, false, "Ruc"),
                f("razonSocial", "razon_social", "String", 60, true, false, false, "Razon Social"))));
        add(new EntityMeta("personal_categoria", "PERSONAL_CATEGORIA", "Personal Categoria", PersonalCategoria.class, null, List.of(
                f("codiPersCateg", "codi_pers_categ", "Long", 0, true, true, false, "Codi Pers Categ"),
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("tipoCatTrab", "tipo_cat_trab", "String", 1, false, false, false, "Tipo Cat Trab"),
                f("essalud", "essalud", "Short", 0, false, false, false, "Essalud"),
                f("ruc", "ruc", "String", 11, false, false, false, "Ruc"),
                f("codiElemCosto", "codi_elem_costo", "Short", 0, false, false, false, "Codi Elem Costo"),
                f("codiTipoDocuIden", "codi_tipo_docu_iden", "Short", 0, false, false, false, "Codi Tipo Docu Iden"),
                f("codiTipoCont", "codi_tipo_cont", "Short", 0, false, false, false, "Codi Tipo Cont"),
                f("condiDomi", "condi_domi", "Short", 0, false, false, false, "Condi Domi"),
                f("codiTipoPers", "codi_tipo_pers", "Short", 0, false, false, false, "Codi Tipo Pers"),
                f("codiNivel", "codi_nivel", "Short", 0, false, false, false, "Codi Nivel"),
                f("codiOcu", "codi_ocu", "Short", 0, false, false, false, "Codi Ocu"),
                f("discapacidad", "discapacidad", "Short", 0, false, false, false, "Discapacidad"),
                f("codiPension", "codi_pension", "Short", 0, false, false, false, "Codi Pension"),
                f("fechIngre", "fech_ingre", "LocalDateTime", 0, false, false, false, "Fech Ingre"),
                f("nroCupss", "nro_cupss", "String", 20, false, false, false, "Nro Cupss"),
                f("scrt", "scrt", "Short", 0, false, false, false, "Scrt"),
                f("sctrPension", "sctr_pension", "Short", 0, false, false, false, "Sctr Pension"),
                f("sujetoRegAlter", "sujeto_reg_alter", "Short", 0, false, false, false, "Sujeto Reg Alter"),
                f("sujetoJornadaMax", "sujeto_jornada_max", "Short", 0, false, false, false, "Sujeto Jornada Max"),
                f("horarioNoctur", "horario_noctur", "Short", 0, false, false, false, "Horario Noctur"),
                f("sindicalizado", "sindicalizado", "Short", 0, false, false, false, "Sindicalizado"),
                f("codiPeriodo", "codi_periodo", "Short", 0, false, false, false, "Codi Periodo"),
                f("codiEnti", "codi_enti", "Short", 0, false, false, false, "Codi Enti"),
                f("codiSituTrabPens", "codi_situ_trab_pens", "Short", 0, false, false, false, "Codi Situ Trab Pens"),
                f("rentaQtaCatExoInaf", "renta_qta_cat_exo_inaf", "Short", 0, false, false, false, "Renta Qta Cat Exo Inaf"),
                f("regiLabo", "regi_labo", "Short", 0, false, false, false, "Regi Labo"),
                f("formPago", "form_pago", "String", 20, false, false, false, "Form Pago"),
                f("tipoSegMed", "tipo_seg_med", "Short", 0, false, false, false, "Tipo Seg Med"),
                f("madreRespFam", "madre_resp_fam", "Short", 0, false, false, false, "Madre Resp Fam"),
                f("centroFormProf", "centro_form_prof", "Short", 0, false, false, false, "Centro Form Prof"),
                f("codiCateTrab", "codi_cate_trab", "Short", 0, false, false, false, "Codi Cate Trab"),
                f("codiSistPens", "codi_sist_pens", "String", 2, false, false, false, "Codi Sist Pens"),
                f("inforOtrosIngrQtaCat", "infor_otros_ingr_qta_cat", "Short", 0, false, false, false, "Infor Otros Ingr Qta Cat"),
                f("afiEpsServProp", "afi_eps_serv_prop", "Short", 0, false, false, false, "Afi Eps Serv Prop"),
                f("codiTipoMedioPago", "codi_tipo_medio_pago", "Short", 0, false, false, false, "Codi Tipo Medio Pago"),
                f("codCategOcup", "cod_categ_ocup", "Integer", 0, false, false, false, "Cod Categ Ocup"),
                f("codConvEvitaDobTribu", "cod_conv_evita_dob_tribu", "Integer", 0, false, false, false, "Cod Conv Evita Dob Tribu"),
                f("afiliaAseguraPension", "afilia_asegura_pension", "Integer", 0, false, false, false, "Afilia Asegura Pension"),
                f("codiRegiLabo", "codi_regi_labo", "String", 2, false, false, false, "Codi Regi Labo"),
                f("afpMixta", "afp_mixta", "Integer", 0, false, false, false, "Afp Mixta"))));
        add(new EntityMeta("conceptos", "CONCEPTOS", "Conceptos", Conceptos.class, null, List.of(
                f("codiConc", "codi_conc", "String", 6, true, true, false, "Codi Conc"),
                f("descConc", "desc_conc", "String", 60, false, false, false, "Desc Conc"),
                f("estaActi", "esta_acti", "Boolean", 0, false, false, false, "Esta Acti"),
                f("nemo", "nemo", "String", 20, false, false, false, "Nemo"),
                f("codiSubConcepSunat", "codi_sub_concep_sunat", "Short", 0, false, false, false, "Codi Sub Concep Sunat"),
                f("variable", "variable", "String", 3, false, false, false, "Variable"))));
        add(new EntityMeta("juzgados", "JUZGADOS", "Juzgados", Juzgados.class, null, List.of(
                f("codiJuzg", "codi_juzg", "String", 2, true, true, false, "Codi Juzg"),
                f("descJuzg", "desc_juzg", "String", 200, false, false, false, "Desc Juzg"),
                f("ubicacion", "ubicacion", "String", 20, false, false, false, "Ubicacion"),
                f("direccion", "direccion", "String", 200, false, false, false, "Direccion"))));
        add(new EntityMeta("planilla_subsidio", "PLANILLA_SUBSIDIO", "Planilla Subsidio", PlanillaSubsidio.class, null, List.of(
                f("codiPlanSubs", "codi_plan_subs", "String", 10, true, true, false, "Codi Plan Subs"),
                f("mesanio", "mesanio", "String", 6, true, false, false, "Mesanio"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, false, false, "Codi Unid Oper"),
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("fechPago", "fech_pago", "LocalDateTime", 0, false, false, false, "Fech Pago"),
                f("formPago", "form_pago", "String", 15, false, false, false, "Form Pago"),
                f("nroCheque", "nro_cheque", "String", 15, false, false, false, "Nro Cheque"),
                f("tipo", "tipo", "String", 1, false, false, false, "Tipo"),
                f("codiSema", "codi_sema", "String", 8, false, false, false, "Codi Sema"))));
        add(new EntityMeta("pagos_prestamos", "PAGOS_PRESTAMOS", "Pagos Prestamos", PagosPrestamos.class, PagosPrestamos.Pk.class, List.of(
                f("codiPres", "codi_pres", "String", 6, true, true, false, "Codi Pres"),
                f("nroPago", "nro_pago", "String", 4, true, true, false, "Nro Pago"),
                f("fechPago", "fech_pago", "LocalDateTime", 0, true, false, false, "Fech Pago"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"),
                f("observacion", "observacion", "String", 150, false, false, false, "Observacion"))));
    }

    private void load3() {
        add(new EntityMeta("subsidios", "SUBSIDIOS", "Subsidios", Subsidios.class, Subsidios.Pk.class, List.of(
                f("mesanio", "mesanio", "String", 6, true, false, false, "Mesanio"),
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, true, false, "Codi Unid Oper"),
                f("codiCarg", "codi_carg", "String", 4, true, false, false, "Codi Carg"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"),
                f("dias", "dias", "Integer", 0, false, false, false, "Dias"),
                f("codiSema", "codi_sema", "String", 8, true, true, false, "Codi Sema"),
                f("certificado", "certificado", "String", 50, true, true, false, "Certificado"),
                f("fechaInicio", "fecha_inicio", "LocalDateTime", 0, false, false, false, "Fecha Inicio"),
                f("fechaFin", "fecha_fin", "LocalDateTime", 0, false, false, false, "Fecha Fin"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("tipocambio", "tipocambio", "BigDecimal", 0, false, false, false, "Tipocambio"),
                f("pagoempresa", "pagoempresa", "String", 1, false, false, false, "Pagoempresa"),
                f("pagoessalud", "pagoessalud", "String", 1, false, false, false, "Pagoessalud"),
                f("fechapago", "fechapago", "LocalDateTime", 0, false, false, false, "Fechapago"),
                f("observaciones", "observaciones", "String", 250, false, false, false, "Observaciones"))));
        add(new EntityMeta("parametros_quinta", "PARAMETROS_QUINTA", "Parametros Quinta", ParametrosQuinta.class, ParametrosQuinta.Pk.class, List.of(
                f("nroPara", "nro_para", "Short", 0, true, true, false, "Nro Para"),
                f("fechPara", "fech_para", "LocalDateTime", 0, true, true, false, "Fech Para"),
                f("estaPara", "esta_para", "Boolean", 0, true, false, false, "Esta Para"),
                f("nroMiniUit", "nro_mini_uit", "Integer", 0, true, false, false, "Nro Mini Uit"),
                f("nroMaxiUit", "nro_maxi_uit", "Integer", 0, true, false, false, "Nro Maxi Uit"),
                f("porcentaje", "porcentaje", "BigDecimal", 0, true, false, false, "Porcentaje"))));
        add(new EntityMeta("demandas", "DEMANDAS", "Demandas", Demandas.class, null, List.of(
                f("codiDema", "codi_dema", "String", 10, true, true, false, "Codi Dema"),
                f("nroExpe", "nro_expe", "String", 100, false, false, false, "Nro Expe"),
                f("materia", "materia", "String", 150, false, false, false, "Materia"),
                f("codiJuez", "codi_juez", "String", 3, false, false, false, "Codi Juez"),
                f("codiJuzg", "codi_juzg", "String", 2, false, false, false, "Codi Juzg"),
                f("codiEspe", "codi_espe", "String", 3, false, false, false, "Codi Espe"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("fechIngr", "fech_ingr", "LocalDateTime", 0, false, false, false, "Fech Ingr"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("codiCarg", "codi_carg", "String", 4, false, false, false, "Codi Carg"),
                f("antecedente", "antecedente", "String", 0, false, false, false, "Antecedente"),
                f("anio", "anio", "String", 4, false, false, false, "Anio"),
                f("secretaria", "secretaria", "String", 200, false, false, false, "Secretaria"),
                f("estado", "estado", "String", 50, false, false, false, "Estado"),
                f("fechRece", "fech_rece", "LocalDateTime", 0, false, false, false, "Fech Rece"),
                f("codiAbog", "codi_abog", "String", 3, false, false, false, "Codi Abog"),
                f("proceso", "proceso", "String", 20, false, false, false, "Proceso"),
                f("montoDema", "monto_dema", "BigDecimal", 0, false, false, false, "Monto Dema"),
                f("nombres", "nombres", "String", 200, false, false, false, "Nombres"),
                f("situActu", "situ_actu", "String", 0, false, false, false, "Situ Actu"))));
        add(new EntityMeta("grat_trip_deta_conc", "GRAT_TRIP_DETA_CONC", "Grat Trip Deta Conc", GratTripDetaConc.class, GratTripDetaConc.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("codiSemaInic", "codi_sema_inic", "String", 8, true, true, false, "Codi Sema Inic"),
                f("codiSemaFin", "codi_sema_fin", "String", 8, true, true, false, "Codi Sema Fin"),
                f("anio", "anio", "String", 4, true, true, false, "Anio"),
                f("codiConc", "codi_conc", "String", 6, true, true, false, "Codi Conc"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"),
                f("valor", "valor", "BigDecimal", 0, false, false, false, "Valor"),
                f("codiTipoPlan", "codi_tipo_plan", "String", 2, true, true, false, "Codi Tipo Plan"),
                f("mesanioProv", "mesanio_prov", "String", 6, false, false, false, "Mesanio Prov"),
                f("codiJuic", "codi_juic", "String", 6, false, false, false, "Codi Juic"),
                f("mes", "mes", "String", 2, true, true, false, "Mes"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, true, false, "Codi Unid Oper"))));
        add(new EntityMeta("extra_conta", "EXTRA_CONTA", "Extra Conta", ExtraConta.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("ruc", "ruc", "String", 11, false, false, false, "Ruc"),
                f("tm", "tm", "BigDecimal", 0, true, false, false, "Tm"),
                f("precTm", "prec_tm", "BigDecimal", 0, false, false, false, "Prec Tm"),
                f("comb", "comb", "Long", 0, false, false, false, "Comb"),
                f("preComb", "pre_comb", "BigDecimal", 0, false, false, false, "Pre Comb"),
                f("fdoRete", "fdo_rete", "BigDecimal", 0, false, false, false, "Fdo Rete"),
                f("up", "up", "BigDecimal", 0, false, false, false, "Up"))));
        add(new EntityMeta("extr_cont_liqu_pesc", "Extr_Cont_Liqu_pesc", "Extr Cont Liqu Pesc", ExtrContLiquPesc.class, ExtrContLiquPesc.Pk.class, List.of(
                f("codiSema", "codi_sema", "String", 8, true, true, false, "Codi Sema"),
                f("codiClieProv", "codi_clie_prov", "String", 5, true, true, false, "Codi Clie Prov"),
                f("precPact", "prec_pact", "BigDecimal", 0, true, true, false, "Prec Pact"),
                f("dscto", "dscto", "Long", 0, false, false, false, "Dscto"),
                f("codiBanc", "codi_banc", "String", 2, false, false, false, "Codi Banc"))));
        add(new EntityMeta("planilla_cts_conceptos", "PLANILLA_CTS_CONCEPTOS", "Planilla Cts Conceptos", PlanillaCtsConceptos.class, PlanillaCtsConceptos.Pk.class, List.of(
                f("codiPlanCts", "codi_plan_cts", "String", 10, true, true, false, "Codi Plan Cts"),
                f("codiConc", "codi_conc", "String", 6, true, true, false, "Codi Conc"),
                f("afecto", "afecto", "Boolean", 0, true, false, false, "Afecto"),
                f("valor", "valor", "BigDecimal", 0, true, false, false, "Valor"),
                f("monto", "monto", "BigDecimal", 0, true, false, false, "Monto"))));
        add(new EntityMeta("planilla_bonitri_conceptos", "Planilla_BoniTri_Conceptos", "Planilla Bonitri Conceptos", PlanillaBonitriConceptos.class, PlanillaBonitriConceptos.Pk.class, List.of(
                f("codiPlanBtri", "codi_plan_btri", "String", 10, true, true, false, "Codi Plan Btri"),
                f("codiConc", "codi_conc", "String", 6, true, true, false, "Codi Conc"),
                f("afecto", "afecto", "Boolean", 0, true, false, false, "Afecto"),
                f("valor", "valor", "BigDecimal", 0, true, false, false, "Valor"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"),
                f("especial", "especial", "BigDecimal", 0, false, false, false, "Especial"),
                f("codi", "codi", "String", 2, false, false, false, "Codi"))));
        add(new EntityMeta("calc_util_tota", "CALC_UTIL_TOTA", "Calc Util Tota", CalcUtilTota.class, null, List.of(
                f("anio", "anio", "String", 4, true, true, false, "Anio"),
                f("rentaNeta", "renta_neta", "BigDecimal", 0, false, false, false, "Renta Neta"),
                f("participacion", "participacion", "BigDecimal", 0, false, false, false, "Participacion"),
                f("remuPercTota", "remu_perc_tota", "BigDecimal", 0, false, false, false, "Remu Perc Tota"),
                f("diasLaboTota", "dias_labo_tota", "Long", 0, false, false, false, "Dias Labo Tota"))));
        add(new EntityMeta("calc_util_pers", "CALC_UTIL_PERS", "Calc Util Pers", CalcUtilPers.class, CalcUtilPers.Pk.class, List.of(
                f("anio", "anio", "String", 4, true, true, false, "Anio"),
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("apellidos", "apellidos", "String", 50, false, false, false, "Apellidos"),
                f("nombres", "nombres", "String", 50, false, false, false, "Nombres"),
                f("remuPerc", "remu_perc", "BigDecimal", 0, false, false, false, "Remu Perc"),
                f("diasLabo", "dias_labo", "Long", 0, false, false, false, "Dias Labo"),
                f("liqRemuPerc", "liq_remu_perc", "BigDecimal", 0, false, false, false, "Liq Remu Perc"),
                f("liqDiasLabo", "liq_dias_labo", "BigDecimal", 0, false, false, false, "Liq Dias Labo"),
                f("liqTota", "liq_tota", "BigDecimal", 0, false, false, false, "Liq Tota"),
                f("mes", "mes", "String", 2, false, false, false, "Mes"))));
        add(new EntityMeta("calc_util_deta", "CALC_UTIL_DETA", "Calc Util Deta", CalcUtilDeta.class, CalcUtilDeta.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("anio", "anio", "String", 4, true, true, false, "Anio"),
                f("codiConc", "codi_conc", "String", 7, true, true, false, "Codi Conc"),
                f("valor", "valor", "BigDecimal", 0, false, false, false, "Valor"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"),
                f("codiAuxi", "codi_auxi", "String", 10, false, false, false, "Codi Auxi"),
                f("nroPago", "nro_pago", "Integer", 0, false, false, false, "Nro Pago"))));
        add(new EntityMeta("planilla_boni_tripu", "Planilla_Boni_tripu", "Planilla Boni Tripu", PlanillaBoniTripu.class, null, List.of(
                f("codiPlanBtri", "codi_plan_btri", "String", 10, true, true, false, "Codi Plan Btri"),
                f("codiSema", "codi_sema", "String", 8, true, false, false, "Codi Sema"),
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("codiTipoPlan", "codi_tipo_plan", "String", 2, true, false, false, "Codi Tipo Plan"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("formPago", "form_pago", "String", 20, false, false, false, "Form Pago"),
                f("nroCheque", "nro_cheque", "String", 30, false, false, false, "Nro Cheque"),
                f("fechPago", "fech_pago", "LocalDateTime", 0, false, false, false, "Fech Pago"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, false, false, "Codi Unid Oper"),
                f("importeEspecial", "importe_especial", "BigDecimal", 0, false, false, false, "Importe Especial"),
                f("nroAsis", "nro_asis", "String", 1, false, false, false, "Nro Asis"),
                f("mesanio", "mesanio", "String", 6, false, false, false, "Mesanio"))));
        add(new EntityMeta("planilla_boni_moto", "PLANILLA_BONI_MOTO", "Planilla Boni Moto", PlanillaBoniMoto.class, null, List.of(
                f("codiPlanBoni", "codi_plan_boni", "String", 10, true, true, false, "Codi Plan Boni"),
                f("mesanio", "mesanio", "String", 6, true, false, false, "Mesanio"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, false, false, "Codi Unid Oper"),
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("fechPago", "fech_pago", "LocalDateTime", 0, false, false, false, "Fech Pago"),
                f("formPago", "form_pago", "String", 15, false, false, false, "Form Pago"),
                f("nroCheque", "nro_cheque", "String", 15, false, false, false, "Nro Cheque"),
                f("tipo", "tipo", "String", 1, false, false, false, "Tipo"))));
        add(new EntityMeta("juicios_empresa", "JUICIOS_EMPRESA", "Juicios Empresa", JuiciosEmpresa.class, null, List.of(
                f("codiJuicEmpr", "codi_juic_empr", "String", 5, true, true, false, "Codi Juic Empr"),
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, false, false, false, "Fech Inic"),
                f("fechTerm", "fech_term", "LocalDateTime", 0, false, false, false, "Fech Term"),
                f("descJuic", "desc_juic", "String", 100, false, false, false, "Desc Juic"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"),
                f("juzgado", "juzgado", "String", 100, false, false, false, "Juzgado"),
                f("nombJuez", "nomb_juez", "String", 100, false, false, false, "Nomb Juez"),
                f("observacion", "observacion", "String", 200, false, false, false, "Observacion"),
                f("nroExp", "nro_exp", "String", 15, false, false, false, "Nro Exp"),
                f("activo", "activo", "Boolean", 0, false, false, false, "Activo"))));
        add(new EntityMeta("adelanto_ep_terceros", "Adelanto_EP_terceros", "Adelanto Ep Terceros", AdelantoEpTerceros.class, null, List.of(
                f("codiAdelTerc", "codi_adel_terc", "String", 6, true, true, false, "Codi Adel Terc"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, false, false, "Codi Unid Oper"),
                f("nroAdel", "nro_adel", "Integer", 0, true, false, false, "Nro Adel"),
                f("fechAdel", "fech_adel", "LocalDateTime", 0, true, false, false, "Fech Adel"),
                f("motiAdel", "moti_adel", "String", 100, false, false, false, "Moti Adel"),
                f("estaPago", "esta_pago", "Boolean", 0, true, false, false, "Esta Pago"),
                f("codiMoneAdel", "codi_mone_adel", "String", 2, true, false, false, "Codi Mone Adel"),
                f("montAdel", "mont_adel", "BigDecimal", 0, true, false, false, "Mont Adel"),
                f("codiSema", "codi_sema", "String", 8, false, false, false, "Codi Sema"))));
        add(new EntityMeta("personal_por_tipo_trabajador", "PERSONAL_POR_TIPO_TRABAJADOR", "Personal Por Tipo Trabajador", PersonalPorTipoTrabajador.class, PersonalPorTipoTrabajador.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("codiTipoPers", "codi_tipo_pers", "String", 2, true, true, false, "Codi Tipo Pers"))));
        add(new EntityMeta("personal", "PERSONAL", "Personal", Personal.class, null, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"),
                f("nroDocuIden", "nro_docu_iden", "String", 20, false, false, false, "Nro Docu Iden"),
                f("apel1", "apel_1", "String", 50, false, false, false, "Apel 1"),
                f("apel2", "apel_2", "String", 50, false, false, false, "Apel 2"),
                f("nomb1", "nomb_1", "String", 50, false, false, false, "Nomb 1"),
                f("nomb2", "nomb_2", "String", 50, false, false, false, "Nomb 2"),
                f("codiSistPens", "codi_sist_pens", "String", 2, false, false, false, "Codi Sist Pens"),
                f("codiCarg", "codi_carg", "String", 4, false, false, false, "Codi Carg"),
                f("codiArea", "codi_area", "String", 2, false, false, false, "Codi Area"),
                f("codiMoneBasi", "codi_mone_basi", "String", 2, false, false, false, "Codi Mone Basi"),
                f("suelBasi", "suel_basi", "BigDecimal", 0, false, false, false, "Suel Basi"),
                f("fechIngre", "fech_ingre", "LocalDateTime", 0, false, false, false, "Fech Ingre"),
                f("essalud", "essalud", "Boolean", 0, false, false, false, "Essalud"),
                f("carnEssalud", "carn_essalud", "String", 30, false, false, false, "Carn Essalud"),
                f("estaCivi", "esta_civi", "String", 1, false, false, false, "Esta Civi"),
                f("fechNaci", "fech_naci", "LocalDateTime", 0, false, false, false, "Fech Naci"),
                f("asigFami", "asig_fami", "Boolean", 0, false, false, false, "Asig Fami"),
                f("estaActi", "esta_acti", "Boolean", 0, true, false, false, "Esta Acti"),
                f("scrt", "scrt", "Boolean", 0, false, false, false, "Scrt"),
                f("comiPesc", "comi_pesc", "Boolean", 0, false, false, false, "Comi Pesc"),
                f("nroCupss", "nro_cupss", "String", 20, false, false, false, "Nro Cupss"),
                f("afilSind", "afil_sind", "Boolean", 0, false, false, false, "Afil Sind"),
                f("nroCenso", "nro_censo", "String", 20, false, false, false, "Nro Censo"),
                f("tipoCont", "tipo_cont", "String", 1, false, false, false, "Tipo Cont"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("suelNeto", "suel_neto", "BigDecimal", 0, false, false, false, "Suel Neto"),
                f("cargFami", "carg_fami", "Boolean", 0, false, false, false, "Carg Fami"),
                f("sexo", "sexo", "String", 1, false, false, false, "Sexo"),
                f("nacionalidad", "nacionalidad", "String", 50, false, false, false, "Nacionalidad"),
                f("direccion", "direccion", "String", 150, false, false, false, "Direccion"),
                f("eMail", "e_mail", "String", 50, false, false, false, "E Mail"),
                f("tipoSituLabo", "tipo_situ_labo", "String", 1, false, false, false, "Tipo Situ Labo"),
                f("seguVidaLey", "segu_vida_ley", "Boolean", 0, false, false, false, "Segu Vida Ley"),
                f("nroLibEmb", "nro_lib_emb", "String", 15, false, false, false, "Nro Lib Emb"),
                f("fechCese", "fech_cese", "LocalDateTime", 0, false, false, false, "Fech Cese"),
                f("clave", "clave", "String", 4, false, false, false, "Clave"),
                f("jubilado", "jubilado", "Boolean", 0, true, false, false, "Jubilado"),
                f("formPago", "form_pago", "String", 20, false, false, false, "Form Pago"),
                f("codiAnti", "codi_anti", "String", 10, false, false, false, "Codi Anti"),
                f("montPagoCome", "mont_pago_come", "BigDecimal", 0, false, false, false, "Mont Pago Come"),
                f("horaLabo", "hora_labo", "BigDecimal", 0, false, false, false, "Hora Labo"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("fechInicJubi", "fech_inic_jubi", "LocalDateTime", 0, false, false, false, "Fech Inic Jubi"),
                f("codiRela", "codi_rela", "String", 5, false, false, false, "Codi Rela"),
                f("motiCese", "moti_cese", "String", 200, false, false, false, "Moti Cese"),
                f("provincia", "provincia", "String", 70, false, false, false, "Provincia"),
                f("distrito", "distrito", "String", 30, false, false, false, "Distrito"),
                f("vcmto", "vcmto", "LocalDateTime", 0, false, false, false, "Vcmto"),
                f("departamento", "departamento", "String", 60, false, false, false, "Departamento"),
                f("observaciones", "observaciones", "String", 200, false, false, false, "Observaciones"),
                f("codiTipoRies", "codi_tipo_ries", "String", 2, false, false, false, "Codi Tipo Ries"),
                f("ubigeo", "ubigeo", "String", 10, false, false, false, "Ubigeo"),
                f("fotoSiNo", "foto_si_no", "Boolean", 0, false, false, false, "Foto Si No"),
                f("fechInicAfil", "fech_inic_afil", "LocalDateTime", 0, false, false, false, "Fech Inic Afil"),
                f("distNaci", "dist_naci", "String", 100, false, false, false, "Dist Naci"),
                f("provNaci", "prov_naci", "String", 100, false, false, false, "Prov Naci"),
                f("codiAreaGrup", "codi_area_grup", "String", 2, false, false, false, "Codi Area Grup"),
                f("codiSubAreaGrup", "codi_sub_area_grup", "String", 4, false, false, false, "Codi Sub Area Grup"),
                f("horaAuto", "hora_auto", "BigDecimal", 0, false, false, false, "Hora Auto"),
                f("grat", "grat", "Boolean", 0, false, false, false, "Grat"),
                f("vaca", "vaca", "Boolean", 0, false, false, false, "Vaca"),
                f("codiLugaTrab", "codi_luga_trab", "String", 2, false, false, false, "Codi Luga Trab"),
                f("afectoLey", "afecto_ley", "Boolean", 0, false, false, false, "Afecto Ley"),
                f("fotocheck", "fotocheck", "Integer", 0, false, false, false, "Fotocheck"),
                f("horario", "horario", "Short", 0, false, false, false, "Horario"),
                f("codiCateTrab", "codi_cate_trab", "Short", 0, false, false, false, "Codi Cate Trab"),
                f("aporEssa", "apor_essa", "Boolean", 0, false, false, false, "Apor Essa"),
                f("aporSena", "apor_sena", "Boolean", 0, false, false, false, "Apor Sena"),
                f("aporSenc", "apor_senc", "Boolean", 0, false, false, false, "Apor Senc"),
                f("aporCona", "apor_cona", "Boolean", 0, false, false, false, "Apor Cona"),
                f("tipoSangr", "tipo_sangr", "String", 5, false, false, false, "Tipo Sangr"),
                f("pesoKilo", "peso_kilo", "BigDecimal", 0, false, false, false, "Peso Kilo"),
                f("tallMetr", "tall_metr", "BigDecimal", 0, false, false, false, "Tall Metr"),
                f("codiElemCosto", "codi_elem_costo", "Short", 0, false, false, false, "Codi Elem Costo"),
                f("codiTipoDocuIden", "codi_tipo_docu_iden", "Short", 0, false, false, false, "Codi Tipo Docu Iden"),
                f("codiNacion", "codi_nacion", "Short", 0, false, false, false, "Codi Nacion"),
                f("codiVia", "codi_via", "Short", 0, false, false, false, "Codi Via"),
                f("nombVia", "nomb_via", "String", 20, false, false, false, "Nomb Via"),
                f("numVia", "num_via", "String", 4, false, false, false, "Num Via"),
                f("interiorVia", "interior_via", "String", 4, false, false, false, "Interior Via"),
                f("codiZona", "codi_zona", "Short", 0, false, false, false, "Codi Zona"),
                f("nombZona", "nomb_zona", "String", 20, false, false, false, "Nomb Zona"),
                f("codiUbiReg", "codi_ubi_reg", "Short", 0, false, false, false, "Codi Ubi Reg"),
                f("codiUbiProv", "codi_ubi_prov", "Short", 0, false, false, false, "Codi Ubi Prov"),
                f("codiUbiDist", "codi_ubi_dist", "Short", 0, false, false, false, "Codi Ubi Dist"),
                f("telefono", "telefono", "String", 8, false, false, false, "Telefono"),
                f("condiDomi", "condi_domi", "Short", 0, false, false, false, "Condi Domi"),
                f("codiPension", "codi_pension", "Short", 0, false, false, false, "Codi Pension"),
                f("codiSituTrabPens", "codi_situ_trab_pens", "Short", 0, false, false, false, "Codi Situ Trab Pens"),
                f("codiMotiFinPeri", "codi_moti_fin_peri", "Short", 0, false, false, false, "Codi Moti Fin Peri"),
                f("ruc", "ruc", "String", 11, false, false, false, "Ruc"),
                f("laboraSabado", "labora_sabado", "String", 1, false, false, false, "Labora Sabado"),
                f("refeZona", "refe_zona", "String", 40, false, false, false, "Refe Zona"),
                f("codiEmpreEstab", "codi_empre_estab", "Integer", 0, false, false, false, "Codi Empre Estab"),
                f("codiPaisEmi", "codi_pais_emi", "String", 3, false, false, false, "Codi Pais Emi"))));
        add(new EntityMeta("plan_conc_desc", "PLAN_CONC_DESC", "Plan Conc Desc", PlanConcDesc.class, null, List.of(
                f("codiPrin", "codi_prin", "String", 10, true, true, false, "Codi Prin"),
                f("codiPlanConc", "codi_plan_conc", "String", 10, true, false, false, "Codi Plan Conc"),
                f("codiConc", "codi_conc", "String", 6, true, false, false, "Codi Conc"),
                f("codiDesc", "codi_desc", "String", 10, true, false, false, "Codi Desc"),
                f("nroPago", "nro_pago", "Integer", 0, false, false, false, "Nro Pago"),
                f("codiTipoTrab", "codi_tipo_trab", "String", 2, true, false, false, "Codi Tipo Trab"),
                f("indiTipoDesc", "indi_tipo_desc", "String", 2, true, false, false, "Indi Tipo Desc"),
                f("valor", "valor", "BigDecimal", 0, true, false, false, "Valor"),
                f("indiTiemDesc", "indi_tiem_desc", "String", 10, false, false, false, "Indi Tiem Desc"))));
        add(new EntityMeta("planilla_grati_vaca_concep", "PLANILLA_GRATI_VACA_CONCEP", "Planilla Grati Vaca Concep", PlanillaGratiVacaConcep.class, PlanillaGratiVacaConcep.Pk.class, List.of(
                f("codiPlanGrva", "codi_plan_grva", "String", 10, true, true, false, "Codi Plan Grva"),
                f("codiConc", "codi_conc", "String", 6, true, true, false, "Codi Conc"),
                f("afecto", "afecto", "Boolean", 0, false, false, false, "Afecto"),
                f("valor", "valor", "BigDecimal", 0, false, false, false, "Valor"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"),
                f("codi", "codi", "String", 2, false, false, false, "Codi"))));
        add(new EntityMeta("auto_trab_cent_oper", "AUTO_TRAB_CENT_OPER", "Auto Trab Cent Oper", AutoTrabCentOper.class, null, List.of(
                f("codiAutoTrabCo", "codi_auto_trab_co", "String", 5, true, true, false, "Codi Auto Trab Co"),
                f("nroAuto", "nro_auto", "Integer", 0, true, false, false, "Nro Auto"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("unidOperSoli", "unid_oper_soli", "String", 5, false, false, false, "Unid Oper Soli"),
                f("unidOperCo", "unid_oper_co", "String", 5, false, false, false, "Unid Oper Co"),
                f("codiPuerOper", "codi_puer_oper", "String", 2, false, false, false, "Codi Puer Oper"),
                f("lugar", "lugar", "String", 250, false, false, false, "Lugar"),
                f("codiUsuaSoli", "codi_usua_soli", "String", 5, false, false, false, "Codi Usua Soli"),
                f("codiUsuaJefeTall", "codi_usua_jefe_tall", "String", 5, false, false, false, "Codi Usua Jefe Tall"),
                f("codiUsuaAutoMant", "codi_usua_auto_mant", "String", 5, false, false, false, "Codi Usua Auto Mant"),
                f("codiUsuaAutoFlot", "codi_usua_auto_flot", "String", 5, false, false, false, "Codi Usua Auto Flot"),
                f("descGeneTrab", "desc_gene_trab", "String", 250, false, false, false, "Desc Gene Trab"),
                f("descGeneTrab1", "desc_gene_trab_1", "String", 250, false, false, false, "Desc Gene Trab 1"))));
        add(new EntityMeta("asistencia_tripulantes_pesca", "ASISTENCIA_TRIPULANTES_PESCA", "Asistencia Tripulantes Pesca", AsistenciaTripulantesPesca.class, AsistenciaTripulantesPesca.Pk.class, List.of(
                f("codiSema", "codi_sema", "String", 8, true, true, false, "Codi Sema"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, true, false, "Codi Unid Oper"),
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("codiCarg", "codi_carg", "String", 4, true, false, false, "Codi Carg"),
                f("jueves", "jueves", "String", 1, false, false, false, "Jueves"),
                f("viernes", "viernes", "String", 1, false, false, false, "Viernes"),
                f("sabado", "sabado", "String", 1, false, false, false, "Sabado"),
                f("domingo", "domingo", "String", 1, false, false, false, "Domingo"),
                f("lunes", "lunes", "String", 1, false, false, false, "Lunes"),
                f("martes", "martes", "String", 1, false, false, false, "Martes"),
                f("miercoles", "miercoles", "String", 1, false, false, false, "Miercoles"),
                f("juevCarg", "juev_carg", "String", 4, false, false, false, "Juev Carg"),
                f("vierCarg", "vier_carg", "String", 4, false, false, false, "Vier Carg"),
                f("sabaCarg", "saba_carg", "String", 4, false, false, false, "Saba Carg"),
                f("domiCarg", "domi_carg", "String", 4, false, false, false, "Domi Carg"),
                f("luneCarg", "lune_carg", "String", 4, false, false, false, "Lune Carg"),
                f("martCarg", "mart_carg", "String", 4, false, false, false, "Mart Carg"),
                f("mierCarg", "mier_carg", "String", 4, false, false, false, "Mier Carg"),
                f("nroAsis", "nro_asis", "String", 1, true, true, false, "Nro Asis"),
                f("mesanio", "mesanio", "String", 6, false, false, false, "Mesanio"))));
        add(new EntityMeta("planilla_subs_concepto", "PLANILLA_SUBS_CONCEPTO", "Planilla Subs Concepto", PlanillaSubsConcepto.class, PlanillaSubsConcepto.Pk.class, List.of(
                f("codiPlanSubs", "codi_plan_subs", "String", 10, true, true, false, "Codi Plan Subs"),
                f("codiConc", "codi_conc", "String", 6, true, true, false, "Codi Conc"),
                f("afecto", "afecto", "String", 1, true, false, false, "Afecto"),
                f("valor", "valor", "BigDecimal", 0, false, false, false, "Valor"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"))));
        add(new EntityMeta("planilla_boni_concepto", "PLANILLA_BONI_CONCEPTO", "Planilla Boni Concepto", PlanillaBoniConcepto.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("codiPlanBoni", "codi_plan_boni", "String", 10, true, false, false, "Codi Plan Boni"),
                f("codiConc", "codi_conc", "String", 6, true, false, false, "Codi Conc"),
                f("afecto", "afecto", "String", 1, true, false, false, "Afecto"),
                f("valor", "valor", "BigDecimal", 0, false, false, false, "Valor"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"))));
        add(new EntityMeta("conceptos_contables", "CONCEPTOS_CONTABLES", "Conceptos Contables", ConceptosContables.class, ConceptosContables.Pk.class, List.of(
                f("codiConc", "codi_conc", "String", 6, true, true, false, "Codi Conc"),
                f("nroCuen", "nro_cuen", "String", 7, true, true, false, "Nro Cuen"),
                f("codiConcFina", "codi_conc_fina", "String", 6, false, false, false, "Codi Conc Fina"),
                f("cargAbon", "carg_abon", "String", 1, false, false, false, "Carg Abon"),
                f("tipoCont", "tipo_cont", "String", 1, true, true, false, "Tipo Cont"),
                f("codiTipoPlan", "codi_tipo_plan", "String", 2, true, true, false, "Codi Tipo Plan"),
                f("codiTipoProv", "codi_tipo_prov", "String", 2, false, false, false, "Codi Tipo Prov"),
                f("codiTipoPers", "codi_tipo_pers", "String", 2, true, true, false, "Codi Tipo Pers"),
                f("codiUniOper", "codi_uni_oper", "String", 5, false, false, false, "Codi Uni Oper"),
                f("factMult", "fact_mult", "BigDecimal", 0, false, false, false, "Fact Mult"),
                f("codiSistPens", "codi_sist_pens", "String", 2, false, false, false, "Codi Sist Pens"),
                f("codiRela", "codi_rela", "String", 5, false, false, false, "Codi Rela"))));
        add(new EntityMeta("conceptos_afectos_planillas", "CONCEPTOS_AFECTOS_PLANILLAS", "Conceptos Afectos Planillas", ConceptosAfectosPlanillas.class, ConceptosAfectosPlanillas.Pk.class, List.of(
                f("codiConc", "codi_conc", "String", 6, true, true, false, "Codi Conc"),
                f("codiTipoPlan", "codi_tipo_plan", "String", 2, true, true, false, "Codi Tipo Plan"),
                f("fechRegi", "fech_regi", "LocalDateTime", 0, true, true, false, "Fech Regi"),
                f("afecto", "afecto", "Boolean", 0, true, false, false, "Afecto"),
                f("estaActi", "esta_acti", "Boolean", 0, true, false, false, "Esta Acti"),
                f("codiValoUnit", "codi_valo_unit", "Integer", 0, false, false, false, "Codi Valo Unit"),
                f("rubro", "rubro", "String", 2, false, false, false, "Rubro"),
                f("grupo", "grupo", "String", 1, false, false, false, "Grupo"),
                f("formula", "formula", "String", 250, false, false, false, "Formula"))));
    }

    private void load4() {
        add(new EntityMeta("valores_sistema_pensiones", "VALORES_SISTEMA_PENSIONES", "Valores Sistema Pensiones", ValoresSistemaPensiones.class, ValoresSistemaPensiones.Pk.class, List.of(
                f("codiSistPens", "codi_sist_pens", "String", 2, true, true, false, "Codi Sist Pens"),
                f("codiRubr", "codi_rubr", "String", 3, true, true, false, "Codi Rubr"),
                f("anioMes", "anio_mes", "String", 6, true, true, false, "Anio Mes"),
                f("valor", "valor", "BigDecimal", 0, true, false, false, "Valor"))));
        add(new EntityMeta("planilla_de_tripulantes", "PLANILLA_DE_TRIPULANTES", "Planilla De Tripulantes", PlanillaDeTripulantes.class, null, List.of(
                f("codiPlanTrip", "codi_plan_trip", "String", 10, true, true, false, "Codi Plan Trip"),
                f("codiSema", "codi_sema", "String", 8, true, false, false, "Codi Sema"),
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("codiTipoPlan", "codi_tipo_plan", "String", 2, true, false, false, "Codi Tipo Plan"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("formPago", "form_pago", "String", 20, false, false, false, "Form Pago"),
                f("nroCheq", "nro_cheq", "String", 30, false, false, false, "Nro Cheq"),
                f("fechPago", "fech_pago", "LocalDateTime", 0, false, false, false, "Fech Pago"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, false, false, "Codi Unid Oper"),
                f("importeEspecial", "importe_especial", "BigDecimal", 0, false, false, false, "Importe Especial"),
                f("nroAsis", "nro_asis", "String", 1, false, false, false, "Nro Asis"),
                f("mesanio", "mesanio", "String", 6, false, false, false, "Mesanio"))));
        add(new EntityMeta("incrementos_personal", "INCREMENTOS_PERSONAL", "Incrementos Personal", IncrementosPersonal.class, IncrementosPersonal.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("nroIncre", "nro_incre", "Short", 0, true, true, false, "Nro Incre"),
                f("descIncr", "desc_incr", "String", 100, false, false, false, "Desc Incr"),
                f("tipoIncre", "tipo_incre", "Boolean", 0, true, false, false, "Tipo Incre"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("valor", "valor", "BigDecimal", 0, true, false, false, "Valor"),
                f("estaActi", "esta_acti", "Boolean", 0, true, false, false, "Esta Acti"))));
        add(new EntityMeta("hora_pers_fech", "HORA_PERS_FECH", "Hora Pers Fech", HoraPersFech.class, HoraPersFech.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, true, true, false, "Fech Inic"),
                f("fechFin", "fech_fin", "LocalDateTime", 0, false, false, false, "Fech Fin"),
                f("codiHora", "codi_hora", "Short", 0, false, false, false, "Codi Hora"))));
        add(new EntityMeta("planilla_de_obreros", "PLANILLA_DE_OBREROS", "Planilla De Obreros", PlanillaDeObreros.class, null, List.of(
                f("codiPlanObre", "codi_plan_obre", "String", 10, true, true, false, "Codi Plan Obre"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, true, false, false, "Fech Inic"),
                f("fechTerm", "fech_term", "LocalDateTime", 0, false, false, false, "Fech Term"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"),
                f("codiTipoPlan", "codi_tipo_plan", "String", 2, false, false, false, "Codi Tipo Plan"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("anio", "anio", "String", 4, true, false, false, "Anio"),
                f("mes", "mes", "String", 2, true, false, false, "Mes"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("indiTiem", "indi_tiem", "String", 5, true, false, false, "Indi Tiem"),
                f("formPago", "form_pago", "String", 20, false, false, false, "Form Pago"),
                f("nroCheq", "nro_cheq", "String", 30, false, false, false, "Nro Cheq"),
                f("fechPago", "fech_pago", "LocalDateTime", 0, false, false, false, "Fech Pago"),
                f("codiSistPens", "codi_sist_pens", "String", 2, false, false, false, "Codi Sist Pens"),
                f("codiTipoPers", "codi_tipo_pers", "String", 2, false, false, false, "Codi Tipo Pers"),
                f("semana", "semana", "Short", 0, false, false, false, "Semana"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"))));
        add(new EntityMeta("plan_conc_incr", "PLAN_CONC_INCR", "Plan Conc Incr", PlanConcIncr.class, null, List.of(
                f("codiPrin", "codi_prin", "String", 10, true, true, false, "Codi Prin"),
                f("codiPlanConc", "codi_plan_conc", "String", 10, true, false, false, "Codi Plan Conc"),
                f("codiConc", "codi_conc", "String", 6, true, false, false, "Codi Conc"),
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("nroIncre", "nro_incre", "Integer", 0, true, false, false, "Nro Incre"),
                f("codiTipoPers", "codi_tipo_pers", "String", 2, true, false, false, "Codi Tipo Pers"),
                f("valor", "valor", "BigDecimal", 0, true, false, false, "Valor"))));
        add(new EntityMeta("personal_turno", "PERSONAL_TURNO", "Personal Turno", PersonalTurno.class, PersonalTurno.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("codiTurn", "codi_turn", "String", 2, true, true, false, "Codi Turn"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, true, true, false, "Fech Inic"),
                f("fechTerm", "fech_term", "LocalDateTime", 0, false, false, false, "Fech Term"))));
        add(new EntityMeta("personal_seguros", "PERSONAL_SEGUROS", "Personal Seguros", PersonalSeguros.class, PersonalSeguros.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("codiSegu", "codi_segu", "Short", 0, true, true, false, "Codi Segu"),
                f("fechSegu", "fech_segu", "LocalDateTime", 0, true, true, false, "Fech Segu"),
                f("tipoCant", "tipo_cant", "Boolean", 0, false, false, false, "Tipo Cant"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("valor", "valor", "BigDecimal", 0, false, false, false, "Valor"))));
        add(new EntityMeta("adelantos", "ADELANTOS", "Adelantos", Adelantos.class, null, List.of(
                f("codiAdel", "codi_adel", "String", 6, true, true, false, "Codi Adel"),
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("nroAdel", "nro_adel", "Integer", 0, true, false, false, "Nro Adel"),
                f("fechAdel", "fech_adel", "LocalDateTime", 0, true, false, false, "Fech Adel"),
                f("motiAdel", "moti_adel", "String", 100, false, false, false, "Moti Adel"),
                f("estaPago", "esta_pago", "Boolean", 0, true, false, false, "Esta Pago"),
                f("codiMoneAdel", "codi_mone_adel", "String", 2, true, false, false, "Codi Mone Adel"),
                f("montAdel", "mont_adel", "BigDecimal", 0, true, false, false, "Mont Adel"),
                f("tipoAdel", "tipo_adel", "String", 5, false, false, false, "Tipo Adel"),
                f("inteTiemDesc", "inte_tiem_desc", "String", 20, false, false, false, "Inte Tiem Desc"),
                f("montPago", "mont_pago", "BigDecimal", 0, false, false, false, "Mont Pago"),
                f("saldo", "saldo", "BigDecimal", 0, false, false, false, "Saldo"),
                f("regiAdel", "regi_adel", "String", 10, false, false, false, "Regi Adel"))));
        add(new EntityMeta("vacaciones", "VACACIONES", "Vacaciones", Vacaciones.class, Vacaciones.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, true, true, false, "Fech Inic"),
                f("fechTerm", "fech_term", "LocalDateTime", 0, false, false, false, "Fech Term"),
                f("nroDias", "nro_dias", "Short", 0, false, false, false, "Nro Dias"),
                f("anio", "anio", "String", 4, true, false, false, "Anio"),
                f("mes", "mes", "String", 2, true, false, false, "Mes"),
                f("estaActi", "esta_acti", "Boolean", 0, false, false, false, "Esta Acti"),
                f("observaciones", "observaciones", "String", 200, false, false, false, "Observaciones"),
                f("codiTipoVaca", "codi_tipo_vaca", "String", 2, false, false, false, "Codi Tipo Vaca"),
                f("anioIni", "anio_ini", "String", 4, false, false, false, "Anio Ini"),
                f("anioFin", "anio_fin", "String", 4, false, false, false, "Anio Fin"))));
        add(new EntityMeta("auto_trab_cent_oper_deta", "AUTO_TRAB_CENT_OPER_DETA", "Auto Trab Cent Oper Deta", AutoTrabCentOperDeta.class, AutoTrabCentOperDeta.Pk.class, List.of(
                f("codiAutoTrabCo", "codi_auto_trab_co", "String", 5, true, true, false, "Codi Auto Trab Co"),
                f("nroDeta", "nro_deta", "Short", 0, true, true, false, "Nro Deta"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, false, false, false, "Fech Inic"),
                f("fechTerm", "fech_term", "LocalDateTime", 0, false, false, false, "Fech Term"),
                f("numeHoraNorm", "nume_hora_norm", "BigDecimal", 0, false, false, false, "Nume Hora Norm"),
                f("numeHora25", "nume_hora_25", "BigDecimal", 0, false, false, false, "Nume Hora 25"),
                f("numeHora35", "nume_hora_35", "BigDecimal", 0, false, false, false, "Nume Hora 35"),
                f("numeHoraNoct", "nume_hora_noct", "BigDecimal", 0, false, false, false, "Nume Hora Noct"),
                f("situHora25", "situ_hora_25", "String", 2, false, false, false, "Situ Hora 25"),
                f("situHora35", "situ_hora_35", "String", 2, false, false, false, "Situ Hora 35"),
                f("situHoraNoct", "situ_hora_noct", "String", 2, false, false, false, "Situ Hora Noct"),
                f("detaTrab", "deta_trab", "String", 250, false, false, false, "Deta Trab"))));
        add(new EntityMeta("derecho_habiente", "DERECHO_HABIENTE", "Derecho Habiente", DerechoHabiente.class, DerechoHabiente.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("codiDereHabi", "codi_dere_habi", "Short", 0, true, true, false, "Codi Dere Habi"),
                f("tipoRela", "tipo_rela", "String", 40, false, false, false, "Tipo Rela"),
                f("nomb1", "nomb_1", "String", 30, true, false, false, "Nomb 1"),
                f("nomb2", "nomb_2", "String", 30, false, false, false, "Nomb 2"),
                f("apel1", "apel_1", "String", 30, false, false, false, "Apel 1"),
                f("apel2", "apel_2", "String", 30, false, false, false, "Apel 2"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"),
                f("nroDocuIden", "nro_docu_iden", "String", 30, false, false, false, "Nro Docu Iden"),
                f("fechNaci", "fech_naci", "LocalDateTime", 0, false, false, false, "Fech Naci"),
                f("sexo", "sexo", "String", 1, false, false, false, "Sexo"),
                f("situacion", "situacion", "String", 1, false, false, false, "Situacion"),
                f("motiBaja", "moti_baja", "String", 1, false, false, false, "Moti Baja"),
                f("domicilio", "domicilio", "String", 1, false, false, false, "Domicilio"),
                f("incapacidad", "incapacidad", "Boolean", 0, false, false, false, "Incapacidad"),
                f("certMedi", "cert_medi", "String", 20, false, false, false, "Cert Medi"),
                f("codiTipoDocuIden", "codi_tipo_docu_iden", "Short", 0, false, false, false, "Codi Tipo Docu Iden"),
                f("codiVincFami", "codi_vinc_fami", "Short", 0, false, false, false, "Codi Vinc Fami"),
                f("tipoDocAcredPater", "tipo_doc_acred_pater", "Short", 0, false, false, false, "Tipo Doc Acred Pater"),
                f("nroDocAcredPater", "nro_doc_acred_pater", "String", 20, false, false, false, "Nro Doc Acred Pater"),
                f("fechAlta", "fech_alta", "LocalDateTime", 0, false, false, false, "Fech Alta"),
                f("fechBaja", "fech_baja", "LocalDateTime", 0, false, false, false, "Fech Baja"),
                f("codiMotiBajaDh", "codi_moti_baja_dh", "Short", 0, false, false, false, "Codi Moti Baja Dh"),
                f("nroResoluDirect", "nro_resolu_direct", "String", 20, false, false, false, "Nro Resolu Direct"),
                f("codiVia", "codi_via", "Short", 0, false, false, false, "Codi Via"),
                f("nombVia", "nomb_via", "String", 20, false, false, false, "Nomb Via"),
                f("numVia", "num_via", "String", 4, false, false, false, "Num Via"),
                f("interiorVia", "interior_via", "String", 4, false, false, false, "Interior Via"),
                f("codiZona", "codi_zona", "Short", 0, false, false, false, "Codi Zona"),
                f("nombZona", "nomb_zona", "String", 20, false, false, false, "Nomb Zona"),
                f("referencia", "referencia", "String", 40, false, false, false, "Referencia"),
                f("codiUbiReg", "codi_ubi_reg", "Short", 0, false, false, false, "Codi Ubi Reg"),
                f("codiUbiProv", "codi_ubi_prov", "Short", 0, false, false, false, "Codi Ubi Prov"),
                f("codiUbiDist", "codi_ubi_dist", "Short", 0, false, false, false, "Codi Ubi Dist"),
                f("codiPais", "codi_pais", "String", 3, false, false, false, "Codi Pais"),
                f("mesconcep", "mesconcep", "String", 6, false, false, false, "Mesconcep"),
                f("codiDocuVinculo", "codi_docu_vinculo", "Integer", 0, false, false, false, "Codi Docu Vinculo"),
                f("codiLdistanci", "codi_ldistanci", "String", 3, false, false, false, "Codi Ldistanci"),
                f("telefono", "telefono", "String", 10, false, false, false, "Telefono"),
                f("correo", "correo", "String", 70, false, false, false, "Correo"))));
        add(new EntityMeta("pers_dato_adic", "PERS_DATO_ADIC", "Pers Dato Adic", PersDatoAdic.class, null, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("nroCertSalu", "nro_cert_salu", "String", 20, false, false, false, "Nro Cert Salu"),
                f("certAntePoli", "cert_ante_poli", "String", 20, false, false, false, "Cert Ante Poli"),
                f("certAntePenaAlfa", "cert_ante_pena_alfa", "String", 20, false, false, false, "Cert Ante Pena Alfa"),
                f("sabeNadar", "sabe_nadar", "Boolean", 0, false, false, false, "Sabe Nadar"),
                f("smo", "smo", "Boolean", 0, false, false, false, "Smo"),
                f("tipoSmo", "tipo_smo", "String", 20, false, false, false, "Tipo Smo"),
                f("carnDiscamet", "carn_discamet", "Boolean", 0, false, false, false, "Carn Discamet"),
                f("licePortArma", "lice_port_arma", "Boolean", 0, false, false, false, "Lice Port Arma"),
                f("nroCarnDisc", "nro_carn_disc", "String", 20, false, false, false, "Nro Carn Disc"),
                f("nroLiceArmaAlfa", "nro_lice_arma_alfa", "String", 20, false, false, false, "Nro Lice Arma Alfa"))));
        add(new EntityMeta("juicios", "JUICIOS", "Juicios", Juicios.class, null, List.of(
                f("codiJuic", "codi_juic", "String", 6, true, true, false, "Codi Juic"),
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("nroJuic", "nro_juic", "Integer", 0, true, false, false, "Nro Juic"),
                f("fechJuic", "fech_juic", "LocalDateTime", 0, true, false, false, "Fech Juic"),
                f("motiJuic", "moti_juic", "String", 100, false, false, false, "Moti Juic"),
                f("estaActi", "esta_acti", "Boolean", 0, true, false, false, "Esta Acti"),
                f("tipoDesc", "tipo_desc", "Boolean", 0, true, false, false, "Tipo Desc"),
                f("codiMone", "codi_mone", "String", 2, true, false, false, "Codi Mone"),
                f("montDesc", "mont_desc", "BigDecimal", 0, true, false, false, "Mont Desc"),
                f("inteTiemDesc", "inte_tiem_desc", "String", 20, false, false, false, "Inte Tiem Desc"),
                f("apliTodaRemu", "apli_toda_remu", "Boolean", 0, false, false, false, "Apli Toda Remu"),
                f("persBeneJuic", "pers_bene_juic", "String", 200, false, false, false, "Pers Bene Juic"),
                f("dniPersBene", "dni_pers_bene", "String", 10, false, false, false, "Dni Pers Bene"),
                f("nroResoJudi", "nro_reso_judi", "String", 50, false, false, false, "Nro Reso Judi"),
                f("juzgado", "juzgado", "String", 200, false, false, false, "Juzgado"),
                f("apliTope", "apli_tope", "Boolean", 0, false, false, false, "Apli Tope"),
                f("tope", "tope", "BigDecimal", 0, false, false, false, "Tope"),
                f("saldo", "saldo", "BigDecimal", 0, false, false, false, "Saldo"),
                f("codiBanc", "codi_banc", "String", 2, false, false, false, "Codi Banc"),
                f("nroCtaCteBene", "nro_cta_cte_bene", "String", 20, false, false, false, "Nro Cta Cte Bene"),
                f("codiMoneCtaCteBene", "codi_mone_cta_cte_bene", "String", 2, false, false, false, "Codi Mone Cta Cte Bene"))));
        add(new EntityMeta("planilla_tripulante_conceptos", "PLANILLA_TRIPULANTE_CONCEPTOS", "Planilla Tripulante Conceptos", PlanillaTripulanteConceptos.class, PlanillaTripulanteConceptos.Pk.class, List.of(
                f("codiPlanTrip", "codi_plan_trip", "String", 10, true, true, false, "Codi Plan Trip"),
                f("codiConc", "codi_conc", "String", 6, true, true, false, "Codi Conc"),
                f("afecto", "afecto", "Boolean", 0, true, false, false, "Afecto"),
                f("valor", "valor", "BigDecimal", 0, true, false, false, "Valor"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"),
                f("especial", "especial", "BigDecimal", 0, false, false, false, "Especial"),
                f("codi", "codi", "String", 2, false, false, false, "Codi"))));
        add(new EntityMeta("datos_cts", "DATOS_CTS", "Datos Cts", DatosCts.class, null, List.of(
                f("codiPlanCts", "codi_plan_cts", "String", 10, true, true, false, "Codi Plan Cts"),
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, true, false, false, "Fech Inic"),
                f("fechTerm", "fech_term", "LocalDateTime", 0, true, false, false, "Fech Term"),
                f("tipoPago", "tipo_pago", "String", 50, false, false, false, "Tipo Pago"),
                f("descTipoPago", "desc_tipo_pago", "String", 50, false, false, false, "Desc Tipo Pago"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("fechPago", "fech_pago", "LocalDateTime", 0, false, false, false, "Fech Pago"),
                f("codiTipoPlan", "codi_tipo_plan", "String", 2, true, false, false, "Codi Tipo Plan"),
                f("anio", "anio", "String", 4, true, false, false, "Anio"),
                f("mes", "mes", "String", 2, true, false, false, "Mes"),
                f("nroCheqOper", "nro_cheq_oper", "String", 30, false, false, false, "Nro Cheq Oper"),
                f("importe", "importe", "BigDecimal", 0, true, false, false, "Importe"),
                f("impoDola", "impo_dola", "BigDecimal", 0, true, false, false, "Impo Dola"),
                f("codiTipoPers", "codi_tipo_pers", "String", 2, true, false, false, "Codi Tipo Pers"),
                f("tipoCamb", "tipo_camb", "BigDecimal", 0, true, false, false, "Tipo Camb"),
                f("estaPago", "esta_pago", "String", 1, false, false, false, "Esta Pago"),
                f("fechVenc", "fech_venc", "LocalDateTime", 0, false, false, false, "Fech Venc"),
                f("montInteDiar", "mont_inte_diar", "BigDecimal", 0, false, false, false, "Mont Inte Diar"),
                f("codiBanc", "codi_banc", "String", 2, false, false, false, "Codi Banc"),
                f("tipoCts", "tipo_cts", "String", 1, false, false, false, "Tipo Cts"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("interes", "interes", "BigDecimal", 0, false, false, false, "Interes"))));
        add(new EntityMeta("planilla_pesca_tripulantes", "PLANILLA_PESCA_TRIPULANTES", "Planilla Pesca Tripulantes", PlanillaPescaTripulantes.class, PlanillaPescaTripulantes.Pk.class, List.of(
                f("codiSema", "codi_sema", "String", 8, true, true, false, "Codi Sema"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, true, false, "Codi Unid Oper"),
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("codiCarg", "codi_carg", "String", 4, true, true, false, "Codi Carg"),
                f("dia", "dia", "LocalDateTime", 0, true, true, false, "Dia"),
                f("nomDia", "nom_dia", "String", 10, true, false, false, "Nom Dia"),
                f("pescReal", "pesc_real", "BigDecimal", 0, false, false, false, "Pesc Real"),
                f("precSnp", "prec_snp", "BigDecimal", 0, false, false, false, "Prec Snp"),
                f("porcDistr", "porc_distr", "BigDecimal", 0, false, false, false, "Porc Distr"),
                f("parte", "parte", "BigDecimal", 0, false, false, false, "Parte"),
                f("adicional", "adicional", "BigDecimal", 0, false, false, false, "Adicional"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"),
                f("refri", "refri", "BigDecimal", 0, false, false, false, "Refri"),
                f("espeParte", "espe_parte", "BigDecimal", 0, false, false, false, "Espe Parte"),
                f("espeAdic", "espe_adic", "BigDecimal", 0, false, false, false, "Espe Adic"),
                f("espeMonto", "espe_monto", "BigDecimal", 0, false, false, false, "Espe Monto"),
                f("nroAsis", "nro_asis", "String", 1, true, true, false, "Nro Asis"),
                f("mesanio", "mesanio", "String", 6, false, false, false, "Mesanio"))));
        add(new EntityMeta("planilla_de_empleados", "PLANILLA_DE_EMPLEADOS", "Planilla De Empleados", PlanillaDeEmpleados.class, null, List.of(
                f("codiPlanEmpl", "codi_plan_empl", "String", 10, true, true, false, "Codi Plan Empl"),
                f("anio", "anio", "String", 4, true, false, false, "Anio"),
                f("mes", "mes", "String", 2, true, false, false, "Mes"),
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("codiTipoPlan", "codi_tipo_plan", "String", 2, false, false, false, "Codi Tipo Plan"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, false, false, false, "Fech Inic"),
                f("fechTerm", "fech_term", "LocalDateTime", 0, false, false, false, "Fech Term"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("indiTiem", "indi_tiem", "String", 5, true, false, false, "Indi Tiem"),
                f("formPago", "form_pago", "String", 20, false, false, false, "Form Pago"),
                f("nroCheq", "nro_cheq", "String", 30, false, false, false, "Nro Cheq"),
                f("fechPago", "fech_pago", "LocalDateTime", 0, false, false, false, "Fech Pago"),
                f("codiSistPens", "codi_sist_pens", "String", 2, false, false, false, "Codi Sist Pens"),
                f("codiTipoPers", "codi_tipo_pers", "String", 2, false, false, false, "Codi Tipo Pers"),
                f("semana", "semana", "Short", 0, false, false, false, "Semana"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"))));
        add(new EntityMeta("prestamos", "PRESTAMOS", "Prestamos", Prestamos.class, null, List.of(
                f("codiPres", "codi_pres", "String", 6, true, true, false, "Codi Pres"),
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("nroPres", "nro_pres", "Integer", 0, true, false, false, "Nro Pres"),
                f("fechPres", "fech_pres", "LocalDateTime", 0, true, false, false, "Fech Pres"),
                f("motiPres", "moti_pres", "String", 100, false, false, false, "Moti Pres"),
                f("estaActi", "esta_acti", "Boolean", 0, true, false, false, "Esta Acti"),
                f("tipoDesc", "tipo_desc", "Boolean", 0, true, false, false, "Tipo Desc"),
                f("codiMone", "codi_mone", "String", 2, true, false, false, "Codi Mone"),
                f("monto", "monto", "BigDecimal", 0, true, false, false, "Monto"),
                f("montDesc", "mont_desc", "BigDecimal", 0, false, false, false, "Mont Desc"),
                f("inteTiemDesc", "inte_tiem_desc", "String", 20, false, false, false, "Inte Tiem Desc"),
                f("saldo", "saldo", "BigDecimal", 0, false, false, false, "Saldo"),
                f("presupuesto", "presupuesto", "String", 10, false, false, false, "Presupuesto"),
                f("codiBaza", "codi_baza", "String", 2, false, false, false, "Codi Baza"),
                f("registro", "registro", "String", 10, false, false, false, "Registro"),
                f("codiTipoPres", "codi_tipo_pres", "String", 2, false, false, false, "Codi Tipo Pres"))));
        add(new EntityMeta("contratos_personal", "CONTRATOS_PERSONAL", "Contratos Personal", ContratosPersonal.class, null, List.of(
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("codiContPers", "codi_cont_pers", "String", 5, true, true, false, "Codi Cont Pers"),
                f("fechInicCont", "fech_inic_cont", "LocalDateTime", 0, true, false, false, "Fech Inic Cont"),
                f("fechFinCont", "fech_fin_cont", "LocalDateTime", 0, false, false, false, "Fech Fin Cont"),
                f("fechSali", "fech_sali", "LocalDateTime", 0, false, false, false, "Fech Sali"),
                f("estaCont", "esta_cont", "Boolean", 0, false, false, false, "Esta Cont"),
                f("suelBasi", "suel_basi", "BigDecimal", 0, false, false, false, "Suel Basi"),
                f("observacion", "observacion", "String", 100, false, false, false, "Observacion"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("codiCarg", "codi_carg", "String", 4, false, false, false, "Codi Carg"),
                f("tipoCont", "tipo_cont", "String", 10, false, false, false, "Tipo Cont"),
                f("grupOcup", "grup_ocup", "String", 50, false, false, false, "Grup Ocup"),
                f("modaCont", "moda_cont", "String", 50, false, false, false, "Moda Cont"),
                f("artiModa", "arti_moda", "String", 6, false, false, false, "Arti Moda"),
                f("compAseg", "comp_aseg", "String", 150, false, false, false, "Comp Aseg"),
                f("tipoPrac", "tipo_prac", "String", 20, false, false, false, "Tipo Prac"),
                f("centEstuPrac", "cent_estu_prac", "String", 150, false, false, false, "Cent Estu Prac"),
                f("horaLaboDiar", "hora_labo_diar", "Short", 0, false, false, false, "Hora Labo Diar"),
                f("horaPrac", "hora_prac", "Short", 0, false, false, false, "Hora Prac"),
                f("horaTeor", "hora_teor", "Short", 0, false, false, false, "Hora Teor"),
                f("horaEntr1", "hora_entr_1", "LocalDateTime", 0, false, false, false, "Hora Entr 1"),
                f("horaSali1", "hora_sali_1", "LocalDateTime", 0, false, false, false, "Hora Sali 1"),
                f("horaEntr2", "hora_entr_2", "LocalDateTime", 0, false, false, false, "Hora Entr 2"),
                f("horaSali2", "hora_sali_2", "LocalDateTime", 0, false, false, false, "Hora Sali 2"),
                f("tituPrac", "titu_prac", "String", 250, false, false, false, "Titu Prac"),
                f("horaDias", "hora_dias", "String", 250, false, false, false, "Hora Dias"),
                f("denoCentEstuPrac", "deno_cent_estu_prac", "String", 50, false, false, false, "Deno Cent Estu Prac"),
                f("fechPresPrac", "fech_pres_prac", "LocalDateTime", 0, false, false, false, "Fech Pres Prac"),
                f("tiemDura", "tiem_dura", "String", 100, false, false, false, "Tiem Dura"))));
        add(new EntityMeta("licencias_por_personal", "LICENCIAS_POR_PERSONAL", "Licencias Por Personal", LicenciasPorPersonal.class, LicenciasPorPersonal.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("codiTipoLice", "codi_tipo_lice", "String", 3, true, true, false, "Codi Tipo Lice"),
                f("motivo", "motivo", "String", 100, false, false, false, "Motivo"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, true, true, false, "Fech Inic"),
                f("fechTerm", "fech_term", "LocalDateTime", 0, true, false, false, "Fech Term"),
                f("estaActi", "esta_acti", "Boolean", 0, false, false, false, "Esta Acti"),
                f("goceHabe", "goce_habe", "Boolean", 0, false, false, false, "Goce Habe"),
                f("nroDiasRemu", "nro_dias_remu", "Integer", 0, false, false, false, "Nro Dias Remu"),
                f("observaciones", "observaciones", "String", 200, false, false, false, "Observaciones"),
                f("nroHoraRemu", "nro_hora_remu", "BigDecimal", 0, false, false, false, "Nro Hora Remu"),
                f("codiJefeInmeAuto", "codi_jefe_inme_auto", "String", 5, false, false, false, "Codi Jefe Inme Auto"),
                f("codiJefeSupeAuto", "codi_jefe_supe_auto", "String", 5, false, false, false, "Codi Jefe Supe Auto"),
                f("codiTipoSuspLabo", "codi_tipo_susp_labo", "Short", 0, false, false, false, "Codi Tipo Susp Labo"),
                f("nroCitt", "nro_citt", "String", 15, false, false, false, "Nro Citt"))));
        add(new EntityMeta("planilla_empleado_conceptos", "PLANILLA_EMPLEADO_CONCEPTOS", "Planilla Empleado Conceptos", PlanillaEmpleadoConceptos.class, PlanillaEmpleadoConceptos.Pk.class, List.of(
                f("codiPlanEmpl", "codi_plan_empl", "String", 10, true, true, false, "Codi Plan Empl"),
                f("codiConc", "codi_conc", "String", 6, true, true, false, "Codi Conc"),
                f("afecto", "afecto", "Boolean", 0, true, false, false, "Afecto"),
                f("valor", "valor", "BigDecimal", 0, true, false, false, "Valor"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"))));
        add(new EntityMeta("planilla_obrero_conceptos", "PLANILLA_OBRERO_CONCEPTOS", "Planilla Obrero Conceptos", PlanillaObreroConceptos.class, PlanillaObreroConceptos.Pk.class, List.of(
                f("codiPlanObre", "codi_plan_obre", "String", 10, true, true, false, "Codi Plan Obre"),
                f("codiConc", "codi_conc", "String", 6, true, true, false, "Codi Conc"),
                f("afecto", "afecto", "Boolean", 0, true, false, false, "Afecto"),
                f("valor", "valor", "BigDecimal", 0, true, false, false, "Valor"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"))));
    }

    @Override
    public String service() {
        return "rrhh";
    }

    @Override
    public Optional<EntityMeta> find(String name) {
        return Optional.ofNullable(entities.get(name));
    }

    @Override
    public List<EntityMeta> all() {
        return List.copyOf(entities.values());
    }
}
