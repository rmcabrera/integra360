package pe.sige.finanzas.domain.legacy;

import jakarta.enterprise.context.ApplicationScoped;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import pe.sige.common.catalog.EntityCatalog;
import pe.sige.common.catalog.EntityMeta;
import pe.sige.common.catalog.FieldMeta;

/** Catalogo de entidades legado de ms-finanzas (45 tablas). Generado: no editar. */
@ApplicationScoped
public class LegacyCatalog implements EntityCatalog {

    private final Map<String, EntityMeta> entities = new LinkedHashMap<>();

    public LegacyCatalog() {
        load0();
        load1();
    }

    private void add(EntityMeta m) {
        entities.put(m.name(), m);
    }

    private static FieldMeta f(String field, String column, String type, int length, boolean required, boolean id, boolean generated, String label) {
        return new FieldMeta(field, column, type, length, required, id, generated, label);
    }

    private void load0() {
        add(new EntityMeta("caja_chica", "CAJA_CHICA", "Caja Chica", CajaChica.class, CajaChica.Pk.class, List.of(
                f("codiAlma", "codi_alma", "String", 2, true, true, false, "Codi Alma"),
                f("nroRecibo", "nro_recibo", "String", 10, true, true, false, "Nro Recibo"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("tipoIo", "tipo_io", "Integer", 0, true, true, false, "Tipo Io"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("glosa", "glosa", "String", 150, false, false, false, "Glosa"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"),
                f("serie", "serie", "String", 10, false, false, false, "Serie"),
                f("nroDocu", "nro_docu", "String", 20, false, false, false, "Nro Docu"),
                f("tipoContab", "tipo_contab", "String", 3, false, false, false, "Tipo Contab"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("codiUsuaSoli", "codi_usua_soli", "String", 5, false, false, false, "Codi Usua Soli"),
                f("provCanc", "prov_canc", "String", 1, false, false, false, "Prov Canc"),
                f("horaReal", "hora_real", "LocalDateTime", 0, false, false, false, "Hora Real"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("placaCarreta", "placa_carreta", "String", 5, false, false, false, "Placa Carreta"),
                f("rendir", "rendir", "String", 1, false, false, false, "Rendir"),
                f("nroReciboAux", "nro_recibo_aux", "String", 10, false, false, false, "Nro Recibo Aux"),
                f("codiLiqu", "codi_liqu", "Long", 0, false, false, false, "Codi Liqu"),
                f("importeS", "importe_s", "BigDecimal", 0, false, false, false, "Importe S"),
                f("rutaDe", "ruta_de", "String", 200, false, false, false, "Ruta De"),
                f("rutaA", "ruta_a", "String", 200, false, false, false, "Ruta A"),
                f("fechaDocu", "fecha_docu", "LocalDateTime", 0, false, false, false, "Fecha Docu"),
                f("placa", "placa", "String", 5, false, false, false, "Placa"),
                f("galones", "galones", "BigDecimal", 0, false, false, false, "Galones"),
                f("kmIni", "km_ini", "BigDecimal", 0, false, false, false, "Km Ini"),
                f("kmFin", "km_fin", "BigDecimal", 0, false, false, false, "Km Fin"),
                f("fechaVence", "fecha_vence", "LocalDateTime", 0, false, false, false, "Fecha Vence"),
                f("dsctoAdm", "dscto_adm", "String", 1, false, false, false, "Dscto Adm"),
                f("hechoPor", "hecho_por", "String", 5, false, false, false, "Hecho Por"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("activo", "activo", "String", 1, false, false, false, "Activo"))));
        add(new EntityMeta("letras_productos", "LETRAS_PRODUCTOS", "Letras Productos", LetrasProductos.class, LetrasProductos.Pk.class, List.of(
                f("registro", "registro", "String", 11, true, true, false, "Registro"),
                f("codiProd", "codi_prod", "String", 8, true, true, false, "Codi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"))));
        add(new EntityMeta("registro_pagos", "REGISTRO_PAGOS", "Registro Pagos", RegistroPagos.class, null, List.of(
                f("idSec", "id_sec", "Long", 0, true, true, true, "Id Sec"),
                f("fechaReg", "fecha_reg", "LocalDateTime", 0, false, false, false, "Fecha Reg"),
                f("numero", "numero", "Long", 0, false, false, false, "Numero"),
                f("documento", "documento", "String", 50, false, false, false, "Documento"),
                f("medioPago", "medio_pago", "String", 50, false, false, false, "Medio Pago"),
                f("cuota", "cuota", "String", 25, false, false, false, "Cuota"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("concepto", "concepto", "String", 250, false, false, false, "Concepto"),
                f("codigo", "codigo", "String", 35, false, false, false, "Codigo"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("comentario", "comentario", "String", 255, false, false, false, "Comentario"),
                f("fechaPago", "fecha_pago", "LocalDateTime", 0, false, false, false, "Fecha Pago"),
                f("observaciones", "observaciones", "String", 255, false, false, false, "Observaciones"),
                f("activo", "activo", "String", 1, false, false, false, "Activo"),
                f("condicion", "condicion", "String", 1, false, false, false, "Condicion"),
                f("codiCliePers", "codi_clie_pers", "String", 5, false, false, false, "Codi Clie Pers"),
                f("cliePers", "clie_pers", "String", 150, false, false, false, "Clie Pers"))));
        add(new EntityMeta("tipo_form_pago", "TIPO_FORM_PAGO", "Tipo Form Pago", TipoFormPago.class, null, List.of(
                f("codiFormPago", "codi_form_pago", "String", 2, true, true, false, "Codi Form Pago"),
                f("descFormPago", "desc_form_pago", "String", 100, false, false, false, "Desc Form Pago"),
                f("nemoFormPago", "nemo_form_pago", "String", 20, false, false, false, "Nemo Form Pago"),
                f("codiTipoPago", "codi_tipo_pago", "Short", 0, false, false, false, "Codi Tipo Pago"))));
        add(new EntityMeta("caja_cierre", "CAJA_CIERRE", "Caja Cierre", CajaCierre.class, CajaCierre.Pk.class, List.of(
                f("codiAlma", "codi_alma", "String", 2, true, true, false, "Codi Alma"),
                f("fecha", "fecha", "LocalDateTime", 0, true, true, false, "Fecha"))));
        add(new EntityMeta("caja_chica_depo", "CAJA_CHICA_DEPO", "Caja Chica Depo", CajaChicaDepo.class, CajaChicaDepo.Pk.class, List.of(
                f("codiDepo", "codi_depo", "String", 10, true, true, false, "Codi Depo"),
                f("codiDocu", "codi_docu", "String", 10, true, true, false, "Codi Docu"),
                f("tipoRela", "tipo_rela", "String", 1, false, false, false, "Tipo Rela"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"),
                f("serFact", "ser_fact", "String", 10, false, false, false, "Ser Fact"),
                f("nroFact", "nro_fact", "String", 20, false, false, false, "Nro Fact"),
                f("totaFact", "tota_fact", "BigDecimal", 0, false, false, false, "Tota Fact"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("grupo", "grupo", "Integer", 0, false, false, false, "Grupo"))));
        add(new EntityMeta("letra_calculo", "Letra_Calculo", "Letra Calculo", LetraCalculo.class, LetraCalculo.Pk.class, List.of(
                f("codiLetra", "codi_letra", "String", 3, true, true, false, "Codi Letra"),
                f("anio", "anio", "String", 4, true, true, false, "Anio"),
                f("codiContable", "codi_contable", "String", 10, false, false, false, "Codi Contable"),
                f("nroCuenBanco", "nro_cuen_banco", "String", 7, false, false, false, "Nro Cuen Banco"),
                f("nroCuenAmor", "nro_cuen_amor", "String", 7, false, false, false, "Nro Cuen Amor"),
                f("nroCuenInte", "nro_cuen_inte", "String", 7, false, false, false, "Nro Cuen Inte"),
                f("fechVenc", "fech_venc", "LocalDateTime", 0, false, false, false, "Fech Venc"),
                f("importeAmor", "importe_amor", "BigDecimal", 0, false, false, false, "Importe Amor"),
                f("importeInte", "importe_inte", "BigDecimal", 0, false, false, false, "Importe Inte"),
                f("tipoSitu", "tipo_situ", "String", 2, false, false, false, "Tipo Situ"),
                f("observacion", "observacion", "String", 50, false, false, false, "Observacion"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("tipo", "tipo", "String", 1, true, true, false, "Tipo"),
                f("saldo", "saldo", "BigDecimal", 0, false, false, false, "Saldo"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"))));
        add(new EntityMeta("conci_banco", "CONCI_BANCO", "Conci Banco", ConciBanco.class, null, List.of(
                f("codiConcBanc", "codi_conc_banc", "String", 10, true, true, false, "Codi Conc Banc"),
                f("nroCuen", "nro_cuen", "String", 7, true, false, false, "Nro Cuen"),
                f("anio", "anio", "String", 4, true, false, false, "Anio"),
                f("mes", "mes", "String", 2, true, false, false, "Mes"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("subdia", "subdia", "String", 2, false, false, false, "Subdia"),
                f("compr", "compr", "String", 10, false, false, false, "Compr"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"),
                f("nroDocu", "nro_docu", "String", 10, false, false, false, "Nro Docu"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("glosa", "glosa", "String", 200, false, false, false, "Glosa"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("saldo", "saldo", "BigDecimal", 0, false, false, false, "Saldo"),
                f("codiTipoSituConcBanc", "codi_tipo_situ_conc_banc", "String", 2, false, false, false, "Codi Tipo Situ Conc Banc"),
                f("cargoAbono", "cargo_abono", "String", 1, false, false, false, "Cargo Abono"),
                f("anioDocu", "anio_docu", "String", 4, false, false, false, "Anio Docu"),
                f("mesDocu", "mes_docu", "String", 2, false, false, false, "Mes Docu"),
                f("codiContable", "codi_contable", "String", 10, false, false, false, "Codi Contable"))));
        add(new EntityMeta("polizas", "Polizas", "Polizas", Polizas.class, null, List.of(
                f("codiPoli", "codi_poli", "Long", 0, true, true, true, "Codi Poli"),
                f("descripcion", "descripcion", "String", 50, false, false, false, "Descripcion"),
                f("tipo", "tipo", "String", 20, false, false, false, "Tipo"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("fechAdqui", "fech_adqui", "LocalDateTime", 0, false, false, false, "Fech Adqui"),
                f("fechVigen", "fech_vigen", "LocalDateTime", 0, false, false, false, "Fech Vigen"),
                f("nMesesPago", "n_meses_pago", "Integer", 0, false, false, false, "N Meses Pago"),
                f("diaPago", "dia_pago", "Integer", 0, false, false, false, "Dia Pago"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("montoMensual", "monto_mensual", "BigDecimal", 0, false, false, false, "Monto Mensual"),
                f("diasAviso", "dias_aviso", "Integer", 0, false, false, false, "Dias Aviso"))));
        add(new EntityMeta("tipo_medio_pago", "TIPO_MEDIO_PAGO", "Tipo Medio Pago", TipoMedioPago.class, null, List.of(
                f("codiTipoMedioPago", "codi_tipo_medio_pago", "Short", 0, true, true, false, "Codi Tipo Medio Pago"),
                f("codiSunat", "codi_sunat", "String", 3, true, false, false, "Codi Sunat"),
                f("descTipoMedioPago", "desc_tipo_medio_pago", "String", 250, true, false, false, "Desc Tipo Medio Pago"),
                f("nemo", "nemo", "String", 30, false, false, false, "Nemo"))));
        add(new EntityMeta("bancos", "BANCOS", "Bancos", Bancos.class, null, List.of(
                f("codiBanc", "codi_banc", "String", 2, true, true, false, "Codi Banc"),
                f("descBanc", "desc_banc", "String", 50, false, false, false, "Desc Banc"),
                f("direBanc", "dire_banc", "String", 150, false, false, false, "Dire Banc"),
                f("teleBanc", "tele_banc", "String", 30, false, false, false, "Tele Banc"),
                f("faxBanc", "fax_banc", "String", 20, false, false, false, "Fax Banc"),
                f("nemo", "nemo", "String", 10, false, false, false, "Nemo"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("codiSunat", "codi_sunat", "String", 2, false, false, false, "Codi Sunat"),
                f("teaCts", "tea_cts", "BigDecimal", 0, false, false, false, "Tea Cts"),
                f("teaCtsDola", "tea_cts_dola", "BigDecimal", 0, false, false, false, "Tea Cts Dola"))));
        add(new EntityMeta("pres_pago", "PRES_PAGO", "Pres Pago", PresPago.class, null, List.of(
                f("codiPres", "codi_pres", "String", 4, true, true, false, "Codi Pres"),
                f("descPres", "desc_pres", "String", 40, false, false, false, "Desc Pres"),
                f("codiGrup", "codi_grup", "String", 2, true, false, false, "Codi Grup"))));
        add(new EntityMeta("pres_grup", "pres_grup", "Pres Grup", PresGrup.class, null, List.of(
                f("codiGrup", "codi_grup", "String", 2, true, true, false, "Codi Grup"),
                f("descGrup", "desc_grup", "String", 40, false, false, false, "Desc Grup"))));
        add(new EntityMeta("tipo_situ_conc_banc", "TIPO_SITU_CONC_BANC", "Tipo Situ Conc Banc", TipoSituConcBanc.class, null, List.of(
                f("codiTipoSituConcBanc", "codi_tipo_situ_conc_banc", "String", 2, true, true, false, "Codi Tipo Situ Conc Banc"),
                f("descTipoSituConcBanc", "desc_tipo_situ_conc_banc", "String", 50, false, false, false, "Desc Tipo Situ Conc Banc"),
                f("simbTipoSituConcBanc", "simb_tipo_situ_conc_banc", "String", 3, false, false, false, "Simb Tipo Situ Conc Banc"))));
        add(new EntityMeta("tipo_situ_cheq", "Tipo_Situ_Cheq", "Tipo Situ Cheq", TipoSituCheq.class, null, List.of(
                f("codiSituCheq", "codi_situ_cheq", "String", 2, true, true, false, "Codi Situ Cheq"),
                f("descSituCheq", "desc_situ_cheq", "String", 50, false, false, false, "Desc Situ Cheq"),
                f("tipoSituLetra", "tipo_situ_letra", "String", 1, false, false, false, "Tipo Situ Letra"))));
        add(new EntityMeta("tipo_reembolso_almacen", "TIPO_REEMBOLSO_ALMACEN", "Tipo Reembolso Almacen", TipoReembolsoAlmacen.class, TipoReembolsoAlmacen.Pk.class, List.of(
                f("tipoReemb", "tipo_reemb", "String", 3, true, true, false, "Tipo Reemb"),
                f("codiAlma", "codi_alma", "String", 2, true, true, false, "Codi Alma"))));
        add(new EntityMeta("tipo_reembolso", "TIPO_REEMBOLSO", "Tipo Reembolso", TipoReembolso.class, null, List.of(
                f("tipoReemb", "tipo_reemb", "String", 3, true, true, false, "Tipo Reemb"),
                f("descReemb", "desc_reemb", "String", 50, false, false, false, "Desc Reemb"),
                f("ctaCon", "cta_con", "String", 7, false, false, false, "Cta Con"),
                f("ctaSin", "cta_sin", "String", 7, false, false, false, "Cta Sin"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"))));
        add(new EntityMeta("tipo_cta_cte", "TIPO_CTA_CTE", "Tipo Cta Cte", TipoCtaCte.class, null, List.of(
                f("codiTipoCtaCte", "codi_tipo_cta_cte", "String", 2, true, true, false, "Codi Tipo Cta Cte"),
                f("descTipoCtaCte", "desc_tipo_cta_cte", "String", 100, false, false, false, "Desc Tipo Cta Cte"),
                f("nemoTipoCtaCte", "nemo_tipo_cta_cte", "String", 20, false, false, false, "Nemo Tipo Cta Cte"))));
        add(new EntityMeta("tipo_cta_banc", "TIPO_CTA_BANC", "Tipo Cta Banc", TipoCtaBanc.class, null, List.of(
                f("codiTipoCuenBanc", "codi_tipo_cuen_banc", "String", 2, true, true, false, "Codi Tipo Cuen Banc"),
                f("descTipoCuenBanc", "desc_tipo_cuen_banc", "String", 50, false, false, false, "Desc Tipo Cuen Banc"),
                f("nemo", "nemo", "String", 10, false, false, false, "Nemo"),
                f("nroCeroTc", "nro_cero_tc", "Short", 0, false, false, false, "Nro Cero Tc"),
                f("tipoCuenTc", "tipo_cuen_tc", "String", 2, false, false, false, "Tipo Cuen Tc"))));
        add(new EntityMeta("tipo_cta", "TIPO_CTA", "Tipo Cta", TipoCta.class, null, List.of(
                f("codCta", "cod_cta", "String", 1, true, true, false, "Cod Cta"),
                f("descCta", "desc_cta", "String", 20, false, false, false, "Desc Cta"),
                f("grupo", "grupo", "String", 1, false, false, false, "Grupo"),
                f("orden", "orden", "Short", 0, false, false, false, "Orden"),
                f("descgrupo", "descgrupo", "String", 50, false, false, false, "Descgrupo"))));
        add(new EntityMeta("cta_cte_prov", "CTA_CTE_PROV", "Cta Cte Prov", CtaCteProv.class, null, List.of(
                f("codiCtaCte", "codi_cta_cte", "String", 6, true, true, false, "Codi Cta Cte"),
                f("codiClieProv", "codi_clie_prov", "String", 5, true, false, false, "Codi Clie Prov"),
                f("codiBanc", "codi_banc", "String", 2, false, false, false, "Codi Banc"),
                f("nroCtaCte", "nro_cta_cte", "String", 20, true, false, false, "Nro Cta Cte"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("tipoCtaBanc", "tipo_cta_banc", "String", 2, false, false, false, "Tipo Cta Banc"),
                f("obse", "obse", "String", 200, false, false, false, "Obse"),
                f("detraccion", "detraccion", "Boolean", 0, false, false, false, "Detraccion"))));
        add(new EntityMeta("saldo_moneda", "SALDO_MONEDA", "Saldo Moneda", SaldoMoneda.class, null, List.of(
                f("id", "id", "Long", 0, true, true, false, "Id"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("moneda", "moneda", "BigDecimal", 0, false, false, false, "Moneda"),
                f("cantS", "cant_s", "Integer", 0, false, false, false, "Cant S"),
                f("cantD", "cant_d", "Integer", 0, false, false, false, "Cant D"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"))));
        add(new EntityMeta("saldo_bancos", "SALDO_BANCOS", "Saldo Bancos", SaldoBancos.class, SaldoBancos.Pk.class, List.of(
                f("fecha", "fecha", "LocalDateTime", 0, true, true, false, "Fecha"),
                f("nroCuen", "nro_cuen", "String", 7, true, true, false, "Nro Cuen"),
                f("codiMone", "codi_mone", "String", 2, true, true, false, "Codi Mone"),
                f("saldo", "saldo", "BigDecimal", 0, false, false, false, "Saldo"))));
        add(new EntityMeta("sald_conc_banc", "SALD_CONC_BANC", "Sald Conc Banc", SaldConcBanc.class, null, List.of(
                f("codiSaldBanc", "codi_sald_banc", "String", 10, true, true, false, "Codi Sald Banc"),
                f("anio", "anio", "String", 4, false, false, false, "Anio"),
                f("mes", "mes", "String", 2, false, false, false, "Mes"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("saldLibr", "sald_libr", "BigDecimal", 0, false, false, false, "Sald Libr"),
                f("estaCuen", "esta_cuen", "BigDecimal", 0, false, false, false, "Esta Cuen"),
                f("saldAnte", "sald_ante", "BigDecimal", 0, false, false, false, "Sald Ante"))));
        add(new EntityMeta("rubros_caja_detalle", "RUBROS_CAJA_DETALLE", "Rubros Caja Detalle", RubrosCajaDetalle.class, RubrosCajaDetalle.Pk.class, List.of(
                f("idRubro", "id_rubro", "Integer", 0, true, true, false, "Id Rubro"),
                f("tipoReemb", "tipo_reemb", "String", 3, true, true, false, "Tipo Reemb"),
                f("iO", "i_o", "Integer", 0, false, false, false, "I O"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"))));
    }

    private void load1() {
        add(new EntityMeta("rubros_caja", "RUBROS_CAJA", "Rubros Caja", RubrosCaja.class, null, List.of(
                f("idRubro", "id_rubro", "Integer", 0, true, true, false, "Id Rubro"),
                f("descRubro", "desc_rubro", "String", 100, false, false, false, "Desc Rubro"),
                f("iO", "i_o", "Integer", 0, false, false, false, "I O"))));
        add(new EntityMeta("escribalo_deta", "ESCRIBALO_DETA", "Escribalo Deta", EscribaloDeta.class, EscribaloDeta.Pk.class, List.of(
                f("codiEscr", "codi_escr", "String", 10, true, true, false, "Codi Escr"),
                f("codiContable", "codi_contable", "String", 10, true, true, false, "Codi Contable"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("regb", "regb", "String", 7, false, false, false, "Regb"),
                f("codiVouc", "codi_vouc", "String", 10, false, false, false, "Codi Vouc"),
                f("codiRela", "codi_rela", "String", 10, false, false, false, "Codi Rela"),
                f("codiMone", "codi_mone", "String", 10, false, false, false, "Codi Mone"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("esta", "esta", "Boolean", 0, false, false, false, "Esta"),
                f("codiAgru", "codi_agru", "String", 10, false, false, false, "Codi Agru"),
                f("nroDocu", "nro_docu", "String", 50, false, false, false, "Nro Docu"),
                f("subdia", "subdia", "String", 1, false, false, false, "Subdia"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"))));
        add(new EntityMeta("escribalo", "ESCRIBALO", "Escribalo", Escribalo.class, null, List.of(
                f("codiEscr", "codi_escr", "String", 10, true, true, false, "Codi Escr"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("nroEscr", "nro_escr", "String", 6, false, false, false, "Nro Escr"),
                f("anio", "anio", "String", 4, false, false, false, "Anio"),
                f("inic", "inic", "String", 10, false, false, false, "Inic"),
                f("de", "de", "String", 200, false, false, false, "De"),
                f("para", "para", "String", 200, false, false, false, "Para"),
                f("asunto", "asunto", "String", 200, false, false, false, "Asunto"),
                f("codiUsuaGene", "codi_usua_gene", "String", 5, false, false, false, "Codi Usua Gene"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, false, false, false, "Fech Inic"),
                f("fechFin", "fech_fin", "LocalDateTime", 0, false, false, false, "Fech Fin"))));
        add(new EntityMeta("warrant_pagos", "WARRANT_PAGOS", "Warrant Pagos", WarrantPagos.class, null, List.of(
                f("codiPwarr", "codi_pwarr", "Long", 0, true, true, false, "Codi Pwarr"),
                f("nroWarr", "nro_warr", "String", 50, false, false, false, "Nro Warr"),
                f("fechaPago", "fecha_pago", "LocalDateTime", 0, false, false, false, "Fecha Pago"),
                f("cantiCancel", "canti_cancel", "BigDecimal", 0, false, false, false, "Canti Cancel"),
                f("montoPaga", "monto_paga", "BigDecimal", 0, false, false, false, "Monto Paga"),
                f("periodo", "periodo", "String", 4, false, false, false, "Periodo"))));
        add(new EntityMeta("warrant_control", "WARRANT_CONTROL", "Warrant Control", WarrantControl.class, null, List.of(
                f("codiWarr", "codi_warr", "Long", 0, true, true, false, "Codi Warr"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("almacenera", "almacenera", "String", 5, false, false, false, "Almacenera"),
                f("bancoNro", "banco_nro", "String", 20, false, false, false, "Banco Nro"),
                f("codiBanc", "codi_banc", "String", 7, false, false, false, "Codi Banc"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("nroWarr", "nro_warr", "String", 50, false, false, false, "Nro Warr"),
                f("tmAlma", "tm_alma", "BigDecimal", 0, false, false, false, "Tm Alma"),
                f("ingrWarr", "ingr_warr", "BigDecimal", 0, false, false, false, "Ingr Warr"),
                f("saliCant", "sali_cant", "BigDecimal", 0, false, false, false, "Sali Cant"),
                f("stock", "stock", "BigDecimal", 0, false, false, false, "Stock"),
                f("valorWarr", "valor_warr", "BigDecimal", 0, false, false, false, "Valor Warr"),
                f("iO", "i_o", "String", 1, false, false, false, "I O"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("tpc", "tpc", "BigDecimal", 0, false, false, false, "Tpc"),
                f("disponible", "disponible", "BigDecimal", 0, false, false, false, "Disponible"),
                f("periodo", "periodo", "String", 4, false, false, false, "Periodo"),
                f("broker", "broker", "String", 5, false, false, false, "Broker"),
                f("comprador", "comprador", "String", 5, false, false, false, "Comprador"),
                f("fechaEmba", "fecha_emba", "LocalDateTime", 0, false, false, false, "Fecha Emba"),
                f("codiTpago", "codi_tpago", "Integer", 0, false, false, false, "Codi Tpago"),
                f("numPago", "num_pago", "String", 50, false, false, false, "Num Pago"),
                f("valorFina", "valor_fina", "BigDecimal", 0, false, false, false, "Valor Fina"),
                f("tmCred", "tm_cred", "BigDecimal", 0, false, false, false, "Tm Cred"),
                f("valorCred", "valor_cred", "BigDecimal", 0, false, false, false, "Valor Cred"))));
        add(new EntityMeta("recibo_egreso", "Recibo_egreso", "Recibo Egreso", ReciboEgreso.class, null, List.of(
                f("codiRecibo", "codi_recibo", "String", 6, true, true, false, "Codi Recibo"),
                f("fechaRecibo", "fecha_recibo", "LocalDateTime", 0, false, false, false, "Fecha Recibo"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("nroDocu", "nro_docu", "String", 20, false, false, false, "Nro Docu"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("importeD", "importe_d", "BigDecimal", 0, false, false, false, "Importe D"),
                f("glosa", "glosa", "String", 500, false, false, false, "Glosa"),
                f("tipoCambio", "tipo_cambio", "BigDecimal", 0, false, false, false, "Tipo Cambio"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"),
                f("codiOrdeComp", "codi_orde_comp", "String", 10, false, false, false, "Codi Orde Comp"))));
        add(new EntityMeta("tipos_pago_warrant", "TIPOS_PAGO_WARRANT", "Tipos Pago Warrant", TiposPagoWarrant.class, null, List.of(
                f("codiTpago", "codi_tpago", "Integer", 0, true, true, false, "Codi Tpago"),
                f("descTipo", "desc_tipo", "String", 50, false, false, false, "Desc Tipo"),
                f("nemoTipo", "nemo_tipo", "String", 50, false, false, false, "Nemo Tipo"))));
        add(new EntityMeta("bancos_saldos", "BANCOS_SALDOS", "Bancos Saldos", BancosSaldos.class, BancosSaldos.Pk.class, List.of(
                f("nroCuen", "nro_cuen", "String", 7, true, true, false, "Nro Cuen"),
                f("anio", "anio", "String", 4, true, true, false, "Anio"),
                f("codiMone", "codi_mone", "String", 2, true, false, false, "Codi Mone"),
                f("sald00", "sald_00", "BigDecimal", 0, false, false, false, "Sald 00"),
                f("sald01", "sald_01", "BigDecimal", 0, false, false, false, "Sald 01"),
                f("sald02", "sald_02", "BigDecimal", 0, false, false, false, "Sald 02"),
                f("sald03", "sald_03", "BigDecimal", 0, false, false, false, "Sald 03"),
                f("sald04", "sald_04", "BigDecimal", 0, false, false, false, "Sald 04"),
                f("sald05", "sald_05", "BigDecimal", 0, false, false, false, "Sald 05"),
                f("sald06", "sald_06", "BigDecimal", 0, false, false, false, "Sald 06"),
                f("sald07", "sald_07", "BigDecimal", 0, false, false, false, "Sald 07"),
                f("sald08", "sald_08", "BigDecimal", 0, false, false, false, "Sald 08"),
                f("sald09", "sald_09", "BigDecimal", 0, false, false, false, "Sald 09"),
                f("sald10", "sald_10", "BigDecimal", 0, false, false, false, "Sald 10"),
                f("sald11", "sald_11", "BigDecimal", 0, false, false, false, "Sald 11"),
                f("sald12", "sald_12", "BigDecimal", 0, false, false, false, "Sald 12"),
                f("saldb00", "saldb_00", "BigDecimal", 0, false, false, false, "Saldb 00"))));
        add(new EntityMeta("bancos_disponible_deta", "BANCOS_DISPONIBLE_DETA", "Bancos Disponible Deta", BancosDisponibleDeta.class, BancosDisponibleDeta.Pk.class, List.of(
                f("idSec", "id_sec", "Long", 0, true, true, false, "Id Sec"),
                f("idConc", "id_conc", "String", 2, true, true, false, "Id Conc"),
                f("montoS", "monto_s", "BigDecimal", 0, false, false, false, "Monto S"),
                f("montoD", "monto_d", "BigDecimal", 0, false, false, false, "Monto D"))));
        add(new EntityMeta("bancos_disponible", "BANCOS_DISPONIBLE", "Bancos Disponible", BancosDisponible.class, null, List.of(
                f("idSec", "id_sec", "Long", 0, true, true, true, "Id Sec"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("contableS", "contable_s", "BigDecimal", 0, false, false, false, "Contable S"),
                f("contableD", "contable_d", "BigDecimal", 0, false, false, false, "Contable D"),
                f("disponibleS", "disponible_s", "BigDecimal", 0, false, false, false, "Disponible S"),
                f("disponibleD", "disponible_d", "BigDecimal", 0, false, false, false, "Disponible D"))));
        add(new EntityMeta("bancos_cheques", "BANCOS_CHEQUES", "Bancos Cheques", BancosCheques.class, BancosCheques.Pk.class, List.of(
                f("nroCuen", "nro_cuen", "String", 7, true, true, false, "Nro Cuen"),
                f("codiMone", "codi_mone", "String", 2, true, false, false, "Codi Mone"),
                f("nroTalon", "nro_talon", "String", 6, true, true, false, "Nro Talon"),
                f("nroInicCheq", "nro_inic_cheq", "String", 8, false, false, false, "Nro Inic Cheq"),
                f("nroFinCheq", "nro_fin_cheq", "String", 8, false, false, false, "Nro Fin Cheq"),
                f("cantCheq", "cant_cheq", "Long", 0, false, false, false, "Cant Cheq"),
                f("codiUsua", "codi_usua", "String", 5, false, false, false, "Codi Usua"),
                f("cantCheqGira", "cant_cheq_gira", "Long", 0, false, false, false, "Cant Cheq Gira"),
                f("cantCheqAnul", "cant_cheq_anul", "Long", 0, false, false, false, "Cant Cheq Anul"),
                f("cantCheqSald", "cant_cheq_sald", "Long", 0, false, false, false, "Cant Cheq Sald"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("cheqUlti", "cheq_ulti", "String", 8, false, false, false, "Cheq Ulti"),
                f("situCheq", "situ_cheq", "String", 2, true, true, false, "Situ Cheq"))));
        add(new EntityMeta("documento_garantia", "Documento_garantia", "Documento Garantia", DocumentoGarantia.class, null, List.of(
                f("codiDocg", "codi_docg", "String", 2, true, true, false, "Codi Docg"),
                f("docGarantia", "doc_garantia", "String", 50, false, false, false, "Doc Garantia"))));
        add(new EntityMeta("depositos", "DEPOSITOS", "Depositos", Depositos.class, Depositos.Pk.class, List.of(
                f("codiDepo", "codi_depo", "String", 10, true, true, false, "Codi Depo"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("codiAlma", "codi_alma", "String", 2, true, true, false, "Codi Alma"),
                f("nroOper", "nro_oper", "String", 100, false, false, false, "Nro Oper"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("codiRespo", "codi_respo", "String", 5, false, false, false, "Codi Respo"),
                f("codiUsuaSoli", "codi_usua_soli", "String", 5, false, false, false, "Codi Usua Soli"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("glosa", "glosa", "String", 200, false, false, false, "Glosa"),
                f("fechaDepo", "fecha_depo", "LocalDateTime", 0, false, false, false, "Fecha Depo"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("tipo", "tipo", "String", 1, false, false, false, "Tipo"),
                f("creacion", "creacion", "LocalDateTime", 0, false, false, false, "Creacion"),
                f("codiVouc", "codi_vouc", "String", 10, false, false, false, "Codi Vouc"),
                f("hechoPor", "hecho_por", "String", 5, false, false, false, "Hecho Por"))));
        add(new EntityMeta("presupuesto", "Presupuesto", "Presupuesto", Presupuesto.class, null, List.of(
                f("codiPresu", "codi_presu", "String", 5, true, true, false, "Codi Presu"),
                f("descPresu", "desc_presu", "String", 50, false, false, false, "Desc Presu"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"))));
        add(new EntityMeta("anticipos", "ANTICIPOS", "Anticipos", Anticipos.class, null, List.of(
                f("codiAnti", "codi_anti", "String", 20, true, true, false, "Codi Anti"),
                f("porcentaje", "porcentaje", "Long", 0, false, false, false, "Porcentaje"),
                f("fechAnti", "fech_anti", "Long", 0, false, false, false, "Fech Anti"),
                f("codiTipoDocuPago", "codi_tipo_docu_pago", "String", 4, false, false, false, "Codi Tipo Docu Pago"),
                f("nroDocu", "nro_docu", "String", 20, false, false, false, "Nro Docu"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("codiTipoDocuSoli", "codi_tipo_docu_soli", "String", 4, false, false, false, "Codi Tipo Docu Soli"))));
        add(new EntityMeta("cheques", "CHEQUES", "Cheques", Cheques.class, null, List.of(
                f("codiCheq", "codi_cheq", "String", 10, true, true, false, "Codi Cheq"),
                f("nroCheq", "nro_cheq", "String", 8, true, false, false, "Nro Cheq"),
                f("nroCuen", "nro_cuen", "String", 7, true, false, false, "Nro Cuen"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"))));
        add(new EntityMeta("seguros", "SEGUROS", "Seguros", Seguros.class, null, List.of(
                f("codiSegu", "codi_segu", "Short", 0, true, true, false, "Codi Segu"),
                f("descSegu", "desc_segu", "String", 50, true, false, false, "Desc Segu"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"))));
        add(new EntityMeta("cta_cte_personal", "CTA_CTE_PERSONAL", "Cta Cte Personal", CtaCtePersonal.class, null, List.of(
                f("codiCtaCte", "codi_cta_cte", "String", 6, true, true, false, "Codi Cta Cte"),
                f("codiPers", "codi_pers", "String", 5, true, false, false, "Codi Pers"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("codiBanc", "codi_banc", "String", 2, false, false, false, "Codi Banc"),
                f("nroCtaCte", "nro_cta_cte", "String", 30, true, false, false, "Nro Cta Cte"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("tipoCtaCte", "tipo_cta_cte", "String", 10, false, false, false, "Tipo Cta Cte"),
                f("tipoCtaBanc", "tipo_cta_banc", "String", 2, false, false, false, "Tipo Cta Banc"))));
        add(new EntityMeta("anticipos_documento_compra", "ANTICIPOS_DOCUMENTO_COMPRA", "Anticipos Documento Compra", AnticiposDocumentoCompra.class, AnticiposDocumentoCompra.Pk.class, List.of(
                f("codiAnti", "codi_anti", "String", 20, true, true, false, "Codi Anti"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, true, false, false, "Codi Tipo Docu"),
                f("codiDocuCv", "codi_docu_cv", "String", 10, true, true, false, "Codi Docu Cv"))));
        add(new EntityMeta("pagos_juicios", "PAGOS_JUICIOS", "Pagos Juicios", PagosJuicios.class, PagosJuicios.Pk.class, List.of(
                f("codiJuic", "codi_juic", "String", 6, true, true, false, "Codi Juic"),
                f("nroPago", "nro_pago", "String", 4, true, true, false, "Nro Pago"),
                f("fechPago", "fech_pago", "LocalDateTime", 0, true, false, false, "Fech Pago"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"),
                f("observacion", "observacion", "String", 150, false, false, false, "Observacion"))));
    }

    @Override
    public String service() {
        return "finanzas";
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
