package pe.sige.produccion.domain.legacy;

import jakarta.enterprise.context.ApplicationScoped;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import pe.sige.common.catalog.EntityCatalog;
import pe.sige.common.catalog.EntityMeta;
import pe.sige.common.catalog.FieldMeta;

/** Catalogo de entidades legado de ms-produccion (40 tablas). Generado: no editar. */
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
        add(new EntityMeta("analisis_aceite", "Analisis_Aceite", "Analisis Aceite", AnalisisAceite.class, null, List.of(
                f("codAnalisis", "cod_analisis", "Long", 0, true, true, true, "Cod Analisis"),
                f("codiIngr", "codi_ingr", "Long", 0, true, false, false, "Codi Ingr"),
                f("codiAlma", "codi_alma", "String", 2, true, false, false, "Codi Alma"),
                f("item", "item", "Integer", 0, true, false, false, "Item"),
                f("codiProd", "codi_prod", "String", 8, true, false, false, "Codi Prod"),
                f("iO", "i_o", "String", 1, true, false, false, "I O"),
                f("condicion", "condicion", "Short", 0, true, false, false, "0 no analizado 1 analizado"),
                f("fechaAnalisis", "fecha_analisis", "LocalDateTime", 0, false, false, false, "Fecha Analisis"),
                f("fechaRegistro", "fecha_registro", "LocalDateTime", 0, true, false, false, "Fecha Registro"),
                f("codiUsua", "codi_usua", "String", 5, false, false, false, "Persona que registra el analisis"),
                f("estadoIngreso", "estado_ingreso", "Short", 0, false, false, false, "1 habilitado  0 rechazado  "))));
        add(new EntityMeta("lugar_origen", "LUGAR_ORIGEN", "Lugar Origen", LugarOrigen.class, null, List.of(
                f("codiLuga", "codi_luga", "String", 3, true, true, false, "Codi Luga"),
                f("descLuga", "desc_luga", "String", 200, false, false, false, "Desc Luga"))));
        add(new EntityMeta("informe_acidez", "INFORME_ACIDEZ", "Informe Acidez", InformeAcidez.class, InformeAcidez.Pk.class, List.of(
                f("codiAlma", "codi_alma", "String", 2, true, true, false, "Codi Alma"),
                f("fecha", "fecha", "String", 10, true, true, false, "Fecha"),
                f("peso", "peso", "BigDecimal", 0, false, false, false, "Peso"),
                f("superior", "superior", "BigDecimal", 0, false, false, false, "Superior"),
                f("medio", "medio", "BigDecimal", 0, false, false, false, "Medio"),
                f("compo", "compo", "BigDecimal", 0, false, false, false, "Compo"),
                f("fondo", "fondo", "BigDecimal", 0, false, false, false, "Fondo"),
                f("solidos", "solidos", "BigDecimal", 0, false, false, false, "Solidos"),
                f("altura", "altura", "BigDecimal", 0, false, false, false, "Altura"),
                f("observaciones", "observaciones", "String", 100, false, false, false, "Observaciones"),
                f("hora", "hora", "String", 10, false, false, false, "Hora"))));
        add(new EntityMeta("nrotrip_embar", "NroTrip_Embar", "Nrotrip Embar", NrotripEmbar.class, null, List.of(
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, true, false, "Codi Unid Oper"),
                f("nroTrip", "nro_trip", "Integer", 0, true, false, false, "Nro Trip"))));
        add(new EntityMeta("nota_ingreso_aceite", "Nota_ingreso_Aceite", "Nota Ingreso Aceite", NotaIngresoAceite.class, NotaIngresoAceite.Pk.class, List.of(
                f("codiIngr", "codi_ingr", "Long", 0, true, true, false, "Codi Ingr"),
                f("codiAlma", "codi_alma", "String", 2, true, true, false, "Codi Alma"),
                f("nroIngr", "nro_ingr", "Long", 0, false, false, false, "Nro Ingr"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, false, false, false, "Codi Tipo Docu"),
                f("serie", "serie", "String", 3, false, false, false, "Serie"),
                f("numero", "numero", "String", 10, false, false, false, "Numero"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("codiMotiTras", "codi_moti_tras", "String", 2, false, false, false, "Codi Moti Tras"),
                f("tpc", "tpc", "BigDecimal", 0, false, false, false, "Tpc"),
                f("observacion", "observacion", "String", 250, false, false, false, "Observacion"),
                f("codiOrde", "codi_orde", "Long", 0, false, false, false, "Codi Orde"),
                f("relaVale", "rela_vale", "Long", 0, false, false, false, "Rela Vale"),
                f("anulado", "anulado", "String", 1, false, false, false, "Anulado"),
                f("subt", "subt", "BigDecimal", 0, false, false, false, "Subt"),
                f("igv", "igv", "BigDecimal", 0, false, false, false, "Igv"),
                f("total", "total", "BigDecimal", 0, false, false, false, "Total"),
                f("ordenCompra", "orden_compra", "Long", 0, false, false, false, "Orden Compra"),
                f("productor", "productor", "String", 5, false, false, false, "Productor"),
                f("transporte", "transporte", "String", 5, false, false, false, "Transporte"),
                f("placa", "placa", "String", 10, false, false, false, "Placa"),
                f("codiDoc", "codi_doc", "String", 4, false, false, false, "Codi Doc"),
                f("serfact", "serfact", "String", 5, false, false, false, "Serfact"),
                f("nrofact", "nrofact", "String", 10, false, false, false, "Nrofact"),
                f("fechaFact", "fecha_fact", "LocalDateTime", 0, false, false, false, "Fecha Fact"),
                f("codiSali", "codi_sali", "Long", 0, false, false, false, "Codi Sali"),
                f("chofer", "chofer", "String", 4, false, false, false, "Chofer"),
                f("periodo", "periodo", "String", 4, false, false, false, "Periodo"),
                f("indiceRela", "indice_rela", "Long", 0, false, false, false, "Indice Rela"),
                f("procedencia", "procedencia", "String", 3, false, false, false, "Procedencia"),
                f("contabilizado", "contabilizado", "Boolean", 0, true, false, false, "Contabilizado"),
                f("codiUnidOperProd", "codi_unid_oper_prod", "String", 5, false, false, false, "Codi Unid Oper Prod"))));
        add(new EntityMeta("pozas", "POZAS", "Pozas", Pozas.class, null, List.of(
                f("codiPoza", "codi_poza", "String", 2, true, true, false, "Codi Poza"),
                f("descPoza", "desc_poza", "String", 50, true, false, false, "Desc Poza"))));
        add(new EntityMeta("tipo_destino", "TIPO_DESTINO", "Tipo Destino", TipoDestino.class, null, List.of(
                f("codiTipoDest", "codi_tipo_dest", "String", 2, true, true, false, "Codi Tipo Dest"),
                f("descTipoDest", "desc_tipo_dest", "String", 100, false, false, false, "Desc Tipo Dest"),
                f("nemo", "nemo", "String", 4, false, false, false, "Nemo"))));
        add(new EntityMeta("tipo_cert_emba", "TIPO_CERT_EMBA", "Tipo Cert Emba", TipoCertEmba.class, null, List.of(
                f("codiTipoCert", "codi_tipo_cert", "String", 2, true, true, false, "Codi Tipo Cert"),
                f("descTipoCert", "desc_tipo_cert", "String", 100, false, false, false, "Desc Tipo Cert"),
                f("nemoTipoCert", "nemo_tipo_cert", "String", 20, false, false, false, "Nemo Tipo Cert"))));
        add(new EntityMeta("orden_compra_aceite", "ORDEN_COMPRA_ACEITE", "Orden Compra Aceite", OrdenCompraAceite.class, null, List.of(
                f("codiOrde", "codi_orde", "Long", 0, true, true, false, "Codi Orde"),
                f("nroOrde", "nro_orde", "Long", 0, false, false, false, "Nro Orde"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
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
                f("contabilizado", "contabilizado", "String", 1, false, false, false, "Contabilizado"),
                f("codiVouc", "codi_vouc", "String", 10, false, false, false, "Codi Vouc"),
                f("subt", "subt", "BigDecimal", 0, false, false, false, "Subt"),
                f("igv", "igv", "BigDecimal", 0, false, false, false, "Igv"),
                f("total", "total", "BigDecimal", 0, false, false, false, "Total"),
                f("productor", "productor", "String", 5, false, false, false, "Productor"),
                f("transporte", "transporte", "String", 5, false, false, false, "Transporte"),
                f("placa", "placa", "String", 10, false, false, false, "Placa"),
                f("serfact", "serfact", "String", 5, false, false, false, "Serfact"),
                f("nrofact", "nrofact", "String", 10, false, false, false, "Nrofact"),
                f("codiDoc", "codi_doc", "String", 4, false, false, false, "Codi Doc"),
                f("periodo", "periodo", "String", 4, false, false, false, "Periodo"))));
        add(new EntityMeta("situ_emba", "SITU_EMBA", "Situ Emba", SituEmba.class, null, List.of(
                f("codiSitu", "codi_situ", "String", 2, true, true, false, "Codi Situ"),
                f("descSitu", "desc_situ", "String", 50, false, false, false, "Desc Situ"),
                f("nemoSitu", "nemo_situ", "String", 10, false, false, false, "Nemo Situ"))));
        add(new EntityMeta("sistemas_embarcaciones", "SISTEMAS_EMBARCACIONES", "Sistemas Embarcaciones", SistemasEmbarcaciones.class, null, List.of(
                f("codiSistEmba", "codi_sist_emba", "String", 2, true, true, false, "Codi Sist Emba"),
                f("descSistEmba", "desc_sist_emba", "String", 100, false, false, false, "Desc Sist Emba"),
                f("nemoSistEmba", "nemo_sist_emba", "String", 20, false, false, false, "Nemo Sist Emba"))));
        add(new EntityMeta("especies", "ESPECIES", "Especies", Especies.class, null, List.of(
                f("codiEspe", "codi_espe", "String", 2, true, true, false, "Codi Espe"),
                f("descEspe", "desc_espe", "String", 50, false, false, false, "Desc Espe"),
                f("descuento", "descuento", "BigDecimal", 0, false, false, false, "Descuento"),
                f("tipoCons", "tipo_cons", "String", 1, false, false, false, "Tipo Cons"))));
        add(new EntityMeta("zarp_obse", "ZARP_OBSE", "Zarp Obse", ZarpObse.class, ZarpObse.Pk.class, List.of(
                f("codiZarp", "codi_zarp", "String", 10, true, true, false, "Codi Zarp"),
                f("nroObse", "nro_obse", "Short", 0, true, true, false, "Nro Obse"),
                f("descObse", "desc_obse", "String", 250, false, false, false, "Desc Obse"),
                f("nroCuen", "nro_cuen", "String", 7, false, false, false, "Nro Cuen"),
                f("codiSistEmba", "codi_sist_emba", "String", 2, false, false, false, "Codi Sist Emba"))));
        add(new EntityMeta("propias_terceros", "propias_terceros", "Propias Terceros", PropiasTerceros.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("codiTipo", "codi_tipo", "String", 1, false, false, false, "Codi Tipo"),
                f("descTipo", "desc_tipo", "String", 10, false, false, false, "Desc Tipo"))));
        add(new EntityMeta("puerto", "Puerto", "Puerto", Puerto.class, null, List.of(
                f("codiPuer", "codi_puer", "String", 2, true, true, false, "Codi Puer"),
                f("descPuer", "desc_puer", "String", 30, false, false, false, "Desc Puer"))));
        add(new EntityMeta("tipos_orden_produccion", "TIPOS_ORDEN_PRODUCCION", "Tipos Orden Produccion", TiposOrdenProduccion.class, null, List.of(
                f("codiTipoOp", "codi_tipo_op", "Integer", 0, true, true, false, "Codi Tipo Op"),
                f("descTipoOp", "desc_tipo_op", "String", 50, false, false, false, "Desc Tipo Op"),
                f("nemo", "nemo", "String", 20, false, false, false, "Nemo"))));
        add(new EntityMeta("tipo_titu_pesc", "TIPO_TITU_PESC", "Tipo Titu Pesc", TipoTituPesc.class, null, List.of(
                f("codiTipoTituPesc", "codi_tipo_titu_pesc", "String", 2, true, true, false, "Codi Tipo Titu Pesc"),
                f("descTipoTituPesc", "desc_tipo_titu_pesc", "String", 50, false, false, false, "Desc Tipo Titu Pesc"),
                f("abre", "abre", "String", 20, false, false, false, "Abre"),
                f("orden", "orden", "Integer", 0, false, false, false, "Orden"))));
        add(new EntityMeta("destinos_pesca", "DESTINOS_PESCA", "Destinos Pesca", DestinosPesca.class, null, List.of(
                f("codiDest", "codi_dest", "String", 3, true, true, false, "Codi Dest"),
                f("descDest", "desc_dest", "String", 250, false, false, false, "Desc Dest"),
                f("abrev", "abrev", "String", 30, false, false, false, "Abrev"))));
        add(new EntityMeta("derechopesca", "DERECHOPESCA", "Derechopesca", Derechopesca.class, Derechopesca.Pk.class, List.of(
                f("mesanio", "mesanio", "String", 6, true, true, false, "Mesanio"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, true, false, "Codi Unid Oper"),
                f("captura", "captura", "BigDecimal", 0, false, false, false, "Captura"),
                f("factor", "factor", "BigDecimal", 0, false, false, false, "Factor"),
                f("derecho", "derecho", "BigDecimal", 0, false, false, false, "Derecho"),
                f("porcentaje", "porcentaje", "BigDecimal", 0, false, false, false, "Porcentaje"),
                f("derechopor", "derechopor", "BigDecimal", 0, false, false, false, "Derechopor"),
                f("credito", "credito", "BigDecimal", 0, false, false, false, "Credito"),
                f("deducion", "deducion", "BigDecimal", 0, false, false, false, "Deducion"),
                f("total", "total", "BigDecimal", 0, false, false, false, "Total"),
                f("aplicar", "aplicar", "String", 1, false, false, false, "Aplicar"))));
        add(new EntityMeta("tanques", "TANQUES", "Tanques", Tanques.class, null, List.of(
                f("codiTanq", "codi_tanq", "String", 2, true, true, false, "Codi Tanq"),
                f("descTanq", "desc_tanq", "String", 50, true, false, false, "Desc Tanq"),
                f("stocTanq", "stoc_tanq", "BigDecimal", 0, false, false, false, "Stoc Tanq"),
                f("capaTanq", "capa_tanq", "BigDecimal", 0, false, false, false, "Capa Tanq"))));
        add(new EntityMeta("tanq_auxiliar", "TANQ_AUXILIAR", "Tanq Auxiliar", TanqAuxiliar.class, null, List.of(
                f("codiTanqAuxi", "codi_tanq_auxi", "String", 3, true, true, false, "Codi Tanq Auxi"),
                f("descTanqAuxi", "desc_tanq_auxi", "String", 50, true, false, false, "Desc Tanq Auxi"),
                f("stocTanqAuxi", "stoc_tanq_auxi", "BigDecimal", 0, false, false, false, "Stoc Tanq Auxi"))));
        add(new EntityMeta("talleres", "Talleres", "Talleres", Talleres.class, null, List.of(
                f("codiTall", "codi_tall", "String", 2, true, true, false, "Codi Tall"),
                f("nombre", "nombre", "String", 30, true, false, false, "Nombre"))));
        add(new EntityMeta("orden_produccion", "ORDEN_PRODUCCION", "Orden Produccion", OrdenProduccion.class, null, List.of(
                f("codiOrdeProduc", "codi_orde_produc", "Integer", 0, true, true, false, "Codi Orde Produc"),
                f("nroOrdeProduc", "nro_orde_produc", "Integer", 0, true, false, false, "Nro Orde Produc"),
                f("fechaOrdeProduc", "fecha_orde_produc", "LocalDateTime", 0, true, false, false, "Fecha Orde Produc"),
                f("codiClie", "codi_clie", "String", 5, true, false, false, "Codi Clie"),
                f("descripcion", "descripcion", "String", 200, true, false, false, "Descripcion"),
                f("nroOcClie", "nro_oc_clie", "String", 25, false, false, false, "Nro Oc Clie"),
                f("fechaEntrega", "fecha_entrega", "LocalDateTime", 0, true, false, false, "Fecha Entrega"),
                f("precUnit", "prec_unit", "BigDecimal", 0, true, false, false, "Prec Unit"),
                f("cantidad", "cantidad", "BigDecimal", 0, true, false, false, "Cantidad"),
                f("codiUnidMedi", "codi_unid_medi", "String", 2, false, false, false, "Codi Unid Medi"),
                f("tama1", "tama1", "BigDecimal", 0, false, false, false, "Tama1"),
                f("tama2", "tama2", "BigDecimal", 0, false, false, false, "Tama2"),
                f("codiUnidMedit", "codi_unid_medit", "String", 2, false, false, false, "Codi Unid Medit"),
                f("otrosAcabado", "otros_acabado", "String", 200, false, false, false, "Otros Acabado"),
                f("observaciones", "observaciones", "String", 800, false, false, false, "Observaciones"),
                f("codiUsua", "codi_usua", "String", 5, true, false, false, "Codi Usua"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("tipoPers", "tipo_pers", "String", 1, false, false, false, "Tipo Pers"),
                f("idClieNatu", "id_clie_natu", "Integer", 0, false, false, false, "Id Clie Natu"),
                f("codiMone", "codi_mone", "String", 2, true, false, false, "Codi Mone"),
                f("tama", "tama", "String", 25, false, false, false, "Tama"),
                f("nroordefisico", "nroordefisico", "Short", 0, false, false, false, "Nroordefisico"),
                f("otroMaterial", "otro_material", "String", 50, false, false, false, "Otro Material"),
                f("cliente", "cliente", "String", 75, false, false, false, "Cliente"),
                f("direccion", "direccion", "String", 75, false, false, false, "Direccion"),
                f("nroDocu", "nro_docu", "String", 20, false, false, false, "Nro Docu"),
                f("descripcionItem", "descripcion_item", "String", 1000, false, false, false, "Descripcion Item"),
                f("material", "material", "String", 200, false, false, false, "Material"),
                f("color", "color", "String", 200, false, false, false, "Color"),
                f("acabado", "acabado", "String", 200, false, false, false, "Acabado"),
                f("servProd", "serv_prod", "String", 1, false, false, false, "P producto , S servicio"),
                f("total", "total", "BigDecimal", 0, false, false, false, "Total"),
                f("codiTipoOp", "codi_tipo_op", "Integer", 0, false, false, false, "Codi Tipo Op"),
                f("aurtorizaPor", "aurtoriza_por", "String", 5, false, false, false, "Aurtoriza Por"),
                f("solicitadoPor", "solicitado_por", "String", 5, false, false, false, "Solicitado Por"))));
        add(new EntityMeta("embarcaciones", "EMBARCACIONES", "Embarcaciones", Embarcaciones.class, null, List.of(
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, true, false, "Codi Unid Oper"),
                f("descUnidOper", "desc_unid_oper", "String", 100, false, false, false, "Desc Unid Oper"),
                f("capaBode", "capa_bode", "BigDecimal", 0, false, false, false, "Capa Bode"),
                f("capaNeta", "capa_neta", "BigDecimal", 0, false, false, false, "Capa Neta"),
                f("nroMatri", "nro_matri", "String", 15, false, false, false, "Nro Matri"),
                f("lugaCons", "luga_cons", "String", 50, false, false, false, "Luga Cons"),
                f("porcDist", "porc_dist", "BigDecimal", 0, false, false, false, "Porc Dist"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("codiCaja", "codi_caja", "String", 10, false, false, false, "Codi Caja"),
                f("grupo", "grupo", "String", 10, false, false, false, "Grupo"),
                f("subsidio", "subsidio", "BigDecimal", 0, false, false, false, "Subsidio"),
                f("orden", "orden", "Short", 0, false, false, false, "Orden"),
                f("montoboni", "montoboni", "BigDecimal", 0, false, false, false, "Montoboni"),
                f("propTerc", "prop_terc", "String", 1, false, false, false, "Prop Terc"),
                f("nemoEmba", "nemo_emba", "String", 10, false, false, false, "Nemo Emba"),
                f("detra", "detra", "BigDecimal", 0, false, false, false, "Detra"),
                f("fechCese", "fech_cese", "LocalDateTime", 0, false, false, false, "Fech Cese"),
                f("arquBrut", "arqu_brut", "BigDecimal", 0, false, false, false, "Arqu Brut"),
                f("arquNeto", "arqu_neto", "BigDecimal", 0, false, false, false, "Arqu Neto"),
                f("mateCasc", "mate_casc", "String", 50, false, false, false, "Mate Casc"),
                f("coloCasc", "colo_casc", "String", 50, false, false, false, "Colo Casc"),
                f("mateSupeEstr", "mate_supe_estr", "String", 50, false, false, false, "Mate Supe Estr"),
                f("coloSupeEstr", "colo_supe_estr", "String", 50, false, false, false, "Colo Supe Estr"),
                f("montopatron", "montopatron", "BigDecimal", 0, false, false, false, "Montopatron"),
                f("codiMonePatron", "codi_mone_patron", "String", 2, false, false, false, "Codi Mone Patron"),
                f("montoSegundo", "monto_segundo", "BigDecimal", 0, false, false, false, "Monto Segundo"),
                f("codiMoneSegun", "codi_mone_segun", "String", 2, false, false, false, "Codi Mone Segun"),
                f("aplicaSegun", "aplica_segun", "String", 1, false, false, false, "Aplica Segun"),
                f("conserva", "conserva", "BigDecimal", 0, false, false, false, "Conserva"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("montoAdic", "monto_adic", "BigDecimal", 0, false, false, false, "Monto Adic"),
                f("codiMoneAdic", "codi_mone_adic", "String", 2, false, false, false, "Codi Mone Adic"),
                f("sunatAdic", "sunat_adic", "BigDecimal", 0, false, false, false, "Sunat Adic"),
                f("eslora", "eslora", "Long", 0, false, false, false, "Eslora"),
                f("manga", "manga", "Long", 0, false, false, false, "Manga"),
                f("puntual", "puntual", "Long", 0, false, false, false, "Puntual"),
                f("nroMampEstaTran", "nro_mamp_esta_tran", "Short", 0, false, false, false, "Nro Mamp Esta Tran"),
                f("nroCubiBajoCubi", "nro_cubi_bajo_cubi", "Short", 0, false, false, false, "Nro Cubi Bajo Cubi"),
                f("nroCubiSobrCubi", "nro_cubi_sobr_cubi", "Short", 0, false, false, false, "Nro Cubi Sobr Cubi"),
                f("nroMast", "nro_mast", "Short", 0, false, false, false, "Nro Mast"),
                f("nroBode", "nro_bode", "Short", 0, false, false, false, "Nro Bode"),
                f("nroCuad", "nro_cuad", "Short", 0, false, false, false, "Nro Cuad"),
                f("nroGrua", "nro_grua", "Short", 0, false, false, false, "Nro Grua"),
                f("formPopa", "form_popa", "String", 30, false, false, false, "Form Popa"),
                f("formProa", "form_proa", "String", 30, false, false, false, "Form Proa"),
                f("marcMoto", "marc_moto", "String", 30, false, false, false, "Marc Moto"),
                f("modeMoto", "mode_moto", "String", 30, false, false, false, "Mode Moto"),
                f("seriMoto", "seri_moto", "String", 30, false, false, false, "Seri Moto"),
                f("poteMoto", "pote_moto", "Long", 0, false, false, false, "Pote Moto"),
                f("unidMediPote", "unid_medi_pote", "String", 2, false, false, false, "Unid Medi Pote"),
                f("tipoComb", "tipo_comb", "String", 30, false, false, false, "Tipo Comb"),
                f("nroTanqComb", "nro_tanq_comb", "Short", 0, false, false, false, "Nro Tanq Comb"),
                f("capaTanqComb", "capa_tanq_comb", "Long", 0, false, false, false, "Capa Tanq Comb"),
                f("tipoAgua", "tipo_agua", "String", 30, false, false, false, "Tipo Agua"),
                f("nroTanqAgua", "nro_tanq_agua", "Short", 0, false, false, false, "Nro Tanq Agua"),
                f("capaTanqAgua", "capa_tanq_agua", "Long", 0, false, false, false, "Capa Tanq Agua"),
                f("nroMampEstaLong", "nro_mamp_esta_long", "Short", 0, false, false, false, "Nro Mamp Esta Long"))));
        add(new EntityMeta("embar_carac", "EMBAR_CARAC", "Embar Carac", EmbarCarac.class, null, List.of(
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, true, false, "Codi Unid Oper"),
                f("eslora", "eslora", "BigDecimal", 0, false, false, false, "Eslora"),
                f("manga", "manga", "BigDecimal", 0, false, false, false, "Manga"),
                f("puntual", "puntual", "BigDecimal", 0, false, false, false, "Puntual"),
                f("nroMampEstaTran", "nro_mamp_esta_tran", "Short", 0, false, false, false, "Nro Mamp Esta Tran"),
                f("nroMampEstaLong", "nro_mamp_esta_long", "Short", 0, false, false, false, "Nro Mamp Esta Long"),
                f("nroCubiBajoCubi", "nro_cubi_bajo_cubi", "Short", 0, false, false, false, "Nro Cubi Bajo Cubi"),
                f("nroCubiSobrCubi", "nro_cubi_sobr_cubi", "Short", 0, false, false, false, "Nro Cubi Sobr Cubi"),
                f("nroMast", "nro_mast", "Short", 0, false, false, false, "Nro Mast"),
                f("nroBode", "nro_bode", "Short", 0, false, false, false, "Nro Bode"),
                f("nroCuad", "nro_cuad", "Short", 0, false, false, false, "Nro Cuad"),
                f("nroGrua", "nro_grua", "Short", 0, false, false, false, "Nro Grua"),
                f("formPopa", "form_popa", "String", 30, false, false, false, "Form Popa"),
                f("formProa", "form_proa", "String", 30, false, false, false, "Form Proa"),
                f("marcMoto", "marc_moto", "String", 30, false, false, false, "Marc Moto"),
                f("modeMoto", "mode_moto", "String", 30, false, false, false, "Mode Moto"),
                f("seriMoto", "seri_moto", "String", 30, false, false, false, "Seri Moto"),
                f("poteMoto", "pote_moto", "BigDecimal", 0, false, false, false, "Pote Moto"),
                f("unidMediPote", "unid_medi_pote", "String", 2, false, false, false, "Unid Medi Pote"),
                f("tipoComb", "tipo_comb", "String", 30, false, false, false, "Tipo Comb"),
                f("nroTanqComb", "nro_tanq_comb", "Short", 0, false, false, false, "Nro Tanq Comb"),
                f("capaTanqComb", "capa_tanq_comb", "BigDecimal", 0, false, false, false, "Capa Tanq Comb"),
                f("tipoAgua", "tipo_agua", "String", 30, false, false, false, "Tipo Agua"),
                f("nroTanqAgua", "nro_tanq_agua", "Short", 0, false, false, false, "Nro Tanq Agua"),
                f("capaTanqAgua", "capa_tanq_agua", "BigDecimal", 0, false, false, false, "Capa Tanq Agua"))));
    }

    private void load1() {
        add(new EntityMeta("emba_venc_cert", "EMBA_VENC_CERT", "Emba Venc Cert", EmbaVencCert.class, null, List.of(
                f("codiVencCert", "codi_venc_cert", "String", 6, true, true, false, "Codi Venc Cert"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, false, false, false, "Codi Unid Oper"),
                f("codiTipoCert", "codi_tipo_cert", "String", 2, false, false, false, "Codi Tipo Cert"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, true, false, false, "Fech Inic"),
                f("fechTerm", "fech_term", "LocalDateTime", 0, false, false, false, "Fech Term"),
                f("periodo", "periodo", "String", 10, false, false, false, "Periodo"),
                f("observacion", "observacion", "String", 200, false, false, false, "Observacion"))));
        add(new EntityMeta("parte_cargo", "PARTE_CARGO", "Parte Cargo", ParteCargo.class, ParteCargo.Pk.class, List.of(
                f("codiCarg", "codi_carg", "String", 4, true, true, false, "Codi Carg"),
                f("fechAsig", "fech_asig", "LocalDateTime", 0, true, true, false, "Fech Asig"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, true, false, "Codi Unid Oper"),
                f("parte", "parte", "BigDecimal", 0, false, false, false, "Parte"),
                f("adicional", "adicional", "BigDecimal", 0, false, false, false, "Adicional"),
                f("espePart", "espe_part", "BigDecimal", 0, false, false, false, "Espe Part"),
                f("espeAdic", "espe_adic", "BigDecimal", 0, false, false, false, "Espe Adic"),
                f("empresa", "empresa", "BigDecimal", 0, false, false, false, "Empresa"))));
        add(new EntityMeta("taller_diario", "Taller_Diario", "Taller Diario", TallerDiario.class, TallerDiario.Pk.class, List.of(
                f("codiTall", "codi_tall", "String", 2, true, false, false, "Codi Tall"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, false, false, "Codi Unid Oper"),
                f("codiItem", "codi_item", "String", 3, true, true, false, "Codi Item"),
                f("fecha", "fecha", "LocalDateTime", 0, true, true, false, "Fecha"),
                f("descripcion", "descripcion", "String", 150, false, false, false, "Descripcion"),
                f("monto", "monto", "BigDecimal", 0, false, false, false, "Monto"))));
        add(new EntityMeta("ratio_produccion", "RATIO_PRODUCCION", "Ratio Produccion", RatioProduccion.class, null, List.of(
                f("codiRatiProd", "codi_rati_prod", "String", 10, true, true, false, "Codi Rati Prod"),
                f("codiTurn", "codi_turn", "String", 2, true, false, false, "Codi Turn"),
                f("codiRati", "codi_rati", "String", 2, true, false, false, "Codi Rati"),
                f("fechRatiProd", "fech_rati_prod", "LocalDateTime", 0, true, false, false, "Fech Rati Prod"),
                f("valoRatiProd", "valo_rati_prod", "BigDecimal", 0, true, false, false, "Valo Rati Prod"),
                f("codiUnidNego", "codi_unid_nego", "String", 2, false, false, false, "Codi Unid Nego"))));
        add(new EntityMeta("saldo_poza", "Saldo_Poza", "Saldo Poza", SaldoPoza.class, null, List.of(
                f("codiSaldPoza", "codi_sald_poza", "String", 10, true, true, false, "Codi Sald Poza"),
                f("codiTurn", "codi_turn", "String", 2, true, false, false, "Codi Turn"),
                f("codiPoza", "codi_poza", "String", 2, true, false, false, "Codi Poza"),
                f("saldAnte", "sald_ante", "BigDecimal", 0, false, false, false, "Sald Ante"),
                f("cantDescPoza", "cant_desc_poza", "BigDecimal", 0, false, false, false, "Cant Desc Poza"),
                f("consProd", "cons_prod", "BigDecimal", 0, false, false, false, "Cons Prod"),
                f("saldFina", "sald_fina", "BigDecimal", 0, false, false, false, "Sald Fina"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"))));
        add(new EntityMeta("zarpes", "ZARPES", "Zarpes", Zarpes.class, null, List.of(
                f("codiZarp", "codi_zarp", "String", 10, true, true, false, "Codi Zarp"),
                f("fechRepo", "fech_repo", "LocalDateTime", 0, false, false, false, "Fech Repo"),
                f("codiSema", "codi_sema", "String", 8, false, false, false, "Codi Sema"),
                f("fechDesc", "fech_desc", "LocalDateTime", 0, false, false, false, "Fech Desc"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, false, false, "Codi Unid Oper"),
                f("codiPuer", "codi_puer", "String", 2, false, false, false, "Codi Puer"),
                f("zonaPesc", "zona_pesc", "String", 75, false, false, false, "Zona Pesc"),
                f("fechZarp", "fech_zarp", "LocalDateTime", 0, false, false, false, "Fech Zarp"),
                f("fechArri", "fech_arri", "LocalDateTime", 0, false, false, false, "Fech Arri"),
                f("zonaArri", "zona_arri", "String", 75, false, false, false, "Zona Arri"),
                f("zonaPescArri", "zona_pesc_arri", "String", 75, false, false, false, "Zona Pesc Arri"),
                f("codiUnidMedi", "codi_unid_medi", "String", 2, false, false, false, "Codi Unid Medi"),
                f("pescEsti", "pesc_esti", "BigDecimal", 0, false, false, false, "Pesc Esti"),
                f("pescReal", "pesc_real", "BigDecimal", 0, false, false, false, "Pesc Real"),
                f("fechInicDesc", "fech_inic_desc", "LocalDateTime", 0, false, false, false, "Fech Inic Desc"),
                f("fechTermDesc", "fech_term_desc", "LocalDateTime", 0, false, false, false, "Fech Term Desc"),
                f("obsePesc", "obse_pesc", "String", 150, false, false, false, "Obse Pesc"),
                f("cordCapt", "cord_capt", "String", 25, false, false, false, "Cord Capt"),
                f("tempCapt", "temp_capt", "String", 20, false, false, false, "Temp Capt"),
                f("numeCala", "nume_cala", "Integer", 0, false, false, false, "Nume Cala"),
                f("fechPosiArri", "fech_posi_arri", "LocalDateTime", 0, false, false, false, "Fech Posi Arri"),
                f("codiPuer2", "codi_puer2", "String", 2, false, false, false, "Codi Puer2"),
                f("combReci", "comb_reci", "Long", 0, false, false, false, "Comb Reci"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("codiProvPetr", "codi_prov_petr", "String", 5, false, false, false, "Codi Prov Petr"),
                f("nroCgs", "nro_cgs", "String", 10, false, false, false, "Nro Cgs"),
                f("fechSgs", "fech_sgs", "LocalDateTime", 0, false, false, false, "Fech Sgs"),
                f("descSgs", "desc_sgs", "BigDecimal", 0, false, false, false, "Desc Sgs"),
                f("lugaDesc", "luga_desc", "String", 200, false, false, false, "Luga Desc"),
                f("obsePesc2", "obse_pesc2", "String", 250, false, false, false, "Obse Pesc2"),
                f("obsePesc3", "obse_pesc3", "String", 250, false, false, false, "Obse Pesc3"),
                f("lugaFond", "luga_fond", "String", 250, false, false, false, "Luga Fond"),
                f("codiPatr", "codi_patr", "String", 5, false, false, false, "Codi Patr"),
                f("oromMp", "orom_mp", "BigDecimal", 0, false, false, false, "Orom Mp"),
                f("oromMa1", "orom_ma1", "BigDecimal", 0, false, false, false, "Orom Ma1"),
                f("oromMa2", "orom_ma2", "BigDecimal", 0, false, false, false, "Orom Ma2"),
                f("codiSitu", "codi_situ", "String", 2, false, false, false, "Codi Situ"),
                f("pescTota", "pesc_tota", "BigDecimal", 0, false, false, false, "Pesc Tota"),
                f("codiSemaFact", "codi_sema_fact", "String", 8, false, false, false, "Codi Sema Fact"),
                f("codiSamaFact", "codi_sama_fact", "String", 8, false, false, false, "Codi Sama Fact"),
                f("refrigerada", "refrigerada", "String", 1, false, false, false, "Refrigerada"),
                f("conserva", "conserva", "String", 1, false, false, false, "Conserva"),
                f("fondeada", "fondeada", "Boolean", 0, false, false, false, "Fondeada"))));
        add(new EntityMeta("precio_snp", "PRECIO_SNP", "Precio Snp", PrecioSnp.class, null, List.of(
                f("codiPrec", "codi_prec", "String", 10, true, true, false, "Codi Prec"),
                f("codiSema", "codi_sema", "String", 8, true, false, false, "Codi Sema"),
                f("codiEspe", "codi_espe", "String", 2, false, false, false, "Codi Espe"),
                f("precio", "precio", "BigDecimal", 0, true, false, false, "Precio"),
                f("codiMone", "codi_mone", "String", 2, true, false, false, "Codi Mone"),
                f("jueves", "jueves", "BigDecimal", 0, false, false, false, "Jueves"),
                f("viernes", "viernes", "BigDecimal", 0, false, false, false, "Viernes"),
                f("sabado", "sabado", "BigDecimal", 0, false, false, false, "Sabado"),
                f("domingo", "domingo", "BigDecimal", 0, false, false, false, "Domingo"),
                f("lunes", "lunes", "BigDecimal", 0, false, false, false, "Lunes"),
                f("martes", "martes", "BigDecimal", 0, false, false, false, "Martes"),
                f("miercoles", "miercoles", "BigDecimal", 0, false, false, false, "Miercoles"))));
        add(new EntityMeta("saldo_tanques", "SALDO_TANQUES", "Saldo Tanques", SaldoTanques.class, null, List.of(
                f("codiSaldTanq", "codi_sald_tanq", "String", 10, true, true, false, "Codi Sald Tanq"),
                f("codiTanqAuxi", "codi_tanq_auxi", "String", 3, true, false, false, "Codi Tanq Auxi"),
                f("codiTurn", "codi_turn", "String", 2, true, false, false, "Codi Turn"),
                f("petrAnte", "petr_ante", "BigDecimal", 0, false, false, false, "Petr Ante"),
                f("petrIngr", "petr_ingr", "BigDecimal", 0, false, false, false, "Petr Ingr"),
                f("petrSali", "petr_sali", "BigDecimal", 0, false, false, false, "Petr Sali"),
                f("petrFina", "petr_fina", "BigDecimal", 0, false, false, false, "Petr Fina"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"))));
        add(new EntityMeta("consumo_combustible", "CONSUMO_COMBUSTIBLE", "Consumo Combustible", ConsumoCombustible.class, null, List.of(
                f("codiConsComb", "codi_cons_comb", "String", 5, true, true, false, "Codi Cons Comb"),
                f("codiUnidTran", "codi_unid_tran", "String", 4, false, false, false, "Codi Unid Tran"),
                f("anio", "anio", "String", 4, false, false, false, "Anio"),
                f("mes", "mes", "String", 2, false, false, false, "Mes"),
                f("kiloInic", "kilo_inic", "BigDecimal", 0, true, false, false, "Kilo Inic"),
                f("kiloFina", "kilo_fina", "BigDecimal", 0, true, false, false, "Kilo Fina"))));
        add(new EntityMeta("precio_pactado", "PRECIO_PACTADO", "Precio Pactado", PrecioPactado.class, PrecioPactado.Pk.class, List.of(
                f("codiSema", "codi_sema", "String", 8, true, true, false, "Codi Sema"),
                f("codiClieProv", "codi_clie_prov", "String", 5, true, true, false, "Codi Clie Prov"),
                f("codiEspe", "codi_espe", "String", 2, true, true, false, "Codi Espe"),
                f("precPact", "prec_pact", "BigDecimal", 0, false, false, false, "Prec Pact"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"))));
        add(new EntityMeta("detalle_zarpe", "DETALLE_ZARPE", "Detalle Zarpe", DetalleZarpe.class, null, List.of(
                f("codiDetaZarp", "codi_deta_zarp", "String", 15, true, true, false, "Codi Deta Zarp"),
                f("codiZarp", "codi_zarp", "String", 10, true, false, false, "Codi Zarp"),
                f("codiEspe", "codi_espe", "String", 2, true, false, false, "Codi Espe"),
                f("cantidad", "cantidad", "BigDecimal", 0, false, false, false, "Cantidad"),
                f("codiUnidMediCant", "codi_unid_medi_cant", "String", 2, false, false, false, "Codi Unid Medi Cant"),
                f("tamaMiniEspe", "tama_mini_espe", "BigDecimal", 0, false, false, false, "Tama Mini Espe"),
                f("tamaMaxiEspe", "tama_maxi_espe", "BigDecimal", 0, false, false, false, "Tama Maxi Espe"),
                f("codiUnidMediTama", "codi_unid_medi_tama", "String", 2, false, false, false, "Codi Unid Medi Tama"),
                f("codiClieProv", "codi_clie_prov", "String", 5, false, false, false, "Codi Clie Prov"),
                f("seriGuia", "seri_guia", "String", 5, false, false, false, "Seri Guia"),
                f("nroGuia", "nro_guia", "String", 10, false, false, false, "Nro Guia"),
                f("precPact", "prec_pact", "BigDecimal", 0, false, false, false, "Prec Pact"),
                f("tipoDocu", "tipo_docu", "String", 2, false, false, false, "Tipo Docu"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("incigv", "incigv", "String", 1, false, false, false, "Incigv"))));
        add(new EntityMeta("zarpe_combustible", "ZARPE_COMBUSTIBLE", "Zarpe Combustible", ZarpeCombustible.class, ZarpeCombustible.Pk.class, List.of(
                f("codiZarp", "codi_zarp", "String", 10, true, true, false, "Codi Zarp"),
                f("codiPetr", "codi_petr", "String", 3, true, true, false, "Codi Petr"),
                f("serFact", "ser_fact", "String", 5, false, false, false, "Ser Fact"),
                f("nroFact", "nro_fact", "String", 10, false, false, false, "Nro Fact"),
                f("cantPetr", "cant_petr", "BigDecimal", 0, false, false, false, "Cant Petr"),
                f("precPetr", "prec_petr", "BigDecimal", 0, false, false, false, "Prec Petr"),
                f("tipoDoc", "tipo_doc", "String", 1, false, false, false, "Tipo Doc"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"),
                f("valoVent", "valo_vent", "BigDecimal", 0, false, false, false, "Valo Vent"),
                f("igv", "igv", "BigDecimal", 0, false, false, false, "Igv"),
                f("valoTota", "valo_tota", "BigDecimal", 0, false, false, false, "Valo Tota"),
                f("codiMone", "codi_mone", "String", 2, false, false, false, "Codi Mone"),
                f("tc", "tc", "BigDecimal", 0, false, false, false, "Tc"))));
        add(new EntityMeta("orden_produccion_factura", "ORDEN_PRODUCCION_FACTURA", "Orden Produccion Factura", OrdenProduccionFactura.class, OrdenProduccionFactura.Pk.class, List.of(
                f("codiOrdeProduc", "codi_orde_produc", "Integer", 0, true, true, false, "Codi Orde Produc"),
                f("codiFact", "codi_fact", "Integer", 0, true, true, false, "Codi Fact"))));
        add(new EntityMeta("detalle_factura_pesca", "DETALLE_FACTURA_PESCA", "Detalle Factura Pesca", DetalleFacturaPesca.class, DetalleFacturaPesca.Pk.class, List.of(
                f("codiFactPesc", "codi_fact_pesc", "String", 10, true, true, false, "Codi Fact Pesc"),
                f("codiDetaZarp", "codi_deta_zarp", "String", 15, true, true, false, "Codi Deta Zarp"),
                f("cantTone", "cant_tone", "BigDecimal", 0, true, false, false, "Cant Tone"),
                f("precUnit", "prec_unit", "BigDecimal", 0, true, false, false, "Prec Unit"),
                f("subTota", "sub_tota", "BigDecimal", 0, true, false, false, "Sub Tota"))));
        add(new EntityMeta("analisis_parametro", "Analisis_Parametro", "Analisis Parametro", AnalisisParametro.class, AnalisisParametro.Pk.class, List.of(
                f("codAnalisis", "cod_analisis", "Long", 0, true, true, false, "Cod Analisis"),
                f("codParam", "cod_param", "Short", 0, true, true, false, "Cod Param"),
                f("valor", "valor", "BigDecimal", 0, false, false, false, "Valor"),
                f("estado", "estado", "Short", 0, false, false, false, "Estado"))));
    }

    @Override
    public String service() {
        return "produccion";
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
