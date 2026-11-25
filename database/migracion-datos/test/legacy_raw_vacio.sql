-- Solo para pruebas: recrea el esquema legacy_raw con TODAS las columnas del
-- legado como text y 0 filas, para verificar que 10-transform.sql es valido.
-- NO usar en produccion (ahi las tablas las crea pgloader con sus tipos reales).
DROP SCHEMA IF EXISTS legacy_raw CASCADE;
CREATE SCHEMA legacy_raw;

CREATE TABLE "legacy_raw"."activos" (
    "codi_activo" text,
    "descri_activo" text,
    "codi_grup" text,
    "nro_cuen" text,
    "fech_ingre" text,
    "nro_docu" text,
    "codi_clie_prov" text,
    "costo" text,
    "codi_mone" text,
    "codi_unid_oper" text,
    "tdat" text,
    "tdac" text,
    "mes" text,
    "anio" text,
    "codi_marca" text,
    "serie" text,
    "modelo" text,
    "anio_fabr" text,
    "matricula" text,
    "color" text,
    "capacidad" text,
    "ancho" text,
    "largo" text,
    "alto" text,
    "voltaje" text,
    "amperaje" text,
    "fecha_depre" text,
    "fecha_contrato" text,
    "nro_con_arre" text,
    "fecha_ini_arre" text,
    "nro_cuotas" text,
    "monto_arre" text,
    "fecha_retiro" text
);
CREATE TABLE "legacy_raw"."activos_centros" (
    "nro_cuen" text,
    "codi_cc" text
);
CREATE TABLE "legacy_raw"."agrupaciones" (
    "codi_grup" text,
    "desc_grup" text
);
CREATE TABLE "legacy_raw"."bien_servicio" (
    "codi_bien_serv" text,
    "desc_bien_serv" text,
    "nemo_bien_serv" text,
    "porc_bien_serv" text,
    "inicio" text,
    "fin" text
);
CREATE TABLE "legacy_raw"."cabecera_detraccion" (
    "codi_lote_detr" text,
    "nro_lote_detrac" text,
    "importe" text,
    "anio" text,
    "nro" text,
    "fech_gene" text,
    "mes" text
);
CREATE TABLE "legacy_raw"."catalmae" (
    "a" text,
    "codi_uo_catalmae" text
);
CREATE TABLE "legacy_raw"."centro_costo" (
    "codi_cc" text,
    "nombre_cc" text
);
CREATE TABLE "legacy_raw"."clase" (
    "cod_clase" text,
    "nomb_clase" text,
    "nomb_grupo" text,
    "estado" text,
    "unidad_negocio" text,
    "modalidad" text,
    "co_orde_serv" text
);
CREATE TABLE "legacy_raw"."clases_cuentas" (
    "codi_clas_cuen" text,
    "desc_clas_cuen" text,
    "a_p" text
);
CREATE TABLE "legacy_raw"."coef_liqu_imp" (
    "aniomes" text,
    "valor_renta" text,
    "fech_venc" text,
    "cfa" text,
    "otros_ma" text,
    "cerrado" text,
    "igv_5_ant" text,
    "igv_5_act" text,
    "igv_favor_ant" text,
    "perc_act" text,
    "perc_ant" text,
    "rete_act" text,
    "rete_ant" text,
    "factor_r3c" text,
    "saldo_r3c_ant" text,
    "itan" text,
    "bonifi" text,
    "cofigv" text,
    "porc" text,
    "cfn" text
);
CREATE TABLE "legacy_raw"."concepto_balance" (
    "codi_concepto" text,
    "desc_concepto" text,
    "cod_cta" text,
    "orden" text
);
CREATE TABLE "legacy_raw"."concepto_sunat" (
    "codi_concep_sunat" text,
    "desc_concep_sunat" text
);
CREATE TABLE "legacy_raw"."contabilizacion" (
    "codigo" text,
    "origen" text,
    "tipod" text,
    "descrip" text,
    "cuenta1" text,
    "ca1" text,
    "desc1" text,
    "cuenta2" text,
    "ca2" text,
    "desc2" text,
    "ctasunat" text,
    "cuenta3" text,
    "ca3" text,
    "desc3" text,
    "cuenta4" text,
    "ca4" text,
    "desc4" text,
    "cuenta5" text,
    "ca5" text,
    "desc5" text,
    "subdiario" text
);
CREATE TABLE "legacy_raw"."costo" (
    "codi_costo" text,
    "desc_costo" text
);
CREATE TABLE "legacy_raw"."cuen_x_tipo_cost" (
    "codi_tipo_cost" text,
    "nro_cuen" text
);
CREATE TABLE "legacy_raw"."cuentas_activos_prov" (
    "nro_cuen" text,
    "cuent_cargo" text,
    "cuent_abono" text
);
CREATE TABLE "legacy_raw"."cuentas_contable" (
    "nro_cuen" text,
    "desc_cuen" text,
    "nro_sub_cuen" text,
    "codi_lcc" text
);
CREATE TABLE "legacy_raw"."cuentas_costo" (
    "codi_cuen_cost" text,
    "codi_clas_cuen" text
);
CREATE TABLE "legacy_raw"."cuentas_gerencial" (
    "item" text,
    "nro_cuen" text,
    "resumen" text
);
CREATE TABLE "legacy_raw"."cuentas_partida" (
    "codi_partida" text,
    "descripcion" text,
    "tipo_cuen" text,
    "orden" text
);
CREATE TABLE "legacy_raw"."cuentas_partida_reporte" (
    "nro_cuen" text,
    "codi_partida" text
);
CREATE TABLE "legacy_raw"."cuentas_plan_prov" (
    "codi_item" text,
    "codi_unid_oper" text,
    "nro_cuen" text,
    "cargo" text,
    "grupo" text,
    "tipo_plan" text
);
CREATE TABLE "legacy_raw"."cuentas_plan_prov_concep" (
    "codi_item" text,
    "codi_deta" text,
    "codi_conc" text,
    "codi_conc_fin" text
);
CREATE TABLE "legacy_raw"."cuentas_provision" (
    "codigo" text,
    "descripcion" text,
    "cuenta" text,
    "codi_unid_oper" text
);
CREATE TABLE "legacy_raw"."cuentas_reporte" (
    "tipo_cuen" text,
    "descripcion" text,
    "orden" text,
    "codi_grupo" text
);
CREATE TABLE "legacy_raw"."decl_diar_arri" (
    "codi_decl_diar_arri" text,
    "nume_arri" text,
    "fecha" text,
    "codi_unid_oper" text,
    "nro_matri" text,
    "codi_decl_diar_zarp" text,
    "codi_puer_arri" text,
    "fech_arri" text,
    "zona_pesc" text,
    "latitud" text,
    "longitud" text,
    "tiempo" text,
    "tiem_nave" text,
    "codi_espe_1" text,
    "codi_espe_2" text,
    "codi_espe_3" text,
    "cant_espe_1" text,
    "cant_espe_2" text,
    "cant_espe_3" text,
    "codi_plan_desc" text,
    "codi_plan_comp" text,
    "obse_1" text,
    "obse_2" text,
    "obse_3" text,
    "obse_4" text,
    "obse_5" text,
    "obse_6" text,
    "obse_7" text,
    "obse_8" text,
    "codi_patr" text
);
CREATE TABLE "legacy_raw"."decl_diar_zarp" (
    "codi_decl_diar_zarp" text,
    "nume_decl" text,
    "fecha" text,
    "codi_unid_oper" text,
    "nro_matri" text,
    "arqu_brut" text,
    "codi_puer_capi" text,
    "zona_pesc" text,
    "tiem_oper" text,
    "fech_esti_arri" text,
    "codi_usua_repr" text,
    "fech_venc_matr" text,
    "fech_venc_lmc" text,
    "fech_venc_comp_comp" text,
    "fech_venc_radi_bali" text,
    "fech_venc_segu" text,
    "fech_venc_hidr_carb" text,
    "fech_venc_agua_suci" text,
    "codi_patr" text
);
CREATE TABLE "legacy_raw"."decl_diar_zarp_deta" (
    "codi_decl_diar_zarp" text,
    "nro_item" text,
    "codi_pers" text,
    "nro_matr_pers" text,
    "fin_vige_matr" text,
    "codi_carg" text
);
CREATE TABLE "legacy_raw"."decl_zarp_trim" (
    "codi_zarp_trim" text,
    "nume_zarp" text,
    "fecha" text,
    "fech_inic_vige" text,
    "fech_fin_vige" text,
    "codi_unid_oper" text,
    "nro_matri" text,
    "arqu_brut" text,
    "arqu_neto" text,
    "codi_puer_capi" text,
    "codi_usua_repr" text,
    "nro_trip" text,
    "fech_venc_matr" text,
    "fech_venc_arqu" text,
    "fech_venc_lmc" text,
    "fech_venc_comp_comp" text,
    "fech_venc_radi_bali" text,
    "fech_venc_segu" text,
    "fech_venc_hidr_carb" text,
    "fech_venc_agua_suci" text,
    "codi_patr" text,
    "colo_casc" text,
    "colo_supe_estr" text
);
CREATE TABLE "legacy_raw"."decl_zarp_trim_deta" (
    "codi_zarp_trim" text,
    "nro_item" text,
    "codi_pers" text,
    "nro_matr_pers" text,
    "fin_vige_matr" text,
    "codi_carg" text,
    "codi_titu" text
);
CREATE TABLE "legacy_raw"."declara_jurada" (
    "codi_decla" text,
    "codi_pers" text,
    "codi_alma" text,
    "fecha_decla" text,
    "direccion" text,
    "lugar" text
);
CREATE TABLE "legacy_raw"."declara_jurada_caja" (
    "codi_decla" text,
    "fecha_caja" text,
    "monto_caja" text,
    "codi_mone" text
);
CREATE TABLE "legacy_raw"."declara_jurada_merca" (
    "codi_decla" text,
    "codi_lin" text,
    "monto_linea" text
);
CREATE TABLE "legacy_raw"."detalle_calc_af" (
    "codi_activo" text,
    "fecha_detalle" text,
    "fecha_activo" text,
    "costo_hist" text,
    "costo_ajus" text,
    "depre_hist_ant" text,
    "depre_hist_act" text,
    "depre_ajus_act" text,
    "depre_ajus_ant" text,
    "depre_acum_hist" text,
    "depre_acum_ajus" text,
    "neto_hist" text,
    "neto_ajus" text,
    "origen" text,
    "retirado" text,
    "valor_depre" text
);
CREATE TABLE "legacy_raw"."detalle_detraccion" (
    "codi_lote_detr" text,
    "nro_detalle" text,
    "codi_clie_prov" text,
    "nro_proforma" text,
    "codi_bien_serv" text,
    "codi_cta_cte" text,
    "importe_deposito" text,
    "codi_oper" text,
    "nro_cta_cte" text,
    "codi_fact" text,
    "codi_tipo_docu" text,
    "serie" text,
    "nro_docu" text,
    "registro" text,
    "fecha_spot" text,
    "num_spot" text
);
CREATE TABLE "legacy_raw"."dif_camb" (
    "codi_cuenta" text,
    "cta_gasto" text,
    "cta_ingreso" text
);
CREATE TABLE "legacy_raw"."eeff" (
    "cod_esta" text,
    "des_esta" text
);
CREATE TABLE "legacy_raw"."elemento_costo" (
    "codi_elem_costo" text,
    "desc_elem_costo" text,
    "nemo" text,
    "codi_tipo_gast" text,
    "uso" text
);
CREATE TABLE "legacy_raw"."estados_financieros" (
    "id" text,
    "descripcion" text,
    "orden" text,
    "tipo" text
);
CREATE TABLE "legacy_raw"."estados_financieros_detalle" (
    "id" text,
    "nro_cuen" text,
    "orden" text
);
CREATE TABLE "legacy_raw"."gasto_operativo" (
    "codi_gasto" text,
    "anio" text,
    "mes" text,
    "valor" text
);
CREATE TABLE "legacy_raw"."gerencial_repo" (
    "id_gere" text,
    "desc_gere" text
);
CREATE TABLE "legacy_raw"."gerencial_repo_tipo_cuen" (
    "id_gere" text,
    "id_tipo" text,
    "nro_cuen" text
);
CREATE TABLE "legacy_raw"."gerencial_repo_tipos" (
    "id_gere" text,
    "id_tipo" text,
    "desc_tipo_repo" text
);
CREATE TABLE "legacy_raw"."glosas" (
    "glosa" text
);
CREATE TABLE "legacy_raw"."libro_diario_s" (
    "cuenta" text,
    "tipo" text
);
CREATE TABLE "legacy_raw"."libro_registro" (
    "codi_libro_regi" text,
    "desc_libro_regi" text
);
CREATE TABLE "legacy_raw"."linea_clase_c" (
    "codi_lcc" text,
    "desc_lcc" text,
    "td" text,
    "codi_subc_4" text
);
CREATE TABLE "legacy_raw"."m_cuentas_contable" (
    "ide" text,
    "nro_cuen" text,
    "desc_cuen" text,
    "nro_sub_cuen" text,
    "codi_lcc" text,
    "cta_6" text,
    "tipo_cuen" text,
    "codi_mone" text,
    "nro_cta_cte_banc" text,
    "codi_banc" text,
    "codi_tipo_cuen_banc" text,
    "porc_detr" text,
    "transfer" text,
    "cta_cierre" text,
    "tipo_costo" text
);
CREATE TABLE "legacy_raw"."m_linea_clase_c" (
    "ide" text,
    "codi_lcc" text,
    "desc_lcc" text,
    "codi_subc" text,
    "td" text
);
CREATE TABLE "legacy_raw"."m_sub_clas_cuen" (
    "ide" text,
    "codi_subc" text,
    "desc_subc" text,
    "codi_clas_cuen" text
);
CREATE TABLE "legacy_raw"."movi_contables" (
    "codi_contable" text,
    "anio" text,
    "mes" text,
    "subdia" text,
    "compr" text,
    "codi_mone" text,
    "fecha" text,
    "nro_cuen" text,
    "nro_sub_cuen" text,
    "codi_clie_prov" text,
    "serie" text,
    "nro_docu" text,
    "codi_tipo_docu" text,
    "importe" text,
    "igv" text,
    "otros" text,
    "total" text,
    "importe_d" text,
    "igv_d" text,
    "otros_d" text,
    "total_d" text,
    "registro" text,
    "codi_unid_oper" text,
    "glosa" text,
    "cargo_abono" text,
    "fecha_venc" text,
    "tipo_cambio" text,
    "situ_cheq" text,
    "tipo_cambio_2" text,
    "codi_vouc" text,
    "fecha_spot" text,
    "num_spot" text,
    "codi_pers" text,
    "codi_sema" text,
    "codi_nota_ingr" text,
    "nro_orde_comp" text,
    "nro_orde_pedi" text,
    "codi_pres" text,
    "nro_presu" text,
    "banco" text,
    "cartera" text,
    "hecho_por" text,
    "itf" text,
    "compensa" text,
    "detraccion" text,
    "fech_pago" text,
    "ref" text,
    "nro_fact" text,
    "codi_memo" text,
    "tipo_movi" text,
    "codi_desti" text,
    "codi_tasa_detr" text,
    "retencion" text,
    "codi_ingr" text,
    "codi_alma" text,
    "codi_tipo_intan" text,
    "codi_aduana" text,
    "anio_dua_dsi" text,
    "nro_detrac" text,
    "fecha_detrac" text,
    "fecha_nd_nc" text,
    "tipo_docu_nd_nc" text,
    "serie_nd_nc" text,
    "nro_docu_nd_nc" text,
    "tipo_venta" text,
    "codi_libro_regi" text,
    "codi_tipo_medio_pago" text,
    "banco_aux" text,
    "fecha_creacion" text,
    "estado_inic" text,
    "creacion" text,
    "id_flujo" text,
    "id_tipo_flujo" text,
    "codi_oper" text,
    "codi_bien_serv" text,
    "pdetr" text,
    "valor_refe" text,
    "placa" text,
    "nro_refe" text
);
CREATE TABLE "legacy_raw"."operac_sunat_ple" (
    "id_sec" text,
    "anio" text,
    "mes" text,
    "compr" text,
    "anio_regis" text,
    "mes_regis" text,
    "subdia_regis" text,
    "estado" text
);
CREATE TABLE "legacy_raw"."operaciones" (
    "codi_oper" text,
    "desc_oper" text,
    "nemo_oper" text
);
CREATE TABLE "legacy_raw"."plecompras" (
    "columna 0" text,
    "columna 1" text,
    "columna 2" text,
    "columna 3" text,
    "columna 4" text,
    "columna 5" text,
    "columna 6" text,
    "columna 7" text,
    "columna 8" text,
    "columna 9" text,
    "columna 10" text,
    "columna 11" text,
    "columna 12" text,
    "columna 13" text,
    "columna 14" text,
    "columna 15" text,
    "columna 16" text,
    "columna 17" text,
    "columna 18" text,
    "columna 19" text,
    "columna 20" text,
    "columna 21" text,
    "columna 22" text,
    "columna 23" text,
    "columna 24" text,
    "columna 25" text,
    "columna 26" text,
    "columna 27" text,
    "columna 28" text,
    "columna 29" text,
    "columna 30" text,
    "columna 31" text,
    "columna 32" text,
    "columna 33" text,
    "columna 34" text,
    "columna 35" text,
    "columna 36" text,
    "columna 37" text,
    "columna 38" text,
    "columna 39" text,
    "columna 40" text,
    "columna 41" text
);
CREATE TABLE "legacy_raw"."punto_equilibrio" (
    "mesanio" text,
    "costo_fijo" text,
    "costo_vari" text,
    "costo_tota" text,
    "toneladas" text,
    "ventas" text,
    "costo_vari_uni" text,
    "precio_vari_unit" text,
    "peunidades" text,
    "peventas" text,
    "marg_segu" text
);
CREATE TABLE "legacy_raw"."ratios" (
    "codi_rati" text,
    "desc_rati" text
);
CREATE TABLE "legacy_raw"."reporte_eeff" (
    "codi_repo" text,
    "desc_repo" text
);
CREATE TABLE "legacy_raw"."reporte_eeff_grupo" (
    "codi_grupo" text,
    "desc_grupo" text,
    "codi_repo" text,
    "orden" text
);
CREATE TABLE "legacy_raw"."retencion" (
    "serie" text,
    "num" text,
    "subdia" text,
    "compr" text,
    "mes" text,
    "anio" text,
    "banco" text,
    "monto" text,
    "anulado" text,
    "fecha" text
);
CREATE TABLE "legacy_raw"."sald_tota_c" (
    "codi_tota" text,
    "anio" text,
    "mes" text,
    "nro_cuen" text,
    "desc_cuen" text,
    "importe_c" text,
    "importe_a" text,
    "importe_d_c" text,
    "importe_d_a" text
);
CREATE TABLE "legacy_raw"."sald_tota_c_p" (
    "codi_tota" text,
    "anio" text,
    "mes" text,
    "nro_cuen" text,
    "codi_clie_prov" text,
    "desc_cuen" text,
    "ruc_prov" text,
    "desc_prov" text,
    "importe_c" text,
    "importe_a" text,
    "importe_d_c" text,
    "importe_d_a" text
);
CREATE TABLE "legacy_raw"."sald_tota_c_uo" (
    "codi_tota" text,
    "anio" text,
    "mes" text,
    "nro_cuen" text,
    "codi_unid_oper" text,
    "desc_cuen" text,
    "desc_unid_oper" text,
    "importe_c" text,
    "importe_a" text,
    "importe_d_c" text,
    "importe_d_a" text
);
CREATE TABLE "legacy_raw"."sald_tota_c_uo_p" (
    "codi_tota" text,
    "anio" text,
    "mes" text,
    "nro_cuen" text,
    "codi_unid_oper" text,
    "codi_clie_prov" text,
    "desc_cuen" text,
    "desc_unid_oper" text,
    "ruc_prov" text,
    "desc_prov" text,
    "importe_c" text,
    "importe_a" text,
    "importe_d_c" text,
    "importe_d_a" text
);
CREATE TABLE "legacy_raw"."saldos_cuentas" (
    "mesanio" text,
    "nro_cuen" text,
    "saldoant" text,
    "cargo" text,
    "abono" text,
    "saldonue" text,
    "cargoacum" text,
    "abonoacum" text
);
CREATE TABLE "legacy_raw"."sub_clas_cuen" (
    "codi_subc" text,
    "desc_subc" text,
    "codi_clas_cuen" text
);
CREATE TABLE "legacy_raw"."sub_clase" (
    "cod_clase" text,
    "cod_subclase" text,
    "nomb_subclase" text,
    "id_bien_detraccion" text,
    "tasa_detraccion" text,
    "unidad_negocio" text,
    "unidad" text,
    "flag_cargo_directo" text
);
CREATE TABLE "legacy_raw"."sub_clase_cont_4" (
    "codi_subc_4" text,
    "desc_sub_4" text,
    "codi_subc" text
);
CREATE TABLE "legacy_raw"."sub_concepto_sunat" (
    "codi_sub_concep" text,
    "desc_sub_concep_sunat" text,
    "codi_concep_sunat" text
);
CREATE TABLE "legacy_raw"."subdiario" (
    "codi_subd" text,
    "nemotec" text,
    "descrip" text,
    "orden" text,
    "central" text,
    "codi_libro" text
);
CREATE TABLE "legacy_raw"."sunat" (
    "codi_sunat" text,
    "nro_cuen" text
);
CREATE TABLE "legacy_raw"."sunat_f318" (
    "id_tipo_flujo" text,
    "id_flujo" text,
    "desc_acti" text,
    "desc_flujo" text,
    "subdia" text,
    "orden" text
);
CREATE TABLE "legacy_raw"."tipo_afecta_igv" (
    "codi_tipo_afec" text,
    "desc_tipo_afec" text,
    "tipo_afec" text,
    "cod_imp" text
);
CREATE TABLE "legacy_raw"."tipo_comprobante" (
    "codi_compr" text,
    "desc_compr" text
);
CREATE TABLE "legacy_raw"."tipo_cost_gene" (
    "codi_tipo_cost_gene" text,
    "desc_tipo_cost_gene" text,
    "nemo" text,
    "orden" text
);
CREATE TABLE "legacy_raw"."tipo_costo" (
    "codi_tipo_cost" text,
    "desc_tipo_cost" text,
    "nemo" text,
    "orden" text,
    "cf_cv" text,
    "tcg" text
);
CREATE TABLE "legacy_raw"."tipo_eeff" (
    "codi_tipo_eeff" text,
    "desc_tipo_eeff" text,
    "nemo_tipo_eeff" text
);
CREATE TABLE "legacy_raw"."tipo_form_most_eeff" (
    "codi_tipo_eeff" text,
    "codi_clas_cuen" text,
    "tipo_form_most" text
);
CREATE TABLE "legacy_raw"."tipo_form_prov_plan" (
    "codi_tipo_prov" text,
    "desc_tipo_prov" text
);
CREATE TABLE "legacy_raw"."tipo_gasto" (
    "codi_tipo_gast" text,
    "desc_tipo_gast" text
);
CREATE TABLE "legacy_raw"."tipo_impuestos" (
    "cod_imp" text,
    "desc_imp" text
);
CREATE TABLE "legacy_raw"."tipo_intangible" (
    "codi_tipo_intan" text,
    "desc_tipo_intan" text
);
CREATE TABLE "legacy_raw"."anticipos" (
    "codi_anti" text,
    "porcentaje" text,
    "fech_anti" text,
    "codi_tipo_docu_pago" text,
    "nro_docu" text,
    "codi_clie_prov" text,
    "codi_tipo_docu_soli" text
);
CREATE TABLE "legacy_raw"."anticipos_documento_compra" (
    "codi_anti" text,
    "codi_tipo_docu" text,
    "codi_docu_cv" text
);
CREATE TABLE "legacy_raw"."bancos" (
    "codi_banc" text,
    "desc_banc" text,
    "dire_banc" text,
    "tele_banc" text,
    "fax_banc" text,
    "nemo" text,
    "codi_clie_prov" text,
    "codi_sunat" text,
    "tea_cts" text,
    "tea_cts_dola" text
);
CREATE TABLE "legacy_raw"."bancos_cheques" (
    "nro_cuen" text,
    "codi_mone" text,
    "nro_talon" text,
    "nro_inic_cheq" text,
    "nro_fin_cheq" text,
    "cant_cheq" text,
    "codi_usua" text,
    "cant_cheq_gira" text,
    "cant_cheq_anul" text,
    "cant_cheq_sald" text,
    "fecha" text,
    "cheq_ulti" text,
    "situ_cheq" text
);
CREATE TABLE "legacy_raw"."bancos_disponible" (
    "id_sec" text,
    "fecha" text,
    "nro_cuen" text,
    "contable_s" text,
    "contable_d" text,
    "disponible_s" text,
    "disponible_d" text
);
CREATE TABLE "legacy_raw"."bancos_disponible_deta" (
    "id_sec" text,
    "id_conc" text,
    "monto_s" text,
    "monto_d" text
);
CREATE TABLE "legacy_raw"."bancos_saldos" (
    "nro_cuen" text,
    "anio" text,
    "codi_mone" text,
    "sald_00" text,
    "sald_01" text,
    "sald_02" text,
    "sald_03" text,
    "sald_04" text,
    "sald_05" text,
    "sald_06" text,
    "sald_07" text,
    "sald_08" text,
    "sald_09" text,
    "sald_10" text,
    "sald_11" text,
    "sald_12" text,
    "saldb_00" text
);
CREATE TABLE "legacy_raw"."caja_chica" (
    "codi_alma" text,
    "nro_recibo" text,
    "fecha" text,
    "tipo_io" text,
    "codi_mone" text,
    "codi_clie_prov" text,
    "glosa" text,
    "codi_tipo_docu" text,
    "serie" text,
    "nro_docu" text,
    "tipo_contab" text,
    "importe" text,
    "codi_usua_soli" text,
    "prov_canc" text,
    "hora_real" text,
    "codi_unid_oper" text,
    "placa_carreta" text,
    "rendir" text,
    "nro_recibo_aux" text,
    "codi_liqu" text,
    "importe_s" text,
    "ruta_de" text,
    "ruta_a" text,
    "fecha_docu" text,
    "placa" text,
    "galones" text,
    "km_ini" text,
    "km_fin" text,
    "fecha_vence" text,
    "dscto_adm" text,
    "hecho_por" text,
    "estado" text,
    "activo" text
);
CREATE TABLE "legacy_raw"."caja_chica_depo" (
    "codi_depo" text,
    "codi_docu" text,
    "tipo_rela" text,
    "codi_tipo_docu" text,
    "ser_fact" text,
    "nro_fact" text,
    "tota_fact" text,
    "importe" text,
    "grupo" text
);
CREATE TABLE "legacy_raw"."caja_cierre" (
    "codi_alma" text,
    "fecha" text
);
CREATE TABLE "legacy_raw"."cheques" (
    "codi_cheq" text,
    "nro_cheq" text,
    "nro_cuen" text,
    "codi_clie_prov" text,
    "fecha" text,
    "importe" text,
    "estado" text
);
CREATE TABLE "legacy_raw"."conci_banco" (
    "codi_conc_banc" text,
    "nro_cuen" text,
    "anio" text,
    "mes" text,
    "codi_mone" text,
    "subdia" text,
    "compr" text,
    "fecha" text,
    "codi_tipo_docu" text,
    "nro_docu" text,
    "codi_clie_prov" text,
    "glosa" text,
    "importe" text,
    "saldo" text,
    "codi_tipo_situ_conc_banc" text,
    "cargo_abono" text,
    "anio_docu" text,
    "mes_docu" text,
    "codi_contable" text
);
CREATE TABLE "legacy_raw"."cta_cte_personal" (
    "codi_cta_cte" text,
    "codi_pers" text,
    "nro_cuen" text,
    "codi_banc" text,
    "nro_cta_cte" text,
    "codi_mone" text,
    "tipo_cta_cte" text,
    "tipo_cta_banc" text
);
CREATE TABLE "legacy_raw"."cta_cte_prov" (
    "codi_cta_cte" text,
    "codi_clie_prov" text,
    "codi_banc" text,
    "nro_cta_cte" text,
    "codi_mone" text,
    "tipo_cta_banc" text,
    "obse" text,
    "detraccion" text
);
CREATE TABLE "legacy_raw"."depositos" (
    "codi_depo" text,
    "nro_cuen" text,
    "codi_alma" text,
    "nro_oper" text,
    "fecha" text,
    "codi_respo" text,
    "codi_usua_soli" text,
    "codi_mone" text,
    "importe" text,
    "glosa" text,
    "fecha_depo" text,
    "estado" text,
    "tipo" text,
    "creacion" text,
    "codi_vouc" text,
    "hecho_por" text
);
CREATE TABLE "legacy_raw"."documento_garantia" (
    "codi_docg" text,
    "doc_garantia" text
);
CREATE TABLE "legacy_raw"."escribalo" (
    "codi_escr" text,
    "fecha" text,
    "nro_escr" text,
    "anio" text,
    "inic" text,
    "de" text,
    "para" text,
    "asunto" text,
    "codi_usua_gene" text,
    "fech_inic" text,
    "fech_fin" text
);
CREATE TABLE "legacy_raw"."escribalo_deta" (
    "codi_escr" text,
    "codi_contable" text,
    "fecha" text,
    "regb" text,
    "codi_vouc" text,
    "codi_rela" text,
    "codi_mone" text,
    "importe" text,
    "esta" text,
    "codi_agru" text,
    "nro_docu" text,
    "subdia" text,
    "codi_tipo_docu" text
);
CREATE TABLE "legacy_raw"."letra_calculo" (
    "codi_letra" text,
    "anio" text,
    "codi_contable" text,
    "nro_cuen_banco" text,
    "nro_cuen_amor" text,
    "nro_cuen_inte" text,
    "fech_venc" text,
    "importe_amor" text,
    "importe_inte" text,
    "tipo_situ" text,
    "observacion" text,
    "fecha" text,
    "tipo" text,
    "saldo" text,
    "codi_mone" text
);
CREATE TABLE "legacy_raw"."letras_productos" (
    "registro" text,
    "codi_prod" text,
    "cantidad" text
);
CREATE TABLE "legacy_raw"."pagos_juicios" (
    "codi_juic" text,
    "nro_pago" text,
    "fech_pago" text,
    "codi_mone" text,
    "monto" text,
    "observacion" text
);
CREATE TABLE "legacy_raw"."polizas" (
    "codi_poli" text,
    "descripcion" text,
    "tipo" text,
    "codi_clie_prov" text,
    "codi_unid_oper" text,
    "fech_adqui" text,
    "fech_vigen" text,
    "n_meses_pago" text,
    "dia_pago" text,
    "codi_mone" text,
    "monto_mensual" text,
    "dias_aviso" text
);
CREATE TABLE "legacy_raw"."pres_grup" (
    "codi_grup" text,
    "desc_grup" text
);
CREATE TABLE "legacy_raw"."pres_pago" (
    "codi_pres" text,
    "desc_pres" text,
    "codi_grup" text
);
CREATE TABLE "legacy_raw"."presupuesto" (
    "codi_presu" text,
    "desc_presu" text,
    "fecha" text,
    "nro_cuen" text
);
CREATE TABLE "legacy_raw"."recibo_egreso" (
    "codi_recibo" text,
    "fecha_recibo" text,
    "fecha" text,
    "nro_cuen" text,
    "nro_docu" text,
    "importe" text,
    "importe_d" text,
    "glosa" text,
    "tipo_cambio" text,
    "codi_pers" text,
    "codi_orde_comp" text
);
CREATE TABLE "legacy_raw"."registro_pagos" (
    "id_sec" text,
    "fecha_reg" text,
    "numero" text,
    "documento" text,
    "medio_pago" text,
    "cuota" text,
    "codi_clie_prov" text,
    "concepto" text,
    "codigo" text,
    "fecha" text,
    "codi_mone" text,
    "importe" text,
    "comentario" text,
    "fecha_pago" text,
    "observaciones" text,
    "activo" text,
    "condicion" text,
    "codi_clie_pers" text,
    "clie_pers" text
);
CREATE TABLE "legacy_raw"."rubros_caja" (
    "id_rubro" text,
    "desc_rubro" text,
    "i_o" text
);
CREATE TABLE "legacy_raw"."rubros_caja_detalle" (
    "id_rubro" text,
    "tipo_reemb" text,
    "i_o" text,
    "codi_alma" text
);
CREATE TABLE "legacy_raw"."sald_conc_banc" (
    "codi_sald_banc" text,
    "anio" text,
    "mes" text,
    "nro_cuen" text,
    "sald_libr" text,
    "esta_cuen" text,
    "sald_ante" text
);
CREATE TABLE "legacy_raw"."saldo_bancos" (
    "fecha" text,
    "nro_cuen" text,
    "codi_mone" text,
    "saldo" text
);
CREATE TABLE "legacy_raw"."saldo_moneda" (
    "id" text,
    "fecha" text,
    "moneda" text,
    "cant_s" text,
    "cant_d" text,
    "codi_alma" text
);
CREATE TABLE "legacy_raw"."seguros" (
    "codi_segu" text,
    "desc_segu" text,
    "codi_clie_prov" text
);
CREATE TABLE "legacy_raw"."tipo_cta" (
    "cod_cta" text,
    "desc_cta" text,
    "grupo" text,
    "orden" text,
    "descgrupo" text
);
CREATE TABLE "legacy_raw"."tipo_cta_banc" (
    "codi_tipo_cuen_banc" text,
    "desc_tipo_cuen_banc" text,
    "nemo" text,
    "nro_cero_tc" text,
    "tipo_cuen_tc" text
);
CREATE TABLE "legacy_raw"."tipo_cta_cte" (
    "codi_tipo_cta_cte" text,
    "desc_tipo_cta_cte" text,
    "nemo_tipo_cta_cte" text
);
CREATE TABLE "legacy_raw"."tipo_form_pago" (
    "codi_form_pago" text,
    "desc_form_pago" text,
    "nemo_form_pago" text,
    "codi_tipo_pago" text
);
CREATE TABLE "legacy_raw"."tipo_medio_pago" (
    "codi_tipo_medio_pago" text,
    "codi_sunat" text,
    "desc_tipo_medio_pago" text,
    "nemo" text
);
CREATE TABLE "legacy_raw"."tipo_reembolso" (
    "tipo_reemb" text,
    "desc_reemb" text,
    "cta_con" text,
    "cta_sin" text,
    "estado" text,
    "codi_alma" text
);
CREATE TABLE "legacy_raw"."tipo_reembolso_almacen" (
    "tipo_reemb" text,
    "codi_alma" text
);
CREATE TABLE "legacy_raw"."tipo_situ_cheq" (
    "codi_situ_cheq" text,
    "desc_situ_cheq" text,
    "tipo_situ_letra" text
);
CREATE TABLE "legacy_raw"."tipo_situ_conc_banc" (
    "codi_tipo_situ_conc_banc" text,
    "desc_tipo_situ_conc_banc" text,
    "simb_tipo_situ_conc_banc" text
);
CREATE TABLE "legacy_raw"."tipos_pago_warrant" (
    "codi_tpago" text,
    "desc_tipo" text,
    "nemo_tipo" text
);
CREATE TABLE "legacy_raw"."warrant_control" (
    "codi_warr" text,
    "fecha" text,
    "almacenera" text,
    "banco_nro" text,
    "codi_banc" text,
    "codi_alma" text,
    "nro_warr" text,
    "tm_alma" text,
    "ingr_warr" text,
    "sali_cant" text,
    "stock" text,
    "valor_warr" text,
    "i_o" text,
    "codi_mone" text,
    "tpc" text,
    "disponible" text,
    "periodo" text,
    "broker" text,
    "comprador" text,
    "fecha_emba" text,
    "codi_tpago" text,
    "num_pago" text,
    "valor_fina" text,
    "tm_cred" text,
    "valor_cred" text
);
CREATE TABLE "legacy_raw"."warrant_pagos" (
    "codi_pwarr" text,
    "nro_warr" text,
    "fecha_pago" text,
    "canti_cancel" text,
    "monto_paga" text,
    "periodo" text
);
CREATE TABLE "legacy_raw"."acabado" (
    "codi_acab" text,
    "desc_acab" text,
    "nemo_aca" text
);
CREATE TABLE "legacy_raw"."aceptacion_lista_reque" (
    "codi_deta_list_requ" text,
    "codi_pers" text,
    "aceptacion" text,
    "nro_jera" text,
    "fech_acep" text,
    "cantidad" text
);
CREATE TABLE "legacy_raw"."almacen" (
    "codi_alma" text,
    "desc_alma" text,
    "direccion" text,
    "telefono" text,
    "nemo_alma" text,
    "ubicacion" text,
    "tipo" text,
    "codi_luga" text,
    "codi_clie_prov" text,
    "codi_alma_princi" text,
    "codi_unid_oper" text,
    "nro_cuen" text,
    "representante" text,
    "nro_cuen_d" text,
    "distrito" text,
    "correo" text,
    "ruta" text,
    "impresora" text,
    "codi_alma_desc" text,
    "codigo_estable" text,
    "activo" text,
    "codigo_ubigeo" text,
    "dist_alma" text
);
CREATE TABLE "legacy_raw"."almacen_doc_regularizar" (
    "idd_sec" text,
    "codi_alma" text,
    "codi_tipo_docu" text,
    "serie_alma" text,
    "nro_docu_empieza" text,
    "fecha" text,
    "creacion" text
);
CREATE TABLE "legacy_raw"."almacen_producto" (
    "codi_alma" text,
    "codi_prod" text,
    "prec_costo" text,
    "stock_alma" text,
    "stock_min_alma" text,
    "stock_temp_alma" text,
    "prec_prom_alma" text,
    "prec_porc_uti_men" text,
    "prec_porc_uti_may" text,
    "prec_porc_uti_esp" text,
    "prec" text
);
CREATE TABLE "legacy_raw"."almacen_usuario" (
    "codi_alma" text,
    "codi_usua" text
);
CREATE TABLE "legacy_raw"."almacenes" (
    "codi_alma" text,
    "desc_alma" text,
    "ubic_alma" text
);
CREATE TABLE "legacy_raw"."ccnu_clases" (
    "codi_clas" text,
    "codi_fami" text,
    "desc_clas" text
);
CREATE TABLE "legacy_raw"."ccnu_familias" (
    "codi_fami" text,
    "cod_seg" text,
    "desc_fami" text
);
CREATE TABLE "legacy_raw"."ccnu_productos" (
    "codi_prod_sunat" text,
    "codi_clas" text,
    "desc_prod_sunat" text
);
CREATE TABLE "legacy_raw"."ccnu_segmentos" (
    "cod_seg" text,
    "desc_seg" text
);
CREATE TABLE "legacy_raw"."color" (
    "codi_color" text,
    "desc_color" text
);
CREATE TABLE "legacy_raw"."compromisos_pactados" (
    "codi_comp" text,
    "nro_comp" text,
    "fecha" text,
    "codi_alma" text,
    "codi_clie_prov" text,
    "tipo" text,
    "observaciones" text,
    "fecha_venc" text,
    "lugar" text,
    "codi_mone" text
);
CREATE TABLE "legacy_raw"."compromisos_pactados_deta" (
    "codi_comp" text,
    "codi_deta" text,
    "codi_prod" text,
    "cantidad" text,
    "p_unit" text,
    "total" text
);
CREATE TABLE "legacy_raw"."control_problemas" (
    "id_control" text,
    "nro_control" text,
    "fecha" text,
    "descripcion" text,
    "hecho_por" text
);
CREATE TABLE "legacy_raw"."control_problemas_detalle" (
    "id_control" text,
    "id_sec" text,
    "id_sub_fami_prod" text,
    "opcion" text,
    "dosis" text
);
CREATE TABLE "legacy_raw"."cotizacion_de_pedidos" (
    "codi_coti" text,
    "fech_coti" text,
    "tiem_plaz_cred" text,
    "codi_unid_medi" text,
    "estado" text,
    "codi_mone" text,
    "prec_tota_coti" text,
    "codi_orde_pedi" text,
    "codi_list_requ_orig" text
);
CREATE TABLE "legacy_raw"."cotizacion_deta" (
    "codi_coti" text,
    "codi_deta" text,
    "codi_prod" text,
    "cantidad" text,
    "stock" text,
    "p_unit" text,
    "total" text
);
CREATE TABLE "legacy_raw"."detalle_cotizacion_pedido" (
    "codi_deta_coti" text,
    "codi_coti" text,
    "codi_prod" text,
    "cantidad" text,
    "codi_unid_medi_tiem" text,
    "tiem_resp" text,
    "codi_mone" text,
    "prec_unit" text
);
CREATE TABLE "legacy_raw"."detalle_docu_sali" (
    "codi_deta_docu_sali" text,
    "codi_docu_sali" text,
    "nro_cuen" text,
    "codi_prod" text,
    "cantidad" text,
    "prec_costo" text,
    "prec_prom" text,
    "stoc_sali" text,
    "fech_ulti_sali" text,
    "cant_ulti_sali" text,
    "codi_orde_pedi" text,
    "codi_unid_oper" text,
    "codi_alma" text,
    "codi_alma_desti" text,
    "codi_deta_orde_pedi" text,
    "prec_kard" text,
    "concen_iqf" text,
    "prodserviqf" text,
    "canti_prodserviqf" text,
    "um_prodserviqf" text,
    "deseiqf" text,
    "canti_deseiqf" text,
    "um_deseiqf" text,
    "canti_rhpm_iqf" text,
    "um_rhpm_iqf" text,
    "moti_rhpm_iqf" text,
    "observaciones" text,
    "prec_unit" text,
    "nro_cuen_ni" text
);
CREATE TABLE "legacy_raw"."detalle_listarequerimientos" (
    "codi_deta_list_requ" text,
    "codi_list_requ" text,
    "codi_prod" text,
    "cantidad" text,
    "nro_cuen" text,
    "stoc_ulti" text,
    "stoc_temp_ulti" text,
    "ulti_prec" text,
    "codi_mone_ulti_prec" text,
    "cuen_cost" text,
    "fech_ulti_requ" text,
    "codi_unid_oper" text,
    "codi_alma" text
);
CREATE TABLE "legacy_raw"."detalle_nota_ingreso" (
    "codi_nota_ingr" text,
    "nro_item_nota_ingr" text,
    "codi_prod" text,
    "cantidad" text,
    "codi_mone" text,
    "prec_unit" text,
    "codi_unid_oper" text,
    "nro_cuen" text,
    "prec_kard" text,
    "stoc_ulti" text,
    "stoc_temp_ulti" text,
    "prec_ulti" text,
    "porc_detr" text,
    "codi_deta_orde_comp" text,
    "codi_mone_ulti_prec" text,
    "codi_alma" text,
    "codi_deta_orde_pedi" text,
    "codi_tipo_enva" text,
    "num_enva" text,
    "exceso" text,
    "faltante" text,
    "observaciones" text,
    "concen_iqf" text,
    "dscto_porcentaje" text,
    "prec_compra" text,
    "tipo_compra" text
);
CREATE TABLE "legacy_raw"."detalle_orden_compra" (
    "codi_deta_orde_comp" text,
    "codi_orde_comp" text,
    "codi_prod" text,
    "cantidad" text,
    "precio" text,
    "codi_mone" text,
    "nro_cuen" text,
    "tipo_desc" text,
    "descuento" text,
    "prec_orig" text,
    "codi_deta_orde_pedi" text,
    "codi_unid_oper" text,
    "codi_alma" text,
    "proc_pedi" text,
    "fecha_venc" text,
    "tipo_compra" text,
    "codi_unid_medi_orde" text,
    "tipo_prod" text
);
CREATE TABLE "legacy_raw"."detalle_orden_compra_distribucion" (
    "codi_orde_comp" text,
    "codi_prod" text,
    "codi_alma" text,
    "cantidad" text
);
CREATE TABLE "legacy_raw"."detalle_orden_de_pedido" (
    "codi_deta_orde_pedi" text,
    "codi_orde_pedi" text,
    "codi_prod" text,
    "cantidad" text,
    "nro_cuen" text,
    "estado" text,
    "prec_prom" text,
    "prec_ulti" text,
    "codi_mone_prec_ulti" text,
    "codi_clie_prov_ulti" text,
    "stoc_ulti" text,
    "stoc_temp_ulti" text,
    "nro_ulti_sali" text,
    "fech_ulti_sali" text,
    "cant_ulti_sali" text,
    "cons_prom" text,
    "cuen_cost" text,
    "luga_aten" text,
    "codi_unid_oper" text,
    "codi_alma" text,
    "prec_venta" text
);
CREATE TABLE "legacy_raw"."detalle_orden_servicio" (
    "codi_deta_orde_comp" text,
    "codi_orde_comp" text,
    "codi_prod" text,
    "desc_serv" text,
    "cantidad" text,
    "precio" text,
    "codi_mone" text,
    "nro_cuen" text,
    "tipo_desc" text,
    "descuento" text,
    "prec_orig" text,
    "codi_deta_orde_pedi" text,
    "codi_unid_medi" text,
    "codi_unid_oper" text
);
CREATE TABLE "legacy_raw"."detalle_salida_materiales" (
    "codi_deta_docu_sali" text,
    "codi_docu_sali" text,
    "nro_cuen" text,
    "codi_prod" text,
    "desc_prod" text,
    "codi_unid_medi_prod" text,
    "cantidad" text,
    "peso" text,
    "codi_unid_medi_peso" text,
    "codi_unid_oper" text,
    "con_reto" text,
    "indi_reto" text,
    "codi_deta_orig" text,
    "tipo_orig" text,
    "codi_alma" text
);
CREATE TABLE "legacy_raw"."docu_sali_mate" (
    "codi_docu_sali" text,
    "codi_unid_oper_rece" text,
    "codi_tipo_docu_sali" text,
    "codi_orde_pedi" text,
    "codi_pers_emis" text,
    "codi_pers_rece" text,
    "fech_emis" text,
    "codi_turn" text,
    "codi_unid_nego" text,
    "codi_clie_prov" text,
    "nro_seri_docu_sali" text,
    "nro_docu_sali" text,
    "motivo" text,
    "observacion" text,
    "tipo_sali" text,
    "tipo_dest" text,
    "codi_pers_reci_mate" text,
    "moti_sali" text,
    "codi_puer_sali" text,
    "estado" text,
    "viveres" text,
    "codi_emba" text,
    "codi_sema_pesc" text,
    "nro_sali" text,
    "kilometraje" text,
    "kilo_mill" text,
    "codi_alma" text,
    "codi_alma_desti" text,
    "codi_fact" text,
    "condicion" text,
    "fech_reg_fact" text,
    "codi_tipo_docu_cont" text,
    "nro_seri_docu_cont" text,
    "nro_docu_cont" text,
    "importe" text,
    "igv" text,
    "prec_tota" text,
    "contab" text
);
CREATE TABLE "legacy_raw"."docu_sali_x_orde_pedi" (
    "codi_docu_sali" text,
    "codi_orde_pedi" text
);
CREATE TABLE "legacy_raw"."familia_producto" (
    "codi_fami_prod" text,
    "desc_fami_prod" text,
    "prod_serv" text,
    "nro_cuen" text,
    "cod_lin_pro" text
);
CREATE TABLE "legacy_raw"."kardex" (
    "codi_kard" text,
    "codi_prod" text,
    "codi_tipo_docu" text,
    "nro_seri" text,
    "nro_docu" text,
    "codi_unid_oper_soli" text,
    "codi_unid_oper_dest" text,
    "codi_cuen" text,
    "fech_tran" text,
    "cant_ingr" text,
    "cant_sali" text,
    "cant_saldo" text,
    "cant_saldo_alma" text,
    "prec_unit" text,
    "prec_prom" text,
    "prec_prom_alma" text,
    "valo_ingr" text,
    "valo_sali" text,
    "valo_saldo" text,
    "valo_ingr_alma" text,
    "valo_sali_alma" text,
    "valo_saldo_alma" text,
    "codi_mone" text,
    "tipo_camb" text,
    "i_o" text,
    "codi_docu_i_o" text,
    "concepto" text,
    "nro_guia" text,
    "periodo" text,
    "estado" text,
    "item" text,
    "codi_alma" text,
    "prodserviqf" text,
    "canti_prodserviqf" text,
    "um_prodserviqf" text,
    "deseiqf" text,
    "canti_deseiqf" text,
    "um_deseiqf" text,
    "canti_rhpm_iqf" text,
    "um_rhpm_iqf" text,
    "moti_rhpm_iqf" text,
    "creacion" text
);
CREATE TABLE "legacy_raw"."kardex_almacenes" (
    "codigo" text,
    "codi_transa" text,
    "codi_alma" text,
    "item" text,
    "codi_prod" text,
    "i_o" text,
    "cantidad" text,
    "precio" text,
    "total" text,
    "codi_unid_medi" text,
    "codi_mone" text,
    "tipo_cambio" text,
    "ingr_cant" text,
    "sali_cant" text,
    "prec_unit" text,
    "prec_prom" text,
    "stock" text,
    "ingr_valo" text,
    "egre_valo" text,
    "saldo_valo" text,
    "periodo" text,
    "fecha" text,
    "exonerado" text,
    "igv" text,
    "venta" text,
    "valorigv" text,
    "nro_cuen" text,
    "productor" text,
    "acidez" text,
    "cantcolpex" text,
    "entradafisico" text,
    "salidafisico" text,
    "promfisico" text,
    "stockfisico" text,
    "ingresofisico" text,
    "egresofisico" text,
    "saldofisico" text,
    "transporte" text,
    "placa" text,
    "ticket" text,
    "codi_tipo_docu" text,
    "serguia" text,
    "nroguia" text,
    "codi_moti_tras" text,
    "nro_vales" text,
    "indice_rela" text,
    "codi_tipo_enva" text,
    "num_enva" text,
    "exceso" text,
    "faltante" text,
    "observaciones" text,
    "concen_iqf" text,
    "prodserviqf" text,
    "canti_prodserviqf" text,
    "um_prodserviqf" text,
    "deseiqf" text,
    "canti_deseiqf" text,
    "um_deseiqf" text,
    "canti_rhpm_iqf" text,
    "um_rhpm_iqf" text,
    "moti_rhpm_iqf" text
);
CREATE TABLE "legacy_raw"."kit_deta" (
    "codi_kit_inte" text,
    "nro_item" text,
    "codi_prod" text,
    "cantidad" text
);
CREATE TABLE "legacy_raw"."kits" (
    "codi_kit_inte" text,
    "codi_kit_marc" text,
    "desc_kit" text,
    "marc_kit" text,
    "abre_kit" text
);
CREATE TABLE "legacy_raw"."linea_familia_pro" (
    "cod_lin_pro" text,
    "des_lin_pro" text
);
CREATE TABLE "legacy_raw"."lista_de_requerimientos" (
    "codi_list_requ" text,
    "fech_list_requ" text,
    "codi_pers_resp" text,
    "estado" text,
    "codi_unid_oper_soli" text,
    "codi_unid_oper_dest" text,
    "pedi_trab" text,
    "motivo" text,
    "tipo_uso" text,
    "mant_acti" text,
    "observacion" text,
    "observacion_2" text,
    "observacion_3" text,
    "observacion_4" text,
    "observacion_5" text,
    "prio" text,
    "codi_alma" text
);
CREATE TABLE "legacy_raw"."lote_situacion" (
    "id_situ" text,
    "descripcion" text
);
CREATE TABLE "legacy_raw"."marca" (
    "codi_marca" text,
    "desc_marca" text
);
CREATE TABLE "legacy_raw"."material" (
    "codi_material" text,
    "desc_material" text
);
CREATE TABLE "legacy_raw"."nota_ingr_por_orde_comp" (
    "codi_orde_comp" text,
    "codi_nota_ingr" text
);
CREATE TABLE "legacy_raw"."nota_ingreso" (
    "codi_nota_ingr" text,
    "codi_clie_prov" text,
    "codi_tipo_docu" text,
    "nro_seri" text,
    "nro_docu" text,
    "codi_unid_oper_soli" text,
    "codi_unid_oper_dest" text,
    "fech_nota_ingr" text,
    "tipo_nota_ingr" text,
    "importe" text,
    "codi_pers_vist_buen" text,
    "codi_pers_elab" text,
    "codi_mone" text,
    "prec_tota" text,
    "observaciones" text,
    "codi_turn" text,
    "codi_unid_nego" text,
    "nro_seri_docu_cont" text,
    "nro_docu_cont" text,
    "codi_tipo_docu_cont" text,
    "fech_guia_remi" text,
    "fech_reg_fact" text,
    "fech_proceso" text,
    "contab" text,
    "tipo_camb" text,
    "afecto" text,
    "estado" text,
    "codi_sema" text,
    "prov_pesc" text,
    "viveres" text,
    "codi_emba" text,
    "nro_nota_ingr" text,
    "igv" text,
    "otro_afec" text,
    "otro_no_afec" text,
    "codi_alma" text,
    "codi_alma_desti" text,
    "codi_docu_sali" text,
    "codi_transportista" text,
    "registro" text,
    "fech_venc_fact" text,
    "codi_chof" text,
    "codi_alma_dest" text
);
CREATE TABLE "legacy_raw"."orde_serv_x_proy" (
    "codi_orde_comp" text,
    "codi_proy" text
);
CREATE TABLE "legacy_raw"."orden_compra_detalle" (
    "codi_orde" text,
    "item" text,
    "codi_prod" text,
    "cantidad" text,
    "precio" text,
    "codi_unid_medi" text,
    "total" text,
    "nro_cuen" text,
    "saldo" text,
    "igv" text,
    "venta" text,
    "valorigv" text,
    "estado" text,
    "codi_alma" text,
    "exonerado" text,
    "acidez" text,
    "serguia" text,
    "nroguia" text,
    "transporte" text,
    "placa" text,
    "codi_moti_tras" text,
    "pesocolp" text,
    "ticket" text
);
CREATE TABLE "legacy_raw"."orden_compra_pedido_cotiza" (
    "codi_orde_comp" text,
    "codi_docu" text,
    "codi_tipo_docu" text
);
CREATE TABLE "legacy_raw"."orden_de_compra" (
    "codi_orde_comp" text,
    "codi_clie_prov" text,
    "fecha" text,
    "estado" text,
    "codi_mone" text,
    "importe" text,
    "codi_unid_oper_soli" text,
    "codi_unid_oper_dest" text,
    "cond_pago" text,
    "fech_entr" text,
    "luga_entr" text,
    "codi_unid_medi" text,
    "tiem_plaz_cred" text,
    "atencion" text,
    "nro_coti" text,
    "tipo_desc" text,
    "descuento" text,
    "sub_tota" text,
    "codi_tipo_docu_cont" text,
    "igv" text,
    "rent_cuar_cate" text,
    "ies" text,
    "total" text,
    "pedi_trab" text,
    "detraccion" text,
    "tota_detr" text,
    "nro_orde_comp" text,
    "contab" text,
    "tipo_gene" text,
    "obse_1" text,
    "obse_2" text,
    "obse_3" text,
    "obse_4" text,
    "obse_5" text,
    "obse_6" text,
    "obse_7" text,
    "obse_8" text,
    "obse_9" text,
    "obse_10" text,
    "valo_vent" text,
    "nro_guia" text,
    "nro_fact" text,
    "afec_rete" text,
    "hech_por" text,
    "modi_por" text,
    "auto_por" text,
    "soli_por" text,
    "nro_pres" text,
    "desc_cond_pago" text,
    "nro_seri" text,
    "codi_alma" text,
    "otro_no_afec" text,
    "codi_bien_serv" text,
    "porc_detra" text,
    "apro_por" text,
    "codi_ofi" text,
    "anulado" text,
    "motivo" text,
    "fech_docu_cont" text,
    "anio" text,
    "factor" text,
    "nro_comp" text,
    "codi_trans" text,
    "dias" text,
    "codi_luga" text
);
CREATE TABLE "legacy_raw"."orden_de_pedido" (
    "codi_orde_pedi" text,
    "fech_pedi" text,
    "estado" text,
    "codi_list_requ" text,
    "observacion" text,
    "observacion_2" text,
    "observacion_3" text,
    "observacion_4" text,
    "observacion_5" text,
    "nro_orde_pedi" text,
    "pedi_trab" text,
    "codi_pers_resp" text,
    "codi_unid_oper_soli" text,
    "codi_unid_oper_dest" text,
    "motivo" text,
    "tipo_uso" text,
    "mant_acti" text,
    "prio" text,
    "codi_alma" text
);
CREATE TABLE "legacy_raw"."orden_despacho_combustible" (
    "codi_orden_des" text,
    "nro_orden_des" text,
    "codi_orden_soli" text,
    "tipo" text,
    "fecha" text,
    "codi_mone" text,
    "codi_clie_prov" text,
    "elabora_por" text,
    "autoriza_por" text
);
CREATE TABLE "legacy_raw"."orden_despacho_combustible_deta" (
    "codi_orden_des" text,
    "codi_deta" text,
    "codi_tracto" text,
    "codi_trans" text,
    "codi_prod" text,
    "cantidad" text,
    "precio" text,
    "importe" text,
    "valor" text
);
CREATE TABLE "legacy_raw"."prec_prom_inve" (
    "prod" text,
    "precio" text
);
CREATE TABLE "legacy_raw"."presentacion" (
    "cod_pres" text,
    "desc_pres" text,
    "um" text
);
CREATE TABLE "legacy_raw"."principio_activo" (
    "codi_prin" text,
    "descripcion" text
);
CREATE TABLE "legacy_raw"."principio_x_producto" (
    "codi_prod" text,
    "sec" text,
    "codi_prin" text
);
CREATE TABLE "legacy_raw"."producto_almacen_lote" (
    "codi_prod_alma_lote" text,
    "codi_alma" text,
    "codi_prod" text,
    "lote" text,
    "fec_vence" text,
    "stock" text,
    "ubicacion" text,
    "condicion" text,
    "situacion" text,
    "fech_vence_real" text,
    "p_arreglo" text,
    "s_arreglo" text,
    "iden" text,
    "codi_orde_comp" text,
    "correlativo" text,
    "canti_salida_venta" text,
    "fec_ingreso" text
);
CREATE TABLE "legacy_raw"."producto_almacen_lote_pedido" (
    "id" text,
    "codi_prod_alma_lote" text,
    "codi_alma" text,
    "codi_prod" text,
    "lote" text,
    "fec_vence" text,
    "stock" text,
    "ubicacion" text,
    "condicion" text,
    "situacion" text,
    "codi_orden_pedi" text,
    "canti_salida_venta" text
);
CREATE TABLE "legacy_raw"."productos" (
    "codi_prod" text,
    "desc_prod" text,
    "codi_sub_fami_prod" text,
    "codi_unid_medi" text,
    "codi_mone" text,
    "prec_prom" text,
    "stock" text,
    "stoc_mini" text,
    "stoc_maxi" text,
    "punt_repe" text,
    "fech_venc" text,
    "esta_prod" text,
    "stoc_temp" text,
    "ubicacion" text,
    "nro_cuen" text,
    "iqf" text,
    "porc_detr" text,
    "poli_prec" text,
    "exonerado" text,
    "prec_list_1" text,
    "prec_list_2" text,
    "cost_prod" text,
    "analisis" text,
    "material" text,
    "codi_clie_prov" text,
    "cod_pres" text,
    "fec_registro" text,
    "prec_prov" text,
    "descto_compra" text,
    "descto_porcenta" text,
    "cod_impuesto" text,
    "tcambio" text,
    "nro_decim_precio" text,
    "costo_oper" text,
    "codi_aux" text,
    "id_tipocomi" text,
    "codi_tipo_exis" text,
    "peso" text,
    "rotacion" text,
    "codi_prod_sunat" text,
    "esta_acti" text
);
CREATE TABLE "legacy_raw"."productos_baja" (
    "id_ven" text,
    "codi_prod" text,
    "codi_rota" text
);
CREATE TABLE "legacy_raw"."productos_baja_rotacion" (
    "codi_rota" text,
    "descripcion" text
);
CREATE TABLE "legacy_raw"."productos_eventos" (
    "codi_prod" text,
    "codi_alma" text,
    "fecha" text,
    "evento" text,
    "tipo" text,
    "hecho_por" text,
    "activo" text
);
CREATE TABLE "legacy_raw"."productos_lotes_ingre_sali" (
    "codi_deta_ingre_sali" text,
    "codi_prod_alma_lote" text,
    "cantidad" text,
    "io" text,
    "codi_ingr_sali" text
);
CREATE TABLE "legacy_raw"."productos_lotes_nota_venta" (
    "codi_deta_ingre_sali" text,
    "codi_prod_alma_lote" text,
    "cantidad" text,
    "codi_nota_venta" text
);
CREATE TABLE "legacy_raw"."productos_lotes_vale_cred" (
    "codi_deta_ingre_sali" text,
    "codi_prod_alma_lote" text,
    "cantidad" text,
    "codi_vale" text
);
CREATE TABLE "legacy_raw"."productos_matriz" (
    "id_mat" text,
    "codi_prod" text,
    "codi_rota" text,
    "fecha" text
);
CREATE TABLE "legacy_raw"."productos_precio" (
    "codi_item" text,
    "codi_deta_nota_ingr" text,
    "codi_prod" text,
    "precio" text
);
CREATE TABLE "legacy_raw"."productos_sin_venta" (
    "fecha" text,
    "codi_prod" text,
    "desc_prod" text,
    "codi_alma" text,
    "ultimaventa" text,
    "plazo" text,
    "diassinventa" text,
    "observaciones" text,
    "codi_usua" text,
    "creacion" text
);
CREATE TABLE "legacy_raw"."proveedor_productos" (
    "codi_clie_prov" text,
    "codi_fami_prod" text
);
CREATE TABLE "legacy_raw"."proyecto" (
    "codi_proy" text,
    "desc_proy" text,
    "fech_proy" text
);
CREATE TABLE "legacy_raw"."registro_orden_pedido" (
    "codi_orden_pedi" text,
    "codi_pers_resp" text,
    "codi_unid_oper_soli" text,
    "codi_unid_oper_dest" text,
    "motivo" text,
    "observacion" text,
    "codi_guia" text,
    "fecha" text,
    "estado" text,
    "envio" text,
    "apro_por" text,
    "libe_por" text,
    "codi_alma_orig" text,
    "super_por" text
);
CREATE TABLE "legacy_raw"."registro_orden_pedido_deta" (
    "codi_orden_pedi" text,
    "codi_deta" text,
    "codi_prod" text,
    "cantidad" text,
    "cantidad_aux" text
);
CREATE TABLE "legacy_raw"."registro_producto" (
    "codi_regi_prod" text,
    "cultivo" text,
    "area" text,
    "codi_alma" text,
    "cod_zona" text,
    "cod_cultivo" text
);
CREATE TABLE "legacy_raw"."registro_producto_deta" (
    "codi_regi_prod" text,
    "codi_deta" text,
    "codi_prod" text,
    "cantidad" text,
    "q1_1" text,
    "q2_1" text,
    "q1_2" text,
    "q2_2" text,
    "q1_3" text,
    "q2_3" text,
    "q1_4" text,
    "q2_4" text,
    "q1_5" text,
    "q2_5" text,
    "q1_6" text,
    "q2_6" text,
    "nro_diacult" text,
    "cod_eta" text,
    "enfermedades" text
);
CREATE TABLE "legacy_raw"."sali_mate_x_docu_sali" (
    "codi_docu_sali_mate" text,
    "codi_docu_sali" text,
    "tipo_docu_orig_sali" text
);
CREATE TABLE "legacy_raw"."sali_mate_x_proy" (
    "codi_docu_sali" text,
    "codi_proy" text
);
CREATE TABLE "legacy_raw"."salida_material" (
    "codi_docu_sali" text,
    "nro_seri" text,
    "nro_docu_sali" text,
    "codi_tipo_docu" text,
    "fech_emis" text,
    "fech_inic_tras" text,
    "codi_domi_part" text,
    "domi_part_dist" text,
    "domi_part_prov" text,
    "domi_part_depa" text,
    "domi_part_dire" text,
    "dest_codi_clie_prov" text,
    "dest_apel_o_razo_soci" text,
    "dest_dire" text,
    "dest_iden" text,
    "dest_tipo_docu_iden" text,
    "codi_domi_lleg" text,
    "domi_lleg_dist" text,
    "domi_lleg_prov" text,
    "domi_lleg_depa" text,
    "domi_lleg_dire" text,
    "codi_unid_tran" text,
    "codi_trans" text,
    "codi_tipo_docu_comp_pago" text,
    "comp_pago_seri" text,
    "comp_pago_nro" text,
    "codi_moti_tras" text,
    "moti_tras_desc" text,
    "codi_mone_cost" text,
    "cost_mini" text,
    "codi_unid_medi_peso" text,
    "peso_tota" text,
    "estado" text,
    "tipo_gene" text,
    "codi_pers_emit_guia" text,
    "codi_pers_reci_guia" text,
    "apel_1_reci_guia" text,
    "apel_2_reci_guia" text,
    "nomb_1_reci_guia" text,
    "nomb_2_reci_guia" text,
    "codi_unid_oper_rece" text,
    "observacion" text,
    "moti_sali" text,
    "apel_1_chof" text,
    "apel_2_chof" text,
    "nomb_1_chof" text,
    "nomb_2_chof" text,
    "lice_cond_chof" text,
    "dni_chof" text,
    "con_reto" text,
    "indi_reto" text,
    "indi_devo_mate_emba" text,
    "cimt" text,
    "codi_alma" text,
    "marca_transpo" text,
    "nro_placa_transpo" text,
    "empre_trans_razo_soci" text,
    "empre_trans_ruc" text,
    "empre_trans_domici" text
);
CREATE TABLE "legacy_raw"."sub_familia_producto" (
    "codi_sub_fami_prod" text,
    "desc_sub_fami_prod" text,
    "codi_fami_prod" text,
    "poli_prec_adic" text
);
CREATE TABLE "legacy_raw"."tipo_aceptacion" (
    "codi_tipo_acep" text,
    "desc_acep_requ" text,
    "nemo" text
);
CREATE TABLE "legacy_raw"."tipo_envases" (
    "codi_tipo_enva" text,
    "desc_emva" text
);
CREATE TABLE "legacy_raw"."tipo_existencia" (
    "codi_tipo_exis" text,
    "codi_sunat" text,
    "desc_tipo_exis" text,
    "nemo" text
);
CREATE TABLE "legacy_raw"."tipo_ingr_sali" (
    "codi_tipo_is" text,
    "desc_tipo_is" text,
    "nemo_tipo_is" text,
    "i_s" text,
    "codi_sunat_moti_tras" text,
    "desc_sunat_moti_tras" text,
    "contabilizar" text,
    "nro_cuen" text
);
CREATE TABLE "legacy_raw"."unid_oper_divi" (
    "codi_divi_unid_oper" text,
    "desc_divi_unid_oper" text,
    "codi_tipo_unid_oper" text
);
CREATE TABLE "legacy_raw"."vale_salida" (
    "codi_sali" text,
    "codi_alma" text,
    "nro_vale" text,
    "fecha" text,
    "codi_mone" text,
    "codi_tipo_docu" text,
    "serie" text,
    "numero" text,
    "codi_clie_prov" text,
    "codi_moti_tras" text,
    "tpc" text,
    "observacion" text,
    "codi_alma_dest" text,
    "codi_pers" text,
    "correlativo" text,
    "codi_orde" text,
    "anulado" text,
    "subt" text,
    "igv" text,
    "total" text,
    "transporte" text,
    "placa" text,
    "prov_dest" text,
    "chofer" text,
    "periodo" text,
    "indice_rela" text,
    "procedencia" text
);
CREATE TABLE "legacy_raw"."acti_econ_prin" (
    "codi_acti_econ" text,
    "desc_acti_econ" text,
    "nemo_acti_econ" text
);
CREATE TABLE "legacy_raw"."aduana" (
    "codi_aduana" text,
    "codi_sunat" text,
    "desc_aduana" text
);
CREATE TABLE "legacy_raw"."clie_prov_suspen_cta_categ" (
    "codi_clie_prov_sups_cta_categ" text,
    "codi_clie_prov" text,
    "nro_operacion" text,
    "fech_inicio" text,
    "anio" text,
    "medio_presentacion" text
);
CREATE TABLE "legacy_raw"."cliente_natural" (
    "id_clie_natu" text,
    "apellidos" text,
    "nombres" text,
    "nro_docu" text,
    "direccion" text,
    "codi_clie_prov" text
);
CREATE TABLE "legacy_raw"."cliente_proveedor" (
    "codi_clie_prov" text,
    "tipo_pers" text,
    "razo_soci" text,
    "nomb_1" text,
    "nomb_2" text,
    "apel_1" text,
    "apel_2" text,
    "ruc" text,
    "repr_lega" text,
    "denominacion" text,
    "direccion" text,
    "tele_1" text,
    "tele_2" text,
    "fax" text,
    "e_mail" text,
    "tipo_rela" text,
    "distrito" text,
    "provincia" text,
    "departamento" text,
    "codi_acti_econ" text,
    "suje_detr" text,
    "abreviatura" text,
    "propio" text,
    "reten" text,
    "nro_certificado" text,
    "codi_tipo_docu_iden" text,
    "fech_naci" text,
    "sexo" text,
    "codi_nacion" text,
    "essalud_vida" text,
    "domiciliado" text,
    "dv" text,
    "esta_acti" text,
    "frecuencia" text,
    "codi_ubi_dist" text,
    "codi_sunat_esta" text
);
CREATE TABLE "legacy_raw"."codigos_ldistancia" (
    "codi_ldistanci" text,
    "descripcion" text
);
CREATE TABLE "legacy_raw"."cultivos" (
    "cod_cultivo" text,
    "desc_cultivo" text,
    "nro_dias" text
);
CREATE TABLE "legacy_raw"."documentos" (
    "codi_tipo_docu" text,
    "serie" text,
    "nro_actual" text
);
CREATE TABLE "legacy_raw"."domicilio" (
    "codi_domi" text,
    "desc_domi" text,
    "distrito" text,
    "provincia" text,
    "departamento" text
);
CREATE TABLE "legacy_raw"."establecimiento" (
    "codi_esta" text,
    "codi_esta_sunat" text,
    "desc_esta" text
);
CREATE TABLE "legacy_raw"."estados" (
    "estado" text,
    "desc_esta" text
);
CREATE TABLE "legacy_raw"."etapa_fenologica" (
    "cod_eta" text,
    "desc_eta" text
);
CREATE TABLE "legacy_raw"."evento" (
    "codi_plan" text,
    "nro_even" text,
    "evento" text,
    "tipo" text,
    "fecha" text,
    "duracion" text,
    "h_ini" text,
    "h_fin" text,
    "ubicacion" text,
    "notas" text,
    "informe" text,
    "codi_alma" text,
    "codi_pers" text
);
CREATE TABLE "legacy_raw"."feriados" (
    "mes" text,
    "dia" text,
    "anio" text,
    "desc_feri" text,
    "fecha" text
);
CREATE TABLE "legacy_raw"."monedas" (
    "codi_mone" text,
    "desc_mone" text,
    "simbolo" text,
    "codi_sunat" text
);
CREATE TABLE "legacy_raw"."motivos" (
    "codi_moti" text,
    "desc_moti" text
);
CREATE TABLE "legacy_raw"."nacion" (
    "codi_nacion" text,
    "codi_nacion_sunat" text,
    "desc_nacion" text
);
CREATE TABLE "legacy_raw"."pais_emisor" (
    "codi_pais_emi" text,
    "descripcion" text
);
CREATE TABLE "legacy_raw"."referencias" (
    "codi_refe" text,
    "descrip_refe" text
);
CREATE TABLE "legacy_raw"."semana" (
    "codi_sema" text,
    "nro_sema" text,
    "fech_inic" text,
    "fech_term" text,
    "aniomes" text,
    "codi_tipo_pers" text
);
CREATE TABLE "legacy_raw"."telefono" (
    "codi_pers" text,
    "nro_tele" text,
    "tipo_tele" text,
    "observacion" text
);
CREATE TABLE "legacy_raw"."terceros" (
    "dni" text,
    "datos" text,
    "codi_carg" text
);
CREATE TABLE "legacy_raw"."tipo_cambio_a_dolar" (
    "codi_mone_orig" text,
    "fech_camb" text,
    "compra" text,
    "venta" text,
    "codi_mone_camb" text,
    "venta_comer_d_a_s" text
);
CREATE TABLE "legacy_raw"."tipo_docu_iden" (
    "codi_tipo_docu_iden" text,
    "codi_sunat" text,
    "desc_tipo_docu_iden" text,
    "nemo" text
);
CREATE TABLE "legacy_raw"."tipo_documento" (
    "codi_tipo_docu" text,
    "desc_tipo_docu" text,
    "tipo_cont" text,
    "nemo" text,
    "forma_pago" text,
    "codi_tipo_essa" text,
    "tipo_sunat" text,
    "codi_sunat" text
);
CREATE TABLE "legacy_raw"."tipo_empresa" (
    "codi_tipo_empr" text,
    "desc_tipo_empr" text,
    "nemo" text
);
CREATE TABLE "legacy_raw"."tipo_medida" (
    "codigo" text,
    "desc_medida" text
);
CREATE TABLE "legacy_raw"."tipo_pago" (
    "codi_tipo_medio_pago" text,
    "codi_sunat" text,
    "desc_tipo_medio_pago" text,
    "nemo" text
);
CREATE TABLE "legacy_raw"."tipo_unid_oper" (
    "codi_tipo_unid_oper" text,
    "desc_tipo_unid_oper" text,
    "nemo" text
);
CREATE TABLE "legacy_raw"."transacciones" (
    "codi_tran" text,
    "desc_tran" text
);
CREATE TABLE "legacy_raw"."transportistas" (
    "codi_trans" text,
    "desc_trans" text,
    "iden" text,
    "direccion" text,
    "nro_lice_cond" text,
    "nextel" text
);
CREATE TABLE "legacy_raw"."ubigeo_distrito" (
    "codi_ubi_dist" text,
    "codi_ubi_dist_sunat" text,
    "desc_ubi_dist" text,
    "codi_ubi_prov_sunat" text
);
CREATE TABLE "legacy_raw"."ubigeo_provincia" (
    "codi_ubi_prov" text,
    "codi_ubi_prov_sunat" text,
    "desc_ubi_prov" text,
    "codi_ubi_reg_sunat" text
);
CREATE TABLE "legacy_raw"."ubigeo_region" (
    "codi_ubi_reg" text,
    "codi_ubi_reg_sunat" text,
    "desc_ubi_reg" text
);
CREATE TABLE "legacy_raw"."unid_oper" (
    "codi_unid_oper" text,
    "desc_unid_oper" text,
    "codi_pers" text,
    "ubicacion" text,
    "codi_lcc" text
);
CREATE TABLE "legacy_raw"."unidad_medida" (
    "codi_unid_medi" text,
    "desc_unid_medi" text,
    "tipo_unid_medi" text,
    "simb_unid_medi" text,
    "codi_sunat" text,
    "unid_medi_inte" text
);
CREATE TABLE "legacy_raw"."unidad_medida_inter" (
    "codi_unid_medi" text,
    "desc_unid_medi" text,
    "tipo_unid_medi" text,
    "simb_unid_medi" text,
    "codi_sunat" text
);
CREATE TABLE "legacy_raw"."unidad_medida_sunat" (
    "codigo" text,
    "desc_unid" text
);
CREATE TABLE "legacy_raw"."unidad_negocio" (
    "codi_unid_nego" text,
    "desc_unid_nego" text
);
CREATE TABLE "legacy_raw"."valores_unitarios" (
    "codi_valo_unit" text,
    "desc_valo_unit" text,
    "nemo" text
);
CREATE TABLE "legacy_raw"."valores_unitarios_anuales" (
    "codi_valo_unit" text,
    "fech_asig" text,
    "fech_asig_fin" text,
    "valor" text,
    "tipo_valo" text,
    "esta_acti" text
);
CREATE TABLE "legacy_raw"."via" (
    "codi_via" text,
    "codi_via_sunat" text,
    "desc_via" text,
    "nemo_via" text
);
CREATE TABLE "legacy_raw"."zona" (
    "codi_zona" text,
    "codi_zona_sunat" text,
    "desc_zona" text,
    "nemo_zona" text
);
CREATE TABLE "legacy_raw"."zonas" (
    "cod_zona" text,
    "desc_zona" text
);
CREATE TABLE "legacy_raw"."analisis_aceite" (
    "cod_analisis" text,
    "codi_ingr" text,
    "codi_alma" text,
    "item" text,
    "codi_prod" text,
    "i_o" text,
    "condicion" text,
    "fecha_analisis" text,
    "fecha_registro" text,
    "codi_usua" text,
    "estado_ingreso" text
);
CREATE TABLE "legacy_raw"."analisis_parametro" (
    "cod_analisis" text,
    "cod_param" text,
    "valor" text,
    "estado" text
);
CREATE TABLE "legacy_raw"."consumo_combustible" (
    "codi_cons_comb" text,
    "codi_unid_tran" text,
    "anio" text,
    "mes" text,
    "kilo_inic" text,
    "kilo_fina" text
);
CREATE TABLE "legacy_raw"."derechopesca" (
    "mesanio" text,
    "codi_unid_oper" text,
    "captura" text,
    "factor" text,
    "derecho" text,
    "porcentaje" text,
    "derechopor" text,
    "credito" text,
    "deducion" text,
    "total" text,
    "aplicar" text
);
CREATE TABLE "legacy_raw"."destinos_pesca" (
    "codi_dest" text,
    "desc_dest" text,
    "abrev" text
);
CREATE TABLE "legacy_raw"."detalle_factura_pesca" (
    "codi_fact_pesc" text,
    "codi_deta_zarp" text,
    "cant_tone" text,
    "prec_unit" text,
    "sub_tota" text
);
CREATE TABLE "legacy_raw"."detalle_zarpe" (
    "codi_deta_zarp" text,
    "codi_zarp" text,
    "codi_espe" text,
    "cantidad" text,
    "codi_unid_medi_cant" text,
    "tama_mini_espe" text,
    "tama_maxi_espe" text,
    "codi_unid_medi_tama" text,
    "codi_clie_prov" text,
    "seri_guia" text,
    "nro_guia" text,
    "prec_pact" text,
    "tipo_docu" text,
    "estado" text,
    "incigv" text
);
CREATE TABLE "legacy_raw"."emba_venc_cert" (
    "codi_venc_cert" text,
    "codi_unid_oper" text,
    "codi_tipo_cert" text,
    "fech_inic" text,
    "fech_term" text,
    "periodo" text,
    "observacion" text
);
CREATE TABLE "legacy_raw"."embar_carac" (
    "codi_unid_oper" text,
    "eslora" text,
    "manga" text,
    "puntual" text,
    "nro_mamp_esta_tran" text,
    "nro_mamp_esta_long" text,
    "nro_cubi_bajo_cubi" text,
    "nro_cubi_sobr_cubi" text,
    "nro_mast" text,
    "nro_bode" text,
    "nro_cuad" text,
    "nro_grua" text,
    "form_popa" text,
    "form_proa" text,
    "marc_moto" text,
    "mode_moto" text,
    "seri_moto" text,
    "pote_moto" text,
    "unid_medi_pote" text,
    "tipo_comb" text,
    "nro_tanq_comb" text,
    "capa_tanq_comb" text,
    "tipo_agua" text,
    "nro_tanq_agua" text,
    "capa_tanq_agua" text
);
CREATE TABLE "legacy_raw"."embarcaciones" (
    "codi_unid_oper" text,
    "desc_unid_oper" text,
    "capa_bode" text,
    "capa_neta" text,
    "nro_matri" text,
    "luga_cons" text,
    "porc_dist" text,
    "estado" text,
    "codi_caja" text,
    "grupo" text,
    "subsidio" text,
    "orden" text,
    "montoboni" text,
    "prop_terc" text,
    "nemo_emba" text,
    "detra" text,
    "fech_cese" text,
    "arqu_brut" text,
    "arqu_neto" text,
    "mate_casc" text,
    "colo_casc" text,
    "mate_supe_estr" text,
    "colo_supe_estr" text,
    "montopatron" text,
    "codi_mone_patron" text,
    "monto_segundo" text,
    "codi_mone_segun" text,
    "aplica_segun" text,
    "conserva" text,
    "codi_clie_prov" text,
    "monto_adic" text,
    "codi_mone_adic" text,
    "sunat_adic" text,
    "eslora" text,
    "manga" text,
    "puntual" text,
    "nro_mamp_esta_tran" text,
    "nro_cubi_bajo_cubi" text,
    "nro_cubi_sobr_cubi" text,
    "nro_mast" text,
    "nro_bode" text,
    "nro_cuad" text,
    "nro_grua" text,
    "form_popa" text,
    "form_proa" text,
    "marc_moto" text,
    "mode_moto" text,
    "seri_moto" text,
    "pote_moto" text,
    "unid_medi_pote" text,
    "tipo_comb" text,
    "nro_tanq_comb" text,
    "capa_tanq_comb" text,
    "tipo_agua" text,
    "nro_tanq_agua" text,
    "capa_tanq_agua" text,
    "nro_mamp_esta_long" text
);
CREATE TABLE "legacy_raw"."especies" (
    "codi_espe" text,
    "desc_espe" text,
    "descuento" text,
    "tipo_cons" text
);
CREATE TABLE "legacy_raw"."informe_acidez" (
    "codi_alma" text,
    "fecha" text,
    "peso" text,
    "superior" text,
    "medio" text,
    "compo" text,
    "fondo" text,
    "solidos" text,
    "altura" text,
    "observaciones" text,
    "hora" text
);
CREATE TABLE "legacy_raw"."lugar_origen" (
    "codi_luga" text,
    "desc_luga" text
);
CREATE TABLE "legacy_raw"."nota_ingreso_aceite" (
    "codi_ingr" text,
    "codi_alma" text,
    "nro_ingr" text,
    "fecha" text,
    "codi_mone" text,
    "codi_tipo_docu" text,
    "serie" text,
    "numero" text,
    "codi_clie_prov" text,
    "codi_moti_tras" text,
    "tpc" text,
    "observacion" text,
    "codi_orde" text,
    "rela_vale" text,
    "anulado" text,
    "subt" text,
    "igv" text,
    "total" text,
    "orden_compra" text,
    "productor" text,
    "transporte" text,
    "placa" text,
    "codi_doc" text,
    "serfact" text,
    "nrofact" text,
    "fecha_fact" text,
    "codi_sali" text,
    "chofer" text,
    "periodo" text,
    "indice_rela" text,
    "procedencia" text,
    "contabilizado" text,
    "codi_unid_oper_prod" text
);
CREATE TABLE "legacy_raw"."nrotrip_embar" (
    "codi_unid_oper" text,
    "nro_trip" text
);
CREATE TABLE "legacy_raw"."orden_compra_aceite" (
    "codi_orde" text,
    "nro_orde" text,
    "codi_alma" text,
    "fecha" text,
    "codi_mone" text,
    "codi_tipo_docu" text,
    "serie" text,
    "numero" text,
    "codi_clie_prov" text,
    "codi_moti_tras" text,
    "tpc" text,
    "observacion" text,
    "codi_alma_dest" text,
    "contabilizado" text,
    "codi_vouc" text,
    "subt" text,
    "igv" text,
    "total" text,
    "productor" text,
    "transporte" text,
    "placa" text,
    "serfact" text,
    "nrofact" text,
    "codi_doc" text,
    "periodo" text
);
CREATE TABLE "legacy_raw"."orden_produccion" (
    "codi_orde_produc" text,
    "nro_orde_produc" text,
    "fecha_orde_produc" text,
    "codi_clie" text,
    "descripcion" text,
    "nro_oc_clie" text,
    "fecha_entrega" text,
    "prec_unit" text,
    "cantidad" text,
    "codi_unid_medi" text,
    "tama1" text,
    "tama2" text,
    "codi_unid_medit" text,
    "otros_acabado" text,
    "observaciones" text,
    "codi_usua" text,
    "estado" text,
    "tipo_pers" text,
    "id_clie_natu" text,
    "codi_mone" text,
    "tama" text,
    "nroordefisico" text,
    "otro_material" text,
    "cliente" text,
    "direccion" text,
    "nro_docu" text,
    "descripcion_item" text,
    "material" text,
    "color" text,
    "acabado" text,
    "serv_prod" text,
    "total" text,
    "codi_tipo_op" text,
    "aurtoriza_por" text,
    "solicitado_por" text
);
CREATE TABLE "legacy_raw"."orden_produccion_factura" (
    "codi_orde_produc" text,
    "codi_fact" text
);
CREATE TABLE "legacy_raw"."parte_cargo" (
    "codi_carg" text,
    "fech_asig" text,
    "codi_unid_oper" text,
    "parte" text,
    "adicional" text,
    "espe_part" text,
    "espe_adic" text,
    "empresa" text
);
CREATE TABLE "legacy_raw"."pozas" (
    "codi_poza" text,
    "desc_poza" text
);
CREATE TABLE "legacy_raw"."precio_pactado" (
    "codi_sema" text,
    "codi_clie_prov" text,
    "codi_espe" text,
    "prec_pact" text,
    "codi_mone" text
);
CREATE TABLE "legacy_raw"."precio_snp" (
    "codi_prec" text,
    "codi_sema" text,
    "codi_espe" text,
    "precio" text,
    "codi_mone" text,
    "jueves" text,
    "viernes" text,
    "sabado" text,
    "domingo" text,
    "lunes" text,
    "martes" text,
    "miercoles" text
);
CREATE TABLE "legacy_raw"."propias_terceros" (
    "codi_tipo" text,
    "desc_tipo" text
);
CREATE TABLE "legacy_raw"."puerto" (
    "codi_puer" text,
    "desc_puer" text
);
CREATE TABLE "legacy_raw"."ratio_produccion" (
    "codi_rati_prod" text,
    "codi_turn" text,
    "codi_rati" text,
    "fech_rati_prod" text,
    "valo_rati_prod" text,
    "codi_unid_nego" text
);
CREATE TABLE "legacy_raw"."saldo_poza" (
    "codi_sald_poza" text,
    "codi_turn" text,
    "codi_poza" text,
    "sald_ante" text,
    "cant_desc_poza" text,
    "cons_prod" text,
    "sald_fina" text,
    "fecha" text
);
CREATE TABLE "legacy_raw"."saldo_tanques" (
    "codi_sald_tanq" text,
    "codi_tanq_auxi" text,
    "codi_turn" text,
    "petr_ante" text,
    "petr_ingr" text,
    "petr_sali" text,
    "petr_fina" text,
    "fecha" text
);
CREATE TABLE "legacy_raw"."sistemas_embarcaciones" (
    "codi_sist_emba" text,
    "desc_sist_emba" text,
    "nemo_sist_emba" text
);
CREATE TABLE "legacy_raw"."situ_emba" (
    "codi_situ" text,
    "desc_situ" text,
    "nemo_situ" text
);
CREATE TABLE "legacy_raw"."taller_diario" (
    "codi_tall" text,
    "codi_unid_oper" text,
    "codi_item" text,
    "fecha" text,
    "descripcion" text,
    "monto" text
);
CREATE TABLE "legacy_raw"."talleres" (
    "codi_tall" text,
    "nombre" text
);
CREATE TABLE "legacy_raw"."tanq_auxiliar" (
    "codi_tanq_auxi" text,
    "desc_tanq_auxi" text,
    "stoc_tanq_auxi" text
);
CREATE TABLE "legacy_raw"."tanques" (
    "codi_tanq" text,
    "desc_tanq" text,
    "stoc_tanq" text,
    "capa_tanq" text
);
CREATE TABLE "legacy_raw"."tipo_cert_emba" (
    "codi_tipo_cert" text,
    "desc_tipo_cert" text,
    "nemo_tipo_cert" text
);
CREATE TABLE "legacy_raw"."tipo_destino" (
    "codi_tipo_dest" text,
    "desc_tipo_dest" text,
    "nemo" text
);
CREATE TABLE "legacy_raw"."tipo_titu_pesc" (
    "codi_tipo_titu_pesc" text,
    "desc_tipo_titu_pesc" text,
    "abre" text,
    "orden" text
);
CREATE TABLE "legacy_raw"."tipos_orden_produccion" (
    "codi_tipo_op" text,
    "desc_tipo_op" text,
    "nemo" text
);
CREATE TABLE "legacy_raw"."zarp_obse" (
    "codi_zarp" text,
    "nro_obse" text,
    "desc_obse" text,
    "nro_cuen" text,
    "codi_sist_emba" text
);
CREATE TABLE "legacy_raw"."zarpe_combustible" (
    "codi_zarp" text,
    "codi_petr" text,
    "ser_fact" text,
    "nro_fact" text,
    "cant_petr" text,
    "prec_petr" text,
    "tipo_doc" text,
    "estado" text,
    "valo_vent" text,
    "igv" text,
    "valo_tota" text,
    "codi_mone" text,
    "tc" text
);
CREATE TABLE "legacy_raw"."zarpes" (
    "codi_zarp" text,
    "fech_repo" text,
    "codi_sema" text,
    "fech_desc" text,
    "codi_unid_oper" text,
    "codi_puer" text,
    "zona_pesc" text,
    "fech_zarp" text,
    "fech_arri" text,
    "zona_arri" text,
    "zona_pesc_arri" text,
    "codi_unid_medi" text,
    "pesc_esti" text,
    "pesc_real" text,
    "fech_inic_desc" text,
    "fech_term_desc" text,
    "obse_pesc" text,
    "cord_capt" text,
    "temp_capt" text,
    "nume_cala" text,
    "fech_posi_arri" text,
    "codi_puer2" text,
    "comb_reci" text,
    "codi_clie_prov" text,
    "codi_prov_petr" text,
    "nro_cgs" text,
    "fech_sgs" text,
    "desc_sgs" text,
    "luga_desc" text,
    "obse_pesc2" text,
    "obse_pesc3" text,
    "luga_fond" text,
    "codi_patr" text,
    "orom_mp" text,
    "orom_ma1" text,
    "orom_ma2" text,
    "codi_situ" text,
    "pesc_tota" text,
    "codi_sema_fact" text,
    "codi_sama_fact" text,
    "refrigerada" text,
    "conserva" text,
    "fondeada" text
);
CREATE TABLE "legacy_raw"."abogados" (
    "codi_abog" text,
    "apel_1" text,
    "apel_2" text,
    "nomb_1" text,
    "nomb_2" text
);
CREATE TABLE "legacy_raw"."actividad" (
    "codi_acti" text,
    "codi_acti_sunat" text,
    "desc_acti" text
);
CREATE TABLE "legacy_raw"."adelanto_ep_terceros" (
    "codi_adel_terc" text,
    "codi_unid_oper" text,
    "nro_adel" text,
    "fech_adel" text,
    "moti_adel" text,
    "esta_pago" text,
    "codi_mone_adel" text,
    "mont_adel" text,
    "codi_sema" text
);
CREATE TABLE "legacy_raw"."adelantos" (
    "codi_adel" text,
    "codi_pers" text,
    "nro_adel" text,
    "fech_adel" text,
    "moti_adel" text,
    "esta_pago" text,
    "codi_mone_adel" text,
    "mont_adel" text,
    "tipo_adel" text,
    "inte_tiem_desc" text,
    "mont_pago" text,
    "saldo" text,
    "regi_adel" text
);
CREATE TABLE "legacy_raw"."area_grup" (
    "codi_area_grup" text,
    "desc_area_grup" text,
    "jera_area" text
);
CREATE TABLE "legacy_raw"."areas" (
    "codi_area" text,
    "nomb_area" text,
    "ubica" text,
    "area_grup" text
);
CREATE TABLE "legacy_raw"."asistencia_maqui_motor" (
    "codi_pers" text,
    "fech_asis" text,
    "asis_pers" text
);
CREATE TABLE "legacy_raw"."asistencia_motorista" (
    "mesanio" text,
    "codi_unid_oper" text,
    "codi_pers" text,
    "codi_carg" text,
    "dias_traba_quin" text,
    "dias_traba_mens" text
);
CREATE TABLE "legacy_raw"."asistencia_personal" (
    "codi_pers" text,
    "fecha" text,
    "turno" text,
    "he1" text,
    "hs1" text,
    "codi_usua" text,
    "codi_usua_modi" text
);
CREATE TABLE "legacy_raw"."asistencia_tripulantes_pesca" (
    "codi_sema" text,
    "codi_unid_oper" text,
    "codi_pers" text,
    "codi_carg" text,
    "jueves" text,
    "viernes" text,
    "sabado" text,
    "domingo" text,
    "lunes" text,
    "martes" text,
    "miercoles" text,
    "juev_carg" text,
    "vier_carg" text,
    "saba_carg" text,
    "domi_carg" text,
    "lune_carg" text,
    "mart_carg" text,
    "mier_carg" text,
    "nro_asis" text,
    "mesanio" text
);
CREATE TABLE "legacy_raw"."auto_trab_cent_oper" (
    "codi_auto_trab_co" text,
    "nro_auto" text,
    "fecha" text,
    "unid_oper_soli" text,
    "unid_oper_co" text,
    "codi_puer_oper" text,
    "lugar" text,
    "codi_usua_soli" text,
    "codi_usua_jefe_tall" text,
    "codi_usua_auto_mant" text,
    "codi_usua_auto_flot" text,
    "desc_gene_trab" text,
    "desc_gene_trab_1" text
);
CREATE TABLE "legacy_raw"."auto_trab_cent_oper_deta" (
    "codi_auto_trab_co" text,
    "nro_deta" text,
    "codi_pers" text,
    "fech_inic" text,
    "fech_term" text,
    "nume_hora_norm" text,
    "nume_hora_25" text,
    "nume_hora_35" text,
    "nume_hora_noct" text,
    "situ_hora_25" text,
    "situ_hora_35" text,
    "situ_hora_noct" text,
    "deta_trab" text
);
CREATE TABLE "legacy_raw"."calc_util_deta" (
    "codi_pers" text,
    "anio" text,
    "codi_conc" text,
    "valor" text,
    "monto" text,
    "codi_auxi" text,
    "nro_pago" text
);
CREATE TABLE "legacy_raw"."calc_util_pers" (
    "anio" text,
    "codi_pers" text,
    "apellidos" text,
    "nombres" text,
    "remu_perc" text,
    "dias_labo" text,
    "liq_remu_perc" text,
    "liq_dias_labo" text,
    "liq_tota" text,
    "mes" text
);
CREATE TABLE "legacy_raw"."calc_util_tota" (
    "anio" text,
    "renta_neta" text,
    "participacion" text,
    "remu_perc_tota" text,
    "dias_labo_tota" text
);
CREATE TABLE "legacy_raw"."cargos" (
    "codi_carg" text,
    "tipo_carg" text,
    "desc_cargo" text,
    "abrev" text,
    "carg_mostrar" text,
    "jera" text,
    "codi_ocu" text
);
CREATE TABLE "legacy_raw"."categoria_ocupacional" (
    "cod_categ_ocup" text,
    "desc_categ_ocup" text,
    "codigo_sunat" text,
    "privador" text,
    "publico" text,
    "otro" text
);
CREATE TABLE "legacy_raw"."categoria_trabajador" (
    "codi_cate_trab" text,
    "desc_cate_trab" text,
    "abre_cate_trab" text,
    "orde_cate_trab" text,
    "codi_sunat" text
);
CREATE TABLE "legacy_raw"."conceptos" (
    "codi_conc" text,
    "desc_conc" text,
    "esta_acti" text,
    "nemo" text,
    "codi_sub_concep_sunat" text,
    "variable" text
);
CREATE TABLE "legacy_raw"."conceptos_afectos_planillas" (
    "codi_conc" text,
    "codi_tipo_plan" text,
    "fech_regi" text,
    "afecto" text,
    "esta_acti" text,
    "codi_valo_unit" text,
    "rubro" text,
    "grupo" text,
    "formula" text
);
CREATE TABLE "legacy_raw"."conceptos_contables" (
    "codi_conc" text,
    "nro_cuen" text,
    "codi_conc_fina" text,
    "carg_abon" text,
    "tipo_cont" text,
    "codi_tipo_plan" text,
    "codi_tipo_prov" text,
    "codi_tipo_pers" text,
    "codi_uni_oper" text,
    "fact_mult" text,
    "codi_sist_pens" text,
    "codi_rela" text
);
CREATE TABLE "legacy_raw"."constancia_juicios" (
    "codi_juic" text,
    "nro_pago" text,
    "codi_pers" text,
    "codi_unid_oper" text,
    "registro" text,
    "bene_juic" text,
    "nro_reso" text,
    "juzgado" text,
    "valor" text,
    "semana" text,
    "fecha" text,
    "dni" text,
    "nro_asis" text,
    "tipo" text,
    "mesanio" text
);
CREATE TABLE "legacy_raw"."contratos_personal" (
    "codi_pers" text,
    "codi_cont_pers" text,
    "fech_inic_cont" text,
    "fech_fin_cont" text,
    "fech_sali" text,
    "esta_cont" text,
    "suel_basi" text,
    "observacion" text,
    "codi_unid_oper" text,
    "codi_carg" text,
    "tipo_cont" text,
    "grup_ocup" text,
    "moda_cont" text,
    "arti_moda" text,
    "comp_aseg" text,
    "tipo_prac" text,
    "cent_estu_prac" text,
    "hora_labo_diar" text,
    "hora_prac" text,
    "hora_teor" text,
    "hora_entr_1" text,
    "hora_sali_1" text,
    "hora_entr_2" text,
    "hora_sali_2" text,
    "titu_prac" text,
    "hora_dias" text,
    "deno_cent_estu_prac" text,
    "fech_pres_prac" text,
    "tiem_dura" text
);
CREATE TABLE "legacy_raw"."convenio_evita_doble_tributacion" (
    "cod_conv_evita_dob_tribu" text,
    "desc_conv_evita_dob_tribu" text,
    "cod_sunat" text
);
CREATE TABLE "legacy_raw"."datos_cts" (
    "codi_plan_cts" text,
    "codi_pers" text,
    "fech_inic" text,
    "fech_term" text,
    "tipo_pago" text,
    "desc_tipo_pago" text,
    "codi_mone" text,
    "fech_pago" text,
    "codi_tipo_plan" text,
    "anio" text,
    "mes" text,
    "nro_cheq_oper" text,
    "importe" text,
    "impo_dola" text,
    "codi_tipo_pers" text,
    "tipo_camb" text,
    "esta_pago" text,
    "fech_venc" text,
    "mont_inte_diar" text,
    "codi_banc" text,
    "tipo_cts" text,
    "codi_unid_oper" text,
    "interes" text
);
CREATE TABLE "legacy_raw"."demandas" (
    "codi_dema" text,
    "nro_expe" text,
    "materia" text,
    "codi_juez" text,
    "codi_juzg" text,
    "codi_espe" text,
    "codi_pers" text,
    "codi_clie_prov" text,
    "fech_ingr" text,
    "codi_unid_oper" text,
    "codi_carg" text,
    "antecedente" text,
    "anio" text,
    "secretaria" text,
    "estado" text,
    "fech_rece" text,
    "codi_abog" text,
    "proceso" text,
    "monto_dema" text,
    "nombres" text,
    "situ_actu" text
);
CREATE TABLE "legacy_raw"."derecho_habiente" (
    "codi_pers" text,
    "codi_dere_habi" text,
    "tipo_rela" text,
    "nomb_1" text,
    "nomb_2" text,
    "apel_1" text,
    "apel_2" text,
    "codi_tipo_docu" text,
    "nro_docu_iden" text,
    "fech_naci" text,
    "sexo" text,
    "situacion" text,
    "moti_baja" text,
    "domicilio" text,
    "incapacidad" text,
    "cert_medi" text,
    "codi_tipo_docu_iden" text,
    "codi_vinc_fami" text,
    "tipo_doc_acred_pater" text,
    "nro_doc_acred_pater" text,
    "fech_alta" text,
    "fech_baja" text,
    "codi_moti_baja_dh" text,
    "nro_resolu_direct" text,
    "codi_via" text,
    "nomb_via" text,
    "num_via" text,
    "interior_via" text,
    "codi_zona" text,
    "nomb_zona" text,
    "referencia" text,
    "codi_ubi_reg" text,
    "codi_ubi_prov" text,
    "codi_ubi_dist" text,
    "codi_pais" text,
    "mesconcep" text,
    "codi_docu_vinculo" text,
    "codi_ldistanci" text,
    "telefono" text,
    "correo" text
);
CREATE TABLE "legacy_raw"."desplazan_personal" (
    "codi_desplazan_pers" text,
    "codi_clie_prov" text,
    "codi_acti" text,
    "fecha_inic" text,
    "fecha_fin" text
);
CREATE TABLE "legacy_raw"."desplazo_personal" (
    "codi_despla_pers" text,
    "fecha_inicio" text,
    "fecha_fin" text,
    "codi_estable" text,
    "indicador" text,
    "codi_clie_prov" text,
    "codi_acti" text
);
CREATE TABLE "legacy_raw"."deta_ingr_grat_trip" (
    "codi_sema" text,
    "anio" text,
    "codi_pers" text,
    "codi_carg" text,
    "codi_unid_oper" text,
    "grati" text,
    "importe" text,
    "porc_part" text,
    "nro_sema" text,
    "codi_tipo_plan" text,
    "mesanio_prov" text,
    "codi_plan_orig" text,
    "mes" text,
    "tipo_camb" text
);
CREATE TABLE "legacy_raw"."dias_trab" (
    "codi_pers" text,
    "codi_unid_oper" text,
    "codi_sema" text,
    "dias" text
);
CREATE TABLE "legacy_raw"."documento_vinculo" (
    "codi_docu_vinculo" text,
    "codi_docu_vinculo_sunat" text,
    "descipcion_docu" text,
    "descripcion_abre" text,
    "vinculo" text
);
CREATE TABLE "legacy_raw"."entidad_salud" (
    "codi_enti" text,
    "codi_enti_sunat" text,
    "ruc" text,
    "desc_enti" text
);
CREATE TABLE "legacy_raw"."especialistas" (
    "codi_espe" text,
    "apel_1" text,
    "apel_2" text,
    "nomb_1" text,
    "nomb_2" text,
    "dni" text
);
CREATE TABLE "legacy_raw"."extr_cont_liqu_pesc" (
    "codi_sema" text,
    "codi_clie_prov" text,
    "prec_pact" text,
    "dscto" text,
    "codi_banc" text
);
CREATE TABLE "legacy_raw"."extra_conta" (
    "ruc" text,
    "tm" text,
    "prec_tm" text,
    "comb" text,
    "pre_comb" text,
    "fdo_rete" text,
    "up" text
);
CREATE TABLE "legacy_raw"."grat_trip_deta_conc" (
    "codi_pers" text,
    "codi_sema_inic" text,
    "codi_sema_fin" text,
    "anio" text,
    "codi_conc" text,
    "monto" text,
    "valor" text,
    "codi_tipo_plan" text,
    "mesanio_prov" text,
    "codi_juic" text,
    "mes" text,
    "codi_unid_oper" text
);
CREATE TABLE "legacy_raw"."hora_labo_sema" (
    "codi_pers" text,
    "fech_inic" text,
    "fech_term" text,
    "d_01" text,
    "d_02" text,
    "d_03" text,
    "d_04" text,
    "d_05" text,
    "d_06" text,
    "d_07" text,
    "anio" text,
    "mes" text,
    "hora_rein_norm" text,
    "hora_25_rein_norm" text,
    "hora_35_rein_norm" text,
    "hora_rein_domi" text,
    "hora_25_rein_domi" text,
    "hora_35_rein_domi" text,
    "hora_rein_feri" text,
    "hora_25_rein_feri" text,
    "hora_35_rein_feri" text,
    "observaciones" text,
    "indi_tiem" text,
    "codi_tipo_pers" text,
    "semana" text
);
CREATE TABLE "legacy_raw"."hora_pers_fech" (
    "codi_pers" text,
    "fech_inic" text,
    "fech_fin" text,
    "codi_hora" text
);
CREATE TABLE "legacy_raw"."hora_plan_vaca_grat" (
    "codi_pers" text,
    "fech_inic" text,
    "codi_tipo_plan" text,
    "fech_term" text,
    "anio" text,
    "mes" text,
    "prom_remu_hora_25" text,
    "prom_remu_hora_35" text,
    "remu_otro_ingr" text,
    "nro_mese_paga" text,
    "nro_dias_paga" text,
    "moti_obse" text
);
CREATE TABLE "legacy_raw"."horario" (
    "codi_hora" text,
    "descripcion" text,
    "he1n" text,
    "hs1n" text,
    "he2n" text,
    "hs2n" text,
    "he1s" text,
    "hs1s" text,
    "he2s" text,
    "hs2s" text,
    "hora_labo_dia" text,
    "hora_labo_dia_saba" text
);
CREATE TABLE "legacy_raw"."horas_laboradas" (
    "codi_pers" text,
    "fech_inic" text,
    "d_01" text,
    "d_02" text,
    "d_03" text,
    "d_04" text,
    "d_05" text,
    "d_06" text,
    "d_07" text,
    "d_08" text,
    "d_09" text,
    "d_10" text,
    "d_11" text,
    "d_12" text,
    "d_13" text,
    "d_14" text,
    "d_15" text,
    "d_16" text,
    "d_17" text,
    "d_18" text,
    "d_19" text,
    "d_20" text,
    "d_21" text,
    "d_22" text,
    "d_23" text,
    "d_24" text,
    "d_25" text,
    "d_26" text,
    "d_27" text,
    "d_28" text,
    "d_29" text,
    "d_30" text,
    "d_31" text,
    "hora_rein_norm" text,
    "hora_25_rein_norm" text,
    "hora_35_rein_norm" text,
    "hora_rein_domi" text,
    "hora_25_rein_domi" text,
    "hora_35_rein_domi" text,
    "hora_rein_feri" text,
    "hora_25_rein_feri" text,
    "hora_35_rein_feri" text,
    "observaciones" text,
    "indi_tiem" text
);
CREATE TABLE "legacy_raw"."incrementos_personal" (
    "codi_pers" text,
    "nro_incre" text,
    "desc_incr" text,
    "tipo_incre" text,
    "codi_mone" text,
    "valor" text,
    "esta_acti" text
);
CREATE TABLE "legacy_raw"."ingresos_quinta_categ" (
    "codi_ingre" text,
    "codi_pers" text,
    "año" text,
    "mes" text,
    "monto" text,
    "codi_clie_prov" text,
    "reten" text,
    "renta_reten" text
);
CREATE TABLE "legacy_raw"."jueces" (
    "codi_juez" text,
    "apel_1" text,
    "apel_2" text,
    "nomb_1" text,
    "nomb_2" text,
    "dni" text,
    "cargo" text
);
CREATE TABLE "legacy_raw"."juicios" (
    "codi_juic" text,
    "codi_pers" text,
    "nro_juic" text,
    "fech_juic" text,
    "moti_juic" text,
    "esta_acti" text,
    "tipo_desc" text,
    "codi_mone" text,
    "mont_desc" text,
    "inte_tiem_desc" text,
    "apli_toda_remu" text,
    "pers_bene_juic" text,
    "dni_pers_bene" text,
    "nro_reso_judi" text,
    "juzgado" text,
    "apli_tope" text,
    "tope" text,
    "saldo" text,
    "codi_banc" text,
    "nro_cta_cte_bene" text,
    "codi_mone_cta_cte_bene" text
);
CREATE TABLE "legacy_raw"."juicios_empresa" (
    "codi_juic_empr" text,
    "codi_pers" text,
    "fech_inic" text,
    "fech_term" text,
    "desc_juic" text,
    "codi_clie_prov" text,
    "codi_mone" text,
    "monto" text,
    "juzgado" text,
    "nomb_juez" text,
    "observacion" text,
    "nro_exp" text,
    "activo" text
);
CREATE TABLE "legacy_raw"."juzgados" (
    "codi_juzg" text,
    "desc_juzg" text,
    "ubicacion" text,
    "direccion" text
);
CREATE TABLE "legacy_raw"."licencias_por_personal" (
    "codi_pers" text,
    "codi_tipo_lice" text,
    "motivo" text,
    "fech_inic" text,
    "fech_term" text,
    "esta_acti" text,
    "goce_habe" text,
    "nro_dias_remu" text,
    "observaciones" text,
    "nro_hora_remu" text,
    "codi_jefe_inme_auto" text,
    "codi_jefe_supe_auto" text,
    "codi_tipo_susp_labo" text,
    "nro_citt" text
);
CREATE TABLE "legacy_raw"."lugar_trabajo" (
    "codi_luga_trab" text,
    "nomb_luga_trab" text,
    "abre_luga_trab" text
);
CREATE TABLE "legacy_raw"."modalidad_formativa" (
    "codi_moda_forma" text,
    "codi_moda_forma_sunat" text,
    "desc_moda_forma" text
);
CREATE TABLE "legacy_raw"."moti_baja_dh" (
    "codi_moti_baja_dh" text,
    "codi_moti_baja_dh_sunat" text,
    "desc_moti_baja_dh" text
);
CREATE TABLE "legacy_raw"."moti_fin_periodo" (
    "codi_moti_fin_peri" text,
    "codi_moti_fin_peri_sunat" text,
    "desc_moti_fin_peri" text
);
CREATE TABLE "legacy_raw"."nivel" (
    "codi_nivel" text,
    "codi_nivel_sunat" text,
    "desc_nivel" text,
    "nemo_nivel" text
);
CREATE TABLE "legacy_raw"."ocupacion" (
    "codi_ocu" text,
    "codi_ocu_sunat" text,
    "desc_ocu" text,
    "nemo_ocu" text
);
CREATE TABLE "legacy_raw"."pagos_adelantos" (
    "codi_adel" text,
    "nro_pago" text,
    "fech_pago" text,
    "codi_mone" text,
    "monto" text,
    "observacion" text
);
CREATE TABLE "legacy_raw"."pagos_prestamos" (
    "codi_pres" text,
    "nro_pago" text,
    "fech_pago" text,
    "codi_mone" text,
    "monto" text,
    "observacion" text
);
CREATE TABLE "legacy_raw"."parametros_quinta" (
    "nro_para" text,
    "fech_para" text,
    "esta_para" text,
    "nro_mini_uit" text,
    "nro_maxi_uit" text,
    "porcentaje" text
);
CREATE TABLE "legacy_raw"."pension" (
    "codi_pension" text,
    "codi_pension_sunat" text,
    "desc_pension" text,
    "nemo_pension" text
);
CREATE TABLE "legacy_raw"."periodicidad" (
    "codi_periodo" text,
    "codi_periodo_sunat" text,
    "desc_periodo" text
);
CREATE TABLE "legacy_raw"."pers_dato_adic" (
    "codi_pers" text,
    "nro_cert_salu" text,
    "cert_ante_poli" text,
    "cert_ante_pena_alfa" text,
    "sabe_nadar" text,
    "smo" text,
    "tipo_smo" text,
    "carn_discamet" text,
    "lice_port_arma" text,
    "nro_carn_disc" text,
    "nro_lice_arma_alfa" text
);
CREATE TABLE "legacy_raw"."pers_refe_labo" (
    "codi_pers" text,
    "fech_inic" text,
    "fech_term" text,
    "empresa" text,
    "cargo" text
);
CREATE TABLE "legacy_raw"."pers_soli" (
    "codi_pers" text,
    "apel_pers" text
);
CREATE TABLE "legacy_raw"."pers_trip_vige_cert" (
    "codi_vige_cert_trip" text,
    "codi_pers" text,
    "fech_inic_vige" text,
    "fech_term_vige" text,
    "nro_matr" text,
    "codi_carg" text,
    "tipo_titu" text
);
CREATE TABLE "legacy_raw"."personal" (
    "codi_pers" text,
    "codi_tipo_docu" text,
    "nro_docu_iden" text,
    "apel_1" text,
    "apel_2" text,
    "nomb_1" text,
    "nomb_2" text,
    "codi_sist_pens" text,
    "codi_carg" text,
    "codi_area" text,
    "codi_mone_basi" text,
    "suel_basi" text,
    "fech_ingre" text,
    "essalud" text,
    "carn_essalud" text,
    "esta_civi" text,
    "fech_naci" text,
    "asig_fami" text,
    "esta_acti" text,
    "scrt" text,
    "comi_pesc" text,
    "nro_cupss" text,
    "afil_sind" text,
    "nro_censo" text,
    "tipo_cont" text,
    "codi_mone" text,
    "suel_neto" text,
    "carg_fami" text,
    "sexo" text,
    "nacionalidad" text,
    "direccion" text,
    "e_mail" text,
    "tipo_situ_labo" text,
    "segu_vida_ley" text,
    "nro_lib_emb" text,
    "fech_cese" text,
    "clave" text,
    "jubilado" text,
    "form_pago" text,
    "codi_anti" text,
    "mont_pago_come" text,
    "hora_labo" text,
    "codi_unid_oper" text,
    "fech_inic_jubi" text,
    "codi_rela" text,
    "moti_cese" text,
    "provincia" text,
    "distrito" text,
    "vcmto" text,
    "departamento" text,
    "observaciones" text,
    "codi_tipo_ries" text,
    "ubigeo" text,
    "foto_si_no" text,
    "fech_inic_afil" text,
    "dist_naci" text,
    "prov_naci" text,
    "codi_area_grup" text,
    "codi_sub_area_grup" text,
    "hora_auto" text,
    "grat" text,
    "vaca" text,
    "codi_luga_trab" text,
    "afecto_ley" text,
    "fotocheck" text,
    "horario" text,
    "codi_cate_trab" text,
    "apor_essa" text,
    "apor_sena" text,
    "apor_senc" text,
    "apor_cona" text,
    "tipo_sangr" text,
    "peso_kilo" text,
    "tall_metr" text,
    "codi_elem_costo" text,
    "codi_tipo_docu_iden" text,
    "codi_nacion" text,
    "codi_via" text,
    "nomb_via" text,
    "num_via" text,
    "interior_via" text,
    "codi_zona" text,
    "nomb_zona" text,
    "codi_ubi_reg" text,
    "codi_ubi_prov" text,
    "codi_ubi_dist" text,
    "telefono" text,
    "condi_domi" text,
    "codi_pension" text,
    "codi_situ_trab_pens" text,
    "codi_moti_fin_peri" text,
    "ruc" text,
    "labora_sabado" text,
    "refe_zona" text,
    "codi_empre_estab" text,
    "codi_pais_emi" text
);
CREATE TABLE "legacy_raw"."personal_categoria" (
    "codi_pers_categ" text,
    "codi_pers" text,
    "tipo_cat_trab" text,
    "essalud" text,
    "ruc" text,
    "codi_elem_costo" text,
    "codi_tipo_docu_iden" text,
    "codi_tipo_cont" text,
    "condi_domi" text,
    "codi_tipo_pers" text,
    "codi_nivel" text,
    "codi_ocu" text,
    "discapacidad" text,
    "codi_pension" text,
    "fech_ingre" text,
    "nro_cupss" text,
    "scrt" text,
    "sctr_pension" text,
    "sujeto_reg_alter" text,
    "sujeto_jornada_max" text,
    "horario_noctur" text,
    "sindicalizado" text,
    "codi_periodo" text,
    "codi_enti" text,
    "codi_situ_trab_pens" text,
    "renta_qta_cat_exo_inaf" text,
    "regi_labo" text,
    "form_pago" text,
    "tipo_seg_med" text,
    "madre_resp_fam" text,
    "centro_form_prof" text,
    "codi_cate_trab" text,
    "codi_sist_pens" text,
    "infor_otros_ingr_qta_cat" text,
    "afi_eps_serv_prop" text,
    "codi_tipo_medio_pago" text,
    "cod_categ_ocup" text,
    "cod_conv_evita_dob_tribu" text,
    "afilia_asegura_pension" text,
    "codi_regi_labo" text,
    "afp_mixta" text
);
CREATE TABLE "legacy_raw"."personal_otros_emple_qta_cat" (
    "codi_poe" text,
    "codi_pers_categ" text,
    "ruc" text,
    "razon_social" text
);
CREATE TABLE "legacy_raw"."personal_periodo" (
    "codi_periodo" text,
    "codi_pers_categ" text,
    "fech_inicio" text,
    "fech_fin" text,
    "codi_moti_fin_peri" text,
    "codi_moda_forma" text,
    "nro_operacion" text,
    "anio" text,
    "medio_presenta" text
);
CREATE TABLE "legacy_raw"."personal_por_tipo_trabajador" (
    "codi_pers" text,
    "codi_tipo_pers" text
);
CREATE TABLE "legacy_raw"."personal_saludos" (
    "codi_pers" text,
    "saludo_1" text,
    "saludo_2" text,
    "saludo_3" text,
    "saludo_4" text
);
CREATE TABLE "legacy_raw"."personal_seguros" (
    "codi_pers" text,
    "codi_segu" text,
    "fech_segu" text,
    "tipo_cant" text,
    "codi_mone" text,
    "valor" text
);
CREATE TABLE "legacy_raw"."personal_turno" (
    "codi_pers" text,
    "codi_turn" text,
    "fech_inic" text,
    "fech_term" text
);
CREATE TABLE "legacy_raw"."personal_valores_defecto" (
    "codi_tipo_docu" text,
    "codi_sist_pens" text,
    "codi_carg" text,
    "codi_area" text,
    "codi_mone_basi" text,
    "essalud" text,
    "esta_civi" text,
    "esta_acti" text,
    "scrt" text,
    "comi_pesc" text,
    "afil_sind" text,
    "tipo_cont" text,
    "codi_mone" text,
    "carg_fami" text,
    "sexo" text,
    "tipo_situ_labo" text,
    "segu_vida_ley" text,
    "jubilado" text,
    "form_pago" text,
    "hora_labo" text,
    "codi_tipo_ries" text,
    "foto_si_no" text,
    "hora_auto" text,
    "grat" text,
    "vaca" text,
    "codi_luga_trab" text,
    "afecto_ley" text,
    "fotocheck" text,
    "horario" text,
    "codi_cate_trab" text,
    "apor_essa" text,
    "apor_sena" text,
    "apor_senc" text,
    "apor_cona" text,
    "codi_elem_costo" text,
    "codi_tipo_docu_iden" text,
    "codi_nacion" text,
    "codi_ubi_dist" text,
    "condi_domi" text,
    "codi_pension" text,
    "codi_situ_trab_pens" text,
    "codi_moti_fin_peri" text,
    "labora_sabado" text,
    "regi_labo" text,
    "infor_otros_ingr_qta_cat" text,
    "renta_qta_cat_exo_inaf" text,
    "afi_eps_serv_prop" text,
    "sujeto_jornada_max" text,
    "codi_periodo" text,
    "sctr_pension" text,
    "sctr_salud" text
);
CREATE TABLE "legacy_raw"."plan_conc_desc" (
    "codi_prin" text,
    "codi_plan_conc" text,
    "codi_conc" text,
    "codi_desc" text,
    "nro_pago" text,
    "codi_tipo_trab" text,
    "indi_tipo_desc" text,
    "valor" text,
    "indi_tiem_desc" text
);
CREATE TABLE "legacy_raw"."plan_conc_incr" (
    "codi_prin" text,
    "codi_plan_conc" text,
    "codi_conc" text,
    "codi_pers" text,
    "nro_incre" text,
    "codi_tipo_pers" text,
    "valor" text
);
CREATE TABLE "legacy_raw"."planilla_boni_concepto" (
    "codi_plan_boni" text,
    "codi_conc" text,
    "afecto" text,
    "valor" text,
    "monto" text
);
CREATE TABLE "legacy_raw"."planilla_boni_moto" (
    "codi_plan_boni" text,
    "mesanio" text,
    "codi_unid_oper" text,
    "codi_pers" text,
    "importe" text,
    "fech_pago" text,
    "form_pago" text,
    "nro_cheque" text,
    "tipo" text
);
CREATE TABLE "legacy_raw"."planilla_boni_tripu" (
    "codi_plan_btri" text,
    "codi_sema" text,
    "codi_pers" text,
    "codi_tipo_plan" text,
    "estado" text,
    "importe" text,
    "form_pago" text,
    "nro_cheque" text,
    "fech_pago" text,
    "codi_unid_oper" text,
    "importe_especial" text,
    "nro_asis" text,
    "mesanio" text
);
CREATE TABLE "legacy_raw"."planilla_bonitri_conceptos" (
    "codi_plan_btri" text,
    "codi_conc" text,
    "afecto" text,
    "valor" text,
    "monto" text,
    "especial" text,
    "codi" text
);
CREATE TABLE "legacy_raw"."planilla_cts_conceptos" (
    "codi_plan_cts" text,
    "codi_conc" text,
    "afecto" text,
    "valor" text,
    "monto" text
);
CREATE TABLE "legacy_raw"."planilla_de_empleados" (
    "codi_plan_empl" text,
    "anio" text,
    "mes" text,
    "codi_pers" text,
    "codi_tipo_plan" text,
    "fech_inic" text,
    "fech_term" text,
    "importe" text,
    "estado" text,
    "indi_tiem" text,
    "form_pago" text,
    "nro_cheq" text,
    "fech_pago" text,
    "codi_sist_pens" text,
    "codi_tipo_pers" text,
    "semana" text,
    "codi_unid_oper" text
);
CREATE TABLE "legacy_raw"."planilla_de_obreros" (
    "codi_plan_obre" text,
    "fech_inic" text,
    "fech_term" text,
    "codi_pers" text,
    "codi_tipo_plan" text,
    "importe" text,
    "anio" text,
    "mes" text,
    "estado" text,
    "indi_tiem" text,
    "form_pago" text,
    "nro_cheq" text,
    "fech_pago" text,
    "codi_sist_pens" text,
    "codi_tipo_pers" text,
    "semana" text,
    "codi_unid_oper" text
);
CREATE TABLE "legacy_raw"."planilla_de_tripulantes" (
    "codi_plan_trip" text,
    "codi_sema" text,
    "codi_pers" text,
    "codi_tipo_plan" text,
    "estado" text,
    "importe" text,
    "form_pago" text,
    "nro_cheq" text,
    "fech_pago" text,
    "codi_unid_oper" text,
    "importe_especial" text,
    "nro_asis" text,
    "mesanio" text
);
CREATE TABLE "legacy_raw"."planilla_empleado_conceptos" (
    "codi_plan_empl" text,
    "codi_conc" text,
    "afecto" text,
    "valor" text,
    "monto" text
);
CREATE TABLE "legacy_raw"."planilla_grati_vaca" (
    "codi_plan_grva" text,
    "codi_sema" text,
    "codi_pers" text,
    "codi_tipo_plan" text,
    "estado" text,
    "importe" text,
    "form_pago" text,
    "nro_cheq" text,
    "fech_pago" text,
    "codi_unid_oper" text,
    "nro_asis" text,
    "mesanio" text
);
CREATE TABLE "legacy_raw"."planilla_grati_vaca_concep" (
    "codi_plan_grva" text,
    "codi_conc" text,
    "afecto" text,
    "valor" text,
    "monto" text,
    "codi" text
);
CREATE TABLE "legacy_raw"."planilla_obrero_conceptos" (
    "codi_plan_obre" text,
    "codi_conc" text,
    "afecto" text,
    "valor" text,
    "monto" text
);
CREATE TABLE "legacy_raw"."planilla_pesca_tripulantes" (
    "codi_sema" text,
    "codi_unid_oper" text,
    "codi_pers" text,
    "codi_carg" text,
    "dia" text,
    "nom_dia" text,
    "pesc_real" text,
    "prec_snp" text,
    "porc_distr" text,
    "parte" text,
    "adicional" text,
    "monto" text,
    "refri" text,
    "espe_parte" text,
    "espe_adic" text,
    "espe_monto" text,
    "nro_asis" text,
    "mesanio" text
);
CREATE TABLE "legacy_raw"."planilla_subs_concepto" (
    "codi_plan_subs" text,
    "codi_conc" text,
    "afecto" text,
    "valor" text,
    "monto" text
);
CREATE TABLE "legacy_raw"."planilla_subsidio" (
    "codi_plan_subs" text,
    "mesanio" text,
    "codi_unid_oper" text,
    "codi_pers" text,
    "importe" text,
    "fech_pago" text,
    "form_pago" text,
    "nro_cheque" text,
    "tipo" text,
    "codi_sema" text
);
CREATE TABLE "legacy_raw"."planilla_tripulante_conceptos" (
    "codi_plan_trip" text,
    "codi_conc" text,
    "afecto" text,
    "valor" text,
    "monto" text,
    "especial" text,
    "codi" text
);
CREATE TABLE "legacy_raw"."prestamos" (
    "codi_pres" text,
    "codi_pers" text,
    "nro_pres" text,
    "fech_pres" text,
    "moti_pres" text,
    "esta_acti" text,
    "tipo_desc" text,
    "codi_mone" text,
    "monto" text,
    "mont_desc" text,
    "inte_tiem_desc" text,
    "saldo" text,
    "presupuesto" text,
    "codi_baza" text,
    "registro" text,
    "codi_tipo_pres" text
);
CREATE TABLE "legacy_raw"."regimen_laboral" (
    "codigo" text,
    "descripcion" text,
    "abreviada" text,
    "privado" text,
    "publico" text,
    "otros" text
);
CREATE TABLE "legacy_raw"."rubros_sistema_pensiones" (
    "codi_rubr" text,
    "desc_rubr" text,
    "tipo_cant" text,
    "esta_rubr" text
);
CREATE TABLE "legacy_raw"."sindicatos" (
    "codi_sind" text,
    "descrip" text,
    "tipo" text,
    "codi_clie_prov" text,
    "porcentaje" text,
    "tipo_valor" text,
    "nemo" text
);
CREATE TABLE "legacy_raw"."sindicatos_personal" (
    "codi_sind" text,
    "codi_pers" text,
    "estado" text
);
CREATE TABLE "legacy_raw"."sistema_pensiones" (
    "codi_sist_pens" text,
    "desc_sist_pens" text,
    "nemo" text,
    "codi_rela" text,
    "codi_pension" text,
    "afpnet" text
);
CREATE TABLE "legacy_raw"."situ_trab_pens" (
    "codi_situ_trab_pens" text,
    "codi_situ_trab_pens_sunat" text,
    "afiliado_eps" text,
    "desc_situ_trab_pens" text,
    "codi_situ_trab_pens_plame" text
);
CREATE TABLE "legacy_raw"."soli_pres" (
    "codi_soli_pres" text,
    "nro_soli_pres" text,
    "codi_pers" text,
    "fech_soli" text,
    "impo_soli" text,
    "situ_actu" text,
    "codi_usua_dato" text,
    "fech_regi_dato" text,
    "impo_otor" text,
    "form_desc" text,
    "nro_sema_desc" text,
    "peri_desc" text,
    "mes_desc" text,
    "plaz_pago" text,
    "fech_prim_pago" text,
    "nro_cuotas" text,
    "observacion" text,
    "observacion1" text,
    "desc_pres" text
);
CREATE TABLE "legacy_raw"."soli_pres_cron_devo" (
    "codi_soli_pres" text,
    "nro_item" text,
    "nro_cuot" text,
    "fech_venc" text,
    "mont_cuot" text
);
CREATE TABLE "legacy_raw"."soli_pres_ingr_desc" (
    "codi_soli_pres" text,
    "nro_item" text,
    "tipo_mont" text,
    "desc_mont" text,
    "monto" text
);
CREATE TABLE "legacy_raw"."sub_area_grup" (
    "codi_sub_area_grup" text,
    "desc_sub_area_grup" text,
    "nemo_sub_area_grup" text,
    "nro_jera" text,
    "codi_area_grup" text
);
CREATE TABLE "legacy_raw"."subsidios" (
    "mesanio" text,
    "codi_pers" text,
    "codi_unid_oper" text,
    "codi_carg" text,
    "monto" text,
    "dias" text,
    "codi_sema" text,
    "certificado" text,
    "fecha_inicio" text,
    "fecha_fin" text,
    "codi_mone" text,
    "tipocambio" text,
    "pagoempresa" text,
    "pagoessalud" text,
    "fechapago" text,
    "observaciones" text
);
CREATE TABLE "legacy_raw"."tipo_cargo" (
    "codi_tipo_carg" text,
    "desc_tipo_carg" text
);
CREATE TABLE "legacy_raw"."tipo_comida" (
    "codi_tipo_comi" text,
    "desc_tipo_comi" text
);
CREATE TABLE "legacy_raw"."tipo_conceptos" (
    "codi_tipo" text,
    "descripcion" text
);
CREATE TABLE "legacy_raw"."tipo_contrato" (
    "codi_tipo_cont" text,
    "codi_tipo_cont_sunat" text,
    "desc_tipo_cont" text
);
CREATE TABLE "legacy_raw"."tipo_personal" (
    "codi_tipo_pers" text,
    "codi_tipo_pers_sunat" text,
    "desc_tipo_pers" text,
    "nemo_tipo_pers" text
);
CREATE TABLE "legacy_raw"."tipo_plan_nemo" (
    "codi_nemo_plan" text,
    "nemo_plan" text,
    "desc_nemo_plan" text,
    "codi_tipo_plan" text,
    "codi_tipo_pers" text
);
CREATE TABLE "legacy_raw"."tipo_prestamo" (
    "codi_tipo_pres" text,
    "desc_tipo_pres" text,
    "nemo_tipo_pres" text
);
CREATE TABLE "legacy_raw"."tipo_ries_tasa" (
    "codi_tipo_ries" text,
    "fech_inic" text,
    "fech_fin" text,
    "codi_tipo_pers" text,
    "tasa" text
);
CREATE TABLE "legacy_raw"."tipo_riesgo" (
    "codi_tipo_ries" text,
    "desc_tipo_ries" text,
    "nemo" text
);
CREATE TABLE "legacy_raw"."tipo_situ_hora_trab" (
    "codi_tipo_situ_hora" text,
    "desc_situ_hora" text,
    "abre_situ_hora" text
);
CREATE TABLE "legacy_raw"."tipo_suspension" (
    "codi_tipo_susp_labo" text,
    "codi_tipo_susp_labo_sunat" text,
    "desc_tipo_susp_labo" text,
    "tipo" text
);
CREATE TABLE "legacy_raw"."tipo_trabajador" (
    "codi_tipo_pers" text,
    "desc_tipo_pers" text
);
CREATE TABLE "legacy_raw"."tipo_vacaciones" (
    "codi_tipo_vaca" text,
    "desc_tipo_vaca" text
);
CREATE TABLE "legacy_raw"."tipos_licencias" (
    "codi_tipo_lice" text,
    "desc_lice" text,
    "nro_dias_remu" text
);
CREATE TABLE "legacy_raw"."tipos_planillas" (
    "codi_tipo_plan" text,
    "desc_tipo_plan" text
);
CREATE TABLE "legacy_raw"."turnos" (
    "codi_turn" text,
    "desc_turn" text,
    "hora_ini" text,
    "hora_ter" text
);
CREATE TABLE "legacy_raw"."util_pers_anual" (
    "codi_pers" text,
    "periodo" text,
    "importe" text
);
CREATE TABLE "legacy_raw"."vacaciones" (
    "codi_pers" text,
    "fech_inic" text,
    "fech_term" text,
    "nro_dias" text,
    "anio" text,
    "mes" text,
    "esta_acti" text,
    "observaciones" text,
    "codi_tipo_vaca" text,
    "anio_ini" text,
    "anio_fin" text
);
CREATE TABLE "legacy_raw"."valores_sistema_pensiones" (
    "codi_sist_pens" text,
    "codi_rubr" text,
    "anio_mes" text,
    "valor" text
);
CREATE TABLE "legacy_raw"."vinculo_familiar" (
    "codi_vinc_fami" text,
    "codi_vinc_fami_sunat" text,
    "desc_vinc_fami" text
);
CREATE TABLE "legacy_raw"."acceso" (
    "cod_acceso" text,
    "codi_usua" text,
    "fecha_acce" text,
    "hora" text,
    "tipo" text,
    "glosa" text
);
CREATE TABLE "legacy_raw"."aceptacion_x_usuario" (
    "codi_usua" text,
    "codi_tipo_acep" text,
    "crear" text,
    "modificar" text,
    "eliminar" text,
    "guardar" text
);
CREATE TABLE "legacy_raw"."auditoria" (
    "anio" text,
    "mes" text,
    "fecha" text,
    "maquina" text,
    "aplicacion" text,
    "codi_usua" text,
    "accion" text,
    "objeto" text,
    "codigo" text,
    "observacion" text
);
CREATE TABLE "legacy_raw"."cierre_mes" (
    "codi_cierre" text,
    "anio" text,
    "mes" text,
    "estado" text
);
CREATE TABLE "legacy_raw"."cierre_mes_user" (
    "codi_cierre" text,
    "codi_usua" text,
    "mes" text,
    "anio" text
);
CREATE TABLE "legacy_raw"."conexion" (
    "empresa" text,
    "_dbms" text,
    "_servername" text,
    "_logpass" text,
    "_logid" text,
    "_autocommit" text,
    "_database" text,
    "_dbparm" text
);
CREATE TABLE "legacy_raw"."configsys" (
    "id_conf" text,
    "valor" text
);
CREATE TABLE "legacy_raw"."consistencias" (
    "cuenta" text,
    "cargo_abono" text
);
CREATE TABLE "legacy_raw"."empresa" (
    "razon_social" text,
    "ruc" text,
    "representante" text,
    "docu_iden_repr" text,
    "cargo" text,
    "direccion" text,
    "telefono" text,
    "fax" text,
    "direccion_" text,
    "telefono_" text,
    "fax_" text,
    "acti_econ_prin" text,
    "nro_regi" text,
    "fech_incr" text,
    "ubigeo" text,
    "obje_soci" text,
    "obje_soci_2" text,
    "tipo_empr" text,
    "ciiu" text,
    "cuen_con_inmu" text,
    "e_mail" text,
    "pagi_web" text,
    "departamento" text,
    "provincia" text,
    "distrito" text,
    "urbanizacion" text,
    "codi_caja" text,
    "inicial" text,
    "dnirepre" text,
    "nom_bole" text,
    "car_bole" text,
    "docu_bole" text,
    "dat_mostrar" text,
    "grupo" text,
    "sector" text,
    "repr_flota" text,
    "dni_repr_flot" text,
    "codi_tipo_empr" text,
    "iqf_reg_uso" text,
    "iqf_reg_ru" text,
    "ruta_archivo" text,
    "ubl_21" text
);
CREATE TABLE "legacy_raw"."empresa_establec_tasas" (
    "codi_tasa" text,
    "codi_empre_estab" text,
    "tasa" text,
    "estado" text
);
CREATE TABLE "legacy_raw"."empresa_establecimiento" (
    "codi_empre_estab" text,
    "codi_empre" text,
    "codigo_denomi" text,
    "denominacion" text,
    "codi_tipo_estab" text,
    "centro_riesgo" text
);
CREATE TABLE "legacy_raw"."firmas" (
    "f1" text,
    "f2" text,
    "f3" text,
    "f4" text,
    "f5" text
);
CREATE TABLE "legacy_raw"."grupos" (
    "codi_grup" text,
    "nomb_grup" text
);
CREATE TABLE "legacy_raw"."menugrupos" (
    "codi_menu" text,
    "nomb_menu" text,
    "codi_grup" text,
    "activo" text,
    "nivel" text,
    "clase" text
);
CREATE TABLE "legacy_raw"."notas_posits" (
    "idd_nota" text,
    "fecha" text,
    "descripcion" text,
    "codi_alma" text,
    "estado" text
);
CREATE TABLE "legacy_raw"."parametro" (
    "cod_param" text,
    "desc_param" text,
    "unid_medi" text,
    "nemo" text,
    "orden_repo" text,
    "limitemin" text,
    "limitemax" text,
    "optimo" text,
    "codi_prod" text,
    "tipo" text,
    "calculable" text
);
CREATE TABLE "legacy_raw"."parametros" (
    "id_parm" text,
    "desc_parm" text,
    "valor_parm" text,
    "valor1" text,
    "valor2" text,
    "codi_alma" text
);
CREATE TABLE "legacy_raw"."usuarios" (
    "codi_usua" text,
    "apel_1" text,
    "apel_2" text,
    "nomb_1" text,
    "nomb_2" text,
    "codi_pers" text,
    "login" text,
    "clave" text,
    "fech_inic_vige" text,
    "esta_clav" text,
    "codi_carg" text,
    "codi_grup" text,
    "fech_camb" text,
    "recordar" text,
    "codi_alma" text,
    "multi_acceso" text
);
CREATE TABLE "legacy_raw"."usuarios_grupos" (
    "codi_usua" text,
    "codi_grup" text
);
CREATE TABLE "legacy_raw"."viso_even" (
    "fech_even" text,
    "codi_pers" text,
    "desc_even" text,
    "name_pc" text
);
CREATE TABLE "legacy_raw"."visor_de_eventos" (
    "id" text,
    "opcion" text,
    "usuario" text,
    "accion" text,
    "informacion" text,
    "computer" text,
    "fecha" text
);
CREATE TABLE "legacy_raw"."artificio_tablas" (
    "codi_uso" text,
    "uso" text,
    "descripcion" text,
    "nom_dataobject" text,
    "condicion_de_uso" text,
    "uso_si_o_no" text,
    "filtro1_nombre" text,
    "filtro1_valor" text,
    "filtro1_valor_inter" text
);
CREATE TABLE "legacy_raw"."artificio_tablas_copy" (
    "uso" text,
    "descripcion" text,
    "nom_dataobject" text,
    "condicion_de_uso" text,
    "uso_si_o_no" text,
    "filtro1_nombre" text,
    "filtro1_valor" text
);
CREATE TABLE "legacy_raw"."artificio_uso_objetopb" (
    "codi_uso" text,
    "uso" text,
    "objeto_pb" text
);
CREATE TABLE "legacy_raw"."cliente_proveedor_aux" (
    "id" text,
    "codigo" text,
    "ruc" text,
    "nuevo_ruc" text
);
CREATE TABLE "legacy_raw"."cliente_proveedor_tempo" (
    "ide" text,
    "codi_clie_prov" text,
    "tipo_pers" text,
    "razo_soci" text,
    "ruc" text,
    "e_mail" text,
    "nuevo_ruc" text
);
CREATE TABLE "legacy_raw"."cp" (
    "a" text,
    "codi_cp" text,
    "razon" text
);
CREATE TABLE "legacy_raw"."detalle_salida_aux" (
    "codi_deta_docu_sali" text,
    "codi_docu_sali" text,
    "nro_cuen" text,
    "codi_prod" text,
    "cantidad" text,
    "prec_costo" text,
    "prec_prom" text,
    "stoc_sali" text,
    "fech_ulti_sali" text,
    "cant_ulti_sali" text,
    "codi_orde_pedi" text,
    "codi_unid_oper" text,
    "codi_alma" text,
    "codi_alma_desti" text,
    "codi_deta_orde_pedi" text,
    "prec_kard" text,
    "concen_iqf" text,
    "prodserviqf" text,
    "canti_prodserviqf" text,
    "um_prodserviqf" text,
    "deseiqf" text,
    "canti_deseiqf" text,
    "um_deseiqf" text,
    "canti_rhpm_iqf" text,
    "um_rhpm_iqf" text,
    "moti_rhpm_iqf" text,
    "observaciones" text
);
CREATE TABLE "legacy_raw"."eliminar_corre" (
    "correlativo" text,
    "fecha" text,
    "codi_tipo_docu" text,
    "serie" text,
    "nro_docu" text
);
CREATE TABLE "legacy_raw"."kadm" (
    "codigo" text,
    "desc_prod" text,
    "afecto" text,
    "sub_fami" text,
    "familia" text,
    "linea" text,
    "saldo" text,
    "laboratorio" text,
    "almacen" text,
    "stock_inv" text
);
CREATE TABLE "legacy_raw"."kadm2015" (
    "codigo" text,
    "desc_prod" text,
    "afecto" text,
    "sub_fami" text,
    "familia" text,
    "linea" text,
    "saldo" text,
    "laboratorio" text,
    "almacen" text
);
CREATE TABLE "legacy_raw"."le201707" (
    "columna 0" text,
    "columna 1" text,
    "columna 2" text,
    "columna 3" text,
    "columna 4" text,
    "columna 5" text,
    "columna 6" text,
    "columna 7" text,
    "columna 8" text,
    "columna 9" text,
    "columna 10" text,
    "columna 11" text,
    "columna 12" text,
    "columna 13" text,
    "columna 14" text,
    "columna 15" text,
    "columna 16" text,
    "columna 17" text,
    "columna 18" text,
    "columna 19" text,
    "columna 20" text,
    "columna 21" text,
    "columna 22" text,
    "columna 23" text,
    "columna 24" text,
    "columna 25" text,
    "columna 26" text,
    "columna 27" text,
    "columna 28" text,
    "columna 29" text,
    "columna 30" text,
    "columna 31" text,
    "columna 32" text,
    "columna 33" text,
    "columna 34" text,
    "columna 35" text
);
CREATE TABLE "legacy_raw"."movi_contables_ax" (
    "idd" text,
    "codi_contable" text,
    "anio" text,
    "mes" text,
    "subdia" text,
    "compr" text,
    "codi_mone" text,
    "fecha" text,
    "nro_cuen" text,
    "nro_sub_cuen" text,
    "codi_clie_prov" text,
    "serie" text,
    "nro_docu" text,
    "codi_tipo_docu" text,
    "importe" text,
    "igv" text,
    "otros" text,
    "total" text,
    "importe_d" text,
    "igv_d" text,
    "otros_d" text,
    "total_d" text,
    "registro" text,
    "codi_unid_oper" text,
    "glosa" text,
    "cargo_abono" text,
    "fecha_venc" text,
    "tipo_cambio" text,
    "situ_cheq" text,
    "tipo_cambio_2" text,
    "codi_vouc" text,
    "fecha_spot" text,
    "num_spot" text,
    "codi_pers" text,
    "codi_sema" text,
    "codi_nota_ingr" text,
    "nro_orde_comp" text,
    "nro_orde_pedi" text,
    "codi_pres" text,
    "nro_presu" text,
    "banco" text,
    "cartera" text,
    "hecho_por" text,
    "itf" text,
    "compensa" text,
    "detraccion" text,
    "fech_pago" text,
    "ref" text,
    "nro_fact" text,
    "codi_memo" text,
    "tipo_movi" text,
    "codi_desti" text,
    "codi_tasa_detr" text,
    "retencion" text,
    "codi_ingr" text,
    "codi_alma" text,
    "codi_tipo_intan" text,
    "codi_aduana" text,
    "anio_dua_dsi" text,
    "nro_detrac" text,
    "fecha_detrac" text,
    "fecha_nd_nc" text,
    "tipo_docu_nd_nc" text,
    "serie_nd_nc" text,
    "nro_docu_nd_nc" text,
    "tipo_venta" text,
    "codi_libro_regi" text,
    "codi_tipo_medio_pago" text,
    "banco_aux" text,
    "fecha_creacion" text,
    "estado_inic" text,
    "creacion" text,
    "id_flujo" text,
    "id_tipo_flujo" text,
    "codi_oper" text,
    "codi_bien_serv" text,
    "pdetr" text,
    "valor_refe" text
);
CREATE TABLE "legacy_raw"."orden_produc_deta_material_copy" (
    "codi_orde_produc" text,
    "codi_prod" text
);
CREATE TABLE "legacy_raw"."paper" (
    "codi" text,
    "descrip" text
);
CREATE TABLE "legacy_raw"."pbcatcol" (
    "pbc_tnam" text,
    "pbc_tid" text,
    "pbc_ownr" text,
    "pbc_cnam" text,
    "pbc_cid" text,
    "pbc_labl" text,
    "pbc_lpos" text,
    "pbc_hdr" text,
    "pbc_hpos" text,
    "pbc_jtfy" text,
    "pbc_mask" text,
    "pbc_case" text,
    "pbc_hght" text,
    "pbc_wdth" text,
    "pbc_ptrn" text,
    "pbc_bmap" text,
    "pbc_init" text,
    "pbc_cmnt" text,
    "pbc_edit" text,
    "pbc_tag" text
);
CREATE TABLE "legacy_raw"."pbcatedt" (
    "pbe_name" text,
    "pbe_edit" text,
    "pbe_type" text,
    "pbe_cntr" text,
    "pbe_seqn" text,
    "pbe_flag" text,
    "pbe_work" text
);
CREATE TABLE "legacy_raw"."pbcatfmt" (
    "pbf_name" text,
    "pbf_frmt" text,
    "pbf_type" text,
    "pbf_cntr" text
);
CREATE TABLE "legacy_raw"."pbcattbl" (
    "pbt_tnam" text,
    "pbt_tid" text,
    "pbt_ownr" text,
    "pbd_fhgt" text,
    "pbd_fwgt" text,
    "pbd_fitl" text,
    "pbd_funl" text,
    "pbd_fchr" text,
    "pbd_fptc" text,
    "pbd_ffce" text,
    "pbh_fhgt" text,
    "pbh_fwgt" text,
    "pbh_fitl" text,
    "pbh_funl" text,
    "pbh_fchr" text,
    "pbh_fptc" text,
    "pbh_ffce" text,
    "pbl_fhgt" text,
    "pbl_fwgt" text,
    "pbl_fitl" text,
    "pbl_funl" text,
    "pbl_fchr" text,
    "pbl_fptc" text,
    "pbl_ffce" text,
    "pbt_cmnt" text
);
CREATE TABLE "legacy_raw"."pbcatvld" (
    "pbv_name" text,
    "pbv_vald" text,
    "pbv_type" text,
    "pbv_cntr" text,
    "pbv_msg" text
);
CREATE TABLE "legacy_raw"."productos_matriz_x" (
    "id_mat" text,
    "codi_prod" text,
    "codi_rota" text,
    "fecha" text
);
CREATE TABLE "legacy_raw"."productos_xx" (
    "codi_prod" text,
    "desc_prod" text,
    "codi_sub_fami_prod" text,
    "codi_unid_medi" text,
    "codi_mone" text,
    "prec_prom" text,
    "stock" text,
    "stoc_mini" text,
    "stoc_maxi" text,
    "punt_repe" text,
    "fech_venc" text,
    "esta_prod" text,
    "stoc_temp" text,
    "ubicacion" text,
    "nro_cuen" text,
    "iqf" text,
    "porc_detr" text,
    "poli_prec" text,
    "exonerado" text,
    "prec_list_1" text,
    "prec_list_2" text,
    "cost_prod" text,
    "analisis" text,
    "material" text,
    "codi_clie_prov" text,
    "cod_pres" text,
    "fec_registro" text,
    "prec_prov" text,
    "descto_compra" text,
    "descto_porcenta" text,
    "cod_impuesto" text,
    "tcambio" text,
    "nro_decim_precio" text,
    "costo_oper" text
);
CREATE TABLE "legacy_raw"."px" (
    "codi_alma" text,
    "codi_prod" text,
    "modi" text
);
CREATE TABLE "legacy_raw"."registro_axu" (
    "registro" text,
    "importe" text
);
CREATE TABLE "legacy_raw"."sheet" (
    "producto" text,
    "mo" text,
    "presentac#" text,
    "stock" text,
    "x espec#" text,
    "a/e" text,
    "codi_prod" text
);
CREATE TABLE "legacy_raw"."tempo" (
    "nro_fila" text,
    "anio" text,
    "mes" text,
    "subdia" text,
    "compr" text,
    "compr_num" text
);
CREATE TABLE "legacy_raw"."tx" (
    "idd" text,
    "codi_alma" text,
    "codi_prod" text,
    "modi" text
);
CREATE TABLE "legacy_raw"."tx2" (
    "idd" text,
    "codi_alma" text,
    "codi_prod" text,
    "modi" text,
    "origi" text
);
CREATE TABLE "legacy_raw"."tx3" (
    "idd" text,
    "codi_alma" text,
    "codi_prod" text,
    "modi" text,
    "origi" text
);
CREATE TABLE "legacy_raw"."txprod" (
    "codigo" text
);
CREATE TABLE "legacy_raw"."v2017" (
    "sucursal" text,
    "linea" text,
    "subfamilia" text,
    "familia" text,
    "proveedor" text,
    "producto" text,
    "pres" text,
    "cliente" text,
    "fecha" text,
    "pago" text,
    "documento" text,
    "serie" text,
    "numero" text,
    "cantidad" text,
    "precio_venta" text,
    "precio_lista" text,
    "dif" text,
    "codi_prod" text,
    "codi_clie_prov" text,
    "codi_tipo_docu" text
);
CREATE TABLE "legacy_raw"."acta_entrega" (
    "codi_act" text,
    "fecha" text,
    "nro" text,
    "codi_alma" text,
    "codi_clie_prov" text,
    "estado" text,
    "persona_responsable" text,
    "dni" text,
    "domicilio" text
);
CREATE TABLE "legacy_raw"."acta_entrega_detalle" (
    "codi_act" text,
    "codi_prod" text,
    "cantidad" text,
    "descripcion" text,
    "item" text,
    "codi_conv" text,
    "item_conv" text
);
CREATE TABLE "legacy_raw"."almacen_documentos" (
    "codi_alma" text,
    "codi_tipo_docu" text,
    "serie_alma" text,
    "nro_docu_empieza" text,
    "nro_actual" text,
    "estado" text,
    "tipo_fact" text,
    "codi_cont_docu" text
);
CREATE TABLE "legacy_raw"."bazar" (
    "codi_baza" text,
    "nomb_baza" text,
    "mont_inte" text,
    "tipo_mont" text,
    "codi_clie_prov" text,
    "observacion" text,
    "codi_conc" text
);
CREATE TABLE "legacy_raw"."boletas" (
    "codi_bole" text,
    "serie" text,
    "numero" text,
    "codi_clie_prov" text,
    "fecha" text,
    "monto" text,
    "tipo" text,
    "codi_mone" text
);
CREATE TABLE "legacy_raw"."boletas_detalle" (
    "codi_bole" text,
    "codi_deta" text,
    "codi_item" text,
    "descripcion" text,
    "cant_item" text,
    "precio" text,
    "total" text
);
CREATE TABLE "legacy_raw"."captacion" (
    "codi_cap" text,
    "nro_doc" text,
    "cliente" text,
    "zona" text,
    "cultivo" text,
    "area" text,
    "etapa" text,
    "captado" text,
    "observaciones" text,
    "codi_usua" text,
    "fecha" text,
    "tipo_pers" text,
    "codi_tipo_docu_iden" text,
    "apel_1" text,
    "apel_2" text,
    "nomb_1" text,
    "nomb_2" text,
    "denominacion" text,
    "codi_clie_prov" text,
    "codi_alma" text,
    "frecuencia" text
);
CREATE TABLE "legacy_raw"."captacion_visita" (
    "codi_capta" text,
    "fecha" text,
    "agricultor" text,
    "zona" text,
    "cultivo" text,
    "area" text,
    "etapa" text,
    "codi_rec" text,
    "codi_usua" text,
    "tipo" text,
    "codi_alma" text,
    "telefono" text,
    "e_mail" text,
    "siembra" text,
    "area_nro" text,
    "codi_cap" text,
    "codi_clie_prov" text
);
CREATE TABLE "legacy_raw"."cliente_credito_historial" (
    "codi_credito" text,
    "codi_deta" text,
    "fecha" text,
    "decripcion" text
);
CREATE TABLE "legacy_raw"."cliente_creditos" (
    "codi_credito" text,
    "codi_clie_prov" text,
    "fec_inic_cred" text,
    "codi_mone" text,
    "monto_cred" text,
    "fec_fin_cred" text,
    "observa_cred" text,
    "codi_usua_autoriza" text,
    "estado" text,
    "codi_usua_responsa" text,
    "tipo_cred" text,
    "codi_alma" text,
    "multi_credito" text,
    "tipo_pago" text,
    "doc_garantia" text,
    "fec_pago" text,
    "fec_icomp" text,
    "fconyuge" text,
    "faval" text,
    "cdnicliente" text,
    "cdniconyuge" text,
    "ccontrarrend" text,
    "crecserv" text,
    "ctitprop" text,
    "terrprop" text,
    "casa" text,
    "vehiculo" text,
    "negocio" text,
    "referencias" text,
    "fec_csf" text,
    "codigosf" text,
    "calificacion" text,
    "capital" text,
    "intereses" text,
    "total" text,
    "vae1" text,
    "vae2" text,
    "vae3" text,
    "vac1" text,
    "vac2" text,
    "vac3" text,
    "infocorp" text
);
CREATE TABLE "legacy_raw"."cliente_creditos_garantia" (
    "codi_credito" text,
    "doc_garantia" text
);
CREATE TABLE "legacy_raw"."cliente_vendedor" (
    "id_clie_vende" text,
    "codi_usua" text,
    "codi_clie_prov" text,
    "estado" text
);
CREATE TABLE "legacy_raw"."comisiones" (
    "id_comi" text,
    "mes" text,
    "anio" text,
    "codi_alma" text,
    "codi_prod" text,
    "desc_prod" text,
    "desc_pres" text,
    "cantidad" text,
    "valor" text,
    "comision" text,
    "valor_comision" text,
    "codi_depen" text,
    "desc_depen" text,
    "desc_prese_depen" text
);
CREATE TABLE "legacy_raw"."configuracion_vehicular" (
    "id_conf" text,
    "desc_conf" text,
    "carga_util" text
);
CREATE TABLE "legacy_raw"."conocimiento" (
    "codi_con_mer" text,
    "fecha" text,
    "codi_alma" text,
    "cultivo" text,
    "variedad" text,
    "epoca" text,
    "periodo" text,
    "zona" text,
    "sector" text,
    "area" text,
    "rendimiento" text,
    "precio" text
);
CREATE TABLE "legacy_raw"."convenio" (
    "codi_conv" text,
    "codi_fact" text,
    "fecha" text,
    "nro" text,
    "codi_alma" text,
    "codi_clie_prov" text,
    "codi_mone" text,
    "estado" text
);
CREATE TABLE "legacy_raw"."convenio_detalle" (
    "codi_conv" text,
    "fecha" text,
    "codi_prod" text,
    "cantidad" text,
    "descripcion" text,
    "item" text,
    "estado" text,
    "saldo" text
);
CREATE TABLE "legacy_raw"."cotizacion" (
    "codi_coti" text,
    "nro_cotiza" text,
    "fecha" text,
    "codi_alma" text,
    "codi_clie_prov" text,
    "lugar_ent" text,
    "tiempo_ent" text,
    "observaciones" text,
    "fecha_venc" text,
    "forma_pago" text,
    "fact_dias" text
);
CREATE TABLE "legacy_raw"."creditos" (
    "codi_credito" text,
    "codi_clie_prov" text,
    "fec_inic_cred" text,
    "codi_mone" text,
    "monto_cred" text,
    "fec_fin_cred" text,
    "observa_cred" text,
    "codi_usua_autoriza" text,
    "estado" text,
    "codi_usua_responsa" text,
    "tipo_cred" text,
    "codi_alma" text,
    "multi_credito" text,
    "tipo_pago" text,
    "doc_garantia" text,
    "interes" text,
    "igv" text,
    "gastos" text,
    "total" text,
    "codi_lin_cred" text,
    "codi_proy" text,
    "codi_clie_fav" text,
    "periodo" text
);
CREATE TABLE "legacy_raw"."creditos_detalle" (
    "codi_credito" text,
    "codi_deta" text,
    "fecha" text,
    "codi_mone" text,
    "valor" text,
    "activo" text
);
CREATE TABLE "legacy_raw"."creditos_lineas" (
    "codi_lin_cred" text,
    "descripcion" text
);
CREATE TABLE "legacy_raw"."creditos_tipos" (
    "codi_tipo_cred" text,
    "descripcion" text
);
CREATE TABLE "legacy_raw"."cultivos_principal" (
    "codi_culti" text,
    "cultivo" text,
    "periodo" text,
    "epoca" text,
    "zona" text,
    "rendimiento" text,
    "porc_parti" text,
    "codi_usua" text,
    "fecha" text,
    "nro_peri" text,
    "codi_alma" text
);
CREATE TABLE "legacy_raw"."cuotas_sucursal" (
    "anio" text,
    "mes" text,
    "codi_alma" text,
    "monto" text,
    "cod_lin_pro" text
);
CREATE TABLE "legacy_raw"."factura" (
    "codi_fact" text,
    "codi_alma" text,
    "codi_clie_prov" text,
    "fech_fact" text,
    "codi_tipo_docu" text,
    "ser_fact" text,
    "nro_fact" text,
    "orde_fact" text,
    "tele_fact" text,
    "guia_fact" text,
    "venc_fact" text,
    "tipo_fact" text,
    "codi_mone" text,
    "tcambio" text,
    "codi_tipo_pago" text,
    "tipo_credito" text,
    "valo_fact" text,
    "dscto_fact" text,
    "subtota_fact" text,
    "tota_exonerado" text,
    "valor_igv" text,
    "igv_fact" text,
    "tota_fact" text,
    "codi_orde_grua" text,
    "estado" text,
    "codi_unid_oper" text,
    "codi_vouc" text,
    "contabilizado" text,
    "aplica_igv" text,
    "cod_imp" text,
    "cod_usua" text,
    "impreso" text,
    "cod_usua_vende" text,
    "cod_siembra" text,
    "fec_pago" text,
    "cod_cultivo" text,
    "cod_zona" text,
    "cod_usua_recetista" text,
    "prov_canc" text,
    "creacion" text,
    "hectarea" text,
    "hecho_por" text,
    "nro_dias" text,
    "codi_conv" text,
    "fecha_siembra" text,
    "detra" text,
    "codi_bien_serv" text,
    "printer_name" text,
    "dias_fact" text,
    "mes" text,
    "anio" text,
    "codi_oper" text,
    "cod_usua_modi" text,
    "total_gratuita" text,
    "fecha_elim" text,
    "motivo_elim" text,
    "codi_desc" text,
    "dscto_global" text,
    "factor_dscto" text,
    "nro_cuotas" text,
    "codi_guia_rem" text,
    "tipo_impr" text,
    "pdetr" text
);
CREATE TABLE "legacy_raw"."factura_anticipos" (
    "codi_fact" text,
    "id_sec" text,
    "codi_tipo_docu" text,
    "serie" text,
    "numero" text,
    "fecha_pago_rece" text,
    "fecha_pago_efec" text,
    "monto_anti" text,
    "descripcion" text,
    "hora_pago" text,
    "precio" text,
    "codi_fact_anti" text,
    "codi_mone" text
);
CREATE TABLE "legacy_raw"."factura_credito" (
    "codi_fact" text,
    "codi_credito" text,
    "monto" text
);
CREATE TABLE "legacy_raw"."factura_cuotas" (
    "codi_fact" text,
    "id_sec" text,
    "fecha" text,
    "monto" text,
    "fecha_nc" text,
    "monto_nc" text
);
CREATE TABLE "legacy_raw"."factura_detalle" (
    "codi_fact" text,
    "codi_deta" text,
    "codi_alma" text,
    "codi_item" text,
    "codi_prod" text,
    "desc_item" text,
    "codi_unid_medi" text,
    "cant_item" text,
    "prec_item" text,
    "prec_lista" text,
    "dscto_prec" text,
    "dscto_item" text,
    "impo_item" text,
    "igv" text,
    "codi_mate" text,
    "cant_saldo" text,
    "codi_imp" text,
    "prec_costo" text,
    "incl_igv" text,
    "saldo_conv" text,
    "prod_ofer" text,
    "codi_desc_deta" text,
    "codi_tipo_afec" text,
    "tipo_rot" text
);
CREATE TABLE "legacy_raw"."factura_pesca" (
    "codi_fact_pesc" text,
    "codi_clie_prov" text,
    "fech_emis" text,
    "valo_vent" text,
    "igv" text,
    "valo_tota" text,
    "codi_mone" text,
    "ser_fact" text,
    "nro_fact" text,
    "tipo_fact" text,
    "codi_unid_oper" text,
    "detr_tota" text,
    "codi_sema" text,
    "porc_detr" text
);
CREATE TABLE "legacy_raw"."factura_sunat" (
    "codi_fact" text,
    "estado" text
);
CREATE TABLE "legacy_raw"."facturas" (
    "codi_fact" text,
    "serie_fact" text,
    "nro_fact" text,
    "fecha_fact" text,
    "tipo_pers" text,
    "codi_clie" text,
    "id_clie_natu_f" text,
    "valorventa" text,
    "igv" text,
    "total" text,
    "estado" text,
    "codi_usua" text,
    "observaciones" text,
    "exonerado" text,
    "codi_mone" text,
    "codi_tipo_docu" text,
    "tipo_cambio" text,
    "entrega" text,
    "tipo" text,
    "nro_oc_clie" text,
    "impreso" text,
    "cliente" text,
    "direccion" text,
    "nro_docu" text,
    "serv_prod" text,
    "cancelada" text,
    "provisionada" text,
    "codi_vouc" text,
    "fechareg" text
);
CREATE TABLE "legacy_raw"."facturas_detalle" (
    "codi_fact" text,
    "item_fact" text,
    "codi_prod_serv" text,
    "descripcion" text,
    "cantidad" text,
    "codi_unid_medi" text,
    "prec_inc_igv" text,
    "prec_unit" text,
    "subtotal" text,
    "origen" text,
    "estado" text,
    "codi_orde_produc" text,
    "codi_guia" text,
    "item_guia" text,
    "detalle" text,
    "detalle2" text,
    "detalle3" text,
    "detalle4" text,
    "detadescrip" text,
    "descripcion_item" text
);
CREATE TABLE "legacy_raw"."guia" (
    "codi_guia" text,
    "ser_guia" text,
    "nro_guia" text,
    "fech_tras" text,
    "punto_partida" text,
    "e_p" text,
    "orde_compr" text,
    "codi_clie_dest" text,
    "punto_llegada" text,
    "codi_trans" text,
    "placa_vehi" text,
    "codi_moti_tras" text,
    "otros_obs" text,
    "codi_fact" text,
    "marca_placa" text,
    "nro_licencia" text,
    "peso_total" text,
    "codi_mone" text,
    "sub_total" text,
    "igv_venta" text,
    "total_venta" text,
    "codi_docu_sali" text,
    "codi_alma" text,
    "codi_alma_desti" text,
    "estado" text,
    "codi_unid_vehi" text,
    "codi_chof" text,
    "ruc_dni" text,
    "codi_orden_pedi" text,
    "fecha" text,
    "nom_terc" text,
    "const_ins" text,
    "observaciones" text,
    "apro_por" text,
    "creacion" text,
    "envio" text,
    "tipo_gene" text,
    "dist_part" text,
    "dist_dest" text,
    "codi_unid_medi_peso" text,
    "tipo_traslado" text,
    "codi_clie_comp" text,
    "codi_nota_ingre" text
);
CREATE TABLE "legacy_raw"."guia_detalle" (
    "codi_guia" text,
    "item_guia" text,
    "codi_prod" text,
    "cantidad" text,
    "codi_unid_medi" text,
    "descripcion" text,
    "prec_unit" text,
    "valor_venta" text,
    "descuento" text,
    "prec_venta" text,
    "peso_total" text,
    "observaciones" text,
    "doc" text,
    "ser" text,
    "nro" text,
    "prec_compra" text,
    "codi_deta_orde_pedi" text,
    "prec_venta_real" text
);
CREATE TABLE "legacy_raw"."guia_transportista" (
    "id_guia" text,
    "serie" text,
    "numero" text,
    "fecha" text,
    "fecha_inic_tras" text,
    "via_tipo_part" text,
    "via_nomb_part" text,
    "nro_part" text,
    "interior_part" text,
    "zona_part" text,
    "dist_part" text,
    "prov_part" text,
    "depa_part" text,
    "via_tipo_dest" text,
    "via_nomb_dest" text,
    "nro_dest" text,
    "interior_dest" text,
    "zona_dest" text,
    "dist_dest" text,
    "prov_dest" text,
    "depa_dest" text,
    "codi_clie_remi" text,
    "codi_clie_dest" text,
    "codi_clie_subc" text,
    "marca_vehi" text,
    "codi_unid_vehi" text,
    "codi_unid_carr" text,
    "codi_trans" text,
    "observaciones" text,
    "orden_despa" text,
    "orden_venta" text,
    "guia_remitente" text,
    "codi_fact" text,
    "estado" text,
    "codi_orden_soli" text,
    "codi_deta" text
);
CREATE TABLE "legacy_raw"."guia_transportista_detalle" (
    "id_guia" text,
    "item" text,
    "codi_prod" text,
    "descripcion" text,
    "cantidad" text,
    "peso" text,
    "codi_unid_medi" text,
    "costo_minimo" text,
    "precio" text,
    "total" text,
    "codi_deta_oss" text
);
CREATE TABLE "legacy_raw"."hoja_vida" (
    "codi_hoja" text,
    "grupo" text,
    "razon" text,
    "ruc" text,
    "email_emp" text,
    "email_logi" text,
    "email_ventas" text,
    "email_tecni" text,
    "direccion" text,
    "localidad" text,
    "provincia" text,
    "departamento" text,
    "telef" text,
    "celular" text,
    "cobertura" text,
    "ape_1" text,
    "ape_2" text,
    "nombres" text,
    "codigo" text,
    "cargo" text,
    "propietario" text,
    "arrendatario" text,
    "jefe_campo" text,
    "logistica" text,
    "zona_pers" text,
    "prov_pers" text,
    "dist_pers" text,
    "depa_pers" text,
    "email" text,
    "fech_nac" text,
    "dni" text,
    "telef_pers" text,
    "estado_civ" text,
    "celular_pers" text,
    "grado" text,
    "familia" text,
    "especie" text,
    "variedad" text,
    "siembra" text,
    "surco" text,
    "golpe" text,
    "surco_2" text,
    "area" text,
    "semilla" text,
    "nro_semilla" text,
    "densidad" text
);
CREATE TABLE "legacy_raw"."hoja_vida_deta" (
    "codi_hoja" text,
    "codi_deta" text,
    "diagnostico" text,
    "recomendacion" text,
    "dosis" text,
    "gasto" text,
    "gasto_agro" text,
    "gasto_total" text,
    "etapa" text,
    "fecha_prog" text,
    "fecha_vis" text
);
CREATE TABLE "legacy_raw"."liquidacion" (
    "codi_liqu" text,
    "serie" text,
    "nro" text,
    "codi_trans" text,
    "gastos" text,
    "flete" text,
    "zona_part" text,
    "zona_dest" text,
    "mercaderia" text,
    "placa_tracto" text,
    "placa_carreta" text,
    "fecha_sal" text,
    "fecha_lleg" text,
    "codi_clie_prov" text,
    "nro_recibo" text,
    "total" text,
    "rendir" text,
    "combustible" text,
    "costo_comb" text,
    "saldo" text,
    "codi_orden_soli" text
);
CREATE TABLE "legacy_raw"."liquidacion_deta" (
    "codi_liqu" text,
    "codi_deta" text,
    "fecha" text,
    "detalle" text,
    "f" text,
    "importe" text,
    "codi_tipo_docu" text,
    "serie" text,
    "nro_docu" text,
    "tipo_contab" text,
    "codi_clie_prov" text,
    "estado" text,
    "nro_recibo" text,
    "codi_ruta" text
);
CREATE TABLE "legacy_raw"."liquidacion_ruta" (
    "codi_liqu" text,
    "codi_deta" text,
    "zona_part" text,
    "zona_lleg" text,
    "flete" text,
    "fecha_ini" text,
    "fecha_fin" text,
    "codi_clie_prov" text,
    "codi_orden_soli" text,
    "placa_tracto" text,
    "placa_carreta" text
);
CREATE TABLE "legacy_raw"."metas_linea_rota" (
    "cod_lin_pro" text,
    "codi_rota" text,
    "meta1" text,
    "meta2" text,
    "meta3" text
);
CREATE TABLE "legacy_raw"."motivo_nota_cred" (
    "id_moti" text,
    "desc_moti" text,
    "codi_sunat" text
);
CREATE TABLE "legacy_raw"."motivo_traslado" (
    "codi_moti_tras" text,
    "desc_moti_tras" text,
    "nemo_moti_tras" text,
    "codi_tipo_is" text,
    "codi_sunat_elec" text
);
CREATE TABLE "legacy_raw"."nota_credito" (
    "codi_nota_cred" text,
    "ser_nota_cred" text,
    "nro_nota_cred" text,
    "codi_clie_prov" text,
    "fech_nota_cred" text,
    "valo_vent" text,
    "igv" text,
    "prec_vent" text,
    "codi_mone" text,
    "observacion" text,
    "codi_unid_oper" text,
    "codi_sema" text,
    "codi_deta_zarp" text,
    "estado" text,
    "cuenta1" text,
    "cuenta2" text,
    "cuenta3" text,
    "contabilizado" text,
    "codi_tipo" text,
    "razon_social" text,
    "direccion" text,
    "ruc" text,
    "codi_vouc" text,
    "exonerado" text,
    "codi_fact" text,
    "codi_alma" text,
    "id_moti" text,
    "moti_otro" text,
    "tipo_oper" text,
    "fecha_elim" text,
    "motivo_elim" text,
    "tipo_impr" text
);
CREATE TABLE "legacy_raw"."nota_credito_deta" (
    "codi_nota_cred" text,
    "codi_deta" text,
    "desc_item" text,
    "codi_unid_medi" text,
    "cant_item" text,
    "prec_item" text,
    "impo_item" text,
    "codi_item" text,
    "igv" text,
    "codi_deta_fact" text
);
CREATE TABLE "legacy_raw"."nota_debito" (
    "codi_nota_debi" text,
    "ser_nota_debi" text,
    "nro_nota_debi" text,
    "codi_clie_prov" text,
    "fech_nota_debi" text,
    "valo_vent" text,
    "igv" text,
    "prec_vent" text,
    "codi_mone" text,
    "observacion1" text,
    "observacion2" text,
    "codi_unid_oper" text,
    "codi_sema" text,
    "codi_deta_zarp" text,
    "estado" text,
    "cuenta1" text,
    "cuenta2" text,
    "cuenta3" text,
    "contabilizado" text,
    "codi_tipo" text,
    "razon_social" text,
    "direccion" text,
    "ruc" text,
    "codi_vouc" text,
    "exonerado" text,
    "codi_alma" text,
    "codi_fact" text,
    "tipo_oper" text,
    "fecha_elim" text,
    "motivo_elim" text
);
CREATE TABLE "legacy_raw"."nota_debito_deta" (
    "codi_nota_debi" text,
    "codi_deta" text,
    "desc_item" text,
    "cant_item" text,
    "prec_item" text,
    "impo_item" text,
    "codi_unid_medi" text,
    "codi_item" text,
    "igv" text,
    "codi_deta_fact" text
);
CREATE TABLE "legacy_raw"."nota_venta" (
    "codi_nota_venta" text,
    "codi_alma" text,
    "nro_nota_venta" text,
    "codi_clie_prov" text,
    "fecha" text,
    "codi_mone" text,
    "tcambio" text,
    "creacion" text,
    "codi_tipo_pago" text,
    "tipo_credito" text,
    "codi_usua" text,
    "cod_imp" text,
    "cod_siembra" text,
    "cod_cultivo" text,
    "cod_zona" text,
    "cod_usua_recetista" text,
    "hectarea" text,
    "nro_dias" text,
    "fec_pago" text,
    "venc_fact" text,
    "codi_fact" text,
    "valor_igv" text,
    "valo_fact" text,
    "subtota_fact" text,
    "igv_fact" text,
    "tota_exonerado" text,
    "tota_fact" text,
    "estado" text
);
CREATE TABLE "legacy_raw"."nota_venta_detalle" (
    "codi_nota_venta" text,
    "id_sec" text,
    "codi_prod" text,
    "cantidad" text,
    "prec_item" text,
    "prec_lista" text,
    "dscto_prec" text,
    "dscto_item" text,
    "impo_item" text,
    "igv" text,
    "codi_alma" text,
    "codi_imp" text,
    "desc_item" text,
    "prec_costo" text
);
CREATE TABLE "legacy_raw"."orden_solicitud_servicio" (
    "codi_orden_soli" text,
    "nro_orden_soli" text,
    "codi_clie_prov" text,
    "codi_ruta" text,
    "contacto" text,
    "telefono" text,
    "fecha" text,
    "condicion" text,
    "codi_aux" text,
    "facturado" text,
    "responsable" text,
    "flete" text,
    "igv" text,
    "codi_mone" text,
    "tipo" text
);
CREATE TABLE "legacy_raw"."orden_solicitud_servicio_deta" (
    "codi_orden_soli" text,
    "codi_deta" text,
    "codi_tracto" text,
    "codi_carreta" text,
    "codi_trans" text,
    "codi_carga" text,
    "cantidad" text,
    "codi_unid_medi" text,
    "precio" text,
    "estado" text,
    "observacion" text,
    "importe" text,
    "id_guia" text
);
CREATE TABLE "legacy_raw"."plan_marketing" (
    "codi_plan" text,
    "codi_alma" text,
    "mes" text,
    "sem1" text,
    "sem2" text,
    "sem3" text,
    "sem4" text,
    "codi_usua" text,
    "registro" text,
    "fecha" text
);
CREATE TABLE "legacy_raw"."producto_comision" (
    "id_comi_prod" text,
    "codi_prod" text,
    "desc_prod" text,
    "comision" text,
    "inicio" text,
    "fin" text,
    "codi_depen" text
);
CREATE TABLE "legacy_raw"."productos_ofertas" (
    "item" text,
    "codi_prod" text,
    "cantidad" text,
    "precio" text,
    "fecha_ini" text,
    "fecha_fin" text,
    "estado" text,
    "codi_alma" text,
    "codi_mone" text,
    "usado" text,
    "precio_costo" text
);
CREATE TABLE "legacy_raw"."recomendacion" (
    "codi_rec" text,
    "diagnostico" text,
    "recomendacion" text,
    "nro_rec" text
);
CREATE TABLE "legacy_raw"."recomendacion_deta" (
    "codi_rec" text,
    "codi_deta" text,
    "codi_prod" text,
    "dosis" text,
    "descripcion" text,
    "dosis_cant" text,
    "prec_espe" text,
    "cant_unidad" text,
    "total_val" text
);
CREATE TABLE "legacy_raw"."registro_vale" (
    "codi_vale" text,
    "codi_alma" text,
    "nro_vale" text,
    "codi_clie_prov" text,
    "fecha" text,
    "codi_mone" text,
    "tcambio" text,
    "creacion" text,
    "codi_tipo_pago" text,
    "tipo_credito" text,
    "codi_usua" text,
    "cod_imp" text,
    "cod_siembra" text,
    "cod_cultivo" text,
    "cod_zona" text,
    "cod_usua_recetista" text,
    "hectarea" text,
    "nro_dias" text,
    "fec_pago" text,
    "venc_fact" text,
    "codi_fact" text,
    "valor_igv" text,
    "valo_fact" text,
    "subtota_fact" text,
    "igv_fact" text,
    "tota_exonerado" text,
    "tota_fact" text,
    "estado" text
);
CREATE TABLE "legacy_raw"."registro_vale_detalle" (
    "codi_vale" text,
    "id_sec" text,
    "codi_prod" text,
    "cantidad" text,
    "prec_item" text,
    "prec_lista" text,
    "dscto_prec" text,
    "dscto_item" text,
    "impo_item" text,
    "igv" text,
    "codi_alma" text,
    "codi_imp" text,
    "desc_item" text,
    "prec_costo" text
);
CREATE TABLE "legacy_raw"."rotacion" (
    "codi_rota" text,
    "codi_prod" text,
    "cantidad" text,
    "lote" text,
    "fecha" text,
    "tipo" text,
    "codi_alma" text,
    "fecha_venc" text,
    "observaciones" text
);
CREATE TABLE "legacy_raw"."ruta" (
    "codi_ruta" text,
    "zona" text,
    "dia_l" text,
    "dia_m" text,
    "dia_mc" text,
    "dia_j" text,
    "dia_v" text,
    "dia_sa" text,
    "codi_usua" text,
    "fecha" text,
    "fecha_sal" text,
    "codi_alma" text
);
CREATE TABLE "legacy_raw"."ruta_orden" (
    "codi_ruta" text,
    "descripcion" text,
    "destino" text,
    "distancia" text,
    "origen" text,
    "codi_ori" text,
    "codi_des" text,
    "valor" text
);
CREATE TABLE "legacy_raw"."ruta_semanal" (
    "codi_ruta" text,
    "zona" text,
    "cliente" text,
    "cultivo" text,
    "area" text,
    "etapa" text,
    "observacion" text,
    "codi_usua" text,
    "fecha" text,
    "codi_alma" text,
    "zona_aux" text
);
CREATE TABLE "legacy_raw"."siembras" (
    "codi_siembra" text,
    "codi_clie_prov" text,
    "fec_siembra" text,
    "fec_estima_termi" text,
    "fec_termino" text,
    "nro_hecta" text,
    "cod_cultivo" text,
    "cod_zona" text,
    "ubicación" text,
    "observa" text,
    "terreno" text,
    "textsuelo" text,
    "triego" text,
    "cvecinos" text,
    "credsoc" text,
    "expcult" text,
    "asestecn" text,
    "edadcult" text,
    "relacomerc" text,
    "prodhect" text,
    "preccult" text,
    "utilbruta" text,
    "utilneta" text,
    "gastos" text,
    "comprador" text,
    "codi_mone" text
);
CREATE TABLE "legacy_raw"."tipo_carga" (
    "codi_carga" text,
    "descripcion" text
);
CREATE TABLE "legacy_raw"."tipo_comision" (
    "id_tipocomi" text,
    "desc_tipocomi" text,
    "porcentaje" text
);
CREATE TABLE "legacy_raw"."tipo_factura" (
    "codi_tipo" text,
    "descrip" text,
    "tipo" text
);
CREATE TABLE "legacy_raw"."tipo_notas" (
    "codi_tipo" text,
    "descrip" text
);
CREATE TABLE "legacy_raw"."ubicacion" (
    "codi_ubi" text,
    "codi_alma" text,
    "zona" text,
    "sector" text,
    "subsector" text,
    "fecha" text,
    "codi_usua" text
);
CREATE TABLE "legacy_raw"."unidad_transporte" (
    "codi_unid_tran" text,
    "desc_unid_tran" text,
    "marc_unid_tran" text,
    "plac_unid_tran" text,
    "cert_unid_tran" text,
    "colo_unid_tran" text,
    "lice_unid_trans" text,
    "mot_unid_tran" text,
    "anio_unid_tran" text,
    "cod_tran_unid_tran" text,
    "codi_tipo" text,
    "nro_plac_remo" text,
    "apel_1_chof" text,
    "apel_2_chof" text,
    "nomb_1_chof" text,
    "nomb_2_chof" text,
    "lice_cond_chof" text,
    "dni_chof" text,
    "inte_exte" text,
    "codi_unid_oper" text,
    "capacidad" text,
    "id_conf" text,
    "codi_carreta" text,
    "codi_trans" text,
    "codi_tracto" text,
    "tipo_unidad" text,
    "permiso" text,
    "soat_ini" text,
    "soat_fin" text,
    "codi_prop" text,
    "codi_alma" text
);
CREATE TABLE "legacy_raw"."vale_credito" (
    "codi_vale" text,
    "codi_credito" text,
    "monto" text
);
