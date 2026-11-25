package pe.sige.contabilidad.domain.legacy;

import jakarta.enterprise.context.ApplicationScoped;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import pe.sige.common.catalog.EntityCatalog;
import pe.sige.common.catalog.EntityMeta;
import pe.sige.common.catalog.FieldMeta;

/** Catalogo de entidades legado de ms-contabilidad (82 tablas). Generado: no editar. */
@ApplicationScoped
public class LegacyCatalog implements EntityCatalog {

    private final Map<String, EntityMeta> entities = new LinkedHashMap<>();

    public LegacyCatalog() {
        load0();
        load1();
        load2();
        load3();
    }

    private void add(EntityMeta m) {
        entities.put(m.name(), m);
    }

    private static FieldMeta f(String field, String column, String type, int length, boolean required, boolean id, boolean generated, String label) {
        return new FieldMeta(field, column, type, length, required, id, generated, label);
    }

    private void load0() {
        add(new EntityMeta("movi_contables", "Movi_Contables", "Movi Contables", MoviContables.class, null, List.of(
                f("codiContable", "codi_contable", "String", 10, true, true, false, "Codi Contable"),
                f("anio", "anio", "String", 4, false, false, false, "Anio"),
                f("mes", "mes", "String", 2, false, false, false, "Mes"),
                f("subdia", "subdia", "String", 1, false, false, false, "Subdia"),
                f("compr", "compr", "String", 10, false, false, false, "Compr"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("nroSubCuen", "nro_sub_cuen", "String", 7, false, false, false, "Nro Sub Cuen"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("serie", "serie", "String", 5, false, false, false, "Serie"),
                f("nroDocu", "nro_docu", "String", 20, false, false, false, "Nro Docu"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("igv", "igv", "BigDecimal", 0, false, false, false, "Igv"),
                f("otros", "otros", "BigDecimal", 0, false, false, false, "Otros"),
                f("total", "total", "BigDecimal", 0, false, false, false, "Total"),
                f("importeD", "importe_d", "BigDecimal", 0, false, false, false, "Importe D"),
                f("igvD", "igv_d", "BigDecimal", 0, false, false, false, "Igv D"),
                f("otrosD", "otros_d", "BigDecimal", 0, false, false, false, "Otros D"),
                f("totalD", "total_d", "BigDecimal", 0, false, false, false, "Total D"),
                f("registro", "registro", "String", 10, false, false, false, "Registro"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("glosa", "glosa", "String", 200, false, false, false, "Glosa"),
                f("cargoAbono", "cargo_abono", "String", 1, false, false, false, "Cargo Abono"),
                f("fechaVenc", "fecha_venc", "LocalDateTime", 0, false, false, false, "Fecha Venc"),
                f("tipoCambio", "tipo_cambio", "BigDecimal", 0, false, false, false, "Tipo Cambio"),
                f("situCheq", "situ_cheq", "String", 2, false, false, false, "Situ Cheq"),
                f("tipoCambio2", "tipo_cambio_2", "BigDecimal", 0, false, false, false, "Tipo Cambio 2"),
                f("codiVouc", "codi_vouc", "String", 10, false, false, false, "Codi Vouc"),
                f("fechaSpot", "fecha_spot", "LocalDateTime", 0, false, false, false, "Fecha Spot"),
                f("numSpot", "num_spot", "String", 10, false, false, false, "Num Spot"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"),
                f("codiSema", "codi_sema", "String", 10, false, false, false, "Codi Sema"),
                f("codiNotaIngr", "codi_nota_ingr", "String", 10, false, false, false, "Codi Nota Ingr"),
                f("nroOrdeComp", "nro_orde_comp", "String", 10, false, false, false, "Nro Orde Comp"),
                f("nroOrdePedi", "nro_orde_pedi", "String", 10, false, false, false, "Nro Orde Pedi"),
                f("codiPres", "codi_pres", "String", 4, false, false, false, "Codi Pres"),
                f("nroPresu", "nro_presu", "String", 5, false, false, false, "Nro Presu"),
                f("banco", "banco", "String", 7, false, false, false, "Banco"),
                f("cartera", "cartera", "Boolean", 0, false, false, false, "Cartera"),
                f("hechoPor", "hecho_por", "String", 5, false, false, false, "Hecho Por"),
                f("itf", "itf", "String", 1, false, false, false, "Itf"),
                f("compensa", "compensa", "Boolean", 0, false, false, false, "Compensa"),
                f("detraccion", "detraccion", "Boolean", 0, false, false, false, "Detraccion"),
                f("fechPago", "fech_pago", "LocalDateTime", 0, false, false, false, "Fech Pago"),
                f("ref", "ref", "String", 5, false, false, false, "Ref"),
                f("nroFact", "nro_fact", "String", 20, false, false, false, "Nro Fact"),
                f("codiMemo", "codi_memo", "Long", 0, false, false, false, "Codi Memo"),
                f("tipoMovi", "tipo_movi", "String", 2, false, false, false, "Tipo Movi"),
                f("codiDesti", "codi_desti", "String", 1, false, false, false, "Codi Desti"),
                f("codiTasaDetr", "codi_tasa_detr", "String", 5, false, false, false, "Codi Tasa Detr"),
                f("retencion", "retencion", "Boolean", 0, false, false, false, "Retencion"),
                f("codiIngr", "codi_ingr", "Long", 0, false, false, false, "Codi Ingr"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("codiTipoIntan", "codi_tipo_intan", "String", 2, false, false, false, "Codi Tipo Intan"),
                f("codiAduana", "codi_aduana", "Short", 0, false, false, false, "Codi Aduana"),
                f("anioDuaDsi", "anio_dua_dsi", "Short", 0, false, false, false, "Anio Dua Dsi"),
                f("nroDetrac", "nro_detrac", "String", 10, false, false, false, "Nro Detrac"),
                f("fechaDetrac", "fecha_detrac", "LocalDateTime", 0, false, false, false, "Fecha Detrac"),
                f("fechaNdNc", "fecha_nd_nc", "LocalDateTime", 0, false, false, false, "Fecha Nd Nc"),
                f("tipoDocuNdNc", "tipo_docu_nd_nc", "String", 4, false, false, false, "Tipo Docu Nd Nc"),
                f("serieNdNc", "serie_nd_nc", "String", 5, false, false, false, "Serie Nd Nc"),
                f("nroDocuNdNc", "nro_docu_nd_nc", "String", 10, false, false, false, "Nro Docu Nd Nc"),
                f("tipoVenta", "tipo_venta", "String", 1, false, false, false, "Tipo Venta"),
                f("codiLibroRegi", "codi_libro_regi", "Short", 0, false, false, false, "Codi Libro Regi"),
                f("codiTipoMedioPago", "codi_tipo_medio_pago", "Short", 0, false, false, false, "Codi Tipo Medio Pago"),
                f("bancoAux", "banco_aux", "String", 2, false, false, false, "Banco Aux"),
                f("fechaCreacion", "fecha_creacion", "LocalDateTime", 0, false, false, false, "Fecha Creacion"),
                f("estadoInic", "estado_inic", "Integer", 0, false, false, false, "Estado Inic"),
                f("creacion", "creacion", "LocalDateTime", 0, false, false, false, "Creacion"),
                f("idFlujo", "id_flujo", "Integer", 0, false, false, false, "Id Flujo"),
                f("idTipoFlujo", "id_tipo_flujo", "Integer", 0, false, false, false, "Id Tipo Flujo"),
                f("codiOper", "codi_oper", "String", 4, false, false, false, "Codi Oper"),
                f("codiBienServ", "codi_bien_serv", "String", 5, false, false, false, "Codi Bien Serv"),
                f("pdetr", "pdetr", "BigDecimal", 0, false, false, false, "Pdetr"),
                f("valorRefe", "valor_refe", "BigDecimal", 0, false, false, false, "Valor Refe"),
                f("placa", "placa", "String", 100, false, false, false, "Placa"),
                f("nroRefe", "nro_refe", "String", 10, false, false, false, "Nro Refe"))));
        add(new EntityMeta("linea_clase_c", "LINEA_CLASE_C", "Linea Clase C", LineaClaseC.class, null, List.of(
                f("codiLcc", "codi_lcc", "String", 5, true, true, false, "Codi Lcc"),
                f("descLcc", "desc_lcc", "String", 100, true, false, false, "Desc Lcc"),
                f("td", "td", "BigDecimal", 0, false, false, false, "Td"),
                f("codiSubc4", "codi_subc_4", "String", 4, false, false, false, "Codi Subc 4"))));
        add(new EntityMeta("tipo_eeff", "TIPO_EEFF", "Tipo Eeff", TipoEeff.class, null, List.of(
                f("codiTipoEeff", "codi_tipo_eeff", "String", 2, true, true, false, "Codi Tipo Eeff"),
                f("descTipoEeff", "desc_tipo_eeff", "String", 100, false, false, false, "Desc Tipo Eeff"),
                f("nemoTipoEeff", "nemo_tipo_eeff", "String", 10, false, false, false, "Nemo Tipo Eeff"))));
        add(new EntityMeta("tipo_form_prov_plan", "TIPO_FORM_PROV_PLAN", "Tipo Form Prov Plan", TipoFormProvPlan.class, null, List.of(
                f("codiTipoProv", "codi_tipo_prov", "String", 2, true, true, false, "Codi Tipo Prov"),
                f("descTipoProv", "desc_tipo_prov", "String", 50, false, false, false, "Desc Tipo Prov"))));
        add(new EntityMeta("m_sub_clas_cuen", "m_SUB_CLAS_CUEN", "M Sub Clas Cuen", MSubClasCuen.class, null, List.of(
                f("ide", "ide", "Integer", 0, true, true, true, "Ide"),
                f("codiSubc", "codi_subc", "String", 3, false, false, false, "Codi Subc"),
                f("descSubc", "desc_subc", "String", 100, true, false, false, "Desc Subc"),
                f("codiClasCuen", "codi_clas_cuen", "String", 2, false, false, false, "Codi Clas Cuen"))));
        add(new EntityMeta("m_linea_clase_c", "m_LINEA_CLASE_C", "M Linea Clase C", MLineaClaseC.class, null, List.of(
                f("ide", "ide", "Integer", 0, true, true, true, "Ide"),
                f("codiLcc", "codi_lcc", "String", 5, false, false, false, "Codi Lcc"),
                f("descLcc", "desc_lcc", "String", 100, true, false, false, "Desc Lcc"),
                f("codiSubc", "codi_subc", "String", 3, true, false, false, "Codi Subc"),
                f("td", "td", "BigDecimal", 0, false, false, false, "Td"))));
        add(new EntityMeta("m_cuentas_contable", "m_CUENTAS_CONTABLE", "M Cuentas Contable", MCuentasContable.class, null, List.of(
                f("ide", "ide", "Integer", 0, true, true, true, "Ide"),
                f("nroCuen", "nro_cuen", "String", 7, true, false, false, "Nro Cuen"),
                f("descCuen", "desc_cuen", "String", 100, false, false, false, "Desc Cuen"),
                f("nroSubCuen", "nro_sub_cuen", "String", 7, false, false, false, "Nro Sub Cuen"),
                f("codiLcc", "codi_lcc", "String", 5, true, false, false, "Codi Lcc"),
                f("cta6", "cta_6", "String", 7, false, false, false, "Cta 6"),
                f("tipoCuen", "tipo_cuen", "String", 1, false, false, false, "Tipo Cuen"),
                f("codiMone", "codi_mone", "String", 10, false, false, false, "Codi Mone"),
                f("nroCtaCteBanc", "nro_cta_cte_banc", "String", 30, false, false, false, "Nro Cta Cte Banc"),
                f("codiBanc", "codi_banc", "String", 2, false, false, false, "Codi Banc"),
                f("codiTipoCuenBanc", "codi_tipo_cuen_banc", "String", 2, false, false, false, "Codi Tipo Cuen Banc"),
                f("porcDetr", "porc_detr", "BigDecimal", 0, false, false, false, "Porc Detr"),
                f("transfer", "transfer", "String", 1, false, false, false, "Transfer"),
                f("ctaCierre", "cta_cierre", "String", 7, false, false, false, "Cta Cierre"),
                f("tipoCosto", "tipo_costo", "String", 1, false, false, false, "Tipo Costo"))));
        add(new EntityMeta("operaciones", "operaciones", "Operaciones", Operaciones.class, null, List.of(
                f("codiOper", "codi_oper", "String", 2, true, true, false, "Codi Oper"),
                f("descOper", "desc_oper", "String", 250, false, false, false, "Desc Oper"),
                f("nemoOper", "nemo_oper", "String", 50, false, false, false, "Nemo Oper"))));
        add(new EntityMeta("operac_sunat_ple", "OPERAC_SUNAT_PLE", "Operac Sunat Ple", OperacSunatPle.class, null, List.of(
                f("idSec", "id_sec", "Integer", 0, true, true, true, "Id Sec"),
                f("anio", "anio", "Integer", 0, false, false, false, "Anio"),
                f("mes", "mes", "Integer", 0, false, false, false, "Mes"),
                f("compr", "compr", "String", 10, false, false, false, "Compr"),
                f("anioRegis", "anio_regis", "String", 4, false, false, false, "Anio Regis"),
                f("mesRegis", "mes_regis", "String", 2, false, false, false, "Mes Regis"),
                f("subdiaRegis", "subdia_regis", "String", 1, false, false, false, "Subdia Regis"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"))));
        add(new EntityMeta("contabilizacion", "CONTABILIZACION", "Contabilizacion", Contabilizacion.class, null, List.of(
                f("codigo", "codigo", "String", 4, true, true, false, "Codigo"),
                f("origen", "origen", "String", 5, false, false, false, "Origen"),
                f("tipod", "tipod", "String", 4, false, false, false, "Tipod"),
                f("descrip", "descrip", "String", 70, false, false, false, "Descrip"),
                f("cuenta1", "cuenta1", "String", 7, false, false, false, "Cuenta1"),
                f("ca1", "ca1", "String", 1, false, false, false, "Ca1"),
                f("desc1", "desc1", "String", 50, false, false, false, "Desc1"),
                f("cuenta2", "cuenta2", "String", 7, false, false, false, "Cuenta2"),
                f("ca2", "ca2", "String", 1, false, false, false, "Ca2"),
                f("desc2", "desc2", "String", 50, false, false, false, "Desc2"),
                f("ctasunat", "ctasunat", "String", 7, false, false, false, "Ctasunat"),
                f("cuenta3", "cuenta3", "String", 7, false, false, false, "Cuenta3"),
                f("ca3", "ca3", "String", 1, false, false, false, "Ca3"),
                f("desc3", "desc3", "String", 50, false, false, false, "Desc3"),
                f("cuenta4", "cuenta4", "String", 7, false, false, false, "Cuenta4"),
                f("ca4", "ca4", "String", 1, false, false, false, "Ca4"),
                f("desc4", "desc4", "String", 50, false, false, false, "Desc4"),
                f("cuenta5", "cuenta5", "String", 7, false, false, false, "Cuenta5"),
                f("ca5", "ca5", "String", 1, false, false, false, "Ca5"),
                f("desc5", "desc5", "String", 50, false, false, false, "Desc5"),
                f("subdiario", "subdiario", "String", 1, false, false, false, "Subdiario"))));
        add(new EntityMeta("plecompras", "PLECOMPRAS", "Plecompras", Plecompras.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("columna0", "columna_0", "String", 50, false, false, false, "Columna 0"),
                f("columna1", "columna_1", "String", 50, false, false, false, "Columna 1"),
                f("columna2", "columna_2", "String", 50, false, false, false, "Columna 2"),
                f("columna3", "columna_3", "String", 50, false, false, false, "Columna 3"),
                f("columna4", "columna_4", "String", 50, false, false, false, "Columna 4"),
                f("columna5", "columna_5", "String", 50, false, false, false, "Columna 5"),
                f("columna6", "columna_6", "String", 50, false, false, false, "Columna 6"),
                f("columna7", "columna_7", "String", 50, false, false, false, "Columna 7"),
                f("columna8", "columna_8", "String", 50, false, false, false, "Columna 8"),
                f("columna9", "columna_9", "String", 50, false, false, false, "Columna 9"),
                f("columna10", "columna_10", "String", 50, false, false, false, "Columna 10"),
                f("columna11", "columna_11", "String", 50, false, false, false, "Columna 11"),
                f("columna12", "columna_12", "String", 100, false, false, false, "Columna 12"),
                f("columna13", "columna_13", "String", 50, false, false, false, "Columna 13"),
                f("columna14", "columna_14", "String", 50, false, false, false, "Columna 14"),
                f("columna15", "columna_15", "String", 50, false, false, false, "Columna 15"),
                f("columna16", "columna_16", "String", 50, false, false, false, "Columna 16"),
                f("columna17", "columna_17", "String", 50, false, false, false, "Columna 17"),
                f("columna18", "columna_18", "String", 50, false, false, false, "Columna 18"),
                f("columna19", "columna_19", "String", 50, false, false, false, "Columna 19"),
                f("columna20", "columna_20", "String", 50, false, false, false, "Columna 20"),
                f("columna21", "columna_21", "String", 50, false, false, false, "Columna 21"),
                f("columna22", "columna_22", "String", 50, false, false, false, "Columna 22"),
                f("columna23", "columna_23", "String", 50, false, false, false, "Columna 23"),
                f("columna24", "columna_24", "String", 50, false, false, false, "Columna 24"),
                f("columna25", "columna_25", "String", 50, false, false, false, "Columna 25"),
                f("columna26", "columna_26", "String", 50, false, false, false, "Columna 26"),
                f("columna27", "columna_27", "String", 50, false, false, false, "Columna 27"),
                f("columna28", "columna_28", "String", 50, false, false, false, "Columna 28"),
                f("columna29", "columna_29", "String", 50, false, false, false, "Columna 29"),
                f("columna30", "columna_30", "String", 50, false, false, false, "Columna 30"),
                f("columna31", "columna_31", "String", 50, false, false, false, "Columna 31"),
                f("columna32", "columna_32", "String", 50, false, false, false, "Columna 32"),
                f("columna33", "columna_33", "String", 50, false, false, false, "Columna 33"),
                f("columna34", "columna_34", "String", 50, false, false, false, "Columna 34"),
                f("columna35", "columna_35", "String", 50, false, false, false, "Columna 35"),
                f("columna36", "columna_36", "String", 50, false, false, false, "Columna 36"),
                f("columna37", "columna_37", "String", 50, false, false, false, "Columna 37"),
                f("columna38", "columna_38", "String", 50, false, false, false, "Columna 38"),
                f("columna39", "columna_39", "String", 50, false, false, false, "Columna 39"),
                f("columna40", "columna_40", "String", 50, false, false, false, "Columna 40"),
                f("columna41", "columna_41", "String", 50, false, false, false, "Columna 41"))));
        add(new EntityMeta("tipo_intangible", "TIPO_INTANGIBLE", "Tipo Intangible", TipoIntangible.class, null, List.of(
                f("codiTipoIntan", "codi_tipo_intan", "String", 2, true, true, false, "Codi Tipo Intan"),
                f("descTipoIntan", "desc_tipo_intan", "String", 100, true, false, false, "Desc Tipo Intan"))));
        add(new EntityMeta("tipo_impuestos", "TIPO_IMPUESTOS", "Tipo Impuestos", TipoImpuestos.class, null, List.of(
                f("codImp", "cod_imp", "Integer", 0, true, true, false, "Cod Imp"),
                f("descImp", "desc_imp", "String", 30, false, false, false, "Desc Imp"))));
        add(new EntityMeta("tipo_gasto", "TIPO_GASTO", "Tipo Gasto", TipoGasto.class, null, List.of(
                f("codiTipoGast", "codi_tipo_gast", "String", 1, true, true, false, "Codi Tipo Gast"),
                f("descTipoGast", "desc_tipo_gast", "String", 30, false, false, false, "Desc Tipo Gast"))));
        add(new EntityMeta("saldos_cuentas", "SALDOS_CUENTAS", "Saldos Cuentas", SaldosCuentas.class, SaldosCuentas.Pk.class, List.of(
                f("mesanio", "mesanio", "String", 6, true, true, false, "Mesanio"),
                f("nroCuen", "nro_cuen", "String", 7, true, true, false, "Nro Cuen"),
                f("saldoant", "saldoant", "BigDecimal", 0, false, false, false, "Saldoant"),
                f("cargo", "cargo", "BigDecimal", 0, false, false, false, "Cargo"),
                f("abono", "abono", "BigDecimal", 0, false, false, false, "Abono"),
                f("saldonue", "saldonue", "BigDecimal", 0, false, false, false, "Saldonue"),
                f("cargoacum", "cargoacum", "BigDecimal", 0, false, false, false, "Cargoacum"),
                f("abonoacum", "abonoacum", "BigDecimal", 0, false, false, false, "Abonoacum"))));
        add(new EntityMeta("agrupaciones", "AGRUPACIONES", "Agrupaciones", Agrupaciones.class, null, List.of(
                f("codiGrup", "codi_grup", "String", 5, true, true, false, "Codi Grup"),
                f("descGrup", "desc_grup", "String", 100, false, false, false, "Desc Grup"))));
        add(new EntityMeta("detalle_detraccion", "detalle_detraccion", "Detalle Detraccion", DetalleDetraccion.class, DetalleDetraccion.Pk.class, List.of(
                f("codiLoteDetr", "codi_lote_detr", "String", 10, true, true, false, "Codi Lote Detr"),
                f("nroDetalle", "nro_detalle", "String", 3, true, true, false, "Nro Detalle"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("nroProforma", "nro_proforma", "String", 9, false, false, false, "Nro Proforma"),
                f("codiBienServ", "codi_bien_serv", "String", 3, false, false, false, "Codi Bien Serv"),
                f("codiCtaCte", "codi_cta_cte", "String", 6, false, false, false, "Codi Cta Cte"),
                f("importeDeposito", "importe_deposito", "BigDecimal", 0, false, false, false, "Importe Deposito"),
                f("codiOper", "codi_oper", "String", 2, false, false, false, "Codi Oper"),
                f("nroCtaCte", "nro_cta_cte", "String", 20, false, false, false, "Nro Cta Cte"),
                f("codiFact", "codi_fact", "String", 10, false, false, false, "Codi Fact"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"),
                f("serie", "serie", "String", 5, false, false, false, "Serie"),
                f("nroDocu", "nro_docu", "String", 10, false, false, false, "Nro Docu"),
                f("registro", "registro", "String", 10, false, false, false, "Registro"),
                f("fechaSpot", "fecha_spot", "LocalDateTime", 0, false, false, false, "Fecha Spot"),
                f("numSpot", "num_spot", "String", 100, false, false, false, "Num Spot"))));
        add(new EntityMeta("cuentas_contable", "CUENTAS_CONTABLE", "Cuentas Contable", CuentasContable.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("nroCuen", "nro_cuen", "String", 7, true, false, false, "Nro Cuen"),
                f("descCuen", "desc_cuen", "String", 100, false, false, false, "Desc Cuen"),
                f("nroSubCuen", "nro_sub_cuen", "String", 7, false, false, false, "Nro Sub Cuen"),
                f("codiLcc", "codi_lcc", "String", 5, true, false, false, "Codi Lcc"))));
        add(new EntityMeta("tipo_costo", "TIPO_COSTO", "Tipo Costo", TipoCosto.class, null, List.of(
                f("codiTipoCost", "codi_tipo_cost", "String", 2, true, true, false, "Codi Tipo Cost"),
                f("descTipoCost", "desc_tipo_cost", "String", 100, false, false, false, "Desc Tipo Cost"),
                f("nemo", "nemo", "String", 20, false, false, false, "Nemo"),
                f("orden", "orden", "Short", 0, false, false, false, "Orden"),
                f("cfCv", "cf_cv", "String", 2, false, false, false, "Cf Cv"),
                f("tcg", "tcg", "String", 2, false, false, false, "Tcg"))));
        add(new EntityMeta("tipo_cost_gene", "TIPO_COST_GENE", "Tipo Cost Gene", TipoCostGene.class, null, List.of(
                f("codiTipoCostGene", "codi_tipo_cost_gene", "String", 2, true, true, false, "Codi Tipo Cost Gene"),
                f("descTipoCostGene", "desc_tipo_cost_gene", "String", 50, false, false, false, "Desc Tipo Cost Gene"),
                f("nemo", "nemo", "String", 20, false, false, false, "Nemo"),
                f("orden", "orden", "Short", 0, false, false, false, "Orden"))));
        add(new EntityMeta("tipo_comprobante", "TIPO_COMPROBANTE", "Tipo Comprobante", TipoComprobante.class, null, List.of(
                f("codiCompr", "codi_compr", "String", 1, true, true, false, "Codi Compr"),
                f("descCompr", "desc_compr", "String", 50, true, false, false, "Desc Compr"))));
        add(new EntityMeta("cuentas_activos_prov", "CUENTAS_ACTIVOS_PROV", "Cuentas Activos Prov", CuentasActivosProv.class, null, List.of(
                f("nroCuen", "nro_cuen", "String", 7, true, true, false, "Nro Cuen"),
                f("cuentCargo", "cuent_cargo", "String", 7, false, false, false, "Cuent Cargo"),
                f("cuentAbono", "cuent_abono", "String", 7, false, false, false, "Cuent Abono"))));
        add(new EntityMeta("cuen_x_tipo_cost", "CUEN_X_TIPO_COST", "Cuen X Tipo Cost", CuenXTipoCost.class, CuenXTipoCost.Pk.class, List.of(
                f("codiTipoCost", "codi_tipo_cost", "String", 2, true, true, false, "Codi Tipo Cost"),
                f("nroCuen", "nro_cuen", "String", 7, true, true, false, "Nro Cuen"))));
        add(new EntityMeta("clases_cuentas", "CLASES_CUENTAS", "Clases Cuentas", ClasesCuentas.class, null, List.of(
                f("codiClasCuen", "codi_clas_cuen", "String", 2, true, true, false, "Codi Clas Cuen"),
                f("descClasCuen", "desc_clas_cuen", "String", 100, false, false, false, "Desc Clas Cuen"),
                f("aP", "a_p", "String", 1, false, false, false, "A P"))));
        add(new EntityMeta("clase", "CLASE", "Clase", Clase.class, null, List.of(
                f("codClase", "cod_clase", "String", 3, true, true, false, "Cod Clase"),
                f("nombClase", "nomb_clase", "String", 40, true, false, false, "Nomb Clase"),
                f("nombGrupo", "nomb_grupo", "String", 10, false, false, false, "Nomb Grupo"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("unidadNegocio", "unidad_negocio", "String", 10, false, false, false, "Unidad Negocio"),
                f("modalidad", "modalidad", "String", 8, false, false, false, "Modalidad"),
                f("coOrdeServ", "co_orde_serv", "String", 20, false, false, false, "Co Orde Serv"))));
    }

    private void load1() {
        add(new EntityMeta("centro_costo", "Centro_costo", "Centro Costo", CentroCosto.class, null, List.of(
                f("codiCc", "codi_cc", "Long", 0, true, true, false, "Codi Cc"),
                f("nombreCc", "nombre_cc", "String", 120, false, false, false, "Nombre Cc"))));
        add(new EntityMeta("dif_camb", "Dif_camb", "Dif Camb", DifCamb.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("codiCuenta", "codi_cuenta", "String", 7, false, false, false, "Codi Cuenta"),
                f("ctaGasto", "cta_gasto", "String", 7, false, false, false, "Cta Gasto"),
                f("ctaIngreso", "cta_ingreso", "String", 7, false, false, false, "Cta Ingreso"))));
        add(new EntityMeta("sub_clase_cont_4", "SUB_CLASE_CONT_4", "Sub Clase Cont 4", SubClaseCont4.class, null, List.of(
                f("codiSubc4", "codi_subc_4", "String", 4, true, true, false, "Codi Subc 4"),
                f("descSub4", "desc_sub_4", "String", 250, false, false, false, "Desc Sub 4"),
                f("codiSubc", "codi_subc", "String", 3, false, false, false, "Codi Subc"))));
        add(new EntityMeta("sub_clase", "SUB_CLASE", "Sub Clase", SubClase.class, SubClase.Pk.class, List.of(
                f("codClase", "cod_clase", "String", 3, true, true, false, "Cod Clase"),
                f("codSubclase", "cod_subclase", "String", 3, true, true, false, "Cod Subclase"),
                f("nombSubclase", "nomb_subclase", "String", 40, true, false, false, "Nomb Subclase"),
                f("idBienDetraccion", "id_bien_detraccion", "String", 2, false, false, false, "Id Bien Detraccion"),
                f("tasaDetraccion", "tasa_detraccion", "BigDecimal", 0, false, false, false, "Tasa Detraccion"),
                f("unidadNegocio", "unidad_negocio", "String", 10, false, false, false, "Unidad Negocio"),
                f("unidad", "unidad", "String", 8, false, false, false, "Unidad"),
                f("flagCargoDirecto", "flag_cargo_directo", "String", 1, false, false, false, "Flag Cargo Directo"))));
        add(new EntityMeta("catalmae", "catalmae", "Catalmae", Catalmae.class, null, List.of(
                f("a", "a", "Integer", 0, true, true, true, "A"),
                f("codiUoCatalmae", "codi_uo_catalmae", "String", 5, false, false, false, "Codi Uo Catalmae"))));
        add(new EntityMeta("activos_centros", "Activos_centros", "Activos Centros", ActivosCentros.class, ActivosCentros.Pk.class, List.of(
                f("nroCuen", "nro_cuen", "String", 7, true, true, false, "Nro Cuen"),
                f("codiCc", "codi_cc", "Long", 0, true, true, false, "Codi Cc"))));
        add(new EntityMeta("sald_tota_c_uo_p", "SALD_TOTA_C_UO_P", "Sald Tota C Uo P", SaldTotaCUoP.class, null, List.of(
                f("codiTota", "codi_tota", "Long", 0, true, true, true, "Codi Tota"),
                f("anio", "anio", "String", 4, true, false, false, "Anio"),
                f("mes", "mes", "String", 2, true, false, false, "Mes"),
                f("nroCuen", "nro_cuen", "String", 7, true, false, false, "Nro Cuen"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("descCuen", "desc_cuen", "String", 100, false, false, false, "Desc Cuen"),
                f("descUnidOper", "desc_unid_oper", "String", 100, false, false, false, "Desc Unid Oper"),
                f("rucProv", "ruc_prov", "String", 15, false, false, false, "Ruc Prov"),
                f("descProv", "desc_prov", "String", 100, false, false, false, "Desc Prov"),
                f("importeC", "importe_c", "BigDecimal", 0, true, false, false, "Importe C"),
                f("importeA", "importe_a", "BigDecimal", 0, true, false, false, "Importe A"),
                f("importeDC", "importe_d_c", "BigDecimal", 0, true, false, false, "Importe D C"),
                f("importeDA", "importe_d_a", "BigDecimal", 0, true, false, false, "Importe D A"))));
        add(new EntityMeta("sald_tota_c_uo", "SALD_TOTA_C_UO", "Sald Tota C Uo", SaldTotaCUo.class, null, List.of(
                f("codiTota", "codi_tota", "Long", 0, true, true, true, "Codi Tota"),
                f("anio", "anio", "String", 4, true, false, false, "Anio"),
                f("mes", "mes", "String", 2, true, false, false, "Mes"),
                f("nroCuen", "nro_cuen", "String", 7, true, false, false, "Nro Cuen"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("descCuen", "desc_cuen", "String", 100, false, false, false, "Desc Cuen"),
                f("descUnidOper", "desc_unid_oper", "String", 100, false, false, false, "Desc Unid Oper"),
                f("importeC", "importe_c", "BigDecimal", 0, true, false, false, "Importe C"),
                f("importeA", "importe_a", "BigDecimal", 0, true, false, false, "Importe A"),
                f("importeDC", "importe_d_c", "BigDecimal", 0, true, false, false, "Importe D C"),
                f("importeDA", "importe_d_a", "BigDecimal", 0, true, false, false, "Importe D A"))));
        add(new EntityMeta("sald_tota_c_p", "SALD_TOTA_C_P", "Sald Tota C P", SaldTotaCP.class, null, List.of(
                f("codiTota", "codi_tota", "Long", 0, true, true, true, "Codi Tota"),
                f("anio", "anio", "String", 4, true, false, false, "Anio"),
                f("mes", "mes", "String", 2, true, false, false, "Mes"),
                f("nroCuen", "nro_cuen", "String", 7, true, false, false, "Nro Cuen"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("descCuen", "desc_cuen", "String", 100, false, false, false, "Desc Cuen"),
                f("rucProv", "ruc_prov", "String", 15, false, false, false, "Ruc Prov"),
                f("descProv", "desc_prov", "String", 100, false, false, false, "Desc Prov"),
                f("importeC", "importe_c", "BigDecimal", 0, true, false, false, "Importe C"),
                f("importeA", "importe_a", "BigDecimal", 0, true, false, false, "Importe A"),
                f("importeDC", "importe_d_c", "BigDecimal", 0, true, false, false, "Importe D C"),
                f("importeDA", "importe_d_a", "BigDecimal", 0, true, false, false, "Importe D A"))));
        add(new EntityMeta("sald_tota_c", "SALD_TOTA_C", "Sald Tota C", SaldTotaC.class, null, List.of(
                f("codiTota", "codi_tota", "Long", 0, true, true, true, "Codi Tota"),
                f("anio", "anio", "String", 4, true, false, false, "Anio"),
                f("mes", "mes", "String", 2, true, false, false, "Mes"),
                f("nroCuen", "nro_cuen", "String", 7, true, false, false, "Nro Cuen"),
                f("descCuen", "desc_cuen", "String", 100, false, false, false, "Desc Cuen"),
                f("importeC", "importe_c", "BigDecimal", 0, true, false, false, "Importe C"),
                f("importeA", "importe_a", "BigDecimal", 0, true, false, false, "Importe A"),
                f("importeDC", "importe_d_c", "BigDecimal", 0, true, false, false, "Importe D C"),
                f("importeDA", "importe_d_a", "BigDecimal", 0, true, false, false, "Importe D A"))));
        add(new EntityMeta("retencion", "Retencion", "Retencion", Retencion.class, Retencion.Pk.class, List.of(
                f("serie", "serie", "Long", 0, true, true, false, "Serie"),
                f("num", "num", "Long", 0, true, true, false, "Num"),
                f("subdia", "subdia", "String", 1, false, false, false, "Subdia"),
                f("compr", "compr", "String", 4, false, false, false, "Compr"),
                f("mes", "mes", "String", 2, false, false, false, "Mes"),
                f("anio", "anio", "String", 4, false, false, false, "Anio"),
                f("banco", "banco", "String", 7, false, false, false, "Banco"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"),
                f("anulado", "anulado", "String", 1, false, false, false, "Anulado"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"))));
        add(new EntityMeta("concepto_sunat", "CONCEPTO_SUNAT", "Concepto Sunat", ConceptoSunat.class, null, List.of(
                f("codiConcepSunat", "codi_concep_sunat", "Short", 0, true, true, false, "Codi Concep Sunat"),
                f("descConcepSunat", "desc_concep_sunat", "String", 100, true, false, false, "Desc Concep Sunat"))));
        add(new EntityMeta("concepto_balance", "CONCEPTO_BALANCE", "Concepto Balance", ConceptoBalance.class, null, List.of(
                f("codiConcepto", "codi_concepto", "Short", 0, true, true, false, "Codi Concepto"),
                f("descConcepto", "desc_concepto", "String", 200, true, false, false, "Desc Concepto"),
                f("codCta", "cod_cta", "String", 1, true, false, false, "Cod Cta"),
                f("orden", "orden", "Short", 0, true, false, false, "Orden"))));
        add(new EntityMeta("coef_liqu_imp", "COEF_LIQU_IMP", "Coef Liqu Imp", CoefLiquImp.class, null, List.of(
                f("aniomes", "aniomes", "String", 6, true, true, false, "Aniomes"),
                f("valorRenta", "valor_renta", "BigDecimal", 0, false, false, false, "Valor Renta"),
                f("fechVenc", "fech_venc", "LocalDateTime", 0, false, false, false, "Fech Venc"),
                f("cfa", "cfa", "BigDecimal", 0, false, false, false, "Cfa"),
                f("otrosMa", "otros_ma", "BigDecimal", 0, false, false, false, "Otros Ma"),
                f("cerrado", "cerrado", "Boolean", 0, true, false, false, "Cerrado"),
                f("igv5Ant", "igv_5_ant", "BigDecimal", 0, false, false, false, "Igv 5 Ant"),
                f("igv5Act", "igv_5_act", "BigDecimal", 0, false, false, false, "Igv 5 Act"),
                f("igvFavorAnt", "igv_favor_ant", "BigDecimal", 0, false, false, false, "Igv Favor Ant"),
                f("percAct", "perc_act", "BigDecimal", 0, false, false, false, "Perc Act"),
                f("percAnt", "perc_ant", "Long", 0, false, false, false, "Perc Ant"),
                f("reteAct", "rete_act", "BigDecimal", 0, false, false, false, "Rete Act"),
                f("reteAnt", "rete_ant", "BigDecimal", 0, false, false, false, "Rete Ant"),
                f("factorR3c", "factor_r3c", "BigDecimal", 0, false, false, false, "Factor R3c"),
                f("saldoR3cAnt", "saldo_r3c_ant", "BigDecimal", 0, false, false, false, "Saldo R3c Ant"),
                f("itan", "itan", "BigDecimal", 0, false, false, false, "Itan"),
                f("bonifi", "bonifi", "BigDecimal", 0, false, false, false, "Bonifi"),
                f("cofigv", "cofigv", "BigDecimal", 0, false, false, false, "Cofigv"),
                f("porc", "porc", "BigDecimal", 0, false, false, false, "Porc"),
                f("cfn", "cfn", "BigDecimal", 0, false, false, false, "Cfn"))));
        add(new EntityMeta("sub_concepto_sunat", "SUB_CONCEPTO_SUNAT", "Sub Concepto Sunat", SubConceptoSunat.class, null, List.of(
                f("codiSubConcep", "codi_sub_concep", "Short", 0, true, true, false, "Codi Sub Concep"),
                f("descSubConcepSunat", "desc_sub_concep_sunat", "String", 200, true, false, false, "Desc Sub Concep Sunat"),
                f("codiConcepSunat", "codi_concep_sunat", "Short", 0, true, false, false, "Codi Concep Sunat"))));
        add(new EntityMeta("glosas", "Glosas", "Glosas", Glosas.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("glosa", "glosa", "String", 200, true, false, false, "Glosa"))));
        add(new EntityMeta("gerencial_repo_tipos", "GERENCIAL_REPO_TIPOS", "Gerencial Repo Tipos", GerencialRepoTipos.class, GerencialRepoTipos.Pk.class, List.of(
                f("idGere", "id_gere", "Integer", 0, true, true, false, "Id Gere"),
                f("idTipo", "id_tipo", "Integer", 0, true, true, false, "Id Tipo"),
                f("descTipoRepo", "desc_tipo_repo", "String", 150, false, false, false, "Desc Tipo Repo"))));
        add(new EntityMeta("gerencial_repo_tipo_cuen", "GERENCIAL_REPO_TIPO_CUEN", "Gerencial Repo Tipo Cuen", GerencialRepoTipoCuen.class, GerencialRepoTipoCuen.Pk.class, List.of(
                f("idGere", "id_gere", "Integer", 0, true, true, false, "Id Gere"),
                f("idTipo", "id_tipo", "Integer", 0, true, true, false, "Id Tipo"),
                f("nroCuen", "nro_cuen", "String", 7, true, true, false, "Nro Cuen"))));
        add(new EntityMeta("gerencial_repo", "GERENCIAL_REPO", "Gerencial Repo", GerencialRepo.class, null, List.of(
                f("idGere", "id_gere", "Integer", 0, true, true, false, "Id Gere"),
                f("descGere", "desc_gere", "String", 150, false, false, false, "Desc Gere"))));
        add(new EntityMeta("gasto_operativo", "GASTO_OPERATIVO", "Gasto Operativo", GastoOperativo.class, null, List.of(
                f("codiGasto", "codi_gasto", "Long", 0, true, true, true, "Codi Gasto"),
                f("anio", "anio", "String", 4, false, false, false, "Anio"),
                f("mes", "mes", "String", 2, false, false, false, "Mes"),
                f("valor", "valor", "BigDecimal", 0, false, false, false, "Valor"))));
        add(new EntityMeta("ratios", "RATIOS", "Ratios", Ratios.class, null, List.of(
                f("codiRati", "codi_rati", "String", 2, true, true, false, "Codi Rati"),
                f("descRati", "desc_rati", "String", 60, true, false, false, "Desc Rati"))));
        add(new EntityMeta("punto_equilibrio", "PUNTO_EQUILIBRIO", "Punto Equilibrio", PuntoEquilibrio.class, null, List.of(
                f("mesanio", "mesanio", "String", 6, true, true, false, "Mesanio"),
                f("costoFijo", "costo_fijo", "BigDecimal", 0, false, false, false, "Costo Fijo"),
                f("costoVari", "costo_vari", "BigDecimal", 0, false, false, false, "Costo Vari"),
                f("costoTota", "costo_tota", "BigDecimal", 0, false, false, false, "Costo Tota"),
                f("toneladas", "toneladas", "BigDecimal", 0, false, false, false, "Toneladas"),
                f("ventas", "ventas", "BigDecimal", 0, false, false, false, "Ventas"),
                f("costoVariUni", "costo_vari_uni", "BigDecimal", 0, false, false, false, "Costo Vari Uni"),
                f("precioVariUnit", "precio_vari_unit", "BigDecimal", 0, false, false, false, "Precio Vari Unit"),
                f("peunidades", "peunidades", "BigDecimal", 0, false, false, false, "Peunidades"),
                f("peventas", "peventas", "BigDecimal", 0, false, false, false, "Peventas"),
                f("margSegu", "marg_segu", "BigDecimal", 0, false, false, false, "Marg Segu"))));
        add(new EntityMeta("cuentas_reporte", "CUENTAS_REPORTE", "Cuentas Reporte", CuentasReporte.class, null, List.of(
                f("tipoCuen", "tipo_cuen", "Short", 0, true, true, false, "Tipo Cuen"),
                f("descripcion", "descripcion", "String", 255, false, false, false, "Descripcion"),
                f("orden", "orden", "String", 1, false, false, false, "Orden"),
                f("codiGrupo", "codi_grupo", "Integer", 0, false, false, false, "Codi Grupo"))));
        add(new EntityMeta("cuentas_provision", "CUENTAS_PROVISION", "Cuentas Provision", CuentasProvision.class, null, List.of(
                f("codigo", "codigo", "String", 2, true, true, false, "Codigo"),
                f("descripcion", "descripcion", "String", 50, true, false, false, "Descripcion"),
                f("cuenta", "cuenta", "String", 7, true, false, false, "Cuenta"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"))));
        add(new EntityMeta("cabecera_detraccion", "cabecera_detraccion", "Cabecera Detraccion", CabeceraDetraccion.class, null, List.of(
                f("codiLoteDetr", "codi_lote_detr", "String", 10, true, true, false, "Codi Lote Detr"),
                f("nroLoteDetrac", "nro_lote_detrac", "String", 6, true, false, false, "Nro Lote Detrac"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("anio", "anio", "String", 4, false, false, false, "Anio"),
                f("nro", "nro", "Integer", 0, false, false, false, "Nro"),
                f("fechGene", "fech_gene", "LocalDateTime", 0, false, false, false, "Fech Gene"),
                f("mes", "mes", "String", 2, false, false, false, "Mes"))));
    }

    private void load2() {
        add(new EntityMeta("bien_servicio", "bien_servicio", "Bien Servicio", BienServicio.class, null, List.of(
                f("codiBienServ", "codi_bien_serv", "String", 3, true, true, false, "Codi Bien Serv"),
                f("descBienServ", "desc_bien_serv", "String", 250, false, false, false, "Desc Bien Serv"),
                f("nemoBienServ", "nemo_bien_serv", "String", 50, false, false, false, "Nemo Bien Serv"),
                f("porcBienServ", "porc_bien_serv", "BigDecimal", 0, false, false, false, "Porc Bien Serv"),
                f("inicio", "inicio", "LocalDateTime", 0, false, false, false, "Inicio"),
                f("fin", "fin", "LocalDateTime", 0, false, false, false, "Fin"))));
        add(new EntityMeta("tipo_afecta_igv", "TIPO_AFECTA_IGV", "Tipo Afecta Igv", TipoAfectaIgv.class, null, List.of(
                f("codiTipoAfec", "codi_tipo_afec", "String", 2, true, true, false, "Codi Tipo Afec"),
                f("descTipoAfec", "desc_tipo_afec", "String", 150, false, false, false, "Desc Tipo Afec"),
                f("tipoAfec", "tipo_afec", "String", 50, false, false, false, "Tipo Afec"),
                f("codImp", "cod_imp", "Integer", 0, false, false, false, "Cod Imp"))));
        add(new EntityMeta("cuentas_plan_prov", "CUENTAS_PLAN_PROV", "Cuentas Plan Prov", CuentasPlanProv.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("codiItem", "codi_item", "String", 3, true, false, false, "Codi Item"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, false, false, "Codi Unid Oper"),
                f("nroCuen", "nro_cuen", "String", 7, true, false, false, "Nro Cuen"),
                f("cargo", "cargo", "String", 1, true, false, false, "Cargo"),
                f("grupo", "grupo", "String", 1, true, false, false, "Grupo"),
                f("tipoPlan", "tipo_plan", "String", 2, false, false, false, "Tipo Plan"))));
        add(new EntityMeta("cuentas_partida_reporte", "CUENTAS_PARTIDA_REPORTE", "Cuentas Partida Reporte", CuentasPartidaReporte.class, CuentasPartidaReporte.Pk.class, List.of(
                f("nroCuen", "nro_cuen", "String", 7, true, true, false, "Nro Cuen"),
                f("codiPartida", "codi_partida", "String", 4, true, true, false, "Codi Partida"))));
        add(new EntityMeta("cuentas_partida", "CUENTAS_PARTIDA", "Cuentas Partida", CuentasPartida.class, null, List.of(
                f("codiPartida", "codi_partida", "String", 4, true, true, false, "Codi Partida"),
                f("descripcion", "descripcion", "String", 255, false, false, false, "Descripcion"),
                f("tipoCuen", "tipo_cuen", "Short", 0, false, false, false, "Tipo Cuen"),
                f("orden", "orden", "Integer", 0, false, false, false, "Orden"))));
        add(new EntityMeta("cuentas_gerencial", "Cuentas_Gerencial", "Cuentas Gerencial", CuentasGerencial.class, null, List.of(
                f("item", "item", "String", 3, true, true, false, "Item"),
                f("nroCuen", "nro_cuen", "String", 7, true, false, false, "Nro Cuen"),
                f("resumen", "resumen", "String", 100, false, false, false, "Resumen"))));
        add(new EntityMeta("cuentas_costo", "CUENTAS_COSTO", "Cuentas Costo", CuentasCosto.class, null, List.of(
                f("codiCuenCost", "codi_cuen_cost", "String", 2, true, true, false, "Codi Cuen Cost"),
                f("codiClasCuen", "codi_clas_cuen", "String", 2, false, false, false, "Codi Clas Cuen"))));
        add(new EntityMeta("elemento_costo", "ELEMENTO_COSTO", "Elemento Costo", ElementoCosto.class, null, List.of(
                f("codiElemCosto", "codi_elem_costo", "Short", 0, true, true, false, "Codi Elem Costo"),
                f("descElemCosto", "desc_elem_costo", "String", 150, true, false, false, "Desc Elem Costo"),
                f("nemo", "nemo", "String", 50, false, false, false, "Nemo"),
                f("codiTipoGast", "codi_tipo_gast", "String", 2, true, false, false, "Codi Tipo Gast"),
                f("uso", "uso", "String", 1, false, false, false, "Uso"))));
        add(new EntityMeta("eeff", "EEFF", "Eeff", Eeff.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("codEsta", "cod_esta", "String", 2, false, false, false, "Cod Esta"),
                f("desEsta", "des_esta", "String", 55, false, false, false, "Des Esta"))));
        add(new EntityMeta("costo", "COSTO", "Costo", Costo.class, null, List.of(
                f("codiCosto", "codi_costo", "Short", 0, true, true, false, "Codi Costo"),
                f("descCosto", "desc_costo", "String", 100, true, false, false, "Desc Costo"))));
        add(new EntityMeta("sunat_f318", "SUNAT_F318", "Sunat F318", SunatF318.class, null, List.of(
                f("idTipoFlujo", "id_tipo_flujo", "Integer", 0, true, true, false, "Id Tipo Flujo"),
                f("idFlujo", "id_flujo", "Integer", 0, true, false, false, "Id Flujo"),
                f("descActi", "desc_acti", "String", 100, false, false, false, "Desc Acti"),
                f("descFlujo", "desc_flujo", "String", 250, false, false, false, "Desc Flujo"),
                f("subdia", "subdia", "String", 1, false, false, false, "Subdia"),
                f("orden", "orden", "Integer", 0, false, false, false, "Orden"))));
        add(new EntityMeta("sunat", "SUNAT", "Sunat", Sunat.class, null, List.of(
                f("codiSunat", "codi_sunat", "String", 5, true, true, false, "Codi Sunat"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"))));
        add(new EntityMeta("subdiario", "SUBDIARIO", "Subdiario", Subdiario.class, null, List.of(
                f("codiSubd", "codi_subd", "String", 2, true, true, false, "Codi Subd"),
                f("nemotec", "nemotec", "String", 1, false, false, false, "Nemotec"),
                f("descrip", "descrip", "String", 40, false, false, false, "Descrip"),
                f("orden", "orden", "Integer", 0, false, false, false, "Orden"),
                f("central", "central", "String", 1, false, false, false, "Central"),
                f("codiLibro", "codi_libro", "Integer", 0, false, false, false, "Codi Libro"))));
        add(new EntityMeta("declara_jurada_merca", "DECLARA_JURADA_MERCA", "Declara Jurada Merca", DeclaraJuradaMerca.class, DeclaraJuradaMerca.Pk.class, List.of(
                f("codiDecla", "codi_decla", "Long", 0, true, true, false, "Codi Decla"),
                f("codiLin", "codi_lin", "String", 2, true, true, false, "Codi Lin"),
                f("montoLinea", "monto_linea", "Long", 0, false, false, false, "Monto Linea"))));
        add(new EntityMeta("declara_jurada_caja", "DECLARA_JURADA_CAJA", "Declara Jurada Caja", DeclaraJuradaCaja.class, DeclaraJuradaCaja.Pk.class, List.of(
                f("codiDecla", "codi_decla", "Long", 0, true, true, false, "Codi Decla"),
                f("fechaCaja", "fecha_caja", "LocalDateTime", 0, true, true, false, "Fecha Caja"),
                f("montoCaja", "monto_caja", "BigDecimal", 0, false, false, false, "Monto Caja"),
                f("codiMone", "codi_mone", "String", 2, true, true, false, "Codi Mone"))));
        add(new EntityMeta("declara_jurada", "DECLARA_JURADA", "Declara Jurada", DeclaraJurada.class, null, List.of(
                f("codiDecla", "codi_decla", "Long", 0, true, true, false, "Codi Decla"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("fechaDecla", "fecha_decla", "LocalDateTime", 0, false, false, false, "Fecha Decla"),
                f("direccion", "direccion", "String", 150, false, false, false, "Direccion"),
                f("lugar", "lugar", "String", 50, false, false, false, "Lugar"))));
        add(new EntityMeta("decl_diar_zarp", "DECL_DIAR_ZARP", "Decl Diar Zarp", DeclDiarZarp.class, null, List.of(
                f("codiDeclDiarZarp", "codi_decl_diar_zarp", "String", 10, true, true, false, "Codi Decl Diar Zarp"),
                f("numeDecl", "nume_decl", "String", 10, false, false, false, "Nume Decl"),
                f("fecha", "fecha", "LocalDateTime", 0, true, false, false, "Fecha"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, false, false, "Codi Unid Oper"),
                f("nroMatri", "nro_matri", "String", 15, false, false, false, "Nro Matri"),
                f("arquBrut", "arqu_brut", "BigDecimal", 0, false, false, false, "Arqu Brut"),
                f("codiPuerCapi", "codi_puer_capi", "String", 2, false, false, false, "Codi Puer Capi"),
                f("zonaPesc", "zona_pesc", "String", 100, false, false, false, "Zona Pesc"),
                f("tiemOper", "tiem_oper", "String", 100, false, false, false, "Tiem Oper"),
                f("fechEstiArri", "fech_esti_arri", "LocalDateTime", 0, false, false, false, "Fech Esti Arri"),
                f("codiUsuaRepr", "codi_usua_repr", "String", 5, false, false, false, "Codi Usua Repr"),
                f("fechVencMatr", "fech_venc_matr", "LocalDateTime", 0, false, false, false, "Fech Venc Matr"),
                f("fechVencLmc", "fech_venc_lmc", "LocalDateTime", 0, false, false, false, "Fech Venc Lmc"),
                f("fechVencCompComp", "fech_venc_comp_comp", "LocalDateTime", 0, false, false, false, "Fech Venc Comp Comp"),
                f("fechVencRadiBali", "fech_venc_radi_bali", "LocalDateTime", 0, false, false, false, "Fech Venc Radi Bali"),
                f("fechVencSegu", "fech_venc_segu", "LocalDateTime", 0, false, false, false, "Fech Venc Segu"),
                f("fechVencHidrCarb", "fech_venc_hidr_carb", "LocalDateTime", 0, false, false, false, "Fech Venc Hidr Carb"),
                f("fechVencAguaSuci", "fech_venc_agua_suci", "LocalDateTime", 0, false, false, false, "Fech Venc Agua Suci"),
                f("codiPatr", "codi_patr", "String", 5, false, false, false, "Codi Patr"))));
        add(new EntityMeta("estados_financieros_detalle", "ESTADOS_FINANCIEROS_DETALLE", "Estados Financieros Detalle", EstadosFinancierosDetalle.class, null, List.of(
                f("sigeId", "sige_id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("id", "id", "Short", 0, true, false, false, "Id"),
                f("nroCuen", "nro_cuen", "String", 3, true, false, false, "Nro Cuen"),
                f("orden", "orden", "Short", 0, true, false, false, "Orden"))));
        add(new EntityMeta("estados_financieros", "ESTADOS_FINANCIEROS", "Estados Financieros", EstadosFinancieros.class, null, List.of(
                f("id", "id", "Short", 0, true, true, false, "Id"),
                f("descripcion", "descripcion", "String", 50, true, false, false, "Descripcion"),
                f("orden", "orden", "Short", 0, false, false, false, "Orden"),
                f("tipo", "tipo", "Short", 0, false, false, false, "1 funcion 2 naturaleza"))));
        add(new EntityMeta("libro_registro", "LIBRO_REGISTRO", "Libro Registro", LibroRegistro.class, null, List.of(
                f("codiLibroRegi", "codi_libro_regi", "Short", 0, true, true, false, "Codi Libro Regi"),
                f("descLibroRegi", "desc_libro_regi", "String", 200, true, false, false, "Desc Libro Regi"))));
        add(new EntityMeta("libro_diario_s", "LIBRO_DIARIO_S", "Libro Diario S", LibroDiarioS.class, null, List.of(
                f("cuenta", "cuenta", "String", 7, true, true, false, "Cuenta"),
                f("tipo", "tipo", "String", 2, false, false, false, "Tipo"))));
        add(new EntityMeta("reporte_eeff_grupo", "REPORTE_EEFF_GRUPO", "Reporte Eeff Grupo", ReporteEeffGrupo.class, null, List.of(
                f("codiGrupo", "codi_grupo", "Integer", 0, true, true, false, "Codi Grupo"),
                f("descGrupo", "desc_grupo", "String", 100, false, false, false, "Desc Grupo"),
                f("codiRepo", "codi_repo", "Integer", 0, false, false, false, "Codi Repo"),
                f("orden", "orden", "String", 1, false, false, false, "Orden"))));
        add(new EntityMeta("reporte_eeff", "REPORTE_EEFF", "Reporte Eeff", ReporteEeff.class, null, List.of(
                f("codiRepo", "codi_repo", "Integer", 0, true, true, false, "Codi Repo"),
                f("descRepo", "desc_repo", "String", 100, false, false, false, "Desc Repo"))));
        add(new EntityMeta("decl_diar_zarp_deta", "DECL_DIAR_ZARP_DETA", "Decl Diar Zarp Deta", DeclDiarZarpDeta.class, DeclDiarZarpDeta.Pk.class, List.of(
                f("codiDeclDiarZarp", "codi_decl_diar_zarp", "String", 10, true, true, false, "Codi Decl Diar Zarp"),
                f("nroItem", "nro_item", "String", 2, true, true, false, "Nro Item"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"),
                f("nroMatrPers", "nro_matr_pers", "String", 30, false, false, false, "Nro Matr Pers"),
                f("finVigeMatr", "fin_vige_matr", "LocalDateTime", 0, false, false, false, "Fin Vige Matr"),
                f("codiCarg", "codi_carg", "String", 4, false, false, false, "Codi Carg"))));
        add(new EntityMeta("cuentas_plan_prov_concep", "CUENTAS_PLAN_PROV_CONCEP", "Cuentas Plan Prov Concep", CuentasPlanProvConcep.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("codiItem", "codi_item", "String", 3, true, false, false, "Codi Item"),
                f("codiDeta", "codi_deta", "String", 3, true, false, false, "Codi Deta"),
                f("codiConc", "codi_conc", "String", 6, true, false, false, "Codi Conc"),
                f("codiConcFin", "codi_conc_fin", "String", 6, true, false, false, "Codi Conc Fin"))));
    }

    private void load3() {
        add(new EntityMeta("sub_clas_cuen", "SUB_CLAS_CUEN", "Sub Clas Cuen", SubClasCuen.class, null, List.of(
                f("codiSubc", "codi_subc", "String", 3, true, true, false, "Codi Subc"),
                f("descSubc", "desc_subc", "String", 100, true, false, false, "Desc Subc"),
                f("codiClasCuen", "codi_clas_cuen", "String", 2, false, false, false, "Codi Clas Cuen"))));
        add(new EntityMeta("tipo_form_most_eeff", "TIPO_FORM_MOST_EEFF", "Tipo Form Most Eeff", TipoFormMostEeff.class, TipoFormMostEeff.Pk.class, List.of(
                f("codiTipoEeff", "codi_tipo_eeff", "String", 2, true, true, false, "Codi Tipo Eeff"),
                f("codiClasCuen", "codi_clas_cuen", "String", 2, true, true, false, "Codi Clas Cuen"),
                f("tipoFormMost", "tipo_form_most", "String", 2, false, false, false, "Tipo Form Most"))));
        add(new EntityMeta("activos", "Activos", "Activos", Activos.class, null, List.of(
                f("codiActivo", "codi_activo", "String", 7, true, true, false, "Codi Activo"),
                f("descriActivo", "descri_activo", "String", 100, false, false, false, "Descri Activo"),
                f("codiGrup", "codi_grup", "Long", 0, false, false, false, "Codi Grup"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("fechIngre", "fech_ingre", "LocalDateTime", 0, false, false, false, "Fech Ingre"),
                f("nroDocu", "nro_docu", "String", 20, false, false, false, "Nro Docu"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("costo", "costo", "BigDecimal", 0, false, false, false, "Costo"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("tdat", "tdat", "BigDecimal", 0, false, false, false, "Tdat"),
                f("tdac", "tdac", "BigDecimal", 0, false, false, false, "Tdac"),
                f("mes", "mes", "String", 2, false, false, false, "Mes"),
                f("anio", "anio", "String", 4, false, false, false, "Anio"),
                f("codiMarca", "codi_marca", "String", 4, false, false, false, "Codi Marca"),
                f("serie", "serie", "String", 20, false, false, false, "Serie"),
                f("modelo", "modelo", "String", 50, false, false, false, "Modelo"),
                f("anioFabr", "anio_fabr", "String", 4, false, false, false, "Anio Fabr"),
                f("matricula", "matricula", "String", 50, false, false, false, "Matricula"),
                f("color", "color", "String", 50, false, false, false, "Color"),
                f("capacidad", "capacidad", "String", 50, false, false, false, "Capacidad"),
                f("ancho", "ancho", "BigDecimal", 0, false, false, false, "Ancho"),
                f("largo", "largo", "BigDecimal", 0, false, false, false, "Largo"),
                f("alto", "alto", "BigDecimal", 0, false, false, false, "Alto"),
                f("voltaje", "voltaje", "BigDecimal", 0, false, false, false, "Voltaje"),
                f("amperaje", "amperaje", "BigDecimal", 0, false, false, false, "Amperaje"),
                f("fechaDepre", "fecha_depre", "LocalDateTime", 0, false, false, false, "Fecha Depre"),
                f("fechaContrato", "fecha_contrato", "LocalDateTime", 0, false, false, false, "Fecha Contrato"),
                f("nroConArre", "nro_con_arre", "String", 100, false, false, false, "Nro Con Arre"),
                f("fechaIniArre", "fecha_ini_arre", "LocalDateTime", 0, false, false, false, "Fecha Ini Arre"),
                f("nroCuotas", "nro_cuotas", "String", 10, false, false, false, "Nro Cuotas"),
                f("montoArre", "monto_arre", "BigDecimal", 0, false, false, false, "Monto Arre"),
                f("fechaRetiro", "fecha_retiro", "LocalDateTime", 0, false, false, false, "Fecha Retiro"))));
        add(new EntityMeta("decl_zarp_trim", "DECL_ZARP_TRIM", "Decl Zarp Trim", DeclZarpTrim.class, null, List.of(
                f("codiZarpTrim", "codi_zarp_trim", "String", 10, true, true, false, "Codi Zarp Trim"),
                f("numeZarp", "nume_zarp", "String", 10, false, false, false, "Nume Zarp"),
                f("fecha", "fecha", "LocalDateTime", 0, true, false, false, "Fecha"),
                f("fechInicVige", "fech_inic_vige", "LocalDateTime", 0, false, false, false, "Fech Inic Vige"),
                f("fechFinVige", "fech_fin_vige", "LocalDateTime", 0, false, false, false, "Fech Fin Vige"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, false, false, "Codi Unid Oper"),
                f("nroMatri", "nro_matri", "String", 15, false, false, false, "Nro Matri"),
                f("arquBrut", "arqu_brut", "BigDecimal", 0, false, false, false, "Arqu Brut"),
                f("arquNeto", "arqu_neto", "BigDecimal", 0, false, false, false, "Arqu Neto"),
                f("codiPuerCapi", "codi_puer_capi", "String", 2, false, false, false, "Codi Puer Capi"),
                f("codiUsuaRepr", "codi_usua_repr", "String", 5, false, false, false, "Codi Usua Repr"),
                f("nroTrip", "nro_trip", "Integer", 0, false, false, false, "Nro Trip"),
                f("fechVencMatr", "fech_venc_matr", "LocalDateTime", 0, false, false, false, "Fech Venc Matr"),
                f("fechVencArqu", "fech_venc_arqu", "LocalDateTime", 0, false, false, false, "Fech Venc Arqu"),
                f("fechVencLmc", "fech_venc_lmc", "LocalDateTime", 0, false, false, false, "Fech Venc Lmc"),
                f("fechVencCompComp", "fech_venc_comp_comp", "LocalDateTime", 0, false, false, false, "Fech Venc Comp Comp"),
                f("fechVencRadiBali", "fech_venc_radi_bali", "LocalDateTime", 0, false, false, false, "Fech Venc Radi Bali"),
                f("fechVencSegu", "fech_venc_segu", "LocalDateTime", 0, false, false, false, "Fech Venc Segu"),
                f("fechVencHidrCarb", "fech_venc_hidr_carb", "LocalDateTime", 0, false, false, false, "Fech Venc Hidr Carb"),
                f("fechVencAguaSuci", "fech_venc_agua_suci", "LocalDateTime", 0, false, false, false, "Fech Venc Agua Suci"),
                f("codiPatr", "codi_patr", "String", 5, false, false, false, "Codi Patr"),
                f("coloCasc", "colo_casc", "String", 50, false, false, false, "Colo Casc"),
                f("coloSupeEstr", "colo_supe_estr", "String", 50, false, false, false, "Colo Supe Estr"))));
        add(new EntityMeta("decl_diar_arri", "DECL_DIAR_ARRI", "Decl Diar Arri", DeclDiarArri.class, null, List.of(
                f("codiDeclDiarArri", "codi_decl_diar_arri", "String", 10, true, true, false, "Codi Decl Diar Arri"),
                f("numeArri", "nume_arri", "String", 10, false, false, false, "Nume Arri"),
                f("fecha", "fecha", "LocalDateTime", 0, true, false, false, "Fecha"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, false, false, "Codi Unid Oper"),
                f("nroMatri", "nro_matri", "String", 15, false, false, false, "Nro Matri"),
                f("codiDeclDiarZarp", "codi_decl_diar_zarp", "String", 10, false, false, false, "Codi Decl Diar Zarp"),
                f("codiPuerArri", "codi_puer_arri", "String", 2, false, false, false, "Codi Puer Arri"),
                f("fechArri", "fech_arri", "LocalDateTime", 0, false, false, false, "Fech Arri"),
                f("zonaPesc", "zona_pesc", "String", 100, false, false, false, "Zona Pesc"),
                f("latitud", "latitud", "String", 20, false, false, false, "Latitud"),
                f("longitud", "longitud", "String", 20, false, false, false, "Longitud"),
                f("tiempo", "tiempo", "String", 20, false, false, false, "Tiempo"),
                f("tiemNave", "tiem_nave", "String", 100, false, false, false, "Tiem Nave"),
                f("codiEspe1", "codi_espe_1", "String", 2, false, false, false, "Codi Espe 1"),
                f("codiEspe2", "codi_espe_2", "String", 2, false, false, false, "Codi Espe 2"),
                f("codiEspe3", "codi_espe_3", "String", 2, false, false, false, "Codi Espe 3"),
                f("cantEspe1", "cant_espe_1", "BigDecimal", 0, false, false, false, "Cant Espe 1"),
                f("cantEspe2", "cant_espe_2", "BigDecimal", 0, false, false, false, "Cant Espe 2"),
                f("cantEspe3", "cant_espe_3", "BigDecimal", 0, false, false, false, "Cant Espe 3"),
                f("codiPlanDesc", "codi_plan_desc", "String", 5, false, false, false, "Codi Plan Desc"),
                f("codiPlanComp", "codi_plan_comp", "String", 5, false, false, false, "Codi Plan Comp"),
                f("obse1", "obse_1", "String", 150, false, false, false, "Obse 1"),
                f("obse2", "obse_2", "String", 150, false, false, false, "Obse 2"),
                f("obse3", "obse_3", "String", 150, false, false, false, "Obse 3"),
                f("obse4", "obse_4", "String", 150, false, false, false, "Obse 4"),
                f("obse5", "obse_5", "String", 150, false, false, false, "Obse 5"),
                f("obse6", "obse_6", "String", 150, false, false, false, "Obse 6"),
                f("obse7", "obse_7", "String", 150, false, false, false, "Obse 7"),
                f("obse8", "obse_8", "String", 150, false, false, false, "Obse 8"),
                f("codiPatr", "codi_patr", "String", 5, false, false, false, "Codi Patr"))));
        add(new EntityMeta("decl_zarp_trim_deta", "DECL_ZARP_TRIM_DETA", "Decl Zarp Trim Deta", DeclZarpTrimDeta.class, DeclZarpTrimDeta.Pk.class, List.of(
                f("codiZarpTrim", "codi_zarp_trim", "String", 10, true, true, false, "Codi Zarp Trim"),
                f("nroItem", "nro_item", "String", 2, true, true, false, "Nro Item"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"),
                f("nroMatrPers", "nro_matr_pers", "String", 30, false, false, false, "Nro Matr Pers"),
                f("finVigeMatr", "fin_vige_matr", "LocalDateTime", 0, false, false, false, "Fin Vige Matr"),
                f("codiCarg", "codi_carg", "String", 4, false, false, false, "Codi Carg"),
                f("codiTitu", "codi_titu", "String", 2, false, false, false, "Codi Titu"))));
        add(new EntityMeta("detalle_calc_af", "DETALLE_CALC_AF", "Detalle Calc Af", DetalleCalcAf.class, DetalleCalcAf.Pk.class, List.of(
                f("codiActivo", "codi_activo", "String", 7, true, true, false, "Codi Activo"),
                f("fechaDetalle", "fecha_detalle", "String", 6, true, true, false, "Fecha Detalle"),
                f("fechaActivo", "fecha_activo", "String", 6, false, false, false, "Fecha Activo"),
                f("costoHist", "costo_hist", "BigDecimal", 0, false, false, false, "Costo Hist"),
                f("costoAjus", "costo_ajus", "BigDecimal", 0, false, false, false, "Costo Ajus"),
                f("depreHistAnt", "depre_hist_ant", "BigDecimal", 0, false, false, false, "Depre Hist Ant"),
                f("depreHistAct", "depre_hist_act", "BigDecimal", 0, false, false, false, "Depre Hist Act"),
                f("depreAjusAct", "depre_ajus_act", "BigDecimal", 0, false, false, false, "Depre Ajus Act"),
                f("depreAjusAnt", "depre_ajus_ant", "BigDecimal", 0, false, false, false, "Depre Ajus Ant"),
                f("depreAcumHist", "depre_acum_hist", "BigDecimal", 0, false, false, false, "Depre Acum Hist"),
                f("depreAcumAjus", "depre_acum_ajus", "BigDecimal", 0, false, false, false, "Depre Acum Ajus"),
                f("netoHist", "neto_hist", "BigDecimal", 0, false, false, false, "Neto Hist"),
                f("netoAjus", "neto_ajus", "BigDecimal", 0, false, false, false, "Neto Ajus"),
                f("origen", "origen", "Boolean", 0, false, false, false, "Origen"),
                f("retirado", "retirado", "String", 1, false, false, false, "Retirado"),
                f("valorDepre", "valor_depre", "BigDecimal", 0, false, false, false, "Valor Depre"))));
    }

    @Override
    public String service() {
        return "contabilidad";
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
