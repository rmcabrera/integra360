package pe.sige.logistica.domain.legacy;

import jakarta.enterprise.context.ApplicationScoped;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import pe.sige.common.catalog.EntityCatalog;
import pe.sige.common.catalog.EntityMeta;
import pe.sige.common.catalog.FieldMeta;

/** Catalogo de entidades legado de ms-logistica (80 tablas). Generado: no editar. */
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
        add(new EntityMeta("almacen", "ALMACEN", "Almacen", Almacen.class, null, List.of(
                f("codiAlma", "codi_alma", "String", 2, true, true, false, "Codi Alma"),
                f("descAlma", "desc_alma", "String", 100, false, false, false, "Desc Alma"),
                f("direccion", "direccion", "String", 100, false, false, false, "Direccion"),
                f("telefono", "telefono", "String", 50, false, false, false, "Telefono"),
                f("nemoAlma", "nemo_alma", "String", 20, false, false, false, "Nemo Alma"),
                f("ubicacion", "ubicacion", "String", 50, false, false, false, "Ubicacion"),
                f("tipo", "tipo", "String", 1, false, false, false, "Tipo"),
                f("codiLuga", "codi_luga", "String", 3, false, false, false, "Codi Luga"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("codiAlmaPrinci", "codi_alma_princi", "String", 2, false, false, false, "Codi Alma Princi"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("representante", "representante", "String", 5, false, false, false, "Representante"),
                f("nroCuenD", "nro_cuen_d", "String", 7, false, false, false, "Nro Cuen D"),
                f("distrito", "distrito", "String", 100, false, false, false, "Distrito"),
                f("correo", "correo", "String", 150, false, false, false, "Correo"),
                f("ruta", "ruta", "String", 255, false, false, false, "Ruta"),
                f("impresora", "impresora", "String", 150, false, false, false, "Impresora"),
                f("codiAlmaDesc", "codi_alma_desc", "String", 2, false, false, false, "Codi Alma Desc"),
                f("codigoEstable", "codigo_estable", "String", 4, false, false, false, "Codigo Estable"),
                f("activo", "activo", "String", 1, false, false, false, "Activo"),
                f("codigoUbigeo", "codigo_ubigeo", "String", 6, false, false, false, "Codigo Ubigeo"),
                f("distAlma", "dist_alma", "Integer", 0, false, false, false, "Dist Alma"))));
        add(new EntityMeta("nota_ingreso", "NOTA_INGRESO", "Nota Ingreso", NotaIngreso.class, null, List.of(
                f("codiNotaIngr", "codi_nota_ingr", "String", 10, true, true, false, "Codi Nota Ingr"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"),
                f("nroSeri", "nro_seri", "String", 5, false, false, false, "Nro Seri"),
                f("nroDocu", "nro_docu", "String", 15, false, false, false, "Nro Docu"),
                f("codiUnidOperSoli", "codi_unid_oper_soli", "String", 5, false, false, false, "Codi Unid Oper Soli"),
                f("codiUnidOperDest", "codi_unid_oper_dest", "String", 5, false, false, false, "Codi Unid Oper Dest"),
                f("fechNotaIngr", "fech_nota_ingr", "LocalDateTime", 0, false, false, false, "Fech Nota Ingr"),
                f("tipoNotaIngr", "tipo_nota_ingr", "String", 20, false, false, false, "Tipo Nota Ingr"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("codiPersVistBuen", "codi_pers_vist_buen", "String", 5, false, false, false, "Codi Pers Vist Buen"),
                f("codiPersElab", "codi_pers_elab", "String", 5, false, false, false, "Codi Pers Elab"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("precTota", "prec_tota", "BigDecimal", 0, false, false, false, "Prec Tota"),
                f("observaciones", "observaciones", "String", 100, false, false, false, "Observaciones"),
                f("codiTurn", "codi_turn", "String", 2, false, false, false, "Codi Turn"),
                f("codiUnidNego", "codi_unid_nego", "String", 2, false, false, false, "Codi Unid Nego"),
                f("nroSeriDocuCont", "nro_seri_docu_cont", "String", 5, false, false, false, "Nro Seri Docu Cont"),
                f("nroDocuCont", "nro_docu_cont", "String", 15, false, false, false, "Nro Docu Cont"),
                f("codiTipoDocuCont", "codi_tipo_docu_cont", "String", 4, false, false, false, "Codi Tipo Docu Cont"),
                f("fechGuiaRemi", "fech_guia_remi", "LocalDateTime", 0, false, false, false, "Fech Guia Remi"),
                f("fechRegFact", "fech_reg_fact", "LocalDateTime", 0, false, false, false, "Fech Reg Fact"),
                f("fechProceso", "fech_proceso", "LocalDateTime", 0, false, false, false, "Fech Proceso"),
                f("contab", "contab", "Boolean", 0, false, false, false, "Contab"),
                f("tipoCamb", "tipo_camb", "BigDecimal", 0, false, false, false, "Tipo Camb"),
                f("afecto", "afecto", "Boolean", 0, false, false, false, "Afecto"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("codiSema", "codi_sema", "String", 8, false, false, false, "Codi Sema"),
                f("provPesc", "prov_pesc", "String", 5, false, false, false, "Prov Pesc"),
                f("viveres", "viveres", "Boolean", 0, false, false, false, "Viveres"),
                f("codiEmba", "codi_emba", "String", 5, false, false, false, "Codi Emba"),
                f("nroNotaIngr", "nro_nota_ingr", "String", 10, false, false, false, "Nro Nota Ingr"),
                f("igv", "igv", "BigDecimal", 0, false, false, false, "Igv"),
                f("otroAfec", "otro_afec", "BigDecimal", 0, false, false, false, "Otro Afec"),
                f("otroNoAfec", "otro_no_afec", "BigDecimal", 0, false, false, false, "Otro No Afec"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("codiAlmaDesti", "codi_alma_desti", "String", 2, false, false, false, "Codi Alma Desti"),
                f("codiDocuSali", "codi_docu_sali", "String", 10, false, false, false, "Codi Docu Sali"),
                f("codiTransportista", "codi_transportista", "String", 5, false, false, false, "codigo de tabla cliente proveedor"),
                f("registro", "registro", "String", 10, false, false, false, "Registro"),
                f("fechVencFact", "fech_venc_fact", "LocalDateTime", 0, false, false, false, "Fech Venc Fact"),
                f("codiChof", "codi_chof", "String", 4, false, false, false, "Codi Chof"),
                f("codiAlmaDest", "codi_alma_dest", "String", 2, false, false, false, "Codi Alma Dest"))));
        add(new EntityMeta("familia_producto", "FAMILIA_PRODUCTO", "Familia Producto", FamiliaProducto.class, null, List.of(
                f("codiFamiProd", "codi_fami_prod", "String", 2, true, true, false, "Codi Fami Prod"),
                f("descFamiProd", "desc_fami_prod", "String", 100, false, false, false, "Desc Fami Prod"),
                f("prodServ", "prod_serv", "String", 1, false, false, false, "Prod Serv"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("codLinPro", "cod_lin_pro", "String", 2, false, false, false, "Cod Lin Pro"))));
        add(new EntityMeta("sub_familia_producto", "SUB_FAMILIA_PRODUCTO", "Sub Familia Producto", SubFamiliaProducto.class, null, List.of(
                f("codiSubFamiProd", "codi_sub_fami_prod", "String", 4, true, true, false, "Codi Sub Fami Prod"),
                f("descSubFamiProd", "desc_sub_fami_prod", "String", 100, false, false, false, "Desc Sub Fami Prod"),
                f("codiFamiProd", "codi_fami_prod", "String", 2, false, false, false, "Codi Fami Prod"),
                f("poliPrecAdic", "poli_prec_adic", "BigDecimal", 0, false, false, false, "Poli Prec Adic"))));
        add(new EntityMeta("productos", "PRODUCTOS", "Productos", Productos.class, null, List.of(
                f("codiProd", "codi_prod", "String", 8, true, true, false, "Codi Prod"),
                f("descProd", "desc_prod", "String", 150, true, false, false, "Desc Prod"),
                f("codiSubFamiProd", "codi_sub_fami_prod", "String", 4, false, false, false, "Codi Sub Fami Prod"),
                f("codiUnidMedi", "codi_unid_medi", "String", 2, false, false, false, "Codi Unid Medi"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("precProm", "prec_prom", "BigDecimal", 0, false, false, false, "Prec Prom"),
                f("stock", "stock", "BigDecimal", 0, true, false, false, "Stock"),
                f("stocMini", "stoc_mini", "BigDecimal", 0, false, false, false, "Stoc Mini"),
                f("stocMaxi", "stoc_maxi", "BigDecimal", 0, false, false, false, "Stoc Maxi"),
                f("puntRepe", "punt_repe", "BigDecimal", 0, false, false, false, "Punt Repe"),
                f("fechVenc", "fech_venc", "LocalDateTime", 0, false, false, false, "Fech Venc"),
                f("estaProd", "esta_prod", "String", 25, false, false, false, "Esta Prod"),
                f("stocTemp", "stoc_temp", "BigDecimal", 0, false, false, false, "Stoc Temp"),
                f("ubicacion", "ubicacion", "String", 50, false, false, false, "Ubicacion"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("iqf", "iqf", "Boolean", 0, false, false, false, "Iqf"),
                f("porcDetr", "porc_detr", "BigDecimal", 0, false, false, false, "Porc Detr"),
                f("poliPrec", "poli_prec", "BigDecimal", 0, false, false, false, "Poli Prec"),
                f("exonerado", "exonerado", "String", 1, false, false, false, "Exonerado"),
                f("precList1", "prec_list_1", "BigDecimal", 0, false, false, false, "Prec List 1"),
                f("precList2", "prec_list_2", "BigDecimal", 0, false, false, false, "Prec List 2"),
                f("costProd", "cost_prod", "BigDecimal", 0, false, false, false, "Cost Prod"),
                f("analisis", "analisis", "Short", 0, false, false, false, "Analisis"),
                f("material", "material", "Short", 0, false, false, false, "Material"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("codPres", "cod_pres", "Integer", 0, false, false, false, "Cod Pres"),
                f("fecRegistro", "fec_registro", "LocalDateTime", 0, false, false, false, "Fec Registro"),
                f("precProv", "prec_prov", "BigDecimal", 0, false, false, false, "Prec Prov"),
                f("desctoCompra", "descto_compra", "BigDecimal", 0, false, false, false, "Descto Compra"),
                f("desctoPorcenta", "descto_porcenta", "BigDecimal", 0, false, false, false, "Descto Porcenta"),
                f("codImpuesto", "cod_impuesto", "Integer", 0, false, false, false, "Cod Impuesto"),
                f("tcambio", "tcambio", "BigDecimal", 0, false, false, false, "Tcambio"),
                f("nroDecimPrecio", "nro_decim_precio", "Integer", 0, false, false, false, "Nro Decim Precio"),
                f("costoOper", "costo_oper", "BigDecimal", 0, false, false, false, "Costo Oper"),
                f("codiAux", "codi_aux", "String", 8, false, false, false, "Codi Aux"),
                f("idTipocomi", "id_tipocomi", "Integer", 0, false, false, false, "Id Tipocomi"),
                f("codiTipoExis", "codi_tipo_exis", "String", 2, false, false, false, "Codi Tipo Exis"),
                f("peso", "peso", "BigDecimal", 0, false, false, false, "Peso"),
                f("rotacion", "rotacion", "Integer", 0, false, false, false, "Rotacion"),
                f("codiProdSunat", "codi_prod_sunat", "String", 8, false, false, false, "Codi Prod Sunat"),
                f("estaActi", "esta_acti", "String", 1, false, false, false, "Esta Acti"))));
        add(new EntityMeta("almacen_producto", "Almacen_Producto", "Almacen Producto", AlmacenProducto.class, AlmacenProducto.Pk.class, List.of(
                f("codiAlma", "codi_alma", "String", 2, true, true, false, "Codi Alma"),
                f("codiProd", "codi_prod", "String", 8, true, true, false, "Codi Prod"),
                f("precCosto", "prec_costo", "BigDecimal", 0, false, false, false, "Prec Costo"),
                f("stockAlma", "stock_alma", "BigDecimal", 0, false, false, false, "Stock Alma"),
                f("stockMinAlma", "stock_min_alma", "BigDecimal", 0, false, false, false, "Stock Min Alma"),
                f("stockTempAlma", "stock_temp_alma", "BigDecimal", 0, false, false, false, "Stock Temp Alma"),
                f("precPromAlma", "prec_prom_alma", "BigDecimal", 0, false, false, false, "Prec Prom Alma"),
                f("precPorcUtiMen", "prec_porc_uti_men", "BigDecimal", 0, false, false, false, "Prec Porc Uti Men"),
                f("precPorcUtiMay", "prec_porc_uti_may", "BigDecimal", 0, false, false, false, "Prec Porc Uti May"),
                f("precPorcUtiEsp", "prec_porc_uti_esp", "BigDecimal", 0, false, false, false, "Prec Porc Uti Esp"),
                f("prec", "prec", "BigDecimal", 0, false, false, false, "Prec"))));
        add(new EntityMeta("kardex", "KARDEX", "Kardex", Kardex.class, null, List.of(
                f("codiKard", "codi_kard", "String", 20, true, true, false, "Codi Kard"),
                f("codiProd", "codi_prod", "String", 8, false, false, false, "Codi Prod"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"),
                f("nroSeri", "nro_seri", "String", 5, false, false, false, "Nro Seri"),
                f("nroDocu", "nro_docu", "String", 15, false, false, false, "Nro Docu"),
                f("codiUnidOperSoli", "codi_unid_oper_soli", "String", 5, false, false, false, "Codi Unid Oper Soli"),
                f("codiUnidOperDest", "codi_unid_oper_dest", "String", 5, false, false, false, "Codi Unid Oper Dest"),
                f("codiCuen", "codi_cuen", "String", 7, false, false, false, "Codi Cuen"),
                f("fechTran", "fech_tran", "LocalDateTime", 0, false, false, false, "Fech Tran"),
                f("cantIngr", "cant_ingr", "BigDecimal", 0, false, false, false, "Cant Ingr"),
                f("cantSali", "cant_sali", "BigDecimal", 0, false, false, false, "Cant Sali"),
                f("cantSaldo", "cant_saldo", "BigDecimal", 0, false, false, false, "Cant Saldo"),
                f("cantSaldoAlma", "cant_saldo_alma", "BigDecimal", 0, false, false, false, "Cant Saldo Alma"),
                f("precUnit", "prec_unit", "BigDecimal", 0, false, false, false, "Prec Unit"),
                f("precProm", "prec_prom", "BigDecimal", 0, false, false, false, "Prec Prom"),
                f("precPromAlma", "prec_prom_alma", "BigDecimal", 0, false, false, false, "Prec Prom Alma"),
                f("valoIngr", "valo_ingr", "BigDecimal", 0, false, false, false, "Valo Ingr"),
                f("valoSali", "valo_sali", "BigDecimal", 0, false, false, false, "Valo Sali"),
                f("valoSaldo", "valo_saldo", "BigDecimal", 0, false, false, false, "Valo Saldo"),
                f("valoIngrAlma", "valo_ingr_alma", "BigDecimal", 0, false, false, false, "Valo Ingr Alma"),
                f("valoSaliAlma", "valo_sali_alma", "BigDecimal", 0, false, false, false, "Valo Sali Alma"),
                f("valoSaldoAlma", "valo_saldo_alma", "BigDecimal", 0, false, false, false, "Valo Saldo Alma"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("tipoCamb", "tipo_camb", "BigDecimal", 0, false, false, false, "Tipo Camb"),
                f("iO", "i_o", "String", 1, false, false, false, "I O"),
                f("codiDocuIO", "codi_docu_i_o", "String", 10, false, false, false, "Codi Docu I O"),
                f("concepto", "concepto", "String", 250, false, false, false, "Concepto"),
                f("nroGuia", "nro_guia", "String", 15, false, false, false, "Nro Guia"),
                f("periodo", "periodo", "Integer", 0, false, false, false, "Periodo"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("item", "item", "String", 12, false, false, false, "Item"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("prodserviqf", "prodserviqf", "String", 50, false, false, false, "Prodserviqf"),
                f("cantiProdserviqf", "canti_prodserviqf", "BigDecimal", 0, false, false, false, "Canti Prodserviqf"),
                f("umProdserviqf", "um_prodserviqf", "String", 2, false, false, false, "Um Prodserviqf"),
                f("deseiqf", "deseiqf", "String", 50, false, false, false, "Deseiqf"),
                f("cantiDeseiqf", "canti_deseiqf", "BigDecimal", 0, false, false, false, "Canti Deseiqf"),
                f("umDeseiqf", "um_deseiqf", "String", 2, false, false, false, "Um Deseiqf"),
                f("cantiRhpmIqf", "canti_rhpm_iqf", "Long", 0, false, false, false, "Canti Rhpm Iqf"),
                f("umRhpmIqf", "um_rhpm_iqf", "String", 2, false, false, false, "Um Rhpm Iqf"),
                f("motiRhpmIqf", "moti_rhpm_iqf", "String", 50, false, false, false, "Moti Rhpm Iqf"),
                f("creacion", "creacion", "LocalDateTime", 0, false, false, false, "Creacion"))));
        add(new EntityMeta("lista_de_requerimientos", "LISTA_DE_REQUERIMIENTOS", "Lista De Requerimientos", ListaDeRequerimientos.class, null, List.of(
                f("codiListRequ", "codi_list_requ", "String", 8, true, true, false, "Codi List Requ"),
                f("fechListRequ", "fech_list_requ", "LocalDateTime", 0, true, false, false, "Fech List Requ"),
                f("codiPersResp", "codi_pers_resp", "String", 5, false, false, false, "Codi Pers Resp"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("codiUnidOperSoli", "codi_unid_oper_soli", "String", 5, false, false, false, "Codi Unid Oper Soli"),
                f("codiUnidOperDest", "codi_unid_oper_dest", "String", 5, false, false, false, "Codi Unid Oper Dest"),
                f("pediTrab", "pedi_trab", "String", 1, false, false, false, "Pedi Trab"),
                f("motivo", "motivo", "String", 250, false, false, false, "Motivo"),
                f("tipoUso", "tipo_uso", "String", 1, false, false, false, "Tipo Uso"),
                f("mantActi", "mant_acti", "String", 1, false, false, false, "Mant Acti"),
                f("observacion", "observacion", "String", 1500, false, false, false, "Observacion"),
                f("observacion2", "observacion_2", "String", 200, false, false, false, "Observacion 2"),
                f("observacion3", "observacion_3", "String", 200, false, false, false, "Observacion 3"),
                f("observacion4", "observacion_4", "String", 200, false, false, false, "Observacion 4"),
                f("observacion5", "observacion_5", "String", 200, false, false, false, "Observacion 5"),
                f("prio", "prio", "Short", 0, false, false, false, "Prio"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"))));
        add(new EntityMeta("orden_de_pedido", "ORDEN_DE_PEDIDO", "Orden De Pedido", OrdenDePedido.class, null, List.of(
                f("codiOrdePedi", "codi_orde_pedi", "String", 10, true, true, false, "Codi Orde Pedi"),
                f("fechPedi", "fech_pedi", "LocalDateTime", 0, true, false, false, "Fech Pedi"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("codiListRequ", "codi_list_requ", "String", 8, false, false, false, "Codi List Requ"),
                f("observacion", "observacion", "String", 250, false, false, false, "Observacion"),
                f("observacion2", "observacion_2", "String", 200, false, false, false, "Observacion 2"),
                f("observacion3", "observacion_3", "String", 200, false, false, false, "Observacion 3"),
                f("observacion4", "observacion_4", "String", 200, false, false, false, "Observacion 4"),
                f("observacion5", "observacion_5", "String", 200, false, false, false, "Observacion 5"),
                f("nroOrdePedi", "nro_orde_pedi", "String", 10, false, false, false, "Nro Orde Pedi"),
                f("pediTrab", "pedi_trab", "String", 1, false, false, false, "Pedi Trab"),
                f("codiPersResp", "codi_pers_resp", "String", 5, false, false, false, "Codi Pers Resp"),
                f("codiUnidOperSoli", "codi_unid_oper_soli", "String", 5, false, false, false, "Codi Unid Oper Soli"),
                f("codiUnidOperDest", "codi_unid_oper_dest", "String", 5, false, false, false, "Codi Unid Oper Dest"),
                f("motivo", "motivo", "String", 250, false, false, false, "Motivo"),
                f("tipoUso", "tipo_uso", "String", 1, false, false, false, "Tipo Uso"),
                f("mantActi", "mant_acti", "String", 1, false, false, false, "Mant Acti"),
                f("prio", "prio", "Short", 0, false, false, false, "Prio"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"))));
        add(new EntityMeta("docu_sali_mate", "DOCU_SALI_MATE", "Docu Sali Mate", DocuSaliMate.class, null, List.of(
                f("codiDocuSali", "codi_docu_sali", "String", 10, true, true, false, "Codi Docu Sali"),
                f("codiUnidOperRece", "codi_unid_oper_rece", "String", 5, false, false, false, "Codi Unid Oper Rece"),
                f("codiTipoDocuSali", "codi_tipo_docu_sali", "String", 4, false, false, false, "Codi Tipo Docu Sali"),
                f("codiOrdePedi", "codi_orde_pedi", "String", 10, false, false, false, "Codi Orde Pedi"),
                f("codiPersEmis", "codi_pers_emis", "String", 5, false, false, false, "Codi Pers Emis"),
                f("codiPersRece", "codi_pers_rece", "String", 5, false, false, false, "Codi Pers Rece"),
                f("fechEmis", "fech_emis", "LocalDateTime", 0, true, false, false, "Fech Emis"),
                f("codiTurn", "codi_turn", "String", 2, false, false, false, "Codi Turn"),
                f("codiUnidNego", "codi_unid_nego", "String", 2, false, false, false, "Codi Unid Nego"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("nroSeriDocuSali", "nro_seri_docu_sali", "String", 5, false, false, false, "Nro Seri Docu Sali"),
                f("nroDocuSali", "nro_docu_sali", "String", 10, false, false, false, "Nro Docu Sali"),
                f("motivo", "motivo", "String", 150, false, false, false, "Motivo"),
                f("observacion", "observacion", "String", 150, false, false, false, "Observacion"),
                f("tipoSali", "tipo_sali", "String", 20, false, false, false, "Tipo Sali"),
                f("tipoDest", "tipo_dest", "String", 2, false, false, false, "Tipo Dest"),
                f("codiPersReciMate", "codi_pers_reci_mate", "String", 5, false, false, false, "Codi Pers Reci Mate"),
                f("motiSali", "moti_sali", "String", 10, false, false, false, "Moti Sali"),
                f("codiPuerSali", "codi_puer_sali", "String", 2, false, false, false, "Codi Puer Sali"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("viveres", "viveres", "Boolean", 0, false, false, false, "Viveres"),
                f("codiEmba", "codi_emba", "String", 5, false, false, false, "Codi Emba"),
                f("codiSemaPesc", "codi_sema_pesc", "String", 5, false, false, false, "Codi Sema Pesc"),
                f("nroSali", "nro_sali", "String", 10, false, false, false, "Nro Sali"),
                f("kilometraje", "kilometraje", "BigDecimal", 0, false, false, false, "Kilometraje"),
                f("kiloMill", "kilo_mill", "BigDecimal", 0, false, false, false, "Kilo Mill"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("codiAlmaDesti", "codi_alma_desti", "String", 2, false, false, false, "Codi Alma Desti"),
                f("codiFact", "codi_fact", "String", 10, false, false, false, "Codi Fact"),
                f("condicion", "condicion", "String", 1, false, false, false, "P=Pendiente de ingreso, A=Aceptado por sucursal"),
                f("fechRegFact", "fech_reg_fact", "LocalDateTime", 0, false, false, false, "Fech Reg Fact"),
                f("codiTipoDocuCont", "codi_tipo_docu_cont", "String", 4, false, false, false, "Codi Tipo Docu Cont"),
                f("nroSeriDocuCont", "nro_seri_docu_cont", "String", 5, false, false, false, "Nro Seri Docu Cont"),
                f("nroDocuCont", "nro_docu_cont", "String", 10, false, false, false, "Nro Docu Cont"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("igv", "igv", "BigDecimal", 0, false, false, false, "Igv"),
                f("precTota", "prec_tota", "BigDecimal", 0, false, false, false, "Prec Tota"),
                f("contab", "contab", "Integer", 0, false, false, false, "Contab"))));
        add(new EntityMeta("tipo_ingr_sali", "TIPO_INGR_SALI", "Tipo Ingr Sali", TipoIngrSali.class, null, List.of(
                f("codiTipoIs", "codi_tipo_is", "String", 2, true, true, false, "Codi Tipo Is"),
                f("descTipoIs", "desc_tipo_is", "String", 100, false, false, false, "Desc Tipo Is"),
                f("nemoTipoIs", "nemo_tipo_is", "String", 15, false, false, false, "Nemo Tipo Is"),
                f("iS", "i_s", "String", 1, false, false, false, "I S"),
                f("codiSunatMotiTras", "codi_sunat_moti_tras", "String", 2, false, false, false, "Codi Sunat Moti Tras"),
                f("descSunatMotiTras", "desc_sunat_moti_tras", "String", 50, false, false, false, "Desc Sunat Moti Tras"),
                f("contabilizar", "contabilizar", "Short", 0, false, false, false, "Contabilizar"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"))));
        add(new EntityMeta("detalle_docu_sali", "DETALLE_DOCU_SALI", "Detalle Docu Sali", DetalleDocuSali.class, null, List.of(
                f("codiDetaDocuSali", "codi_deta_docu_sali", "String", 12, true, true, false, "Codi Deta Docu Sali"),
                f("codiDocuSali", "codi_docu_sali", "String", 10, true, false, false, "Codi Docu Sali"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("codiProd", "codi_prod", "String", 8, true, false, false, "Codi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("precCosto", "prec_costo", "BigDecimal", 0, false, false, false, "Prec Costo"),
                f("precProm", "prec_prom", "BigDecimal", 0, false, false, false, "Prec Prom"),
                f("stocSali", "stoc_sali", "BigDecimal", 0, false, false, false, "Stoc Sali"),
                f("fechUltiSali", "fech_ulti_sali", "LocalDateTime", 0, false, false, false, "Fech Ulti Sali"),
                f("cantUltiSali", "cant_ulti_sali", "BigDecimal", 0, false, false, false, "Cant Ulti Sali"),
                f("codiOrdePedi", "codi_orde_pedi", "String", 10, false, false, false, "Codi Orde Pedi"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("codiAlmaDesti", "codi_alma_desti", "String", 2, false, false, false, "Codi Alma Desti"),
                f("codiDetaOrdePedi", "codi_deta_orde_pedi", "String", 12, false, false, false, "Codi Deta Orde Pedi"),
                f("precKard", "prec_kard", "BigDecimal", 0, false, false, false, "Prec Kard"),
                f("concenIqf", "concen_iqf", "Long", 0, false, false, false, "Concen Iqf"),
                f("prodserviqf", "prodserviqf", "String", 50, false, false, false, "Prodserviqf"),
                f("cantiProdserviqf", "canti_prodserviqf", "Long", 0, false, false, false, "Canti Prodserviqf"),
                f("umProdserviqf", "um_prodserviqf", "String", 2, false, false, false, "Um Prodserviqf"),
                f("deseiqf", "deseiqf", "String", 50, false, false, false, "Deseiqf"),
                f("cantiDeseiqf", "canti_deseiqf", "Long", 0, false, false, false, "Canti Deseiqf"),
                f("umDeseiqf", "um_deseiqf", "String", 2, false, false, false, "Um Deseiqf"),
                f("cantiRhpmIqf", "canti_rhpm_iqf", "Long", 0, false, false, false, "Canti Rhpm Iqf"),
                f("umRhpmIqf", "um_rhpm_iqf", "String", 2, false, false, false, "Um Rhpm Iqf"),
                f("motiRhpmIqf", "moti_rhpm_iqf", "String", 50, false, false, false, "Moti Rhpm Iqf"),
                f("observaciones", "observaciones", "String", 50, false, false, false, "Observaciones"),
                f("precUnit", "prec_unit", "BigDecimal", 0, false, false, false, "Prec Unit"),
                f("nroCuenNi", "nro_cuen_ni", "String", 7, false, false, false, "Nro Cuen Ni"))));
        add(new EntityMeta("linea_familia_pro", "LINEA_FAMILIA_PRO", "Linea Familia Pro", LineaFamiliaPro.class, null, List.of(
                f("codLinPro", "cod_lin_pro", "String", 2, true, true, false, "Cod Lin Pro"),
                f("desLinPro", "des_lin_pro", "String", 100, false, false, false, "Des Lin Pro"))));
        add(new EntityMeta("presentacion", "PRESENTACION", "Presentacion", Presentacion.class, null, List.of(
                f("codPres", "cod_pres", "Integer", 0, true, true, false, "Cod Pres"),
                f("descPres", "desc_pres", "String", 50, false, false, false, "Desc Pres"),
                f("um", "um", "String", 2, false, false, false, "Um"))));
        add(new EntityMeta("detalle_nota_ingreso", "DETALLE_NOTA_INGRESO", "Detalle Nota Ingreso", DetalleNotaIngreso.class, DetalleNotaIngreso.Pk.class, List.of(
                f("codiNotaIngr", "codi_nota_ingr", "String", 10, true, true, false, "Codi Nota Ingr"),
                f("nroItemNotaIngr", "nro_item_nota_ingr", "String", 12, true, true, false, "Nro Item Nota Ingr"),
                f("codiProd", "codi_prod", "String", 8, false, false, false, "Codi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("precUnit", "prec_unit", "BigDecimal", 0, false, false, false, "Precio compra u otros aplicado el descuento compras"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("precKard", "prec_kard", "BigDecimal", 0, false, false, false, "Prec Kard"),
                f("stocUlti", "stoc_ulti", "BigDecimal", 0, false, false, false, "Stoc Ulti"),
                f("stocTempUlti", "stoc_temp_ulti", "BigDecimal", 0, false, false, false, "Stoc Temp Ulti"),
                f("precUlti", "prec_ulti", "BigDecimal", 0, false, false, false, "Prec Ulti"),
                f("porcDetr", "porc_detr", "BigDecimal", 0, false, false, false, "Porc Detr"),
                f("codiDetaOrdeComp", "codi_deta_orde_comp", "String", 12, false, false, false, "Codi Deta Orde Comp"),
                f("codiMoneUltiPrec", "codi_mone_ulti_prec", "String", 2, false, false, false, "Codi Mone Ulti Prec"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("codiDetaOrdePedi", "codi_deta_orde_pedi", "String", 12, false, false, false, "Codi Deta Orde Pedi"),
                f("codiTipoEnva", "codi_tipo_enva", "Short", 0, false, false, false, "Codi Tipo Enva"),
                f("numEnva", "num_enva", "Short", 0, false, false, false, "Num Enva"),
                f("exceso", "exceso", "BigDecimal", 0, false, false, false, "Exceso"),
                f("faltante", "faltante", "BigDecimal", 0, false, false, false, "Faltante"),
                f("observaciones", "observaciones", "String", 50, false, false, false, "Observaciones"),
                f("concenIqf", "concen_iqf", "BigDecimal", 0, false, false, false, "Concen Iqf"),
                f("dsctoPorcentaje", "dscto_porcentaje", "BigDecimal", 0, false, false, false, "Descuento en porcentaje del producto en compras"),
                f("precCompra", "prec_compra", "BigDecimal", 0, false, false, false, "Precio compra mas el descuento"),
                f("tipoCompra", "tipo_compra", "String", 1, false, false, false, "Tipo Compra"))));
        add(new EntityMeta("kardex_almacenes", "KARDEX_ALMACENES", "Kardex Almacenes", KardexAlmacenes.class, KardexAlmacenes.Pk.class, List.of(
                f("codigo", "codigo", "Long", 0, false, false, false, "Codigo"),
                f("codiTransa", "codi_transa", "Long", 0, true, true, false, "Codi Transa"),
                f("codiAlma", "codi_alma", "String", 2, true, true, false, "Codi Alma"),
                f("item", "item", "Integer", 0, true, true, false, "Item"),
                f("codiProd", "codi_prod", "String", 8, true, true, false, "Codi Prod"),
                f("iO", "i_o", "String", 1, true, true, false, "I O"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("precio", "precio", "BigDecimal", 0, false, false, false, "Precio"),
                f("total", "total", "BigDecimal", 0, false, false, false, "Total"),
                f("codiUnidMedi", "codi_unid_medi", "String", 50, false, false, false, "Codi Unid Medi"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("tipoCambio", "tipo_cambio", "BigDecimal", 0, false, false, false, "Tipo Cambio"),
                f("ingrCant", "ingr_cant", "BigDecimal", 0, false, false, false, "Ingr Cant"),
                f("saliCant", "sali_cant", "BigDecimal", 0, false, false, false, "Sali Cant"),
                f("precUnit", "prec_unit", "BigDecimal", 0, false, false, false, "Prec Unit"),
                f("precProm", "prec_prom", "BigDecimal", 0, false, false, false, "Prec Prom"),
                f("stock", "stock", "BigDecimal", 0, false, false, false, "Stock"),
                f("ingrValo", "ingr_valo", "BigDecimal", 0, false, false, false, "Ingr Valo"),
                f("egreValo", "egre_valo", "BigDecimal", 0, false, false, false, "Egre Valo"),
                f("saldoValo", "saldo_valo", "BigDecimal", 0, false, false, false, "Saldo Valo"),
                f("periodo", "periodo", "Integer", 0, false, false, false, "Periodo"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("exonerado", "exonerado", "String", 1, false, false, false, "Exonerado"),
                f("igv", "igv", "BigDecimal", 0, false, false, false, "Igv"),
                f("venta", "venta", "BigDecimal", 0, false, false, false, "Venta"),
                f("valorigv", "valorigv", "BigDecimal", 0, false, false, false, "Valorigv"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("productor", "productor", "String", 5, false, false, false, "Productor"),
                f("acidez", "acidez", "BigDecimal", 0, false, false, false, "Acidez"),
                f("cantcolpex", "cantcolpex", "BigDecimal", 0, false, false, false, "Cantcolpex"),
                f("entradafisico", "entradafisico", "BigDecimal", 0, false, false, false, "Entradafisico"),
                f("salidafisico", "salidafisico", "BigDecimal", 0, false, false, false, "Salidafisico"),
                f("promfisico", "promfisico", "BigDecimal", 0, false, false, false, "Promfisico"),
                f("stockfisico", "stockfisico", "BigDecimal", 0, false, false, false, "Stockfisico"),
                f("ingresofisico", "ingresofisico", "BigDecimal", 0, false, false, false, "Ingresofisico"),
                f("egresofisico", "egresofisico", "BigDecimal", 0, false, false, false, "Egresofisico"),
                f("saldofisico", "saldofisico", "BigDecimal", 0, false, false, false, "Saldofisico"),
                f("transporte", "transporte", "String", 4, false, false, false, "Transporte"),
                f("placa", "placa", "String", 10, false, false, false, "Placa"),
                f("ticket", "ticket", "String", 10, false, false, false, "Ticket"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"),
                f("serguia", "serguia", "String", 5, false, false, false, "Serguia"),
                f("nroguia", "nroguia", "String", 10, false, false, false, "Nroguia"),
                f("codiMotiTras", "codi_moti_tras", "String", 2, false, false, false, "Codi Moti Tras"),
                f("nroVales", "nro_vales", "Long", 0, false, false, false, "Nro Vales"),
                f("indiceRela", "indice_rela", "Long", 0, false, false, false, "Indice Rela"),
                f("codiTipoEnva", "codi_tipo_enva", "Short", 0, false, false, false, "Codi Tipo Enva"),
                f("numEnva", "num_enva", "Short", 0, false, false, false, "Num Enva"),
                f("exceso", "exceso", "BigDecimal", 0, false, false, false, "Exceso"),
                f("faltante", "faltante", "BigDecimal", 0, false, false, false, "Faltante"),
                f("observaciones", "observaciones", "String", 50, false, false, false, "Observaciones"),
                f("concenIqf", "concen_iqf", "BigDecimal", 0, false, false, false, "Concen Iqf"),
                f("prodserviqf", "prodserviqf", "String", 50, false, false, false, "Prodserviqf"),
                f("cantiProdserviqf", "canti_prodserviqf", "Long", 0, false, false, false, "Canti Prodserviqf"),
                f("umProdserviqf", "um_prodserviqf", "String", 2, false, false, false, "Um Prodserviqf"),
                f("deseiqf", "deseiqf", "String", 50, false, false, false, "Deseiqf"),
                f("cantiDeseiqf", "canti_deseiqf", "Long", 0, false, false, false, "Canti Deseiqf"),
                f("umDeseiqf", "um_deseiqf", "String", 2, false, false, false, "Um Deseiqf"),
                f("cantiRhpmIqf", "canti_rhpm_iqf", "Long", 0, false, false, false, "Canti Rhpm Iqf"),
                f("umRhpmIqf", "um_rhpm_iqf", "String", 2, false, false, false, "Um Rhpm Iqf"),
                f("motiRhpmIqf", "moti_rhpm_iqf", "String", 50, false, false, false, "Moti Rhpm Iqf"))));
        add(new EntityMeta("registro_producto_deta", "REGISTRO_PRODUCTO_DETA", "Registro Producto Deta", RegistroProductoDeta.class, RegistroProductoDeta.Pk.class, List.of(
                f("codiRegiProd", "codi_regi_prod", "Long", 0, true, true, false, "Codi Regi Prod"),
                f("codiDeta", "codi_deta", "Integer", 0, true, true, false, "Codi Deta"),
                f("codiProd", "codi_prod", "String", 8, false, false, false, "Codi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("q11", "q1_1", "BigDecimal", 0, false, false, false, "Q1 1"),
                f("q21", "q2_1", "BigDecimal", 0, false, false, false, "Q2 1"),
                f("q12", "q1_2", "BigDecimal", 0, false, false, false, "Q1 2"),
                f("q22", "q2_2", "BigDecimal", 0, false, false, false, "Q2 2"),
                f("q13", "q1_3", "BigDecimal", 0, false, false, false, "Q1 3"),
                f("q23", "q2_3", "BigDecimal", 0, false, false, false, "Q2 3"),
                f("q14", "q1_4", "BigDecimal", 0, false, false, false, "Q1 4"),
                f("q24", "q2_4", "BigDecimal", 0, false, false, false, "Q2 4"),
                f("q15", "q1_5", "BigDecimal", 0, false, false, false, "Q1 5"),
                f("q25", "q2_5", "BigDecimal", 0, false, false, false, "Q2 5"),
                f("q16", "q1_6", "BigDecimal", 0, false, false, false, "Q1 6"),
                f("q26", "q2_6", "BigDecimal", 0, false, false, false, "Q2 6"),
                f("nroDiacult", "nro_diacult", "Integer", 0, false, false, false, "Nro Diacult"),
                f("codEta", "cod_eta", "Long", 0, false, false, false, "Cod Eta"),
                f("enfermedades", "enfermedades", "String", 150, false, false, false, "Enfermedades"))));
        add(new EntityMeta("registro_producto", "REGISTRO_PRODUCTO", "Registro Producto", RegistroProducto.class, null, List.of(
                f("codiRegiProd", "codi_regi_prod", "Long", 0, true, true, false, "Codi Regi Prod"),
                f("cultivo", "cultivo", "String", 250, false, false, false, "Cultivo"),
                f("area", "area", "String", 250, false, false, false, "Area"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("codZona", "cod_zona", "Long", 0, false, false, false, "Cod Zona"),
                f("codCultivo", "cod_cultivo", "Integer", 0, false, false, false, "Cod Cultivo"))));
        add(new EntityMeta("registro_orden_pedido_deta", "REGISTRO_ORDEN_PEDIDO_DETA", "Registro Orden Pedido Deta", RegistroOrdenPedidoDeta.class, RegistroOrdenPedidoDeta.Pk.class, List.of(
                f("codiOrdenPedi", "codi_orden_pedi", "Long", 0, true, true, false, "Codi Orden Pedi"),
                f("codiDeta", "codi_deta", "Integer", 0, true, true, false, "Codi Deta"),
                f("codiProd", "codi_prod", "String", 8, false, false, false, "Codi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("cantidadAux", "cantidad_aux", "BigDecimal", 0, false, false, false, "Cantidad Aux"))));
        add(new EntityMeta("registro_orden_pedido", "REGISTRO_ORDEN_PEDIDO", "Registro Orden Pedido", RegistroOrdenPedido.class, null, List.of(
                f("codiOrdenPedi", "codi_orden_pedi", "Long", 0, true, true, false, "Codi Orden Pedi"),
                f("codiPersResp", "codi_pers_resp", "String", 5, false, false, false, "Codi Pers Resp"),
                f("codiUnidOperSoli", "codi_unid_oper_soli", "String", 2, false, false, false, "Codi Unid Oper Soli"),
                f("codiUnidOperDest", "codi_unid_oper_dest", "String", 2, false, false, false, "Codi Unid Oper Dest"),
                f("motivo", "motivo", "String", 250, false, false, false, "Motivo"),
                f("observacion", "observacion", "String", 0, false, false, false, "Observacion"),
                f("codiGuia", "codi_guia", "Long", 0, false, false, false, "Codi Guia"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("envio", "envio", "String", 1, false, false, false, "Envio"),
                f("aproPor", "apro_por", "String", 5, false, false, false, "Apro Por"),
                f("libePor", "libe_por", "String", 5, false, false, false, "Libe Por"),
                f("codiAlmaOrig", "codi_alma_orig", "String", 2, false, false, false, "Codi Alma Orig"),
                f("superPor", "super_por", "String", 5, false, false, false, "Super Por"))));
        add(new EntityMeta("tipo_existencia", "TIPO_EXISTENCIA", "Tipo Existencia", TipoExistencia.class, null, List.of(
                f("codiTipoExis", "codi_tipo_exis", "String", 2, true, true, false, "Codi Tipo Exis"),
                f("codiSunat", "codi_sunat", "String", 2, true, false, false, "Codi Sunat"),
                f("descTipoExis", "desc_tipo_exis", "String", 100, true, false, false, "Desc Tipo Exis"),
                f("nemo", "nemo", "String", 30, false, false, false, "Nemo"))));
        add(new EntityMeta("tipo_envases", "TIPO_ENVASES", "Tipo Envases", TipoEnvases.class, null, List.of(
                f("codiTipoEnva", "codi_tipo_enva", "Short", 0, true, true, false, "Codi Tipo Enva"),
                f("descEmva", "desc_emva", "String", 50, true, false, false, "Desc Emva"))));
        add(new EntityMeta("docu_sali_x_orde_pedi", "DOCU_SALI_X_ORDE_PEDI", "Docu Sali X Orde Pedi", DocuSaliXOrdePedi.class, DocuSaliXOrdePedi.Pk.class, List.of(
                f("codiDocuSali", "codi_docu_sali", "String", 10, true, true, false, "Codi Docu Sali"),
                f("codiOrdePedi", "codi_orde_pedi", "String", 10, true, true, false, "Codi Orde Pedi"))));
        add(new EntityMeta("kits", "KITS", "Kits", Kits.class, null, List.of(
                f("codiKitInte", "codi_kit_inte", "String", 4, true, true, false, "Codi Kit Inte"),
                f("codiKitMarc", "codi_kit_marc", "String", 15, true, false, false, "Codi Kit Marc"),
                f("descKit", "desc_kit", "String", 150, false, false, false, "Desc Kit"),
                f("marcKit", "marc_kit", "String", 50, false, false, false, "Marc Kit"),
                f("abreKit", "abre_kit", "String", 20, false, false, false, "Abre Kit"))));
        add(new EntityMeta("material", "MATERIAL", "Material", Material.class, null, List.of(
                f("codiMaterial", "codi_material", "Integer", 0, true, true, false, "Codi Material"),
                f("descMaterial", "desc_material", "String", 50, true, false, false, "Desc Material"))));
    }

    private void load1() {
        add(new EntityMeta("marca", "MARCA", "Marca", Marca.class, null, List.of(
                f("codiMarca", "codi_marca", "String", 4, true, true, false, "Codi Marca"),
                f("descMarca", "desc_marca", "String", 50, false, false, false, "Desc Marca"))));
        add(new EntityMeta("lote_situacion", "LOTE_SITUACION", "Lote Situacion", LoteSituacion.class, null, List.of(
                f("idSitu", "id_situ", "Integer", 0, true, true, false, "Id Situ"),
                f("descripcion", "descripcion", "String", 100, false, false, false, "Descripcion"))));
        add(new EntityMeta("orde_serv_x_proy", "ORDE_SERV_X_PROY", "Orde Serv X Proy", OrdeServXProy.class, OrdeServXProy.Pk.class, List.of(
                f("codiOrdeComp", "codi_orde_comp", "String", 10, true, true, false, "Codi Orde Comp"),
                f("codiProy", "codi_proy", "String", 10, true, true, false, "Codi Proy"))));
        add(new EntityMeta("prec_prom_inve", "prec_prom_inve", "Prec Prom Inve", PrecPromInve.class, null, List.of(
                f("prod", "prod", "String", 8, true, true, false, "Prod"),
                f("precio", "precio", "BigDecimal", 0, true, false, false, "Precio"))));
        add(new EntityMeta("almacen_doc_regularizar", "ALMACEN_DOC_REGULARIZAR", "Almacen Doc Regularizar", AlmacenDocRegularizar.class, null, List.of(
                f("iddSec", "idd_sec", "Long", 0, true, true, true, "Idd Sec"),
                f("codiAlma", "codi_alma", "String", 2, true, false, false, "Codi Alma"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, true, false, false, "Codi Tipo Docu"),
                f("serieAlma", "serie_alma", "String", 5, true, false, false, "Serie Alma"),
                f("nroDocuEmpieza", "nro_docu_empieza", "Long", 0, false, false, false, "Nro Docu Empieza"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("creacion", "creacion", "LocalDateTime", 0, false, false, false, "Creacion"))));
        add(new EntityMeta("productos_eventos", "PRODUCTOS_EVENTOS", "Productos Eventos", ProductosEventos.class, ProductosEventos.Pk.class, List.of(
                f("codiProd", "codi_prod", "String", 8, true, true, false, "Codi Prod"),
                f("codiAlma", "codi_alma", "String", 2, true, true, false, "Codi Alma"),
                f("fecha", "fecha", "LocalDateTime", 0, true, true, false, "Fecha"),
                f("evento", "evento", "String", 255, false, false, false, "Evento"),
                f("tipo", "tipo", "String", 1, false, false, false, "Tipo"),
                f("hechoPor", "hecho_por", "String", 5, false, false, false, "Hecho Por"),
                f("activo", "activo", "String", 1, false, false, false, "Activo"))));
        add(new EntityMeta("productos_baja_rotacion", "PRODUCTOS_BAJA_ROTACION", "Productos Baja Rotacion", ProductosBajaRotacion.class, null, List.of(
                f("codiRota", "codi_rota", "Long", 0, true, true, true, "Codi Rota"),
                f("descripcion", "descripcion", "String", 150, false, false, false, "Descripcion"))));
        add(new EntityMeta("productos_baja", "PRODUCTOS_BAJA", "Productos Baja", ProductosBaja.class, ProductosBaja.Pk.class, List.of(
                f("idVen", "id_ven", "Integer", 0, true, true, false, "Id Ven"),
                f("codiProd", "codi_prod", "String", 8, true, true, false, "Codi Prod"),
                f("codiRota", "codi_rota", "Long", 0, false, false, false, "Codi Rota"))));
        add(new EntityMeta("productos_matriz", "PRODUCTOS_MATRIZ", "Productos Matriz", ProductosMatriz.class, null, List.of(
                f("idMat", "id_mat", "Long", 0, true, true, true, "Id Mat"),
                f("codiProd", "codi_prod", "String", 8, false, false, false, "Codi Prod"),
                f("codiRota", "codi_rota", "Long", 0, false, false, false, "Codi Rota"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"))));
        add(new EntityMeta("productos_lotes_vale_cred", "PRODUCTOS_LOTES_VALE_CRED", "Productos Lotes Vale Cred", ProductosLotesValeCred.class, ProductosLotesValeCred.Pk.class, List.of(
                f("codiDetaIngreSali", "codi_deta_ingre_sali", "String", 12, true, true, false, "Codi Deta Ingre Sali"),
                f("codiProdAlmaLote", "codi_prod_alma_lote", "Long", 0, true, true, false, "Codi Prod Alma Lote"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("codiVale", "codi_vale", "Long", 0, true, true, false, "Codi Vale"))));
        add(new EntityMeta("productos_lotes_nota_venta", "PRODUCTOS_LOTES_NOTA_VENTA", "Productos Lotes Nota Venta", ProductosLotesNotaVenta.class, ProductosLotesNotaVenta.Pk.class, List.of(
                f("codiDetaIngreSali", "codi_deta_ingre_sali", "String", 12, true, true, false, "Codi Deta Ingre Sali"),
                f("codiProdAlmaLote", "codi_prod_alma_lote", "Long", 0, true, true, false, "Codi Prod Alma Lote"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("codiNotaVenta", "codi_nota_venta", "Long", 0, true, true, false, "Codi Nota Venta"))));
        add(new EntityMeta("ccnu_segmentos", "CCNU_SEGMENTOS", "Ccnu Segmentos", CcnuSegmentos.class, null, List.of(
                f("codSeg", "cod_seg", "String", 2, true, true, false, "Cod Seg"),
                f("descSeg", "desc_seg", "String", 250, false, false, false, "Desc Seg"))));
        add(new EntityMeta("ccnu_productos", "CCNU_PRODUCTOS", "Ccnu Productos", CcnuProductos.class, CcnuProductos.Pk.class, List.of(
                f("codiProdSunat", "codi_prod_sunat", "String", 8, true, true, false, "Codi Prod Sunat"),
                f("codiClas", "codi_clas", "String", 6, true, true, false, "Codi Clas"),
                f("descProdSunat", "desc_prod_sunat", "String", 250, false, false, false, "Desc Prod Sunat"))));
        add(new EntityMeta("ccnu_familias", "CCNU_FAMILIAS", "Ccnu Familias", CcnuFamilias.class, CcnuFamilias.Pk.class, List.of(
                f("codiFami", "codi_fami", "String", 4, true, true, false, "Codi Fami"),
                f("codSeg", "cod_seg", "String", 2, true, true, false, "Cod Seg"),
                f("descFami", "desc_fami", "String", 250, false, false, false, "Desc Fami"))));
        add(new EntityMeta("ccnu_clases", "CCNU_CLASES", "Ccnu Clases", CcnuClases.class, CcnuClases.Pk.class, List.of(
                f("codiClas", "codi_clas", "String", 6, true, true, false, "Codi Clas"),
                f("codiFami", "codi_fami", "String", 4, true, true, false, "Codi Fami"),
                f("descClas", "desc_clas", "String", 250, false, false, false, "Desc Clas"))));
        add(new EntityMeta("orden_despacho_combustible_deta", "ORDEN_DESPACHO_COMBUSTIBLE_DETA", "Orden Despacho Combustible Deta", OrdenDespachoCombustibleDeta.class, OrdenDespachoCombustibleDeta.Pk.class, List.of(
                f("codiOrdenDes", "codi_orden_des", "Long", 0, true, true, false, "Codi Orden Des"),
                f("codiDeta", "codi_deta", "Long", 0, true, true, false, "Codi Deta"),
                f("codiTracto", "codi_tracto", "String", 5, false, false, false, "Codi Tracto"),
                f("codiTrans", "codi_trans", "String", 4, false, false, false, "Codi Trans"),
                f("codiProd", "codi_prod", "String", 8, false, false, false, "Codi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("precio", "precio", "BigDecimal", 0, false, false, false, "Precio"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("valor", "valor", "BigDecimal", 0, false, false, false, "Valor"))));
        add(new EntityMeta("orden_despacho_combustible", "ORDEN_DESPACHO_COMBUSTIBLE", "Orden Despacho Combustible", OrdenDespachoCombustible.class, OrdenDespachoCombustible.Pk.class, List.of(
                f("codiOrdenDes", "codi_orden_des", "Long", 0, true, true, false, "Codi Orden Des"),
                f("nroOrdenDes", "nro_orden_des", "Long", 0, true, true, false, "Nro Orden Des"),
                f("codiOrdenSoli", "codi_orden_soli", "Long", 0, false, false, false, "Codi Orden Soli"),
                f("tipo", "tipo", "String", 1, false, false, false, "Tipo"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("elaboraPor", "elabora_por", "String", 5, false, false, false, "Elabora Por"),
                f("autorizaPor", "autoriza_por", "String", 5, false, false, false, "Autoriza Por"))));
        add(new EntityMeta("cotizacion_deta", "COTIZACION_DETA", "Cotizacion Deta", CotizacionDeta.class, CotizacionDeta.Pk.class, List.of(
                f("codiCoti", "codi_coti", "Long", 0, true, true, false, "Codi Coti"),
                f("codiDeta", "codi_deta", "Integer", 0, true, true, false, "Codi Deta"),
                f("codiProd", "codi_prod", "String", 8, false, false, false, "Codi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("stock", "stock", "BigDecimal", 0, false, false, false, "Stock"),
                f("pUnit", "p_unit", "BigDecimal", 0, false, false, false, "P Unit"),
                f("total", "total", "BigDecimal", 0, false, false, false, "Total"))));
        add(new EntityMeta("cotizacion_de_pedidos", "COTIZACION_DE_PEDIDOS", "Cotizacion De Pedidos", CotizacionDePedidos.class, null, List.of(
                f("codiCoti", "codi_coti", "String", 10, true, true, false, "Codi Coti"),
                f("fechCoti", "fech_coti", "LocalDateTime", 0, false, false, false, "Fech Coti"),
                f("tiemPlazCred", "tiem_plaz_cred", "Integer", 0, false, false, false, "Tiem Plaz Cred"),
                f("codiUnidMedi", "codi_unid_medi", "String", 2, false, false, false, "Codi Unid Medi"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("precTotaCoti", "prec_tota_coti", "BigDecimal", 0, false, false, false, "Prec Tota Coti"),
                f("codiOrdePedi", "codi_orde_pedi", "String", 10, false, false, false, "Codi Orde Pedi"),
                f("codiListRequOrig", "codi_list_requ_orig", "String", 8, false, false, false, "Codi List Requ Orig"))));
        add(new EntityMeta("detalle_orden_compra_distribucion", "DETALLE_ORDEN_COMPRA_DISTRIBUCION", "Detalle Orden Compra Distribucion", DetalleOrdenCompraDistribucion.class, DetalleOrdenCompraDistribucion.Pk.class, List.of(
                f("codiOrdeComp", "codi_orde_comp", "String", 10, true, true, false, "Codi Orde Comp"),
                f("codiProd", "codi_prod", "String", 8, true, true, false, "Codi Prod"),
                f("codiAlma", "codi_alma", "String", 2, true, true, false, "Codi Alma"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"))));
        add(new EntityMeta("detalle_orden_servicio", "DETALLE_ORDEN_SERVICIO", "Detalle Orden Servicio", DetalleOrdenServicio.class, DetalleOrdenServicio.Pk.class, List.of(
                f("codiDetaOrdeComp", "codi_deta_orde_comp", "String", 12, true, true, false, "Codi Deta Orde Comp"),
                f("codiOrdeComp", "codi_orde_comp", "String", 10, true, true, false, "Codi Orde Comp"),
                f("codiProd", "codi_prod", "String", 8, true, false, false, "Codi Prod"),
                f("descServ", "desc_serv", "String", 250, false, false, false, "Desc Serv"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("precio", "precio", "BigDecimal", 0, false, false, false, "Precio"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("tipoDesc", "tipo_desc", "Boolean", 0, false, false, false, "Tipo Desc"),
                f("descuento", "descuento", "BigDecimal", 0, false, false, false, "Descuento"),
                f("precOrig", "prec_orig", "BigDecimal", 0, false, false, false, "Prec Orig"),
                f("codiDetaOrdePedi", "codi_deta_orde_pedi", "String", 12, false, false, false, "Codi Deta Orde Pedi"),
                f("codiUnidMedi", "codi_unid_medi", "String", 2, false, false, false, "Codi Unid Medi"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"))));
        add(new EntityMeta("acabado", "ACABADO", "Acabado", Acabado.class, null, List.of(
                f("codiAcab", "codi_acab", "Short", 0, true, true, false, "Codi Acab"),
                f("descAcab", "desc_acab", "String", 100, true, false, false, "Desc Acab"),
                f("nemoAca", "nemo_aca", "String", 50, false, false, false, "Nemo Aca"))));
        add(new EntityMeta("compromisos_pactados_deta", "compromisos_pactados_deta", "Compromisos Pactados Deta", CompromisosPactadosDeta.class, CompromisosPactadosDeta.Pk.class, List.of(
                f("codiComp", "codi_comp", "Long", 0, true, true, false, "Codi Comp"),
                f("codiDeta", "codi_deta", "Integer", 0, true, true, false, "Codi Deta"),
                f("codiProd", "codi_prod", "String", 8, false, false, false, "Codi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("pUnit", "p_unit", "BigDecimal", 0, false, false, false, "P Unit"),
                f("total", "total", "BigDecimal", 0, false, false, false, "Total"))));
        add(new EntityMeta("compromisos_pactados", "compromisos_pactados", "Compromisos Pactados", CompromisosPactados.class, null, List.of(
                f("codiComp", "codi_comp", "Long", 0, true, true, false, "Codi Comp"),
                f("nroComp", "nro_comp", "Long", 0, false, false, false, "Nro Comp"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("tipo", "tipo", "String", 1, false, false, false, "Tipo"),
                f("observaciones", "observaciones", "String", 250, false, false, false, "Observaciones"),
                f("fechaVenc", "fecha_venc", "LocalDateTime", 0, false, false, false, "Fecha Venc"),
                f("lugar", "lugar", "String", 50, false, false, false, "Lugar"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"))));
        add(new EntityMeta("color", "COLOR", "Color", Color.class, null, List.of(
                f("codiColor", "codi_color", "Short", 0, true, true, false, "Codi Color"),
                f("descColor", "desc_color", "String", 100, false, false, false, "Desc Color"))));
    }

    private void load2() {
        add(new EntityMeta("productos_sin_venta", "PRODUCTOS_SIN_VENTA", "Productos Sin Venta", ProductosSinVenta.class, ProductosSinVenta.Pk.class, List.of(
                f("fecha", "fecha", "LocalDateTime", 0, true, true, false, "Fecha"),
                f("codiProd", "codi_prod", "String", 8, true, true, false, "Codi Prod"),
                f("descProd", "desc_prod", "String", 150, false, false, false, "Desc Prod"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("ultimaventa", "ultimaventa", "LocalDateTime", 0, false, false, false, "Ultimaventa"),
                f("plazo", "plazo", "LocalDateTime", 0, false, false, false, "Plazo"),
                f("diassinventa", "diassinventa", "Long", 0, false, false, false, "Diassinventa"),
                f("observaciones", "observaciones", "String", 255, false, false, false, "Observaciones"),
                f("codiUsua", "codi_usua", "String", 5, false, false, false, "Codi Usua"),
                f("creacion", "creacion", "LocalDateTime", 0, false, false, false, "Creacion"))));
        add(new EntityMeta("productos_precio", "PRODUCTOS_PRECIO", "Productos Precio", ProductosPrecio.class, null, List.of(
                f("codiItem", "codi_item", "Long", 0, true, true, true, "Codi Item"),
                f("codiDetaNotaIngr", "codi_deta_nota_ingr", "String", 12, false, false, false, "Codi Deta Nota Ingr"),
                f("codiProd", "codi_prod", "String", 8, false, false, false, "Codi Prod"),
                f("precio", "precio", "BigDecimal", 0, false, false, false, "Precio"))));
        add(new EntityMeta("proyecto", "PROYECTO", "Proyecto", Proyecto.class, null, List.of(
                f("codiProy", "codi_proy", "String", 10, true, true, false, "Codi Proy"),
                f("descProy", "desc_proy", "String", 100, false, false, false, "Desc Proy"),
                f("fechProy", "fech_proy", "LocalDateTime", 0, false, false, false, "Fech Proy"))));
        add(new EntityMeta("producto_almacen_lote_pedido", "PRODUCTO_ALMACEN_LOTE_PEDIDO", "Producto Almacen Lote Pedido", ProductoAlmacenLotePedido.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Id"),
                f("codiProdAlmaLote", "codi_prod_alma_lote", "Long", 0, true, false, false, "Codi Prod Alma Lote"),
                f("codiAlma", "codi_alma", "String", 2, true, false, false, "Codi Alma"),
                f("codiProd", "codi_prod", "String", 8, true, false, false, "Codi Prod"),
                f("lote", "lote", "String", 30, true, false, false, "Lote"),
                f("fecVence", "fec_vence", "LocalDateTime", 0, false, false, false, "Fec Vence"),
                f("stock", "stock", "BigDecimal", 0, false, false, false, "Stock"),
                f("ubicacion", "ubicacion", "String", 50, false, false, false, "Ubicacion"),
                f("condicion", "condicion", "String", 1, false, false, false, "Condicion"),
                f("situacion", "situacion", "Integer", 0, false, false, false, "Situacion"),
                f("codiOrdenPedi", "codi_orden_pedi", "Integer", 0, false, false, false, "Codi Orden Pedi"),
                f("cantiSalidaVenta", "canti_salida_venta", "BigDecimal", 0, false, false, false, "Canti Salida Venta"))));
        add(new EntityMeta("vale_salida", "VALE_SALIDA", "Vale Salida", ValeSalida.class, ValeSalida.Pk.class, List.of(
                f("codiSali", "codi_sali", "Long", 0, true, true, false, "Codi Sali"),
                f("codiAlma", "codi_alma", "String", 2, true, true, false, "Codi Alma"),
                f("nroVale", "nro_vale", "Long", 0, false, false, false, "Nro Vale"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"),
                f("serie", "serie", "String", 3, false, false, false, "Serie"),
                f("numero", "numero", "String", 10, false, false, false, "Numero"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("codiMotiTras", "codi_moti_tras", "String", 2, false, false, false, "Codi Moti Tras"),
                f("tpc", "tpc", "BigDecimal", 0, false, false, false, "Tpc"),
                f("observacion", "observacion", "String", 250, false, false, false, "Observacion"),
                f("codiAlmaDest", "codi_alma_dest", "String", 2, false, false, false, "Codi Alma Dest"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"),
                f("correlativo", "correlativo", "Long", 0, false, false, false, "Correlativo"),
                f("codiOrde", "codi_orde", "Long", 0, false, false, false, "Codi Orde"),
                f("anulado", "anulado", "String", 1, false, false, false, "Anulado"),
                f("subt", "subt", "BigDecimal", 0, false, false, false, "Subt"),
                f("igv", "igv", "BigDecimal", 0, false, false, false, "Igv"),
                f("total", "total", "BigDecimal", 0, false, false, false, "Total"),
                f("transporte", "transporte", "String", 5, false, false, false, "Transporte"),
                f("placa", "placa", "String", 10, false, false, false, "Placa"),
                f("provDest", "prov_dest", "String", 5, false, false, false, "Prov Dest"),
                f("chofer", "chofer", "String", 4, false, false, false, "Chofer"),
                f("periodo", "periodo", "String", 4, false, false, false, "Periodo"),
                f("indiceRela", "indice_rela", "Long", 0, false, false, false, "Indice Rela"),
                f("procedencia", "procedencia", "String", 3, false, false, false, "Procedencia"))));
        add(new EntityMeta("orden_de_compra", "ORDEN_DE_COMPRA", "Orden De Compra", OrdenDeCompra.class, null, List.of(
                f("codiOrdeComp", "codi_orde_comp", "String", 10, true, true, false, "Codi Orde Comp"),
                f("codiClieProv", "codi_clie_prov", "String", 5, true, false, false, "Codi Clie Prov"),
                f("fecha", "fecha", "LocalDateTime", 0, true, false, false, "Fecha"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("importe", "importe", "BigDecimal", 0, false, false, false, "Importe"),
                f("codiUnidOperSoli", "codi_unid_oper_soli", "String", 5, false, false, false, "Codi Unid Oper Soli"),
                f("codiUnidOperDest", "codi_unid_oper_dest", "String", 5, false, false, false, "Codi Unid Oper Dest"),
                f("condPago", "cond_pago", "String", 10, false, false, false, "Cond Pago"),
                f("fechEntr", "fech_entr", "LocalDateTime", 0, false, false, false, "Fech Entr"),
                f("lugaEntr", "luga_entr", "String", 100, false, false, false, "Luga Entr"),
                f("codiUnidMedi", "codi_unid_medi", "String", 2, false, false, false, "Codi Unid Medi"),
                f("tiemPlazCred", "tiem_plaz_cred", "Long", 0, false, false, false, "Tiem Plaz Cred"),
                f("atencion", "atencion", "String", 100, false, false, false, "Atencion"),
                f("nroCoti", "nro_coti", "String", 20, false, false, false, "Nro Coti"),
                f("tipoDesc", "tipo_desc", "Boolean", 0, false, false, false, "Tipo Desc"),
                f("descuento", "descuento", "BigDecimal", 0, false, false, false, "Descuento"),
                f("subTota", "sub_tota", "BigDecimal", 0, false, false, false, "Sub Tota"),
                f("codiTipoDocuCont", "codi_tipo_docu_cont", "String", 4, false, false, false, "Codi Tipo Docu Cont"),
                f("igv", "igv", "BigDecimal", 0, false, false, false, "Igv"),
                f("rentCuarCate", "rent_cuar_cate", "BigDecimal", 0, false, false, false, "Rent Cuar Cate"),
                f("ies", "ies", "BigDecimal", 0, false, false, false, "Ies"),
                f("total", "total", "BigDecimal", 0, false, false, false, "Total"),
                f("pediTrab", "pedi_trab", "String", 1, false, false, false, "Pedi Trab"),
                f("detraccion", "detraccion", "Boolean", 0, false, false, false, "Detraccion"),
                f("totaDetr", "tota_detr", "BigDecimal", 0, false, false, false, "Tota Detr"),
                f("nroOrdeComp", "nro_orde_comp", "String", 10, false, false, false, "Nro Orde Comp"),
                f("contab", "contab", "Boolean", 0, false, false, false, "Contab"),
                f("tipoGene", "tipo_gene", "String", 1, false, false, false, "Tipo Gene"),
                f("obse1", "obse_1", "String", 255, false, false, false, "Obse 1"),
                f("obse2", "obse_2", "String", 250, false, false, false, "Obse 2"),
                f("obse3", "obse_3", "String", 250, false, false, false, "Obse 3"),
                f("obse4", "obse_4", "String", 250, false, false, false, "Obse 4"),
                f("obse5", "obse_5", "String", 250, false, false, false, "Obse 5"),
                f("obse6", "obse_6", "String", 250, false, false, false, "Obse 6"),
                f("obse7", "obse_7", "String", 250, false, false, false, "Obse 7"),
                f("obse8", "obse_8", "String", 250, false, false, false, "Obse 8"),
                f("obse9", "obse_9", "String", 250, false, false, false, "Obse 9"),
                f("obse10", "obse_10", "String", 250, false, false, false, "Obse 10"),
                f("valoVent", "valo_vent", "Boolean", 0, false, false, false, "Valo Vent"),
                f("nroGuia", "nro_guia", "String", 20, false, false, false, "Nro Guia"),
                f("nroFact", "nro_fact", "String", 20, false, false, false, "Nro Fact"),
                f("afecRete", "afec_rete", "Boolean", 0, false, false, false, "Afec Rete"),
                f("hechPor", "hech_por", "String", 5, false, false, false, "Hech Por"),
                f("modiPor", "modi_por", "String", 5, false, false, false, "Modi Por"),
                f("autoPor", "auto_por", "String", 5, false, false, false, "Auto Por"),
                f("soliPor", "soli_por", "String", 5, false, false, false, "Soli Por"),
                f("nroPres", "nro_pres", "String", 50, false, false, false, "Nro Pres"),
                f("descCondPago", "desc_cond_pago", "String", 100, false, false, false, "Desc Cond Pago"),
                f("nroSeri", "nro_seri", "String", 5, false, false, false, "Nro Seri"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("otroNoAfec", "otro_no_afec", "Long", 0, false, false, false, "Otro No Afec"),
                f("codiBienServ", "codi_bien_serv", "String", 5, false, false, false, "Codi Bien Serv"),
                f("porcDetra", "porc_detra", "BigDecimal", 0, false, false, false, "Porc Detra"),
                f("aproPor", "apro_por", "String", 5, false, false, false, "Apro Por"),
                f("codiOfi", "codi_ofi", "Long", 0, false, false, false, "Codi Ofi"),
                f("anulado", "anulado", "String", 1, false, false, false, "Anulado"),
                f("motivo", "motivo", "String", 255, false, false, false, "Motivo"),
                f("fechDocuCont", "fech_docu_cont", "LocalDateTime", 0, false, false, false, "Fech Docu Cont"),
                f("anio", "anio", "String", 4, false, false, false, "Anio"),
                f("factor", "factor", "Integer", 0, false, false, false, "Factor"),
                f("nroComp", "nro_comp", "Long", 0, false, false, false, "Nro Comp"),
                f("codiTrans", "codi_trans", "String", 4, false, false, false, "Codi Trans"),
                f("dias", "dias", "Integer", 0, false, false, false, "Dias"),
                f("codiLuga", "codi_luga", "String", 2, false, false, false, "Codi Luga"))));
        add(new EntityMeta("nota_ingr_por_orde_comp", "NOTA_INGR_POR_ORDE_COMP", "Nota Ingr Por Orde Comp", NotaIngrPorOrdeComp.class, NotaIngrPorOrdeComp.Pk.class, List.of(
                f("codiOrdeComp", "codi_orde_comp", "String", 10, true, true, false, "Codi Orde Comp"),
                f("codiNotaIngr", "codi_nota_ingr", "String", 10, true, true, false, "Codi Nota Ingr"))));
        add(new EntityMeta("salida_material", "SALIDA_MATERIAL", "Salida Material", SalidaMaterial.class, null, List.of(
                f("codiDocuSali", "codi_docu_sali", "String", 10, true, true, false, "Codi Docu Sali"),
                f("nroSeri", "nro_seri", "String", 3, false, false, false, "Nro Seri"),
                f("nroDocuSali", "nro_docu_sali", "String", 7, false, false, false, "Nro Docu Sali"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"),
                f("fechEmis", "fech_emis", "LocalDateTime", 0, true, false, false, "Fech Emis"),
                f("fechInicTras", "fech_inic_tras", "LocalDateTime", 0, false, false, false, "Fech Inic Tras"),
                f("codiDomiPart", "codi_domi_part", "String", 4, false, false, false, "Codi Domi Part"),
                f("domiPartDist", "domi_part_dist", "String", 30, false, false, false, "Domi Part Dist"),
                f("domiPartProv", "domi_part_prov", "String", 30, false, false, false, "Domi Part Prov"),
                f("domiPartDepa", "domi_part_depa", "String", 30, false, false, false, "Domi Part Depa"),
                f("domiPartDire", "domi_part_dire", "String", 200, false, false, false, "Domi Part Dire"),
                f("destCodiClieProv", "dest_codi_clie_prov", "String", 5, false, false, false, "Dest Codi Clie Prov"),
                f("destApelORazoSoci", "dest_apel_o_razo_soci", "String", 200, false, false, false, "Dest Apel O Razo Soci"),
                f("destDire", "dest_dire", "String", 200, false, false, false, "Dest Dire"),
                f("destIden", "dest_iden", "String", 15, false, false, false, "Dest Iden"),
                f("destTipoDocuIden", "dest_tipo_docu_iden", "String", 4, false, false, false, "Dest Tipo Docu Iden"),
                f("codiDomiLleg", "codi_domi_lleg", "String", 4, false, false, false, "Codi Domi Lleg"),
                f("domiLlegDist", "domi_lleg_dist", "String", 30, false, false, false, "Domi Lleg Dist"),
                f("domiLlegProv", "domi_lleg_prov", "String", 30, false, false, false, "Domi Lleg Prov"),
                f("domiLlegDepa", "domi_lleg_depa", "String", 30, false, false, false, "Domi Lleg Depa"),
                f("domiLlegDire", "domi_lleg_dire", "String", 200, false, false, false, "Domi Lleg Dire"),
                f("codiUnidTran", "codi_unid_tran", "String", 4, false, false, false, "Codi Unid Tran"),
                f("codiTrans", "codi_trans", "String", 4, false, false, false, "Codi Trans"),
                f("codiTipoDocuCompPago", "codi_tipo_docu_comp_pago", "String", 4, false, false, false, "Codi Tipo Docu Comp Pago"),
                f("compPagoSeri", "comp_pago_seri", "String", 5, false, false, false, "Comp Pago Seri"),
                f("compPagoNro", "comp_pago_nro", "String", 15, false, false, false, "Comp Pago Nro"),
                f("codiMotiTras", "codi_moti_tras", "String", 2, false, false, false, "Codi Moti Tras"),
                f("motiTrasDesc", "moti_tras_desc", "String", 200, false, false, false, "Moti Tras Desc"),
                f("codiMoneCost", "codi_mone_cost", "String", 2, false, false, false, "Codi Mone Cost"),
                f("costMini", "cost_mini", "BigDecimal", 0, false, false, false, "Cost Mini"),
                f("codiUnidMediPeso", "codi_unid_medi_peso", "String", 4, false, false, false, "Codi Unid Medi Peso"),
                f("pesoTota", "peso_tota", "BigDecimal", 0, false, false, false, "Peso Tota"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("tipoGene", "tipo_gene", "String", 1, false, false, false, "Tipo Gene"),
                f("codiPersEmitGuia", "codi_pers_emit_guia", "String", 5, false, false, false, "Codi Pers Emit Guia"),
                f("codiPersReciGuia", "codi_pers_reci_guia", "String", 5, false, false, false, "Codi Pers Reci Guia"),
                f("apel1ReciGuia", "apel_1_reci_guia", "String", 50, false, false, false, "Apel 1 Reci Guia"),
                f("apel2ReciGuia", "apel_2_reci_guia", "String", 50, false, false, false, "Apel 2 Reci Guia"),
                f("nomb1ReciGuia", "nomb_1_reci_guia", "String", 50, false, false, false, "Nomb 1 Reci Guia"),
                f("nomb2ReciGuia", "nomb_2_reci_guia", "String", 50, false, false, false, "Nomb 2 Reci Guia"),
                f("codiUnidOperRece", "codi_unid_oper_rece", "String", 5, false, false, false, "Codi Unid Oper Rece"),
                f("observacion", "observacion", "String", 200, false, false, false, "Observacion"),
                f("motiSali", "moti_sali", "String", 200, false, false, false, "Moti Sali"),
                f("apel1Chof", "apel_1_chof", "String", 30, false, false, false, "Apel 1 Chof"),
                f("apel2Chof", "apel_2_chof", "String", 30, false, false, false, "Apel 2 Chof"),
                f("nomb1Chof", "nomb_1_chof", "String", 30, false, false, false, "Nomb 1 Chof"),
                f("nomb2Chof", "nomb_2_chof", "String", 30, false, false, false, "Nomb 2 Chof"),
                f("liceCondChof", "lice_cond_chof", "String", 20, false, false, false, "Lice Cond Chof"),
                f("dniChof", "dni_chof", "String", 20, false, false, false, "Dni Chof"),
                f("conReto", "con_reto", "String", 1, false, false, false, "Con Reto"),
                f("indiReto", "indi_reto", "String", 1, false, false, false, "Indi Reto"),
                f("indiDevoMateEmba", "indi_devo_mate_emba", "String", 1, false, false, false, "Indi Devo Mate Emba"),
                f("cimt", "cimt", "String", 20, false, false, false, "Cimt"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("marcaTranspo", "marca_transpo", "String", 20, false, false, false, "Marca Transpo"),
                f("nroPlacaTranspo", "nro_placa_transpo", "String", 20, false, false, false, "Nro Placa Transpo"),
                f("empreTransRazoSoci", "empre_trans_razo_soci", "String", 50, false, false, false, "Empre Trans Razo Soci"),
                f("empreTransRuc", "empre_trans_ruc", "String", 15, false, false, false, "Empre Trans Ruc"),
                f("empreTransDomici", "empre_trans_domici", "String", 50, false, false, false, "Empre Trans Domici"))));
        add(new EntityMeta("almacenes", "ALMACENES", "Almacenes", Almacenes.class, null, List.of(
                f("codiAlma", "codi_alma", "String", 3, true, true, false, "Codi Alma"),
                f("descAlma", "desc_alma", "String", 50, true, false, false, "Desc Alma"),
                f("ubicAlma", "ubic_alma", "String", 100, true, false, false, "Ubic Alma"))));
        add(new EntityMeta("tipo_aceptacion", "TIPO_ACEPTACION", "Tipo Aceptacion", TipoAceptacion.class, null, List.of(
                f("codiTipoAcep", "codi_tipo_acep", "String", 2, true, true, false, "Codi Tipo Acep"),
                f("descAcepRequ", "desc_acep_requ", "String", 50, false, false, false, "Desc Acep Requ"),
                f("nemo", "nemo", "String", 4, false, false, false, "Nemo"))));
        add(new EntityMeta("producto_almacen_lote", "PRODUCTO_ALMACEN_LOTE", "Producto Almacen Lote", ProductoAlmacenLote.class, null, List.of(
                f("codiProdAlmaLote", "codi_prod_alma_lote", "Long", 0, true, true, true, "Codi Prod Alma Lote"),
                f("codiAlma", "codi_alma", "String", 2, true, false, false, "Codi Alma"),
                f("codiProd", "codi_prod", "String", 8, true, false, false, "Codi Prod"),
                f("lote", "lote", "String", 30, true, false, false, "Lote"),
                f("fecVence", "fec_vence", "LocalDateTime", 0, false, false, false, "Fec Vence"),
                f("stock", "stock", "BigDecimal", 0, false, false, false, "Stock"),
                f("ubicacion", "ubicacion", "String", 50, false, false, false, "Ubicacion"),
                f("condicion", "condicion", "String", 1, false, false, false, "Condicion"),
                f("situacion", "situacion", "Integer", 0, false, false, false, "Situacion"),
                f("fechVenceReal", "fech_vence_real", "LocalDateTime", 0, false, false, false, "Fech Vence Real"),
                f("pArreglo", "p_arreglo", "String", 255, false, false, false, "P Arreglo"),
                f("sArreglo", "s_arreglo", "String", 255, false, false, false, "S Arreglo"),
                f("iden", "iden", "String", 50, false, false, false, "Iden"),
                f("codiOrdeComp", "codi_orde_comp", "String", 10, false, false, false, "Codi Orde Comp"),
                f("correlativo", "correlativo", "Integer", 0, false, false, false, "Correlativo"),
                f("cantiSalidaVenta", "canti_salida_venta", "BigDecimal", 0, false, false, false, "Canti Salida Venta"),
                f("fecIngreso", "fec_ingreso", "LocalDateTime", 0, false, false, false, "Fec Ingreso"))));
        add(new EntityMeta("principio_x_producto", "PRINCIPIO_X_PRODUCTO", "Principio X Producto", PrincipioXProducto.class, PrincipioXProducto.Pk.class, List.of(
                f("codiProd", "codi_prod", "String", 8, true, true, false, "Codi Prod"),
                f("sec", "sec", "Integer", 0, true, true, true, "Sec"),
                f("codiPrin", "codi_prin", "String", 3, false, false, false, "Codi Prin"))));
        add(new EntityMeta("principio_activo", "PRINCIPIO_ACTIVO", "Principio Activo", PrincipioActivo.class, null, List.of(
                f("codiPrin", "codi_prin", "String", 3, true, true, false, "Codi Prin"),
                f("descripcion", "descripcion", "String", 100, false, false, false, "Descripcion"))));
        add(new EntityMeta("unid_oper_divi", "UNID_OPER_DIVI", "Unid Oper Divi", UnidOperDivi.class, null, List.of(
                f("codiDiviUnidOper", "codi_divi_unid_oper", "String", 3, true, true, false, "Codi Divi Unid Oper"),
                f("descDiviUnidOper", "desc_divi_unid_oper", "String", 200, false, false, false, "Desc Divi Unid Oper"),
                f("codiTipoUnidOper", "codi_tipo_unid_oper", "String", 2, false, false, false, "Codi Tipo Unid Oper"))));
        add(new EntityMeta("control_problemas_detalle", "CONTROL_PROBLEMAS_DETALLE", "Control Problemas Detalle", ControlProblemasDetalle.class, ControlProblemasDetalle.Pk.class, List.of(
                f("idControl", "id_control", "Long", 0, true, true, false, "Id Control"),
                f("idSec", "id_sec", "Integer", 0, true, true, false, "Id Sec"),
                f("idSubFamiProd", "id_sub_fami_prod", "String", 4, false, false, false, "Id Sub Fami Prod"),
                f("opcion", "opcion", "String", 255, false, false, false, "Opcion"),
                f("dosis", "dosis", "String", 255, false, false, false, "Dosis"))));
        add(new EntityMeta("control_problemas", "CONTROL_PROBLEMAS", "Control Problemas", ControlProblemas.class, null, List.of(
                f("idControl", "id_control", "Long", 0, true, true, false, "Id Control"),
                f("nroControl", "nro_control", "Long", 0, false, false, false, "Nro Control"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("descripcion", "descripcion", "String", 255, false, false, false, "Descripcion"),
                f("hechoPor", "hecho_por", "String", 5, false, false, false, "Hecho Por"))));
        add(new EntityMeta("almacen_usuario", "Almacen_Usuario", "Almacen Usuario", AlmacenUsuario.class, AlmacenUsuario.Pk.class, List.of(
                f("codiAlma", "codi_alma", "String", 2, true, true, false, "Codi Alma"),
                f("codiUsua", "codi_usua", "String", 5, true, true, false, "Codi Usua"))));
        add(new EntityMeta("sali_mate_x_proy", "SALI_MATE_X_PROY", "Sali Mate X Proy", SaliMateXProy.class, SaliMateXProy.Pk.class, List.of(
                f("codiDocuSali", "codi_docu_sali", "String", 10, true, true, false, "Codi Docu Sali"),
                f("codiProy", "codi_proy", "String", 10, true, true, false, "Codi Proy"))));
        add(new EntityMeta("sali_mate_x_docu_sali", "SALI_MATE_X_DOCU_SALI", "Sali Mate X Docu Sali", SaliMateXDocuSali.class, SaliMateXDocuSali.Pk.class, List.of(
                f("codiDocuSaliMate", "codi_docu_sali_mate", "String", 10, true, true, false, "Codi Docu Sali Mate"),
                f("codiDocuSali", "codi_docu_sali", "String", 10, true, true, false, "Codi Docu Sali"),
                f("tipoDocuOrigSali", "tipo_docu_orig_sali", "String", 2, true, true, false, "Tipo Docu Orig Sali"))));
        add(new EntityMeta("proveedor_productos", "PROVEEDOR_PRODUCTOS", "Proveedor Productos", ProveedorProductos.class, ProveedorProductos.Pk.class, List.of(
                f("codiClieProv", "codi_clie_prov", "String", 5, true, true, false, "Codi Clie Prov"),
                f("codiFamiProd", "codi_fami_prod", "String", 2, true, true, false, "Codi Fami Prod"))));
        add(new EntityMeta("orden_compra_detalle", "ORDEN_COMPRA_DETALLE", "Orden Compra Detalle", OrdenCompraDetalle.class, OrdenCompraDetalle.Pk.class, List.of(
                f("codiOrde", "codi_orde", "Long", 0, true, true, false, "Codi Orde"),
                f("item", "item", "Integer", 0, true, true, false, "Item"),
                f("codiProd", "codi_prod", "String", 8, false, false, false, "Codi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("precio", "precio", "BigDecimal", 0, false, false, false, "Precio"),
                f("codiUnidMedi", "codi_unid_medi", "String", 2, false, false, false, "Codi Unid Medi"),
                f("total", "total", "BigDecimal", 0, false, false, false, "Total"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("saldo", "saldo", "BigDecimal", 0, false, false, false, "Saldo"),
                f("igv", "igv", "BigDecimal", 0, false, false, false, "Igv"),
                f("venta", "venta", "BigDecimal", 0, false, false, false, "Venta"),
                f("valorigv", "valorigv", "BigDecimal", 0, false, false, false, "Valorigv"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("exonerado", "exonerado", "String", 1, false, false, false, "Exonerado"),
                f("acidez", "acidez", "BigDecimal", 0, false, false, false, "Acidez"),
                f("serguia", "serguia", "String", 5, false, false, false, "Serguia"),
                f("nroguia", "nroguia", "String", 10, false, false, false, "Nroguia"),
                f("transporte", "transporte", "String", 5, false, false, false, "Transporte"),
                f("placa", "placa", "String", 10, false, false, false, "Placa"),
                f("codiMotiTras", "codi_moti_tras", "String", 2, false, false, false, "Codi Moti Tras"),
                f("pesocolp", "pesocolp", "BigDecimal", 0, false, false, false, "Pesocolp"),
                f("ticket", "ticket", "String", 10, false, false, false, "Ticket"))));
        add(new EntityMeta("detalle_salida_materiales", "DETALLE_SALIDA_MATERIALES", "Detalle Salida Materiales", DetalleSalidaMateriales.class, null, List.of(
                f("codiDetaDocuSali", "codi_deta_docu_sali", "String", 12, true, true, false, "Codi Deta Docu Sali"),
                f("codiDocuSali", "codi_docu_sali", "String", 10, true, false, false, "Codi Docu Sali"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("codiProd", "codi_prod", "String", 8, false, false, false, "Codi Prod"),
                f("descProd", "desc_prod", "String", 250, false, false, false, "Desc Prod"),
                f("codiUnidMediProd", "codi_unid_medi_prod", "String", 2, false, false, false, "Codi Unid Medi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("peso", "peso", "BigDecimal", 0, false, false, false, "Peso"),
                f("codiUnidMediPeso", "codi_unid_medi_peso", "String", 2, false, false, false, "Codi Unid Medi Peso"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("conReto", "con_reto", "String", 1, false, false, false, "Con Reto"),
                f("indiReto", "indi_reto", "String", 1, false, false, false, "Indi Reto"),
                f("codiDetaOrig", "codi_deta_orig", "String", 12, false, false, false, "Codi Deta Orig"),
                f("tipoOrig", "tipo_orig", "String", 1, false, false, false, "Tipo Orig"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"))));
        add(new EntityMeta("orden_compra_pedido_cotiza", "ORDEN_COMPRA_PEDIDO_COTIZA", "Orden Compra Pedido Cotiza", OrdenCompraPedidoCotiza.class, OrdenCompraPedidoCotiza.Pk.class, List.of(
                f("codiOrdeComp", "codi_orde_comp", "String", 10, true, true, false, "Codi Orde Comp"),
                f("codiDocu", "codi_docu", "String", 10, true, true, false, "Codi Docu"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, true, true, false, "Codi Tipo Docu"))));
        add(new EntityMeta("detalle_orden_compra", "DETALLE_ORDEN_COMPRA", "Detalle Orden Compra", DetalleOrdenCompra.class, null, List.of(
                f("codiDetaOrdeComp", "codi_deta_orde_comp", "String", 12, true, true, false, "Codi Deta Orde Comp"),
                f("codiOrdeComp", "codi_orde_comp", "String", 10, true, false, false, "Codi Orde Comp"),
                f("codiProd", "codi_prod", "String", 8, true, false, false, "Codi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("precio", "precio", "BigDecimal", 0, false, false, false, "Precio"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("tipoDesc", "tipo_desc", "Integer", 0, false, false, false, "Tipo Desc"),
                f("descuento", "descuento", "BigDecimal", 0, false, false, false, "Descuento"),
                f("precOrig", "prec_orig", "BigDecimal", 0, false, false, false, "Prec Orig"),
                f("codiDetaOrdePedi", "codi_deta_orde_pedi", "String", 12, false, false, false, "Codi Deta Orde Pedi"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("procPedi", "proc_pedi", "String", 1, false, false, false, "Proc Pedi"),
                f("fechaVenc", "fecha_venc", "LocalDateTime", 0, false, false, false, "Fecha Venc"),
                f("tipoCompra", "tipo_compra", "String", 1, false, false, false, "Tipo Compra"),
                f("codiUnidMediOrde", "codi_unid_medi_orde", "String", 2, false, false, false, "Codi Unid Medi Orde"),
                f("tipoProd", "tipo_prod", "String", 5, false, false, false, "Tipo Prod"))));
        add(new EntityMeta("detalle_orden_de_pedido", "DETALLE_ORDEN_DE_PEDIDO", "Detalle Orden De Pedido", DetalleOrdenDePedido.class, null, List.of(
                f("codiDetaOrdePedi", "codi_deta_orde_pedi", "String", 12, true, true, false, "Codi Deta Orde Pedi"),
                f("codiOrdePedi", "codi_orde_pedi", "String", 10, true, false, false, "Codi Orde Pedi"),
                f("codiProd", "codi_prod", "String", 8, false, false, false, "Codi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("precProm", "prec_prom", "BigDecimal", 0, false, false, false, "Prec Prom"),
                f("precUlti", "prec_ulti", "BigDecimal", 0, false, false, false, "Prec Ulti"),
                f("codiMonePrecUlti", "codi_mone_prec_ulti", "String", 2, false, false, false, "Codi Mone Prec Ulti"),
                f("codiClieProvUlti", "codi_clie_prov_ulti", "String", 5, false, false, false, "Codi Clie Prov Ulti"),
                f("stocUlti", "stoc_ulti", "BigDecimal", 0, false, false, false, "Stoc Ulti"),
                f("stocTempUlti", "stoc_temp_ulti", "BigDecimal", 0, false, false, false, "Stoc Temp Ulti"),
                f("nroUltiSali", "nro_ulti_sali", "String", 10, false, false, false, "Nro Ulti Sali"),
                f("fechUltiSali", "fech_ulti_sali", "LocalDateTime", 0, false, false, false, "Fech Ulti Sali"),
                f("cantUltiSali", "cant_ulti_sali", "BigDecimal", 0, false, false, false, "Cant Ulti Sali"),
                f("consProm", "cons_prom", "BigDecimal", 0, false, false, false, "Cons Prom"),
                f("cuenCost", "cuen_cost", "String", 7, false, false, false, "Cuen Cost"),
                f("lugaAten", "luga_aten", "String", 4, false, false, false, "Luga Aten"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("precVenta", "prec_venta", "BigDecimal", 0, false, false, false, "Prec Venta"))));
    }

    private void load3() {
        add(new EntityMeta("detalle_cotizacion_pedido", "DETALLE_COTIZACION_PEDIDO", "Detalle Cotizacion Pedido", DetalleCotizacionPedido.class, null, List.of(
                f("codiDetaCoti", "codi_deta_coti", "String", 12, true, true, false, "Codi Deta Coti"),
                f("codiCoti", "codi_coti", "String", 10, false, false, false, "Codi Coti"),
                f("codiProd", "codi_prod", "String", 8, false, false, false, "Codi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("codiUnidMediTiem", "codi_unid_medi_tiem", "String", 2, false, false, false, "Codi Unid Medi Tiem"),
                f("tiemResp", "tiem_resp", "BigDecimal", 0, false, false, false, "Tiem Resp"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("precUnit", "prec_unit", "BigDecimal", 0, false, false, false, "Prec Unit"))));
        add(new EntityMeta("detalle_listarequerimientos", "DETALLE_LISTAREQUERIMIENTOS", "Detalle Listarequerimientos", DetalleListarequerimientos.class, null, List.of(
                f("codiDetaListRequ", "codi_deta_list_requ", "String", 10, true, true, false, "Codi Deta List Requ"),
                f("codiListRequ", "codi_list_requ", "String", 8, true, false, false, "Codi List Requ"),
                f("codiProd", "codi_prod", "String", 8, true, false, false, "Codi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("stocUlti", "stoc_ulti", "BigDecimal", 0, false, false, false, "Stoc Ulti"),
                f("stocTempUlti", "stoc_temp_ulti", "BigDecimal", 0, false, false, false, "Stoc Temp Ulti"),
                f("ultiPrec", "ulti_prec", "BigDecimal", 0, false, false, false, "Ulti Prec"),
                f("codiMoneUltiPrec", "codi_mone_ulti_prec", "String", 2, false, false, false, "Codi Mone Ulti Prec"),
                f("cuenCost", "cuen_cost", "String", 7, false, false, false, "Cuen Cost"),
                f("fechUltiRequ", "fech_ulti_requ", "LocalDateTime", 0, false, false, false, "Fech Ulti Requ"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"))));
        add(new EntityMeta("kit_deta", "KIT_DETA", "Kit Deta", KitDeta.class, KitDeta.Pk.class, List.of(
                f("codiKitInte", "codi_kit_inte", "String", 4, true, true, false, "Codi Kit Inte"),
                f("nroItem", "nro_item", "Integer", 0, true, true, false, "Nro Item"),
                f("codiProd", "codi_prod", "String", 8, true, false, false, "Codi Prod"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"))));
        add(new EntityMeta("productos_lotes_ingre_sali", "PRODUCTOS_LOTES_INGRE_SALI", "Productos Lotes Ingre Sali", ProductosLotesIngreSali.class, ProductosLotesIngreSali.Pk.class, List.of(
                f("codiDetaIngreSali", "codi_deta_ingre_sali", "String", 12, true, true, false, "codigo segun ingreso o salida"),
                f("codiProdAlmaLote", "codi_prod_alma_lote", "Long", 0, true, true, false, "Codi Prod Alma Lote"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("io", "io", "Integer", 0, true, true, false, "1=ingreso,2=salida"),
                f("codiIngrSali", "codi_ingr_sali", "String", 10, false, false, false, "Codi Ingr Sali"))));
        add(new EntityMeta("aceptacion_lista_reque", "ACEPTACION_LISTA_REQUE", "Aceptacion Lista Reque", AceptacionListaReque.class, AceptacionListaReque.Pk.class, List.of(
                f("codiDetaListRequ", "codi_deta_list_requ", "String", 10, true, true, false, "Codi Deta List Requ"),
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("aceptacion", "aceptacion", "Boolean", 0, false, false, false, "Aceptacion"),
                f("nroJera", "nro_jera", "Short", 0, false, false, false, "Nro Jera"),
                f("fechAcep", "fech_acep", "LocalDateTime", 0, false, false, false, "Fech Acep"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "CANTIDAD ACEPTADA"))));
    }

    @Override
    public String service() {
        return "logistica";
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
