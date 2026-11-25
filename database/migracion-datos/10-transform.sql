-- Generado por tools/db-migrator/src/gen-data-migration.js a partir de
-- database/catalogo/mapeo-columnas.json. No editar a mano: regenerar con el script.

-- legacy_raw (carga cruda de pgloader) -> esquemas destino del modelo SIGE.
-- Reglas: rtrim a textos (char(n) venia con relleno), NULLIF(...,'') -> NULL,
-- cast al tipo destino, se omiten columnas GENERATED ALWAYS, las claves sustitutas
-- se dejan a su valor por defecto y las identidades del legado se reinsertan y luego
-- se reajusta su secuencia con setval. Cada esquema va en su propia transaccion con
-- session_replication_role = replica para diferir disparadores y chequeos de FK.
\set ON_ERROR_STOP on

-- =====================================================================
-- ESQUEMA contabilidad  (82 tablas)
-- =====================================================================
BEGIN;
SET LOCAL session_replication_role = replica;

-- Activos -> contabilidad.activos  (33 col)
INSERT INTO "contabilidad"."activos" ("codi_activo", "descri_activo", "codi_grup", "nro_cuen", "fech_ingre", "nro_docu", "codi_clie_prov", "costo", "codi_mone", "codi_unid_oper", "tdat", "tdac", "mes", "anio", "codi_marca", "serie", "modelo", "anio_fabr", "matricula", "color", "capacidad", "ancho", "largo", "alto", "voltaje", "amperaje", "fecha_depre", "fecha_contrato", "nro_con_arre", "fecha_ini_arre", "nro_cuotas", "monto_arre", "fecha_retiro")
SELECT
       NULLIF(rtrim("codi_activo"::text), '')::varchar(7) AS "codi_activo",
       NULLIF(rtrim("descri_activo"::text), '')::varchar(100) AS "descri_activo",
       NULLIF(btrim("codi_grup"::text), '')::bigint AS "codi_grup",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(btrim("fech_ingre"::text), '')::timestamp(3) AS "fech_ingre",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(20) AS "nro_docu",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("costo"::text), '')::numeric(10,2) AS "costo",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(btrim("tdat"::text), '')::numeric(18,4) AS "tdat",
       NULLIF(btrim("tdac"::text), '')::numeric(18,4) AS "tdac",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("codi_marca"::text), '')::varchar(4) AS "codi_marca",
       NULLIF(rtrim("serie"::text), '')::varchar(20) AS "serie",
       NULLIF(rtrim("modelo"::text), '')::varchar(50) AS "modelo",
       NULLIF(rtrim("anio_fabr"::text), '')::varchar(4) AS "anio_fabr",
       NULLIF(rtrim("matricula"::text), '')::varchar(50) AS "matricula",
       NULLIF(rtrim("color"::text), '')::varchar(50) AS "color",
       NULLIF(rtrim("capacidad"::text), '')::varchar(50) AS "capacidad",
       NULLIF(btrim("ancho"::text), '')::numeric(18,2) AS "ancho",
       NULLIF(btrim("largo"::text), '')::numeric(18,2) AS "largo",
       NULLIF(btrim("alto"::text), '')::numeric(18,2) AS "alto",
       NULLIF(btrim("voltaje"::text), '')::numeric(18,2) AS "voltaje",
       NULLIF(btrim("amperaje"::text), '')::numeric(18,2) AS "amperaje",
       NULLIF(btrim("fecha_depre"::text), '')::timestamp(3) AS "fecha_depre",
       NULLIF(btrim("fecha_contrato"::text), '')::timestamp(3) AS "fecha_contrato",
       NULLIF(rtrim("nro_con_arre"::text), '')::varchar(100) AS "nro_con_arre",
       NULLIF(btrim("fecha_ini_arre"::text), '')::timestamp(3) AS "fecha_ini_arre",
       NULLIF(rtrim("nro_cuotas"::text), '')::varchar(10) AS "nro_cuotas",
       NULLIF(btrim("monto_arre"::text), '')::numeric(12,2) AS "monto_arre",
       NULLIF(btrim("fecha_retiro"::text), '')::timestamp(3) AS "fecha_retiro"
FROM "legacy_raw"."activos"
ON CONFLICT DO NOTHING;

-- Activos_centros -> contabilidad.activos_centros  (2 col)
INSERT INTO "contabilidad"."activos_centros" ("nro_cuen", "codi_cc")
SELECT
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(btrim("codi_cc"::text), '')::bigint AS "codi_cc"
FROM "legacy_raw"."activos_centros"
ON CONFLICT DO NOTHING;

-- AGRUPACIONES -> contabilidad.agrupaciones  (2 col)
INSERT INTO "contabilidad"."agrupaciones" ("codi_grup", "desc_grup")
SELECT
       NULLIF(rtrim("codi_grup"::text), '')::varchar(5) AS "codi_grup",
       NULLIF(rtrim("desc_grup"::text), '')::varchar(100) AS "desc_grup"
FROM "legacy_raw"."agrupaciones"
ON CONFLICT DO NOTHING;

-- bien_servicio -> contabilidad.bien_servicio  (6 col)
INSERT INTO "contabilidad"."bien_servicio" ("codi_bien_serv", "desc_bien_serv", "nemo_bien_serv", "porc_bien_serv", "inicio", "fin")
SELECT
       NULLIF(rtrim("codi_bien_serv"::text), '')::varchar(3) AS "codi_bien_serv",
       NULLIF(rtrim("desc_bien_serv"::text), '')::varchar(250) AS "desc_bien_serv",
       NULLIF(rtrim("nemo_bien_serv"::text), '')::varchar(50) AS "nemo_bien_serv",
       NULLIF(btrim("porc_bien_serv"::text), '')::numeric(18,3) AS "porc_bien_serv",
       NULLIF(btrim("inicio"::text), '')::timestamp(3) AS "inicio",
       NULLIF(btrim("fin"::text), '')::timestamp(3) AS "fin"
FROM "legacy_raw"."bien_servicio"
ON CONFLICT DO NOTHING;

-- cabecera_detraccion -> contabilidad.cabecera_detraccion  (7 col)
INSERT INTO "contabilidad"."cabecera_detraccion" ("codi_lote_detr", "nro_lote_detrac", "importe", "anio", "nro", "fech_gene", "mes")
SELECT
       NULLIF(rtrim("codi_lote_detr"::text), '')::varchar(10) AS "codi_lote_detr",
       NULLIF(rtrim("nro_lote_detrac"::text), '')::varchar(6) AS "nro_lote_detrac",
       NULLIF(btrim("importe"::text), '')::numeric(15,2) AS "importe",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(btrim("nro"::text), '')::integer AS "nro",
       NULLIF(btrim("fech_gene"::text), '')::timestamp(3) AS "fech_gene",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes"
FROM "legacy_raw"."cabecera_detraccion"
ON CONFLICT DO NOTHING;

-- catalmae -> contabilidad.catalmae  (2 col)
INSERT INTO "contabilidad"."catalmae" ("a", "codi_uo_catalmae")
SELECT
       NULLIF(btrim("a"::text), '')::integer AS "a",
       NULLIF(rtrim("codi_uo_catalmae"::text), '')::varchar(5) AS "codi_uo_catalmae"
FROM "legacy_raw"."catalmae"
ON CONFLICT DO NOTHING;

-- Centro_costo -> contabilidad.centro_costo  (2 col)
INSERT INTO "contabilidad"."centro_costo" ("codi_cc", "nombre_cc")
SELECT
       NULLIF(btrim("codi_cc"::text), '')::bigint AS "codi_cc",
       NULLIF(rtrim("nombre_cc"::text), '')::varchar(120) AS "nombre_cc"
FROM "legacy_raw"."centro_costo"
ON CONFLICT DO NOTHING;

-- CLASE -> contabilidad.clase  (7 col)
INSERT INTO "contabilidad"."clase" ("cod_clase", "nomb_clase", "nomb_grupo", "estado", "unidad_negocio", "modalidad", "co_orde_serv")
SELECT
       NULLIF(rtrim("cod_clase"::text), '')::varchar(3) AS "cod_clase",
       NULLIF(rtrim("nomb_clase"::text), '')::varchar(40) AS "nomb_clase",
       NULLIF(rtrim("nomb_grupo"::text), '')::varchar(10) AS "nomb_grupo",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("unidad_negocio"::text), '')::varchar(10) AS "unidad_negocio",
       NULLIF(rtrim("modalidad"::text), '')::varchar(8) AS "modalidad",
       NULLIF(rtrim("co_orde_serv"::text), '')::varchar(20) AS "co_orde_serv"
FROM "legacy_raw"."clase"
ON CONFLICT DO NOTHING;

-- CLASES_CUENTAS -> contabilidad.clases_cuentas  (3 col)
INSERT INTO "contabilidad"."clases_cuentas" ("codi_clas_cuen", "desc_clas_cuen", "a_p")
SELECT
       NULLIF(rtrim("codi_clas_cuen"::text), '')::varchar(2) AS "codi_clas_cuen",
       NULLIF(rtrim("desc_clas_cuen"::text), '')::varchar(100) AS "desc_clas_cuen",
       NULLIF(rtrim("a_p"::text), '')::varchar(1) AS "a_p"
FROM "legacy_raw"."clases_cuentas"
ON CONFLICT DO NOTHING;

-- COEF_LIQU_IMP -> contabilidad.coef_liqu_imp  (20 col)
INSERT INTO "contabilidad"."coef_liqu_imp" ("aniomes", "valor_renta", "fech_venc", "cfa", "otros_ma", "cerrado", "igv_5_ant", "igv_5_act", "igv_favor_ant", "perc_act", "perc_ant", "rete_act", "rete_ant", "factor_r3c", "saldo_r3c_ant", "itan", "bonifi", "cofigv", "porc", "cfn")
SELECT
       NULLIF(rtrim("aniomes"::text), '')::varchar(6) AS "aniomes",
       NULLIF(btrim("valor_renta"::text), '')::numeric(18,4) AS "valor_renta",
       NULLIF(btrim("fech_venc"::text), '')::timestamp(3) AS "fech_venc",
       NULLIF(btrim("cfa"::text), '')::numeric(18,2) AS "cfa",
       NULLIF(btrim("otros_ma"::text), '')::numeric(18,2) AS "otros_ma",
       NULLIF(btrim("cerrado"::text), '')::boolean AS "cerrado",
       NULLIF(btrim("igv_5_ant"::text), '')::numeric(18,2) AS "igv_5_ant",
       NULLIF(btrim("igv_5_act"::text), '')::numeric(18,2) AS "igv_5_act",
       NULLIF(btrim("igv_favor_ant"::text), '')::numeric(18,2) AS "igv_favor_ant",
       NULLIF(btrim("perc_act"::text), '')::numeric(18,2) AS "perc_act",
       NULLIF(btrim("perc_ant"::text), '')::bigint AS "perc_ant",
       NULLIF(btrim("rete_act"::text), '')::numeric(18,2) AS "rete_act",
       NULLIF(btrim("rete_ant"::text), '')::numeric(18,2) AS "rete_ant",
       NULLIF(btrim("factor_r3c"::text), '')::numeric(18,4) AS "factor_r3c",
       NULLIF(btrim("saldo_r3c_ant"::text), '')::numeric(18,2) AS "saldo_r3c_ant",
       NULLIF(btrim("itan"::text), '')::numeric(18,2) AS "itan",
       NULLIF(btrim("bonifi"::text), '')::numeric(12,2) AS "bonifi",
       NULLIF(btrim("cofigv"::text), '')::numeric(12,6) AS "cofigv",
       NULLIF(btrim("porc"::text), '')::numeric(12,6) AS "porc",
       NULLIF(btrim("cfn"::text), '')::numeric(12,2) AS "cfn"
FROM "legacy_raw"."coef_liqu_imp"
ON CONFLICT DO NOTHING;

-- CONCEPTO_BALANCE -> contabilidad.concepto_balance  (4 col)
INSERT INTO "contabilidad"."concepto_balance" ("codi_concepto", "desc_concepto", "cod_cta", "orden")
SELECT
       NULLIF(btrim("codi_concepto"::text), '')::smallint AS "codi_concepto",
       NULLIF(rtrim("desc_concepto"::text), '')::varchar(200) AS "desc_concepto",
       NULLIF(rtrim("cod_cta"::text), '')::varchar(1) AS "cod_cta",
       NULLIF(btrim("orden"::text), '')::smallint AS "orden"
FROM "legacy_raw"."concepto_balance"
ON CONFLICT DO NOTHING;

-- CONCEPTO_SUNAT -> contabilidad.concepto_sunat  (2 col)
INSERT INTO "contabilidad"."concepto_sunat" ("codi_concep_sunat", "desc_concep_sunat")
SELECT
       NULLIF(btrim("codi_concep_sunat"::text), '')::smallint AS "codi_concep_sunat",
       NULLIF(rtrim("desc_concep_sunat"::text), '')::varchar(100) AS "desc_concep_sunat"
FROM "legacy_raw"."concepto_sunat"
ON CONFLICT DO NOTHING;

-- CONTABILIZACION -> contabilidad.contabilizacion  (21 col)
INSERT INTO "contabilidad"."contabilizacion" ("codigo", "origen", "tipod", "descrip", "cuenta1", "ca1", "desc1", "cuenta2", "ca2", "desc2", "ctasunat", "cuenta3", "ca3", "desc3", "cuenta4", "ca4", "desc4", "cuenta5", "ca5", "desc5", "subdiario")
SELECT
       NULLIF(rtrim("codigo"::text), '')::varchar(4) AS "codigo",
       NULLIF(rtrim("origen"::text), '')::varchar(5) AS "origen",
       NULLIF(rtrim("tipod"::text), '')::varchar(4) AS "tipod",
       NULLIF(rtrim("descrip"::text), '')::varchar(70) AS "descrip",
       NULLIF(rtrim("cuenta1"::text), '')::varchar(7) AS "cuenta1",
       NULLIF(rtrim("ca1"::text), '')::varchar(1) AS "ca1",
       NULLIF(rtrim("desc1"::text), '')::varchar(50) AS "desc1",
       NULLIF(rtrim("cuenta2"::text), '')::varchar(7) AS "cuenta2",
       NULLIF(rtrim("ca2"::text), '')::varchar(1) AS "ca2",
       NULLIF(rtrim("desc2"::text), '')::varchar(50) AS "desc2",
       NULLIF(rtrim("ctasunat"::text), '')::varchar(7) AS "ctasunat",
       NULLIF(rtrim("cuenta3"::text), '')::varchar(7) AS "cuenta3",
       NULLIF(rtrim("ca3"::text), '')::varchar(1) AS "ca3",
       NULLIF(rtrim("desc3"::text), '')::varchar(50) AS "desc3",
       NULLIF(rtrim("cuenta4"::text), '')::varchar(7) AS "cuenta4",
       NULLIF(rtrim("ca4"::text), '')::varchar(1) AS "ca4",
       NULLIF(rtrim("desc4"::text), '')::varchar(50) AS "desc4",
       NULLIF(rtrim("cuenta5"::text), '')::varchar(7) AS "cuenta5",
       NULLIF(rtrim("ca5"::text), '')::varchar(1) AS "ca5",
       NULLIF(rtrim("desc5"::text), '')::varchar(50) AS "desc5",
       NULLIF(rtrim("subdiario"::text), '')::varchar(1) AS "subdiario"
FROM "legacy_raw"."contabilizacion"
ON CONFLICT DO NOTHING;

-- COSTO -> contabilidad.costo  (2 col)
INSERT INTO "contabilidad"."costo" ("codi_costo", "desc_costo")
SELECT
       NULLIF(btrim("codi_costo"::text), '')::smallint AS "codi_costo",
       NULLIF(rtrim("desc_costo"::text), '')::varchar(100) AS "desc_costo"
FROM "legacy_raw"."costo"
ON CONFLICT DO NOTHING;

-- CUEN_X_TIPO_COST -> contabilidad.cuen_x_tipo_cost  (2 col)
INSERT INTO "contabilidad"."cuen_x_tipo_cost" ("codi_tipo_cost", "nro_cuen")
SELECT
       NULLIF(rtrim("codi_tipo_cost"::text), '')::varchar(2) AS "codi_tipo_cost",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen"
FROM "legacy_raw"."cuen_x_tipo_cost"
ON CONFLICT DO NOTHING;

-- CUENTAS_ACTIVOS_PROV -> contabilidad.cuentas_activos_prov  (3 col)
INSERT INTO "contabilidad"."cuentas_activos_prov" ("nro_cuen", "cuent_cargo", "cuent_abono")
SELECT
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("cuent_cargo"::text), '')::varchar(7) AS "cuent_cargo",
       NULLIF(rtrim("cuent_abono"::text), '')::varchar(7) AS "cuent_abono"
FROM "legacy_raw"."cuentas_activos_prov"
ON CONFLICT DO NOTHING;

-- CUENTAS_CONTABLE -> contabilidad.cuentas_contable  (4 col)
INSERT INTO "contabilidad"."cuentas_contable" ("nro_cuen", "desc_cuen", "nro_sub_cuen", "codi_lcc")
SELECT
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("desc_cuen"::text), '')::varchar(100) AS "desc_cuen",
       NULLIF(rtrim("nro_sub_cuen"::text), '')::varchar(7) AS "nro_sub_cuen",
       NULLIF(rtrim("codi_lcc"::text), '')::varchar(5) AS "codi_lcc"
FROM "legacy_raw"."cuentas_contable"
ON CONFLICT DO NOTHING;

-- CUENTAS_COSTO -> contabilidad.cuentas_costo  (2 col)
INSERT INTO "contabilidad"."cuentas_costo" ("codi_cuen_cost", "codi_clas_cuen")
SELECT
       NULLIF(rtrim("codi_cuen_cost"::text), '')::varchar(2) AS "codi_cuen_cost",
       NULLIF(rtrim("codi_clas_cuen"::text), '')::varchar(2) AS "codi_clas_cuen"
FROM "legacy_raw"."cuentas_costo"
ON CONFLICT DO NOTHING;

-- Cuentas_Gerencial -> contabilidad.cuentas_gerencial  (3 col)
INSERT INTO "contabilidad"."cuentas_gerencial" ("item", "nro_cuen", "resumen")
SELECT
       NULLIF(rtrim("item"::text), '')::varchar(3) AS "item",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("resumen"::text), '')::varchar(100) AS "resumen"
FROM "legacy_raw"."cuentas_gerencial"
ON CONFLICT DO NOTHING;

-- CUENTAS_PARTIDA -> contabilidad.cuentas_partida  (4 col)
INSERT INTO "contabilidad"."cuentas_partida" ("codi_partida", "descripcion", "tipo_cuen", "orden")
SELECT
       NULLIF(rtrim("codi_partida"::text), '')::varchar(4) AS "codi_partida",
       NULLIF(rtrim("descripcion"::text), '')::varchar(255) AS "descripcion",
       NULLIF(btrim("tipo_cuen"::text), '')::smallint AS "tipo_cuen",
       NULLIF(btrim("orden"::text), '')::integer AS "orden"
FROM "legacy_raw"."cuentas_partida"
ON CONFLICT DO NOTHING;

-- CUENTAS_PARTIDA_REPORTE -> contabilidad.cuentas_partida_reporte  (2 col)
INSERT INTO "contabilidad"."cuentas_partida_reporte" ("nro_cuen", "codi_partida")
SELECT
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("codi_partida"::text), '')::varchar(4) AS "codi_partida"
FROM "legacy_raw"."cuentas_partida_reporte"
ON CONFLICT DO NOTHING;

-- CUENTAS_PLAN_PROV -> contabilidad.cuentas_plan_prov  (6 col)
INSERT INTO "contabilidad"."cuentas_plan_prov" ("codi_item", "codi_unid_oper", "nro_cuen", "cargo", "grupo", "tipo_plan")
SELECT
       NULLIF(rtrim("codi_item"::text), '')::varchar(3) AS "codi_item",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("cargo"::text), '')::varchar(1) AS "cargo",
       NULLIF(rtrim("grupo"::text), '')::varchar(1) AS "grupo",
       NULLIF(rtrim("tipo_plan"::text), '')::varchar(2) AS "tipo_plan"
FROM "legacy_raw"."cuentas_plan_prov"
ON CONFLICT DO NOTHING;

-- CUENTAS_PLAN_PROV_CONCEP -> contabilidad.cuentas_plan_prov_concep  (4 col)
INSERT INTO "contabilidad"."cuentas_plan_prov_concep" ("codi_item", "codi_deta", "codi_conc", "codi_conc_fin")
SELECT
       NULLIF(rtrim("codi_item"::text), '')::varchar(3) AS "codi_item",
       NULLIF(rtrim("codi_deta"::text), '')::varchar(3) AS "codi_deta",
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(rtrim("codi_conc_fin"::text), '')::varchar(6) AS "codi_conc_fin"
FROM "legacy_raw"."cuentas_plan_prov_concep"
ON CONFLICT DO NOTHING;

-- CUENTAS_PROVISION -> contabilidad.cuentas_provision  (4 col)
INSERT INTO "contabilidad"."cuentas_provision" ("codigo", "descripcion", "cuenta", "codi_unid_oper")
SELECT
       NULLIF(rtrim("codigo"::text), '')::varchar(2) AS "codigo",
       NULLIF(rtrim("descripcion"::text), '')::varchar(50) AS "descripcion",
       NULLIF(rtrim("cuenta"::text), '')::varchar(7) AS "cuenta",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper"
FROM "legacy_raw"."cuentas_provision"
ON CONFLICT DO NOTHING;

-- CUENTAS_REPORTE -> contabilidad.cuentas_reporte  (4 col)
INSERT INTO "contabilidad"."cuentas_reporte" ("tipo_cuen", "descripcion", "orden", "codi_grupo")
SELECT
       NULLIF(btrim("tipo_cuen"::text), '')::smallint AS "tipo_cuen",
       NULLIF(rtrim("descripcion"::text), '')::varchar(255) AS "descripcion",
       NULLIF(rtrim("orden"::text), '')::varchar(1) AS "orden",
       NULLIF(btrim("codi_grupo"::text), '')::integer AS "codi_grupo"
FROM "legacy_raw"."cuentas_reporte"
ON CONFLICT DO NOTHING;

-- DECL_DIAR_ARRI -> contabilidad.decl_diar_arri  (30 col)
INSERT INTO "contabilidad"."decl_diar_arri" ("codi_decl_diar_arri", "nume_arri", "fecha", "codi_unid_oper", "nro_matri", "codi_decl_diar_zarp", "codi_puer_arri", "fech_arri", "zona_pesc", "latitud", "longitud", "tiempo", "tiem_nave", "codi_espe_1", "codi_espe_2", "codi_espe_3", "cant_espe_1", "cant_espe_2", "cant_espe_3", "codi_plan_desc", "codi_plan_comp", "obse_1", "obse_2", "obse_3", "obse_4", "obse_5", "obse_6", "obse_7", "obse_8", "codi_patr")
SELECT
       NULLIF(rtrim("codi_decl_diar_arri"::text), '')::varchar(10) AS "codi_decl_diar_arri",
       NULLIF(rtrim("nume_arri"::text), '')::varchar(10) AS "nume_arri",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("nro_matri"::text), '')::varchar(15) AS "nro_matri",
       NULLIF(rtrim("codi_decl_diar_zarp"::text), '')::varchar(10) AS "codi_decl_diar_zarp",
       NULLIF(rtrim("codi_puer_arri"::text), '')::varchar(2) AS "codi_puer_arri",
       NULLIF(btrim("fech_arri"::text), '')::timestamp(3) AS "fech_arri",
       NULLIF(rtrim("zona_pesc"::text), '')::varchar(100) AS "zona_pesc",
       NULLIF(rtrim("latitud"::text), '')::varchar(20) AS "latitud",
       NULLIF(rtrim("longitud"::text), '')::varchar(20) AS "longitud",
       NULLIF(rtrim("tiempo"::text), '')::varchar(20) AS "tiempo",
       NULLIF(rtrim("tiem_nave"::text), '')::varchar(100) AS "tiem_nave",
       NULLIF(rtrim("codi_espe_1"::text), '')::varchar(2) AS "codi_espe_1",
       NULLIF(rtrim("codi_espe_2"::text), '')::varchar(2) AS "codi_espe_2",
       NULLIF(rtrim("codi_espe_3"::text), '')::varchar(2) AS "codi_espe_3",
       NULLIF(btrim("cant_espe_1"::text), '')::numeric(9,4) AS "cant_espe_1",
       NULLIF(btrim("cant_espe_2"::text), '')::numeric(9,4) AS "cant_espe_2",
       NULLIF(btrim("cant_espe_3"::text), '')::numeric(9,4) AS "cant_espe_3",
       NULLIF(rtrim("codi_plan_desc"::text), '')::varchar(5) AS "codi_plan_desc",
       NULLIF(rtrim("codi_plan_comp"::text), '')::varchar(5) AS "codi_plan_comp",
       NULLIF(rtrim("obse_1"::text), '')::varchar(150) AS "obse_1",
       NULLIF(rtrim("obse_2"::text), '')::varchar(150) AS "obse_2",
       NULLIF(rtrim("obse_3"::text), '')::varchar(150) AS "obse_3",
       NULLIF(rtrim("obse_4"::text), '')::varchar(150) AS "obse_4",
       NULLIF(rtrim("obse_5"::text), '')::varchar(150) AS "obse_5",
       NULLIF(rtrim("obse_6"::text), '')::varchar(150) AS "obse_6",
       NULLIF(rtrim("obse_7"::text), '')::varchar(150) AS "obse_7",
       NULLIF(rtrim("obse_8"::text), '')::varchar(150) AS "obse_8",
       NULLIF(rtrim("codi_patr"::text), '')::varchar(5) AS "codi_patr"
FROM "legacy_raw"."decl_diar_arri"
ON CONFLICT DO NOTHING;

-- DECL_DIAR_ZARP -> contabilidad.decl_diar_zarp  (19 col)
INSERT INTO "contabilidad"."decl_diar_zarp" ("codi_decl_diar_zarp", "nume_decl", "fecha", "codi_unid_oper", "nro_matri", "arqu_brut", "codi_puer_capi", "zona_pesc", "tiem_oper", "fech_esti_arri", "codi_usua_repr", "fech_venc_matr", "fech_venc_lmc", "fech_venc_comp_comp", "fech_venc_radi_bali", "fech_venc_segu", "fech_venc_hidr_carb", "fech_venc_agua_suci", "codi_patr")
SELECT
       NULLIF(rtrim("codi_decl_diar_zarp"::text), '')::varchar(10) AS "codi_decl_diar_zarp",
       NULLIF(rtrim("nume_decl"::text), '')::varchar(10) AS "nume_decl",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("nro_matri"::text), '')::varchar(15) AS "nro_matri",
       NULLIF(btrim("arqu_brut"::text), '')::numeric(9,4) AS "arqu_brut",
       NULLIF(rtrim("codi_puer_capi"::text), '')::varchar(2) AS "codi_puer_capi",
       NULLIF(rtrim("zona_pesc"::text), '')::varchar(100) AS "zona_pesc",
       NULLIF(rtrim("tiem_oper"::text), '')::varchar(100) AS "tiem_oper",
       NULLIF(btrim("fech_esti_arri"::text), '')::timestamp(3) AS "fech_esti_arri",
       NULLIF(rtrim("codi_usua_repr"::text), '')::varchar(5) AS "codi_usua_repr",
       NULLIF(btrim("fech_venc_matr"::text), '')::timestamp(3) AS "fech_venc_matr",
       NULLIF(btrim("fech_venc_lmc"::text), '')::timestamp(3) AS "fech_venc_lmc",
       NULLIF(btrim("fech_venc_comp_comp"::text), '')::timestamp(3) AS "fech_venc_comp_comp",
       NULLIF(btrim("fech_venc_radi_bali"::text), '')::timestamp(3) AS "fech_venc_radi_bali",
       NULLIF(btrim("fech_venc_segu"::text), '')::timestamp(3) AS "fech_venc_segu",
       NULLIF(btrim("fech_venc_hidr_carb"::text), '')::timestamp(3) AS "fech_venc_hidr_carb",
       NULLIF(btrim("fech_venc_agua_suci"::text), '')::timestamp(3) AS "fech_venc_agua_suci",
       NULLIF(rtrim("codi_patr"::text), '')::varchar(5) AS "codi_patr"
FROM "legacy_raw"."decl_diar_zarp"
ON CONFLICT DO NOTHING;

-- DECL_DIAR_ZARP_DETA -> contabilidad.decl_diar_zarp_deta  (6 col)
INSERT INTO "contabilidad"."decl_diar_zarp_deta" ("codi_decl_diar_zarp", "nro_item", "codi_pers", "nro_matr_pers", "fin_vige_matr", "codi_carg")
SELECT
       NULLIF(rtrim("codi_decl_diar_zarp"::text), '')::varchar(10) AS "codi_decl_diar_zarp",
       NULLIF(rtrim("nro_item"::text), '')::varchar(2) AS "nro_item",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("nro_matr_pers"::text), '')::varchar(30) AS "nro_matr_pers",
       NULLIF(btrim("fin_vige_matr"::text), '')::timestamp(3) AS "fin_vige_matr",
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg"
FROM "legacy_raw"."decl_diar_zarp_deta"
ON CONFLICT DO NOTHING;

-- DECL_ZARP_TRIM -> contabilidad.decl_zarp_trim  (23 col)
INSERT INTO "contabilidad"."decl_zarp_trim" ("codi_zarp_trim", "nume_zarp", "fecha", "fech_inic_vige", "fech_fin_vige", "codi_unid_oper", "nro_matri", "arqu_brut", "arqu_neto", "codi_puer_capi", "codi_usua_repr", "nro_trip", "fech_venc_matr", "fech_venc_arqu", "fech_venc_lmc", "fech_venc_comp_comp", "fech_venc_radi_bali", "fech_venc_segu", "fech_venc_hidr_carb", "fech_venc_agua_suci", "codi_patr", "colo_casc", "colo_supe_estr")
SELECT
       NULLIF(rtrim("codi_zarp_trim"::text), '')::varchar(10) AS "codi_zarp_trim",
       NULLIF(rtrim("nume_zarp"::text), '')::varchar(10) AS "nume_zarp",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(btrim("fech_inic_vige"::text), '')::timestamp(3) AS "fech_inic_vige",
       NULLIF(btrim("fech_fin_vige"::text), '')::timestamp(3) AS "fech_fin_vige",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("nro_matri"::text), '')::varchar(15) AS "nro_matri",
       NULLIF(btrim("arqu_brut"::text), '')::numeric(9,4) AS "arqu_brut",
       NULLIF(btrim("arqu_neto"::text), '')::numeric(9,4) AS "arqu_neto",
       NULLIF(rtrim("codi_puer_capi"::text), '')::varchar(2) AS "codi_puer_capi",
       NULLIF(rtrim("codi_usua_repr"::text), '')::varchar(5) AS "codi_usua_repr",
       NULLIF(btrim("nro_trip"::text), '')::integer AS "nro_trip",
       NULLIF(btrim("fech_venc_matr"::text), '')::timestamp(3) AS "fech_venc_matr",
       NULLIF(btrim("fech_venc_arqu"::text), '')::timestamp(3) AS "fech_venc_arqu",
       NULLIF(btrim("fech_venc_lmc"::text), '')::timestamp(3) AS "fech_venc_lmc",
       NULLIF(btrim("fech_venc_comp_comp"::text), '')::timestamp(3) AS "fech_venc_comp_comp",
       NULLIF(btrim("fech_venc_radi_bali"::text), '')::timestamp(3) AS "fech_venc_radi_bali",
       NULLIF(btrim("fech_venc_segu"::text), '')::timestamp(3) AS "fech_venc_segu",
       NULLIF(btrim("fech_venc_hidr_carb"::text), '')::timestamp(3) AS "fech_venc_hidr_carb",
       NULLIF(btrim("fech_venc_agua_suci"::text), '')::timestamp(3) AS "fech_venc_agua_suci",
       NULLIF(rtrim("codi_patr"::text), '')::varchar(5) AS "codi_patr",
       NULLIF(rtrim("colo_casc"::text), '')::varchar(50) AS "colo_casc",
       NULLIF(rtrim("colo_supe_estr"::text), '')::varchar(50) AS "colo_supe_estr"
FROM "legacy_raw"."decl_zarp_trim"
ON CONFLICT DO NOTHING;

-- DECL_ZARP_TRIM_DETA -> contabilidad.decl_zarp_trim_deta  (7 col)
INSERT INTO "contabilidad"."decl_zarp_trim_deta" ("codi_zarp_trim", "nro_item", "codi_pers", "nro_matr_pers", "fin_vige_matr", "codi_carg", "codi_titu")
SELECT
       NULLIF(rtrim("codi_zarp_trim"::text), '')::varchar(10) AS "codi_zarp_trim",
       NULLIF(rtrim("nro_item"::text), '')::varchar(2) AS "nro_item",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("nro_matr_pers"::text), '')::varchar(30) AS "nro_matr_pers",
       NULLIF(btrim("fin_vige_matr"::text), '')::timestamp(3) AS "fin_vige_matr",
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg",
       NULLIF(rtrim("codi_titu"::text), '')::varchar(2) AS "codi_titu"
FROM "legacy_raw"."decl_zarp_trim_deta"
ON CONFLICT DO NOTHING;

-- DECLARA_JURADA -> contabilidad.declara_jurada  (6 col)
INSERT INTO "contabilidad"."declara_jurada" ("codi_decla", "codi_pers", "codi_alma", "fecha_decla", "direccion", "lugar")
SELECT
       NULLIF(btrim("codi_decla"::text), '')::bigint AS "codi_decla",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("fecha_decla"::text), '')::timestamp(3) AS "fecha_decla",
       NULLIF(rtrim("direccion"::text), '')::varchar(150) AS "direccion",
       NULLIF(rtrim("lugar"::text), '')::varchar(50) AS "lugar"
FROM "legacy_raw"."declara_jurada"
ON CONFLICT DO NOTHING;

-- DECLARA_JURADA_CAJA -> contabilidad.declara_jurada_caja  (4 col)
INSERT INTO "contabilidad"."declara_jurada_caja" ("codi_decla", "fecha_caja", "monto_caja", "codi_mone")
SELECT
       NULLIF(btrim("codi_decla"::text), '')::bigint AS "codi_decla",
       NULLIF(btrim("fecha_caja"::text), '')::timestamp(3) AS "fecha_caja",
       NULLIF(btrim("monto_caja"::text), '')::numeric(18,2) AS "monto_caja",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone"
FROM "legacy_raw"."declara_jurada_caja"
ON CONFLICT DO NOTHING;

-- DECLARA_JURADA_MERCA -> contabilidad.declara_jurada_merca  (3 col)
INSERT INTO "contabilidad"."declara_jurada_merca" ("codi_decla", "codi_lin", "monto_linea")
SELECT
       NULLIF(btrim("codi_decla"::text), '')::bigint AS "codi_decla",
       NULLIF(rtrim("codi_lin"::text), '')::varchar(2) AS "codi_lin",
       NULLIF(btrim("monto_linea"::text), '')::bigint AS "monto_linea"
FROM "legacy_raw"."declara_jurada_merca"
ON CONFLICT DO NOTHING;

-- DETALLE_CALC_AF -> contabilidad.detalle_calc_af  (16 col)
INSERT INTO "contabilidad"."detalle_calc_af" ("codi_activo", "fecha_detalle", "fecha_activo", "costo_hist", "costo_ajus", "depre_hist_ant", "depre_hist_act", "depre_ajus_act", "depre_ajus_ant", "depre_acum_hist", "depre_acum_ajus", "neto_hist", "neto_ajus", "origen", "retirado", "valor_depre")
SELECT
       NULLIF(rtrim("codi_activo"::text), '')::varchar(7) AS "codi_activo",
       NULLIF(rtrim("fecha_detalle"::text), '')::varchar(6) AS "fecha_detalle",
       NULLIF(rtrim("fecha_activo"::text), '')::varchar(6) AS "fecha_activo",
       NULLIF(btrim("costo_hist"::text), '')::numeric(12,2) AS "costo_hist",
       NULLIF(btrim("costo_ajus"::text), '')::numeric(12,2) AS "costo_ajus",
       NULLIF(btrim("depre_hist_ant"::text), '')::numeric(12,2) AS "depre_hist_ant",
       NULLIF(btrim("depre_hist_act"::text), '')::numeric(12,2) AS "depre_hist_act",
       NULLIF(btrim("depre_ajus_act"::text), '')::numeric(12,2) AS "depre_ajus_act",
       NULLIF(btrim("depre_ajus_ant"::text), '')::numeric(12,2) AS "depre_ajus_ant",
       NULLIF(btrim("depre_acum_hist"::text), '')::numeric(12,2) AS "depre_acum_hist",
       NULLIF(btrim("depre_acum_ajus"::text), '')::numeric(12,2) AS "depre_acum_ajus",
       NULLIF(btrim("neto_hist"::text), '')::numeric(12,2) AS "neto_hist",
       NULLIF(btrim("neto_ajus"::text), '')::numeric(12,2) AS "neto_ajus",
       NULLIF(btrim("origen"::text), '')::boolean AS "origen",
       NULLIF(rtrim("retirado"::text), '')::varchar(1) AS "retirado",
       NULLIF(btrim("valor_depre"::text), '')::numeric(18,2) AS "valor_depre"
FROM "legacy_raw"."detalle_calc_af"
ON CONFLICT DO NOTHING;

-- detalle_detraccion -> contabilidad.detalle_detraccion  (16 col)
INSERT INTO "contabilidad"."detalle_detraccion" ("codi_lote_detr", "nro_detalle", "codi_clie_prov", "nro_proforma", "codi_bien_serv", "codi_cta_cte", "importe_deposito", "codi_oper", "nro_cta_cte", "codi_fact", "codi_tipo_docu", "serie", "nro_docu", "registro", "fecha_spot", "num_spot")
SELECT
       NULLIF(rtrim("codi_lote_detr"::text), '')::varchar(10) AS "codi_lote_detr",
       NULLIF(rtrim("nro_detalle"::text), '')::varchar(3) AS "nro_detalle",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("nro_proforma"::text), '')::varchar(9) AS "nro_proforma",
       NULLIF(rtrim("codi_bien_serv"::text), '')::varchar(3) AS "codi_bien_serv",
       NULLIF(rtrim("codi_cta_cte"::text), '')::varchar(6) AS "codi_cta_cte",
       NULLIF(btrim("importe_deposito"::text), '')::numeric(15,2) AS "importe_deposito",
       NULLIF(rtrim("codi_oper"::text), '')::varchar(2) AS "codi_oper",
       NULLIF(rtrim("nro_cta_cte"::text), '')::varchar(20) AS "nro_cta_cte",
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("serie"::text), '')::varchar(5) AS "serie",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(10) AS "nro_docu",
       NULLIF(rtrim("registro"::text), '')::varchar(10) AS "registro",
       NULLIF(btrim("fecha_spot"::text), '')::timestamp(3) AS "fecha_spot",
       NULLIF(rtrim("num_spot"::text), '')::varchar(100) AS "num_spot"
FROM "legacy_raw"."detalle_detraccion"
ON CONFLICT DO NOTHING;

-- Dif_camb -> contabilidad.dif_camb  (3 col)
INSERT INTO "contabilidad"."dif_camb" ("codi_cuenta", "cta_gasto", "cta_ingreso")
SELECT
       NULLIF(rtrim("codi_cuenta"::text), '')::varchar(7) AS "codi_cuenta",
       NULLIF(rtrim("cta_gasto"::text), '')::varchar(7) AS "cta_gasto",
       NULLIF(rtrim("cta_ingreso"::text), '')::varchar(7) AS "cta_ingreso"
FROM "legacy_raw"."dif_camb"
ON CONFLICT DO NOTHING;

-- EEFF -> contabilidad.eeff  (2 col)
INSERT INTO "contabilidad"."eeff" ("cod_esta", "des_esta")
SELECT
       NULLIF(rtrim("cod_esta"::text), '')::varchar(2) AS "cod_esta",
       NULLIF(rtrim("des_esta"::text), '')::varchar(55) AS "des_esta"
FROM "legacy_raw"."eeff"
ON CONFLICT DO NOTHING;

-- ELEMENTO_COSTO -> contabilidad.elemento_costo  (5 col)
INSERT INTO "contabilidad"."elemento_costo" ("codi_elem_costo", "desc_elem_costo", "nemo", "codi_tipo_gast", "uso")
SELECT
       NULLIF(btrim("codi_elem_costo"::text), '')::smallint AS "codi_elem_costo",
       NULLIF(rtrim("desc_elem_costo"::text), '')::varchar(150) AS "desc_elem_costo",
       NULLIF(rtrim("nemo"::text), '')::varchar(50) AS "nemo",
       NULLIF(rtrim("codi_tipo_gast"::text), '')::varchar(2) AS "codi_tipo_gast",
       NULLIF(rtrim("uso"::text), '')::varchar(1) AS "uso"
FROM "legacy_raw"."elemento_costo"
ON CONFLICT DO NOTHING;

-- ESTADOS_FINANCIEROS -> contabilidad.estados_financieros  (4 col)
INSERT INTO "contabilidad"."estados_financieros" ("id", "descripcion", "orden", "tipo")
SELECT
       NULLIF(btrim("id"::text), '')::smallint AS "id",
       NULLIF(rtrim("descripcion"::text), '')::varchar(50) AS "descripcion",
       NULLIF(btrim("orden"::text), '')::smallint AS "orden",
       NULLIF(btrim("tipo"::text), '')::smallint AS "tipo"
FROM "legacy_raw"."estados_financieros"
ON CONFLICT DO NOTHING;

-- ESTADOS_FINANCIEROS_DETALLE -> contabilidad.estados_financieros_detalle  (3 col)
INSERT INTO "contabilidad"."estados_financieros_detalle" ("id", "nro_cuen", "orden")
SELECT
       NULLIF(btrim("id"::text), '')::smallint AS "id",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(3) AS "nro_cuen",
       NULLIF(btrim("orden"::text), '')::smallint AS "orden"
FROM "legacy_raw"."estados_financieros_detalle"
ON CONFLICT DO NOTHING;

-- GASTO_OPERATIVO -> contabilidad.gasto_operativo  (4 col)
INSERT INTO "contabilidad"."gasto_operativo" ("codi_gasto", "anio", "mes", "valor")
SELECT
       NULLIF(btrim("codi_gasto"::text), '')::bigint AS "codi_gasto",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(btrim("valor"::text), '')::numeric(18,2) AS "valor"
FROM "legacy_raw"."gasto_operativo"
ON CONFLICT DO NOTHING;

-- GERENCIAL_REPO -> contabilidad.gerencial_repo  (2 col)
INSERT INTO "contabilidad"."gerencial_repo" ("id_gere", "desc_gere")
SELECT
       NULLIF(btrim("id_gere"::text), '')::integer AS "id_gere",
       NULLIF(rtrim("desc_gere"::text), '')::varchar(150) AS "desc_gere"
FROM "legacy_raw"."gerencial_repo"
ON CONFLICT DO NOTHING;

-- GERENCIAL_REPO_TIPO_CUEN -> contabilidad.gerencial_repo_tipo_cuen  (3 col)
INSERT INTO "contabilidad"."gerencial_repo_tipo_cuen" ("id_gere", "id_tipo", "nro_cuen")
SELECT
       NULLIF(btrim("id_gere"::text), '')::integer AS "id_gere",
       NULLIF(btrim("id_tipo"::text), '')::integer AS "id_tipo",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen"
FROM "legacy_raw"."gerencial_repo_tipo_cuen"
ON CONFLICT DO NOTHING;

-- GERENCIAL_REPO_TIPOS -> contabilidad.gerencial_repo_tipos  (3 col)
INSERT INTO "contabilidad"."gerencial_repo_tipos" ("id_gere", "id_tipo", "desc_tipo_repo")
SELECT
       NULLIF(btrim("id_gere"::text), '')::integer AS "id_gere",
       NULLIF(btrim("id_tipo"::text), '')::integer AS "id_tipo",
       NULLIF(rtrim("desc_tipo_repo"::text), '')::varchar(150) AS "desc_tipo_repo"
FROM "legacy_raw"."gerencial_repo_tipos"
ON CONFLICT DO NOTHING;

-- Glosas -> contabilidad.glosas  (1 col)
INSERT INTO "contabilidad"."glosas" ("glosa")
SELECT
       NULLIF(rtrim("glosa"::text), '')::varchar(200) AS "glosa"
FROM "legacy_raw"."glosas"
ON CONFLICT DO NOTHING;

-- LIBRO_DIARIO_S -> contabilidad.libro_diario_s  (2 col)
INSERT INTO "contabilidad"."libro_diario_s" ("cuenta", "tipo")
SELECT
       NULLIF(rtrim("cuenta"::text), '')::varchar(7) AS "cuenta",
       NULLIF(rtrim("tipo"::text), '')::varchar(2) AS "tipo"
FROM "legacy_raw"."libro_diario_s"
ON CONFLICT DO NOTHING;

-- LIBRO_REGISTRO -> contabilidad.libro_registro  (2 col)
INSERT INTO "contabilidad"."libro_registro" ("codi_libro_regi", "desc_libro_regi")
SELECT
       NULLIF(btrim("codi_libro_regi"::text), '')::smallint AS "codi_libro_regi",
       NULLIF(rtrim("desc_libro_regi"::text), '')::varchar(200) AS "desc_libro_regi"
FROM "legacy_raw"."libro_registro"
ON CONFLICT DO NOTHING;

-- LINEA_CLASE_C -> contabilidad.linea_clase_c  (4 col)
INSERT INTO "contabilidad"."linea_clase_c" ("codi_lcc", "desc_lcc", "td", "codi_subc_4")
SELECT
       NULLIF(rtrim("codi_lcc"::text), '')::varchar(5) AS "codi_lcc",
       NULLIF(rtrim("desc_lcc"::text), '')::varchar(100) AS "desc_lcc",
       NULLIF(btrim("td"::text), '')::numeric(18,2) AS "td",
       NULLIF(rtrim("codi_subc_4"::text), '')::varchar(4) AS "codi_subc_4"
FROM "legacy_raw"."linea_clase_c"
ON CONFLICT DO NOTHING;

-- m_CUENTAS_CONTABLE -> contabilidad.m_cuentas_contable  (15 col)
INSERT INTO "contabilidad"."m_cuentas_contable" ("ide", "nro_cuen", "desc_cuen", "nro_sub_cuen", "codi_lcc", "cta_6", "tipo_cuen", "codi_mone", "nro_cta_cte_banc", "codi_banc", "codi_tipo_cuen_banc", "porc_detr", "transfer", "cta_cierre", "tipo_costo")
SELECT
       NULLIF(btrim("ide"::text), '')::integer AS "ide",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("desc_cuen"::text), '')::varchar(100) AS "desc_cuen",
       NULLIF(rtrim("nro_sub_cuen"::text), '')::varchar(7) AS "nro_sub_cuen",
       NULLIF(rtrim("codi_lcc"::text), '')::varchar(5) AS "codi_lcc",
       NULLIF(rtrim("cta_6"::text), '')::varchar(7) AS "cta_6",
       NULLIF(rtrim("tipo_cuen"::text), '')::varchar(1) AS "tipo_cuen",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(10) AS "codi_mone",
       NULLIF(rtrim("nro_cta_cte_banc"::text), '')::varchar(30) AS "nro_cta_cte_banc",
       NULLIF(rtrim("codi_banc"::text), '')::varchar(2) AS "codi_banc",
       NULLIF(rtrim("codi_tipo_cuen_banc"::text), '')::varchar(2) AS "codi_tipo_cuen_banc",
       NULLIF(btrim("porc_detr"::text), '')::numeric(15,4) AS "porc_detr",
       NULLIF(rtrim("transfer"::text), '')::varchar(1) AS "transfer",
       NULLIF(rtrim("cta_cierre"::text), '')::varchar(7) AS "cta_cierre",
       NULLIF(rtrim("tipo_costo"::text), '')::varchar(1) AS "tipo_costo"
FROM "legacy_raw"."m_cuentas_contable"
ON CONFLICT DO NOTHING;

-- m_LINEA_CLASE_C -> contabilidad.m_linea_clase_c  (5 col)
INSERT INTO "contabilidad"."m_linea_clase_c" ("ide", "codi_lcc", "desc_lcc", "codi_subc", "td")
SELECT
       NULLIF(btrim("ide"::text), '')::integer AS "ide",
       NULLIF(rtrim("codi_lcc"::text), '')::varchar(5) AS "codi_lcc",
       NULLIF(rtrim("desc_lcc"::text), '')::varchar(100) AS "desc_lcc",
       NULLIF(rtrim("codi_subc"::text), '')::varchar(3) AS "codi_subc",
       NULLIF(btrim("td"::text), '')::numeric(18,2) AS "td"
FROM "legacy_raw"."m_linea_clase_c"
ON CONFLICT DO NOTHING;

-- m_SUB_CLAS_CUEN -> contabilidad.m_sub_clas_cuen  (4 col)
INSERT INTO "contabilidad"."m_sub_clas_cuen" ("ide", "codi_subc", "desc_subc", "codi_clas_cuen")
SELECT
       NULLIF(btrim("ide"::text), '')::integer AS "ide",
       NULLIF(rtrim("codi_subc"::text), '')::varchar(3) AS "codi_subc",
       NULLIF(rtrim("desc_subc"::text), '')::varchar(100) AS "desc_subc",
       NULLIF(rtrim("codi_clas_cuen"::text), '')::varchar(2) AS "codi_clas_cuen"
FROM "legacy_raw"."m_sub_clas_cuen"
ON CONFLICT DO NOTHING;

-- Movi_Contables -> contabilidad.movi_contables  (79 col)
INSERT INTO "contabilidad"."movi_contables" ("codi_contable", "anio", "mes", "subdia", "compr", "codi_mone", "fecha", "nro_cuen", "nro_sub_cuen", "codi_clie_prov", "serie", "nro_docu", "codi_tipo_docu", "importe", "igv", "otros", "total", "importe_d", "igv_d", "otros_d", "total_d", "registro", "codi_unid_oper", "glosa", "cargo_abono", "fecha_venc", "tipo_cambio", "situ_cheq", "tipo_cambio_2", "codi_vouc", "fecha_spot", "num_spot", "codi_pers", "codi_sema", "codi_nota_ingr", "nro_orde_comp", "nro_orde_pedi", "codi_pres", "nro_presu", "banco", "cartera", "hecho_por", "itf", "compensa", "detraccion", "fech_pago", "ref", "nro_fact", "codi_memo", "tipo_movi", "codi_desti", "codi_tasa_detr", "retencion", "codi_ingr", "codi_alma", "codi_tipo_intan", "codi_aduana", "anio_dua_dsi", "nro_detrac", "fecha_detrac", "fecha_nd_nc", "tipo_docu_nd_nc", "serie_nd_nc", "nro_docu_nd_nc", "tipo_venta", "codi_libro_regi", "codi_tipo_medio_pago", "banco_aux", "fecha_creacion", "estado_inic", "creacion", "id_flujo", "id_tipo_flujo", "codi_oper", "codi_bien_serv", "pdetr", "valor_refe", "placa", "nro_refe")
SELECT
       NULLIF(rtrim("codi_contable"::text), '')::varchar(10) AS "codi_contable",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("subdia"::text), '')::varchar(1) AS "subdia",
       NULLIF(rtrim("compr"::text), '')::varchar(10) AS "compr",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("nro_sub_cuen"::text), '')::varchar(7) AS "nro_sub_cuen",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("serie"::text), '')::varchar(5) AS "serie",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(20) AS "nro_docu",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(btrim("importe"::text), '')::numeric(18,2) AS "importe",
       NULLIF(btrim("igv"::text), '')::numeric(18,2) AS "igv",
       NULLIF(btrim("otros"::text), '')::numeric(18,2) AS "otros",
       NULLIF(btrim("total"::text), '')::numeric(18,2) AS "total",
       NULLIF(btrim("importe_d"::text), '')::numeric(18,2) AS "importe_d",
       NULLIF(btrim("igv_d"::text), '')::numeric(18,2) AS "igv_d",
       NULLIF(btrim("otros_d"::text), '')::numeric(18,2) AS "otros_d",
       NULLIF(btrim("total_d"::text), '')::numeric(18,2) AS "total_d",
       NULLIF(rtrim("registro"::text), '')::varchar(10) AS "registro",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("glosa"::text), '')::varchar(200) AS "glosa",
       NULLIF(rtrim("cargo_abono"::text), '')::varchar(1) AS "cargo_abono",
       NULLIF(btrim("fecha_venc"::text), '')::timestamp(3) AS "fecha_venc",
       NULLIF(btrim("tipo_cambio"::text), '')::numeric(18,4) AS "tipo_cambio",
       NULLIF(rtrim("situ_cheq"::text), '')::varchar(2) AS "situ_cheq",
       NULLIF(btrim("tipo_cambio_2"::text), '')::numeric(18,4) AS "tipo_cambio_2",
       NULLIF(rtrim("codi_vouc"::text), '')::varchar(10) AS "codi_vouc",
       NULLIF(btrim("fecha_spot"::text), '')::timestamp(3) AS "fecha_spot",
       NULLIF(rtrim("num_spot"::text), '')::varchar(10) AS "num_spot",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(10) AS "codi_sema",
       NULLIF(rtrim("codi_nota_ingr"::text), '')::varchar(10) AS "codi_nota_ingr",
       NULLIF(rtrim("nro_orde_comp"::text), '')::varchar(10) AS "nro_orde_comp",
       NULLIF(rtrim("nro_orde_pedi"::text), '')::varchar(10) AS "nro_orde_pedi",
       NULLIF(rtrim("codi_pres"::text), '')::varchar(4) AS "codi_pres",
       NULLIF(rtrim("nro_presu"::text), '')::varchar(5) AS "nro_presu",
       NULLIF(rtrim("banco"::text), '')::varchar(7) AS "banco",
       NULLIF(btrim("cartera"::text), '')::boolean AS "cartera",
       NULLIF(rtrim("hecho_por"::text), '')::varchar(5) AS "hecho_por",
       NULLIF(rtrim("itf"::text), '')::varchar(1) AS "itf",
       NULLIF(btrim("compensa"::text), '')::boolean AS "compensa",
       NULLIF(btrim("detraccion"::text), '')::boolean AS "detraccion",
       NULLIF(btrim("fech_pago"::text), '')::timestamp(3) AS "fech_pago",
       NULLIF(rtrim("ref"::text), '')::varchar(5) AS "ref",
       NULLIF(rtrim("nro_fact"::text), '')::varchar(20) AS "nro_fact",
       NULLIF(btrim("codi_memo"::text), '')::bigint AS "codi_memo",
       NULLIF(rtrim("tipo_movi"::text), '')::varchar(2) AS "tipo_movi",
       NULLIF(rtrim("codi_desti"::text), '')::varchar(1) AS "codi_desti",
       NULLIF(rtrim("codi_tasa_detr"::text), '')::varchar(5) AS "codi_tasa_detr",
       NULLIF(btrim("retencion"::text), '')::boolean AS "retencion",
       NULLIF(btrim("codi_ingr"::text), '')::bigint AS "codi_ingr",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_tipo_intan"::text), '')::varchar(2) AS "codi_tipo_intan",
       NULLIF(btrim("codi_aduana"::text), '')::smallint AS "codi_aduana",
       NULLIF(btrim("anio_dua_dsi"::text), '')::smallint AS "anio_dua_dsi",
       NULLIF(rtrim("nro_detrac"::text), '')::varchar(10) AS "nro_detrac",
       NULLIF(btrim("fecha_detrac"::text), '')::timestamp(0) AS "fecha_detrac",
       NULLIF(btrim("fecha_nd_nc"::text), '')::timestamp(0) AS "fecha_nd_nc",
       NULLIF(rtrim("tipo_docu_nd_nc"::text), '')::varchar(4) AS "tipo_docu_nd_nc",
       NULLIF(rtrim("serie_nd_nc"::text), '')::varchar(5) AS "serie_nd_nc",
       NULLIF(rtrim("nro_docu_nd_nc"::text), '')::varchar(10) AS "nro_docu_nd_nc",
       NULLIF(rtrim("tipo_venta"::text), '')::varchar(1) AS "tipo_venta",
       NULLIF(btrim("codi_libro_regi"::text), '')::smallint AS "codi_libro_regi",
       NULLIF(btrim("codi_tipo_medio_pago"::text), '')::smallint AS "codi_tipo_medio_pago",
       NULLIF(rtrim("banco_aux"::text), '')::varchar(2) AS "banco_aux",
       NULLIF(btrim("fecha_creacion"::text), '')::timestamp(3) AS "fecha_creacion",
       NULLIF(btrim("estado_inic"::text), '')::integer AS "estado_inic",
       NULLIF(btrim("creacion"::text), '')::timestamp(3) AS "creacion",
       NULLIF(btrim("id_flujo"::text), '')::integer AS "id_flujo",
       NULLIF(btrim("id_tipo_flujo"::text), '')::integer AS "id_tipo_flujo",
       NULLIF(rtrim("codi_oper"::text), '')::varchar(4) AS "codi_oper",
       NULLIF(rtrim("codi_bien_serv"::text), '')::varchar(5) AS "codi_bien_serv",
       NULLIF(btrim("pdetr"::text), '')::numeric(18,3) AS "pdetr",
       NULLIF(btrim("valor_refe"::text), '')::numeric(18,2) AS "valor_refe",
       NULLIF(rtrim("placa"::text), '')::varchar(100) AS "placa",
       NULLIF(rtrim("nro_refe"::text), '')::varchar(10) AS "nro_refe"
FROM "legacy_raw"."movi_contables"
ON CONFLICT DO NOTHING;

-- OPERAC_SUNAT_PLE -> contabilidad.operac_sunat_ple  (8 col)
INSERT INTO "contabilidad"."operac_sunat_ple" ("id_sec", "anio", "mes", "compr", "anio_regis", "mes_regis", "subdia_regis", "estado")
SELECT
       NULLIF(btrim("id_sec"::text), '')::integer AS "id_sec",
       NULLIF(btrim("anio"::text), '')::integer AS "anio",
       NULLIF(btrim("mes"::text), '')::integer AS "mes",
       NULLIF(rtrim("compr"::text), '')::varchar(10) AS "compr",
       NULLIF(rtrim("anio_regis"::text), '')::varchar(4) AS "anio_regis",
       NULLIF(rtrim("mes_regis"::text), '')::varchar(2) AS "mes_regis",
       NULLIF(rtrim("subdia_regis"::text), '')::varchar(1) AS "subdia_regis",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado"
FROM "legacy_raw"."operac_sunat_ple"
ON CONFLICT DO NOTHING;

-- operaciones -> contabilidad.operaciones  (3 col)
INSERT INTO "contabilidad"."operaciones" ("codi_oper", "desc_oper", "nemo_oper")
SELECT
       NULLIF(rtrim("codi_oper"::text), '')::varchar(2) AS "codi_oper",
       NULLIF(rtrim("desc_oper"::text), '')::varchar(250) AS "desc_oper",
       NULLIF(rtrim("nemo_oper"::text), '')::varchar(50) AS "nemo_oper"
FROM "legacy_raw"."operaciones"
ON CONFLICT DO NOTHING;

-- PLECOMPRAS -> contabilidad.plecompras  (42 col)
INSERT INTO "contabilidad"."plecompras" ("columna_0", "columna_1", "columna_2", "columna_3", "columna_4", "columna_5", "columna_6", "columna_7", "columna_8", "columna_9", "columna_10", "columna_11", "columna_12", "columna_13", "columna_14", "columna_15", "columna_16", "columna_17", "columna_18", "columna_19", "columna_20", "columna_21", "columna_22", "columna_23", "columna_24", "columna_25", "columna_26", "columna_27", "columna_28", "columna_29", "columna_30", "columna_31", "columna_32", "columna_33", "columna_34", "columna_35", "columna_36", "columna_37", "columna_38", "columna_39", "columna_40", "columna_41")
SELECT
       NULLIF(rtrim("columna 0"::text), '')::varchar(50) AS "columna_0",
       NULLIF(rtrim("columna 1"::text), '')::varchar(50) AS "columna_1",
       NULLIF(rtrim("columna 2"::text), '')::varchar(50) AS "columna_2",
       NULLIF(rtrim("columna 3"::text), '')::varchar(50) AS "columna_3",
       NULLIF(rtrim("columna 4"::text), '')::varchar(50) AS "columna_4",
       NULLIF(rtrim("columna 5"::text), '')::varchar(50) AS "columna_5",
       NULLIF(rtrim("columna 6"::text), '')::varchar(50) AS "columna_6",
       NULLIF(rtrim("columna 7"::text), '')::varchar(50) AS "columna_7",
       NULLIF(rtrim("columna 8"::text), '')::varchar(50) AS "columna_8",
       NULLIF(rtrim("columna 9"::text), '')::varchar(50) AS "columna_9",
       NULLIF(rtrim("columna 10"::text), '')::varchar(50) AS "columna_10",
       NULLIF(rtrim("columna 11"::text), '')::varchar(50) AS "columna_11",
       NULLIF(rtrim("columna 12"::text), '')::varchar(100) AS "columna_12",
       NULLIF(rtrim("columna 13"::text), '')::varchar(50) AS "columna_13",
       NULLIF(rtrim("columna 14"::text), '')::varchar(50) AS "columna_14",
       NULLIF(rtrim("columna 15"::text), '')::varchar(50) AS "columna_15",
       NULLIF(rtrim("columna 16"::text), '')::varchar(50) AS "columna_16",
       NULLIF(rtrim("columna 17"::text), '')::varchar(50) AS "columna_17",
       NULLIF(rtrim("columna 18"::text), '')::varchar(50) AS "columna_18",
       NULLIF(rtrim("columna 19"::text), '')::varchar(50) AS "columna_19",
       NULLIF(rtrim("columna 20"::text), '')::varchar(50) AS "columna_20",
       NULLIF(rtrim("columna 21"::text), '')::varchar(50) AS "columna_21",
       NULLIF(rtrim("columna 22"::text), '')::varchar(50) AS "columna_22",
       NULLIF(rtrim("columna 23"::text), '')::varchar(50) AS "columna_23",
       NULLIF(rtrim("columna 24"::text), '')::varchar(50) AS "columna_24",
       NULLIF(rtrim("columna 25"::text), '')::varchar(50) AS "columna_25",
       NULLIF(rtrim("columna 26"::text), '')::varchar(50) AS "columna_26",
       NULLIF(rtrim("columna 27"::text), '')::varchar(50) AS "columna_27",
       NULLIF(rtrim("columna 28"::text), '')::varchar(50) AS "columna_28",
       NULLIF(rtrim("columna 29"::text), '')::varchar(50) AS "columna_29",
       NULLIF(rtrim("columna 30"::text), '')::varchar(50) AS "columna_30",
       NULLIF(rtrim("columna 31"::text), '')::varchar(50) AS "columna_31",
       NULLIF(rtrim("columna 32"::text), '')::varchar(50) AS "columna_32",
       NULLIF(rtrim("columna 33"::text), '')::varchar(50) AS "columna_33",
       NULLIF(rtrim("columna 34"::text), '')::varchar(50) AS "columna_34",
       NULLIF(rtrim("columna 35"::text), '')::varchar(50) AS "columna_35",
       NULLIF(rtrim("columna 36"::text), '')::varchar(50) AS "columna_36",
       NULLIF(rtrim("columna 37"::text), '')::varchar(50) AS "columna_37",
       NULLIF(rtrim("columna 38"::text), '')::varchar(50) AS "columna_38",
       NULLIF(rtrim("columna 39"::text), '')::varchar(50) AS "columna_39",
       NULLIF(rtrim("columna 40"::text), '')::varchar(50) AS "columna_40",
       NULLIF(rtrim("columna 41"::text), '')::varchar(50) AS "columna_41"
FROM "legacy_raw"."plecompras"
ON CONFLICT DO NOTHING;

-- PUNTO_EQUILIBRIO -> contabilidad.punto_equilibrio  (11 col)
INSERT INTO "contabilidad"."punto_equilibrio" ("mesanio", "costo_fijo", "costo_vari", "costo_tota", "toneladas", "ventas", "costo_vari_uni", "precio_vari_unit", "peunidades", "peventas", "marg_segu")
SELECT
       NULLIF(rtrim("mesanio"::text), '')::varchar(6) AS "mesanio",
       NULLIF(btrim("costo_fijo"::text), '')::numeric(18,2) AS "costo_fijo",
       NULLIF(btrim("costo_vari"::text), '')::numeric(18,2) AS "costo_vari",
       NULLIF(btrim("costo_tota"::text), '')::numeric(18,2) AS "costo_tota",
       NULLIF(btrim("toneladas"::text), '')::numeric(18,3) AS "toneladas",
       NULLIF(btrim("ventas"::text), '')::numeric(18,2) AS "ventas",
       NULLIF(btrim("costo_vari_uni"::text), '')::numeric(20,12) AS "costo_vari_uni",
       NULLIF(btrim("precio_vari_unit"::text), '')::numeric(20,12) AS "precio_vari_unit",
       NULLIF(btrim("peunidades"::text), '')::numeric(38,12) AS "peunidades",
       NULLIF(btrim("peventas"::text), '')::numeric(38,12) AS "peventas",
       NULLIF(btrim("marg_segu"::text), '')::numeric(18,2) AS "marg_segu"
FROM "legacy_raw"."punto_equilibrio"
ON CONFLICT DO NOTHING;

-- RATIOS -> contabilidad.ratios  (2 col)
INSERT INTO "contabilidad"."ratios" ("codi_rati", "desc_rati")
SELECT
       NULLIF(rtrim("codi_rati"::text), '')::varchar(2) AS "codi_rati",
       NULLIF(rtrim("desc_rati"::text), '')::varchar(60) AS "desc_rati"
FROM "legacy_raw"."ratios"
ON CONFLICT DO NOTHING;

-- REPORTE_EEFF -> contabilidad.reporte_eeff  (2 col)
INSERT INTO "contabilidad"."reporte_eeff" ("codi_repo", "desc_repo")
SELECT
       NULLIF(btrim("codi_repo"::text), '')::integer AS "codi_repo",
       NULLIF(rtrim("desc_repo"::text), '')::varchar(100) AS "desc_repo"
FROM "legacy_raw"."reporte_eeff"
ON CONFLICT DO NOTHING;

-- REPORTE_EEFF_GRUPO -> contabilidad.reporte_eeff_grupo  (4 col)
INSERT INTO "contabilidad"."reporte_eeff_grupo" ("codi_grupo", "desc_grupo", "codi_repo", "orden")
SELECT
       NULLIF(btrim("codi_grupo"::text), '')::integer AS "codi_grupo",
       NULLIF(rtrim("desc_grupo"::text), '')::varchar(100) AS "desc_grupo",
       NULLIF(btrim("codi_repo"::text), '')::integer AS "codi_repo",
       NULLIF(rtrim("orden"::text), '')::varchar(1) AS "orden"
FROM "legacy_raw"."reporte_eeff_grupo"
ON CONFLICT DO NOTHING;

-- Retencion -> contabilidad.retencion  (10 col)
INSERT INTO "contabilidad"."retencion" ("serie", "num", "subdia", "compr", "mes", "anio", "banco", "monto", "anulado", "fecha")
SELECT
       NULLIF(btrim("serie"::text), '')::bigint AS "serie",
       NULLIF(btrim("num"::text), '')::bigint AS "num",
       NULLIF(rtrim("subdia"::text), '')::varchar(1) AS "subdia",
       NULLIF(rtrim("compr"::text), '')::varchar(4) AS "compr",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("banco"::text), '')::varchar(7) AS "banco",
       NULLIF(btrim("monto"::text), '')::numeric(18,2) AS "monto",
       NULLIF(rtrim("anulado"::text), '')::varchar(1) AS "anulado",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha"
FROM "legacy_raw"."retencion"
ON CONFLICT DO NOTHING;

-- SALD_TOTA_C -> contabilidad.sald_tota_c  (9 col)
INSERT INTO "contabilidad"."sald_tota_c" ("codi_tota", "anio", "mes", "nro_cuen", "desc_cuen", "importe_c", "importe_a", "importe_d_c", "importe_d_a")
SELECT
       NULLIF(btrim("codi_tota"::text), '')::bigint AS "codi_tota",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("desc_cuen"::text), '')::varchar(100) AS "desc_cuen",
       NULLIF(btrim("importe_c"::text), '')::numeric(18,2) AS "importe_c",
       NULLIF(btrim("importe_a"::text), '')::numeric(18,2) AS "importe_a",
       NULLIF(btrim("importe_d_c"::text), '')::numeric(18,2) AS "importe_d_c",
       NULLIF(btrim("importe_d_a"::text), '')::numeric(18,2) AS "importe_d_a"
FROM "legacy_raw"."sald_tota_c"
ON CONFLICT DO NOTHING;

-- SALD_TOTA_C_P -> contabilidad.sald_tota_c_p  (12 col)
INSERT INTO "contabilidad"."sald_tota_c_p" ("codi_tota", "anio", "mes", "nro_cuen", "codi_clie_prov", "desc_cuen", "ruc_prov", "desc_prov", "importe_c", "importe_a", "importe_d_c", "importe_d_a")
SELECT
       NULLIF(btrim("codi_tota"::text), '')::bigint AS "codi_tota",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("desc_cuen"::text), '')::varchar(100) AS "desc_cuen",
       NULLIF(rtrim("ruc_prov"::text), '')::varchar(15) AS "ruc_prov",
       NULLIF(rtrim("desc_prov"::text), '')::varchar(100) AS "desc_prov",
       NULLIF(btrim("importe_c"::text), '')::numeric(18,2) AS "importe_c",
       NULLIF(btrim("importe_a"::text), '')::numeric(18,2) AS "importe_a",
       NULLIF(btrim("importe_d_c"::text), '')::numeric(18,2) AS "importe_d_c",
       NULLIF(btrim("importe_d_a"::text), '')::numeric(18,2) AS "importe_d_a"
FROM "legacy_raw"."sald_tota_c_p"
ON CONFLICT DO NOTHING;

-- SALD_TOTA_C_UO -> contabilidad.sald_tota_c_uo  (11 col)
INSERT INTO "contabilidad"."sald_tota_c_uo" ("codi_tota", "anio", "mes", "nro_cuen", "codi_unid_oper", "desc_cuen", "desc_unid_oper", "importe_c", "importe_a", "importe_d_c", "importe_d_a")
SELECT
       NULLIF(btrim("codi_tota"::text), '')::bigint AS "codi_tota",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("desc_cuen"::text), '')::varchar(100) AS "desc_cuen",
       NULLIF(rtrim("desc_unid_oper"::text), '')::varchar(100) AS "desc_unid_oper",
       NULLIF(btrim("importe_c"::text), '')::numeric(18,2) AS "importe_c",
       NULLIF(btrim("importe_a"::text), '')::numeric(18,2) AS "importe_a",
       NULLIF(btrim("importe_d_c"::text), '')::numeric(18,2) AS "importe_d_c",
       NULLIF(btrim("importe_d_a"::text), '')::numeric(18,2) AS "importe_d_a"
FROM "legacy_raw"."sald_tota_c_uo"
ON CONFLICT DO NOTHING;

-- SALD_TOTA_C_UO_P -> contabilidad.sald_tota_c_uo_p  (14 col)
INSERT INTO "contabilidad"."sald_tota_c_uo_p" ("codi_tota", "anio", "mes", "nro_cuen", "codi_unid_oper", "codi_clie_prov", "desc_cuen", "desc_unid_oper", "ruc_prov", "desc_prov", "importe_c", "importe_a", "importe_d_c", "importe_d_a")
SELECT
       NULLIF(btrim("codi_tota"::text), '')::bigint AS "codi_tota",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("desc_cuen"::text), '')::varchar(100) AS "desc_cuen",
       NULLIF(rtrim("desc_unid_oper"::text), '')::varchar(100) AS "desc_unid_oper",
       NULLIF(rtrim("ruc_prov"::text), '')::varchar(15) AS "ruc_prov",
       NULLIF(rtrim("desc_prov"::text), '')::varchar(100) AS "desc_prov",
       NULLIF(btrim("importe_c"::text), '')::numeric(18,2) AS "importe_c",
       NULLIF(btrim("importe_a"::text), '')::numeric(18,2) AS "importe_a",
       NULLIF(btrim("importe_d_c"::text), '')::numeric(18,2) AS "importe_d_c",
       NULLIF(btrim("importe_d_a"::text), '')::numeric(18,2) AS "importe_d_a"
FROM "legacy_raw"."sald_tota_c_uo_p"
ON CONFLICT DO NOTHING;

-- SALDOS_CUENTAS -> contabilidad.saldos_cuentas  (8 col)
INSERT INTO "contabilidad"."saldos_cuentas" ("mesanio", "nro_cuen", "saldoant", "cargo", "abono", "saldonue", "cargoacum", "abonoacum")
SELECT
       NULLIF(rtrim("mesanio"::text), '')::varchar(6) AS "mesanio",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(btrim("saldoant"::text), '')::numeric(12,2) AS "saldoant",
       NULLIF(btrim("cargo"::text), '')::numeric(12,2) AS "cargo",
       NULLIF(btrim("abono"::text), '')::numeric(12,2) AS "abono",
       NULLIF(btrim("saldonue"::text), '')::numeric(12,2) AS "saldonue",
       NULLIF(btrim("cargoacum"::text), '')::numeric(12,3) AS "cargoacum",
       NULLIF(btrim("abonoacum"::text), '')::numeric(12,3) AS "abonoacum"
FROM "legacy_raw"."saldos_cuentas"
ON CONFLICT DO NOTHING;

-- SUB_CLAS_CUEN -> contabilidad.sub_clas_cuen  (3 col)
INSERT INTO "contabilidad"."sub_clas_cuen" ("codi_subc", "desc_subc", "codi_clas_cuen")
SELECT
       NULLIF(rtrim("codi_subc"::text), '')::varchar(3) AS "codi_subc",
       NULLIF(rtrim("desc_subc"::text), '')::varchar(100) AS "desc_subc",
       NULLIF(rtrim("codi_clas_cuen"::text), '')::varchar(2) AS "codi_clas_cuen"
FROM "legacy_raw"."sub_clas_cuen"
ON CONFLICT DO NOTHING;

-- SUB_CLASE -> contabilidad.sub_clase  (8 col)
INSERT INTO "contabilidad"."sub_clase" ("cod_clase", "cod_subclase", "nomb_subclase", "id_bien_detraccion", "tasa_detraccion", "unidad_negocio", "unidad", "flag_cargo_directo")
SELECT
       NULLIF(rtrim("cod_clase"::text), '')::varchar(3) AS "cod_clase",
       NULLIF(rtrim("cod_subclase"::text), '')::varchar(3) AS "cod_subclase",
       NULLIF(rtrim("nomb_subclase"::text), '')::varchar(40) AS "nomb_subclase",
       NULLIF(rtrim("id_bien_detraccion"::text), '')::varchar(2) AS "id_bien_detraccion",
       NULLIF(btrim("tasa_detraccion"::text), '')::numeric(18,4) AS "tasa_detraccion",
       NULLIF(rtrim("unidad_negocio"::text), '')::varchar(10) AS "unidad_negocio",
       NULLIF(rtrim("unidad"::text), '')::varchar(8) AS "unidad",
       NULLIF(rtrim("flag_cargo_directo"::text), '')::varchar(1) AS "flag_cargo_directo"
FROM "legacy_raw"."sub_clase"
ON CONFLICT DO NOTHING;

-- SUB_CLASE_CONT_4 -> contabilidad.sub_clase_cont_4  (3 col)
INSERT INTO "contabilidad"."sub_clase_cont_4" ("codi_subc_4", "desc_sub_4", "codi_subc")
SELECT
       NULLIF(rtrim("codi_subc_4"::text), '')::varchar(4) AS "codi_subc_4",
       NULLIF(rtrim("desc_sub_4"::text), '')::varchar(250) AS "desc_sub_4",
       NULLIF(rtrim("codi_subc"::text), '')::varchar(3) AS "codi_subc"
FROM "legacy_raw"."sub_clase_cont_4"
ON CONFLICT DO NOTHING;

-- SUB_CONCEPTO_SUNAT -> contabilidad.sub_concepto_sunat  (3 col)
INSERT INTO "contabilidad"."sub_concepto_sunat" ("codi_sub_concep", "desc_sub_concep_sunat", "codi_concep_sunat")
SELECT
       NULLIF(btrim("codi_sub_concep"::text), '')::smallint AS "codi_sub_concep",
       NULLIF(rtrim("desc_sub_concep_sunat"::text), '')::varchar(200) AS "desc_sub_concep_sunat",
       NULLIF(btrim("codi_concep_sunat"::text), '')::smallint AS "codi_concep_sunat"
FROM "legacy_raw"."sub_concepto_sunat"
ON CONFLICT DO NOTHING;

-- SUBDIARIO -> contabilidad.subdiario  (6 col)
INSERT INTO "contabilidad"."subdiario" ("codi_subd", "nemotec", "descrip", "orden", "central", "codi_libro")
SELECT
       NULLIF(rtrim("codi_subd"::text), '')::varchar(2) AS "codi_subd",
       NULLIF(rtrim("nemotec"::text), '')::varchar(1) AS "nemotec",
       NULLIF(rtrim("descrip"::text), '')::varchar(40) AS "descrip",
       NULLIF(btrim("orden"::text), '')::integer AS "orden",
       NULLIF(rtrim("central"::text), '')::varchar(1) AS "central",
       NULLIF(btrim("codi_libro"::text), '')::integer AS "codi_libro"
FROM "legacy_raw"."subdiario"
ON CONFLICT DO NOTHING;

-- SUNAT -> contabilidad.sunat  (2 col)
INSERT INTO "contabilidad"."sunat" ("codi_sunat", "nro_cuen")
SELECT
       NULLIF(rtrim("codi_sunat"::text), '')::varchar(5) AS "codi_sunat",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen"
FROM "legacy_raw"."sunat"
ON CONFLICT DO NOTHING;

-- SUNAT_F318 -> contabilidad.sunat_f318  (6 col)
INSERT INTO "contabilidad"."sunat_f318" ("id_tipo_flujo", "id_flujo", "desc_acti", "desc_flujo", "subdia", "orden")
SELECT
       NULLIF(btrim("id_tipo_flujo"::text), '')::integer AS "id_tipo_flujo",
       NULLIF(btrim("id_flujo"::text), '')::integer AS "id_flujo",
       NULLIF(rtrim("desc_acti"::text), '')::varchar(100) AS "desc_acti",
       NULLIF(rtrim("desc_flujo"::text), '')::varchar(250) AS "desc_flujo",
       NULLIF(rtrim("subdia"::text), '')::varchar(1) AS "subdia",
       NULLIF(btrim("orden"::text), '')::integer AS "orden"
FROM "legacy_raw"."sunat_f318"
ON CONFLICT DO NOTHING;

-- TIPO_AFECTA_IGV -> contabilidad.tipo_afecta_igv  (4 col)
INSERT INTO "contabilidad"."tipo_afecta_igv" ("codi_tipo_afec", "desc_tipo_afec", "tipo_afec", "cod_imp")
SELECT
       NULLIF(rtrim("codi_tipo_afec"::text), '')::varchar(2) AS "codi_tipo_afec",
       NULLIF(rtrim("desc_tipo_afec"::text), '')::varchar(150) AS "desc_tipo_afec",
       NULLIF(rtrim("tipo_afec"::text), '')::varchar(50) AS "tipo_afec",
       NULLIF(btrim("cod_imp"::text), '')::integer AS "cod_imp"
FROM "legacy_raw"."tipo_afecta_igv"
ON CONFLICT DO NOTHING;

-- TIPO_COMPROBANTE -> contabilidad.tipo_comprobante  (2 col)
INSERT INTO "contabilidad"."tipo_comprobante" ("codi_compr", "desc_compr")
SELECT
       NULLIF(rtrim("codi_compr"::text), '')::varchar(1) AS "codi_compr",
       NULLIF(rtrim("desc_compr"::text), '')::varchar(50) AS "desc_compr"
FROM "legacy_raw"."tipo_comprobante"
ON CONFLICT DO NOTHING;

-- TIPO_COST_GENE -> contabilidad.tipo_cost_gene  (4 col)
INSERT INTO "contabilidad"."tipo_cost_gene" ("codi_tipo_cost_gene", "desc_tipo_cost_gene", "nemo", "orden")
SELECT
       NULLIF(rtrim("codi_tipo_cost_gene"::text), '')::varchar(2) AS "codi_tipo_cost_gene",
       NULLIF(rtrim("desc_tipo_cost_gene"::text), '')::varchar(50) AS "desc_tipo_cost_gene",
       NULLIF(rtrim("nemo"::text), '')::varchar(20) AS "nemo",
       NULLIF(btrim("orden"::text), '')::smallint AS "orden"
FROM "legacy_raw"."tipo_cost_gene"
ON CONFLICT DO NOTHING;

-- TIPO_COSTO -> contabilidad.tipo_costo  (6 col)
INSERT INTO "contabilidad"."tipo_costo" ("codi_tipo_cost", "desc_tipo_cost", "nemo", "orden", "cf_cv", "tcg")
SELECT
       NULLIF(rtrim("codi_tipo_cost"::text), '')::varchar(2) AS "codi_tipo_cost",
       NULLIF(rtrim("desc_tipo_cost"::text), '')::varchar(100) AS "desc_tipo_cost",
       NULLIF(rtrim("nemo"::text), '')::varchar(20) AS "nemo",
       NULLIF(btrim("orden"::text), '')::smallint AS "orden",
       NULLIF(rtrim("cf_cv"::text), '')::varchar(2) AS "cf_cv",
       NULLIF(rtrim("tcg"::text), '')::varchar(2) AS "tcg"
FROM "legacy_raw"."tipo_costo"
ON CONFLICT DO NOTHING;

-- TIPO_EEFF -> contabilidad.tipo_eeff  (3 col)
INSERT INTO "contabilidad"."tipo_eeff" ("codi_tipo_eeff", "desc_tipo_eeff", "nemo_tipo_eeff")
SELECT
       NULLIF(rtrim("codi_tipo_eeff"::text), '')::varchar(2) AS "codi_tipo_eeff",
       NULLIF(rtrim("desc_tipo_eeff"::text), '')::varchar(100) AS "desc_tipo_eeff",
       NULLIF(rtrim("nemo_tipo_eeff"::text), '')::varchar(10) AS "nemo_tipo_eeff"
FROM "legacy_raw"."tipo_eeff"
ON CONFLICT DO NOTHING;

-- TIPO_FORM_MOST_EEFF -> contabilidad.tipo_form_most_eeff  (3 col)
INSERT INTO "contabilidad"."tipo_form_most_eeff" ("codi_tipo_eeff", "codi_clas_cuen", "tipo_form_most")
SELECT
       NULLIF(rtrim("codi_tipo_eeff"::text), '')::varchar(2) AS "codi_tipo_eeff",
       NULLIF(rtrim("codi_clas_cuen"::text), '')::varchar(2) AS "codi_clas_cuen",
       NULLIF(rtrim("tipo_form_most"::text), '')::varchar(2) AS "tipo_form_most"
FROM "legacy_raw"."tipo_form_most_eeff"
ON CONFLICT DO NOTHING;

-- TIPO_FORM_PROV_PLAN -> contabilidad.tipo_form_prov_plan  (2 col)
INSERT INTO "contabilidad"."tipo_form_prov_plan" ("codi_tipo_prov", "desc_tipo_prov")
SELECT
       NULLIF(rtrim("codi_tipo_prov"::text), '')::varchar(2) AS "codi_tipo_prov",
       NULLIF(rtrim("desc_tipo_prov"::text), '')::varchar(50) AS "desc_tipo_prov"
FROM "legacy_raw"."tipo_form_prov_plan"
ON CONFLICT DO NOTHING;

-- TIPO_GASTO -> contabilidad.tipo_gasto  (2 col)
INSERT INTO "contabilidad"."tipo_gasto" ("codi_tipo_gast", "desc_tipo_gast")
SELECT
       NULLIF(rtrim("codi_tipo_gast"::text), '')::varchar(1) AS "codi_tipo_gast",
       NULLIF(rtrim("desc_tipo_gast"::text), '')::varchar(30) AS "desc_tipo_gast"
FROM "legacy_raw"."tipo_gasto"
ON CONFLICT DO NOTHING;

-- TIPO_IMPUESTOS -> contabilidad.tipo_impuestos  (2 col)
INSERT INTO "contabilidad"."tipo_impuestos" ("cod_imp", "desc_imp")
SELECT
       NULLIF(btrim("cod_imp"::text), '')::integer AS "cod_imp",
       NULLIF(rtrim("desc_imp"::text), '')::varchar(30) AS "desc_imp"
FROM "legacy_raw"."tipo_impuestos"
ON CONFLICT DO NOTHING;

-- TIPO_INTANGIBLE -> contabilidad.tipo_intangible  (2 col)
INSERT INTO "contabilidad"."tipo_intangible" ("codi_tipo_intan", "desc_tipo_intan")
SELECT
       NULLIF(rtrim("codi_tipo_intan"::text), '')::varchar(2) AS "codi_tipo_intan",
       NULLIF(rtrim("desc_tipo_intan"::text), '')::varchar(100) AS "desc_tipo_intan"
FROM "legacy_raw"."tipo_intangible"
ON CONFLICT DO NOTHING;

-- reajuste de secuencias de identidad del legado
SELECT setval(pg_get_serial_sequence('"contabilidad"."catalmae"', 'a'),
              (SELECT COALESCE(MAX("a"), 1) FROM "contabilidad"."catalmae"),
              (SELECT COUNT(*) > 0 FROM "contabilidad"."catalmae"));
SELECT setval(pg_get_serial_sequence('"contabilidad"."gasto_operativo"', 'codi_gasto'),
              (SELECT COALESCE(MAX("codi_gasto"), 1) FROM "contabilidad"."gasto_operativo"),
              (SELECT COUNT(*) > 0 FROM "contabilidad"."gasto_operativo"));
SELECT setval(pg_get_serial_sequence('"contabilidad"."m_cuentas_contable"', 'ide'),
              (SELECT COALESCE(MAX("ide"), 1) FROM "contabilidad"."m_cuentas_contable"),
              (SELECT COUNT(*) > 0 FROM "contabilidad"."m_cuentas_contable"));
SELECT setval(pg_get_serial_sequence('"contabilidad"."m_linea_clase_c"', 'ide'),
              (SELECT COALESCE(MAX("ide"), 1) FROM "contabilidad"."m_linea_clase_c"),
              (SELECT COUNT(*) > 0 FROM "contabilidad"."m_linea_clase_c"));
SELECT setval(pg_get_serial_sequence('"contabilidad"."m_sub_clas_cuen"', 'ide'),
              (SELECT COALESCE(MAX("ide"), 1) FROM "contabilidad"."m_sub_clas_cuen"),
              (SELECT COUNT(*) > 0 FROM "contabilidad"."m_sub_clas_cuen"));
SELECT setval(pg_get_serial_sequence('"contabilidad"."operac_sunat_ple"', 'id_sec'),
              (SELECT COALESCE(MAX("id_sec"), 1) FROM "contabilidad"."operac_sunat_ple"),
              (SELECT COUNT(*) > 0 FROM "contabilidad"."operac_sunat_ple"));
SELECT setval(pg_get_serial_sequence('"contabilidad"."sald_tota_c"', 'codi_tota'),
              (SELECT COALESCE(MAX("codi_tota"), 1) FROM "contabilidad"."sald_tota_c"),
              (SELECT COUNT(*) > 0 FROM "contabilidad"."sald_tota_c"));
SELECT setval(pg_get_serial_sequence('"contabilidad"."sald_tota_c_p"', 'codi_tota'),
              (SELECT COALESCE(MAX("codi_tota"), 1) FROM "contabilidad"."sald_tota_c_p"),
              (SELECT COUNT(*) > 0 FROM "contabilidad"."sald_tota_c_p"));
SELECT setval(pg_get_serial_sequence('"contabilidad"."sald_tota_c_uo"', 'codi_tota'),
              (SELECT COALESCE(MAX("codi_tota"), 1) FROM "contabilidad"."sald_tota_c_uo"),
              (SELECT COUNT(*) > 0 FROM "contabilidad"."sald_tota_c_uo"));
SELECT setval(pg_get_serial_sequence('"contabilidad"."sald_tota_c_uo_p"', 'codi_tota'),
              (SELECT COALESCE(MAX("codi_tota"), 1) FROM "contabilidad"."sald_tota_c_uo_p"),
              (SELECT COUNT(*) > 0 FROM "contabilidad"."sald_tota_c_uo_p"));

COMMIT;

-- =====================================================================
-- ESQUEMA finanzas  (45 tablas)
-- =====================================================================
BEGIN;
SET LOCAL session_replication_role = replica;

-- ANTICIPOS -> finanzas.anticipos  (7 col)
INSERT INTO "finanzas"."anticipos" ("codi_anti", "porcentaje", "fech_anti", "codi_tipo_docu_pago", "nro_docu", "codi_clie_prov", "codi_tipo_docu_soli")
SELECT
       NULLIF(rtrim("codi_anti"::text), '')::varchar(20) AS "codi_anti",
       NULLIF(btrim("porcentaje"::text), '')::bigint AS "porcentaje",
       NULLIF(btrim("fech_anti"::text), '')::bigint AS "fech_anti",
       NULLIF(rtrim("codi_tipo_docu_pago"::text), '')::varchar(4) AS "codi_tipo_docu_pago",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(20) AS "nro_docu",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_tipo_docu_soli"::text), '')::varchar(4) AS "codi_tipo_docu_soli"
FROM "legacy_raw"."anticipos"
ON CONFLICT DO NOTHING;

-- ANTICIPOS_DOCUMENTO_COMPRA -> finanzas.anticipos_documento_compra  (3 col)
INSERT INTO "finanzas"."anticipos_documento_compra" ("codi_anti", "codi_tipo_docu", "codi_docu_cv")
SELECT
       NULLIF(rtrim("codi_anti"::text), '')::varchar(20) AS "codi_anti",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("codi_docu_cv"::text), '')::varchar(10) AS "codi_docu_cv"
FROM "legacy_raw"."anticipos_documento_compra"
ON CONFLICT DO NOTHING;

-- BANCOS -> finanzas.bancos  (10 col)
INSERT INTO "finanzas"."bancos" ("codi_banc", "desc_banc", "dire_banc", "tele_banc", "fax_banc", "nemo", "codi_clie_prov", "codi_sunat", "tea_cts", "tea_cts_dola")
SELECT
       NULLIF(rtrim("codi_banc"::text), '')::varchar(2) AS "codi_banc",
       NULLIF(rtrim("desc_banc"::text), '')::varchar(50) AS "desc_banc",
       NULLIF(rtrim("dire_banc"::text), '')::varchar(150) AS "dire_banc",
       NULLIF(rtrim("tele_banc"::text), '')::varchar(30) AS "tele_banc",
       NULLIF(rtrim("fax_banc"::text), '')::varchar(20) AS "fax_banc",
       NULLIF(rtrim("nemo"::text), '')::varchar(10) AS "nemo",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_sunat"::text), '')::varchar(2) AS "codi_sunat",
       NULLIF(btrim("tea_cts"::text), '')::numeric(12,4) AS "tea_cts",
       NULLIF(btrim("tea_cts_dola"::text), '')::numeric(12,6) AS "tea_cts_dola"
FROM "legacy_raw"."bancos"
ON CONFLICT DO NOTHING;

-- BANCOS_CHEQUES -> finanzas.bancos_cheques  (13 col)
INSERT INTO "finanzas"."bancos_cheques" ("nro_cuen", "codi_mone", "nro_talon", "nro_inic_cheq", "nro_fin_cheq", "cant_cheq", "codi_usua", "cant_cheq_gira", "cant_cheq_anul", "cant_cheq_sald", "fecha", "cheq_ulti", "situ_cheq")
SELECT
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("nro_talon"::text), '')::varchar(6) AS "nro_talon",
       NULLIF(rtrim("nro_inic_cheq"::text), '')::varchar(8) AS "nro_inic_cheq",
       NULLIF(rtrim("nro_fin_cheq"::text), '')::varchar(8) AS "nro_fin_cheq",
       NULLIF(btrim("cant_cheq"::text), '')::bigint AS "cant_cheq",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(btrim("cant_cheq_gira"::text), '')::bigint AS "cant_cheq_gira",
       NULLIF(btrim("cant_cheq_anul"::text), '')::bigint AS "cant_cheq_anul",
       NULLIF(btrim("cant_cheq_sald"::text), '')::bigint AS "cant_cheq_sald",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("cheq_ulti"::text), '')::varchar(8) AS "cheq_ulti",
       NULLIF(rtrim("situ_cheq"::text), '')::varchar(2) AS "situ_cheq"
FROM "legacy_raw"."bancos_cheques"
ON CONFLICT DO NOTHING;

-- BANCOS_DISPONIBLE -> finanzas.bancos_disponible  (7 col)
INSERT INTO "finanzas"."bancos_disponible" ("id_sec", "fecha", "nro_cuen", "contable_s", "contable_d", "disponible_s", "disponible_d")
SELECT
       NULLIF(btrim("id_sec"::text), '')::bigint AS "id_sec",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(btrim("contable_s"::text), '')::numeric(18,2) AS "contable_s",
       NULLIF(btrim("contable_d"::text), '')::numeric(18,2) AS "contable_d",
       NULLIF(btrim("disponible_s"::text), '')::numeric(18,2) AS "disponible_s",
       NULLIF(btrim("disponible_d"::text), '')::numeric(18,2) AS "disponible_d"
FROM "legacy_raw"."bancos_disponible"
ON CONFLICT DO NOTHING;

-- BANCOS_DISPONIBLE_DETA -> finanzas.bancos_disponible_deta  (4 col)
INSERT INTO "finanzas"."bancos_disponible_deta" ("id_sec", "id_conc", "monto_s", "monto_d")
SELECT
       NULLIF(btrim("id_sec"::text), '')::bigint AS "id_sec",
       NULLIF(rtrim("id_conc"::text), '')::varchar(2) AS "id_conc",
       NULLIF(btrim("monto_s"::text), '')::numeric(18,2) AS "monto_s",
       NULLIF(btrim("monto_d"::text), '')::numeric(18,2) AS "monto_d"
FROM "legacy_raw"."bancos_disponible_deta"
ON CONFLICT DO NOTHING;

-- BANCOS_SALDOS -> finanzas.bancos_saldos  (17 col)
INSERT INTO "finanzas"."bancos_saldos" ("nro_cuen", "anio", "codi_mone", "sald_00", "sald_01", "sald_02", "sald_03", "sald_04", "sald_05", "sald_06", "sald_07", "sald_08", "sald_09", "sald_10", "sald_11", "sald_12", "saldb_00")
SELECT
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("sald_00"::text), '')::numeric(18,2) AS "sald_00",
       NULLIF(btrim("sald_01"::text), '')::numeric(18,2) AS "sald_01",
       NULLIF(btrim("sald_02"::text), '')::numeric(18,2) AS "sald_02",
       NULLIF(btrim("sald_03"::text), '')::numeric(18,2) AS "sald_03",
       NULLIF(btrim("sald_04"::text), '')::numeric(18,2) AS "sald_04",
       NULLIF(btrim("sald_05"::text), '')::numeric(18,2) AS "sald_05",
       NULLIF(btrim("sald_06"::text), '')::numeric(18,2) AS "sald_06",
       NULLIF(btrim("sald_07"::text), '')::numeric(18,2) AS "sald_07",
       NULLIF(btrim("sald_08"::text), '')::numeric(18,2) AS "sald_08",
       NULLIF(btrim("sald_09"::text), '')::numeric(18,2) AS "sald_09",
       NULLIF(btrim("sald_10"::text), '')::numeric(18,2) AS "sald_10",
       NULLIF(btrim("sald_11"::text), '')::numeric(18,2) AS "sald_11",
       NULLIF(btrim("sald_12"::text), '')::numeric(18,2) AS "sald_12",
       NULLIF(btrim("saldb_00"::text), '')::numeric(18,2) AS "saldb_00"
FROM "legacy_raw"."bancos_saldos"
ON CONFLICT DO NOTHING;

-- CAJA_CHICA -> finanzas.caja_chica  (33 col)
INSERT INTO "finanzas"."caja_chica" ("codi_alma", "nro_recibo", "fecha", "tipo_io", "codi_mone", "codi_clie_prov", "glosa", "codi_tipo_docu", "serie", "nro_docu", "tipo_contab", "importe", "codi_usua_soli", "prov_canc", "hora_real", "codi_unid_oper", "placa_carreta", "rendir", "nro_recibo_aux", "codi_liqu", "importe_s", "ruta_de", "ruta_a", "fecha_docu", "placa", "galones", "km_ini", "km_fin", "fecha_vence", "dscto_adm", "hecho_por", "estado", "activo")
SELECT
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("nro_recibo"::text), '')::varchar(10) AS "nro_recibo",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(btrim("tipo_io"::text), '')::integer AS "tipo_io",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("glosa"::text), '')::varchar(150) AS "glosa",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("serie"::text), '')::varchar(10) AS "serie",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(20) AS "nro_docu",
       NULLIF(rtrim("tipo_contab"::text), '')::varchar(3) AS "tipo_contab",
       NULLIF(btrim("importe"::text), '')::numeric(18,3) AS "importe",
       NULLIF(rtrim("codi_usua_soli"::text), '')::varchar(5) AS "codi_usua_soli",
       NULLIF(rtrim("prov_canc"::text), '')::varchar(1) AS "prov_canc",
       NULLIF(btrim("hora_real"::text), '')::timestamp(3) AS "hora_real",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("placa_carreta"::text), '')::varchar(5) AS "placa_carreta",
       NULLIF(rtrim("rendir"::text), '')::varchar(1) AS "rendir",
       NULLIF(rtrim("nro_recibo_aux"::text), '')::varchar(10) AS "nro_recibo_aux",
       NULLIF(btrim("codi_liqu"::text), '')::bigint AS "codi_liqu",
       NULLIF(btrim("importe_s"::text), '')::numeric(18,3) AS "importe_s",
       NULLIF(rtrim("ruta_de"::text), '')::varchar(200) AS "ruta_de",
       NULLIF(rtrim("ruta_a"::text), '')::varchar(200) AS "ruta_a",
       NULLIF(btrim("fecha_docu"::text), '')::timestamp(3) AS "fecha_docu",
       NULLIF(rtrim("placa"::text), '')::varchar(5) AS "placa",
       NULLIF(btrim("galones"::text), '')::numeric(18,2) AS "galones",
       NULLIF(btrim("km_ini"::text), '')::numeric(18,2) AS "km_ini",
       NULLIF(btrim("km_fin"::text), '')::numeric(18,2) AS "km_fin",
       NULLIF(btrim("fecha_vence"::text), '')::timestamp(3) AS "fecha_vence",
       NULLIF(rtrim("dscto_adm"::text), '')::varchar(1) AS "dscto_adm",
       NULLIF(rtrim("hecho_por"::text), '')::varchar(5) AS "hecho_por",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("activo"::text), '')::varchar(1) AS "activo"
FROM "legacy_raw"."caja_chica"
ON CONFLICT DO NOTHING;

-- CAJA_CHICA_DEPO -> finanzas.caja_chica_depo  (9 col)
INSERT INTO "finanzas"."caja_chica_depo" ("codi_depo", "codi_docu", "tipo_rela", "codi_tipo_docu", "ser_fact", "nro_fact", "tota_fact", "importe", "grupo")
SELECT
       NULLIF(rtrim("codi_depo"::text), '')::varchar(10) AS "codi_depo",
       NULLIF(rtrim("codi_docu"::text), '')::varchar(10) AS "codi_docu",
       NULLIF(rtrim("tipo_rela"::text), '')::varchar(1) AS "tipo_rela",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("ser_fact"::text), '')::varchar(10) AS "ser_fact",
       NULLIF(rtrim("nro_fact"::text), '')::varchar(20) AS "nro_fact",
       NULLIF(btrim("tota_fact"::text), '')::numeric(12,3) AS "tota_fact",
       NULLIF(btrim("importe"::text), '')::numeric(18,3) AS "importe",
       NULLIF(btrim("grupo"::text), '')::integer AS "grupo"
FROM "legacy_raw"."caja_chica_depo"
ON CONFLICT DO NOTHING;

-- CAJA_CIERRE -> finanzas.caja_cierre  (2 col)
INSERT INTO "finanzas"."caja_cierre" ("codi_alma", "fecha")
SELECT
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha"
FROM "legacy_raw"."caja_cierre"
ON CONFLICT DO NOTHING;

-- CHEQUES -> finanzas.cheques  (7 col)
INSERT INTO "finanzas"."cheques" ("codi_cheq", "nro_cheq", "nro_cuen", "codi_clie_prov", "fecha", "importe", "estado")
SELECT
       NULLIF(rtrim("codi_cheq"::text), '')::varchar(10) AS "codi_cheq",
       NULLIF(rtrim("nro_cheq"::text), '')::varchar(8) AS "nro_cheq",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(btrim("importe"::text), '')::numeric(12,2) AS "importe",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado"
FROM "legacy_raw"."cheques"
ON CONFLICT DO NOTHING;

-- CONCI_BANCO -> finanzas.conci_banco  (19 col)
INSERT INTO "finanzas"."conci_banco" ("codi_conc_banc", "nro_cuen", "anio", "mes", "codi_mone", "subdia", "compr", "fecha", "codi_tipo_docu", "nro_docu", "codi_clie_prov", "glosa", "importe", "saldo", "codi_tipo_situ_conc_banc", "cargo_abono", "anio_docu", "mes_docu", "codi_contable")
SELECT
       NULLIF(rtrim("codi_conc_banc"::text), '')::varchar(10) AS "codi_conc_banc",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("subdia"::text), '')::varchar(2) AS "subdia",
       NULLIF(rtrim("compr"::text), '')::varchar(10) AS "compr",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(10) AS "nro_docu",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("glosa"::text), '')::varchar(200) AS "glosa",
       NULLIF(btrim("importe"::text), '')::numeric(18,4) AS "importe",
       NULLIF(btrim("saldo"::text), '')::numeric(18,4) AS "saldo",
       NULLIF(rtrim("codi_tipo_situ_conc_banc"::text), '')::varchar(2) AS "codi_tipo_situ_conc_banc",
       NULLIF(rtrim("cargo_abono"::text), '')::varchar(1) AS "cargo_abono",
       NULLIF(rtrim("anio_docu"::text), '')::varchar(4) AS "anio_docu",
       NULLIF(rtrim("mes_docu"::text), '')::varchar(2) AS "mes_docu",
       NULLIF(rtrim("codi_contable"::text), '')::varchar(10) AS "codi_contable"
FROM "legacy_raw"."conci_banco"
ON CONFLICT DO NOTHING;

-- CTA_CTE_PERSONAL -> finanzas.cta_cte_personal  (8 col)
INSERT INTO "finanzas"."cta_cte_personal" ("codi_cta_cte", "codi_pers", "nro_cuen", "codi_banc", "nro_cta_cte", "codi_mone", "tipo_cta_cte", "tipo_cta_banc")
SELECT
       NULLIF(rtrim("codi_cta_cte"::text), '')::varchar(6) AS "codi_cta_cte",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("codi_banc"::text), '')::varchar(2) AS "codi_banc",
       NULLIF(rtrim("nro_cta_cte"::text), '')::varchar(30) AS "nro_cta_cte",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("tipo_cta_cte"::text), '')::varchar(10) AS "tipo_cta_cte",
       NULLIF(rtrim("tipo_cta_banc"::text), '')::varchar(2) AS "tipo_cta_banc"
FROM "legacy_raw"."cta_cte_personal"
ON CONFLICT DO NOTHING;

-- CTA_CTE_PROV -> finanzas.cta_cte_prov  (8 col)
INSERT INTO "finanzas"."cta_cte_prov" ("codi_cta_cte", "codi_clie_prov", "codi_banc", "nro_cta_cte", "codi_mone", "tipo_cta_banc", "obse", "detraccion")
SELECT
       NULLIF(rtrim("codi_cta_cte"::text), '')::varchar(6) AS "codi_cta_cte",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_banc"::text), '')::varchar(2) AS "codi_banc",
       NULLIF(rtrim("nro_cta_cte"::text), '')::varchar(20) AS "nro_cta_cte",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("tipo_cta_banc"::text), '')::varchar(2) AS "tipo_cta_banc",
       NULLIF(rtrim("obse"::text), '')::varchar(200) AS "obse",
       NULLIF(btrim("detraccion"::text), '')::boolean AS "detraccion"
FROM "legacy_raw"."cta_cte_prov"
ON CONFLICT DO NOTHING;

-- DEPOSITOS -> finanzas.depositos  (16 col)
INSERT INTO "finanzas"."depositos" ("codi_depo", "nro_cuen", "codi_alma", "nro_oper", "fecha", "codi_respo", "codi_usua_soli", "codi_mone", "importe", "glosa", "fecha_depo", "estado", "tipo", "creacion", "codi_vouc", "hecho_por")
SELECT
       NULLIF(rtrim("codi_depo"::text), '')::varchar(10) AS "codi_depo",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("nro_oper"::text), '')::varchar(100) AS "nro_oper",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_respo"::text), '')::varchar(5) AS "codi_respo",
       NULLIF(rtrim("codi_usua_soli"::text), '')::varchar(5) AS "codi_usua_soli",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("importe"::text), '')::numeric(18,2) AS "importe",
       NULLIF(rtrim("glosa"::text), '')::varchar(200) AS "glosa",
       NULLIF(btrim("fecha_depo"::text), '')::timestamp(3) AS "fecha_depo",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo",
       NULLIF(btrim("creacion"::text), '')::timestamp(3) AS "creacion",
       NULLIF(rtrim("codi_vouc"::text), '')::varchar(10) AS "codi_vouc",
       NULLIF(rtrim("hecho_por"::text), '')::varchar(5) AS "hecho_por"
FROM "legacy_raw"."depositos"
ON CONFLICT DO NOTHING;

-- Documento_garantia -> finanzas.documento_garantia  (2 col)
INSERT INTO "finanzas"."documento_garantia" ("codi_docg", "doc_garantia")
SELECT
       NULLIF(rtrim("codi_docg"::text), '')::varchar(2) AS "codi_docg",
       NULLIF(rtrim("doc_garantia"::text), '')::varchar(50) AS "doc_garantia"
FROM "legacy_raw"."documento_garantia"
ON CONFLICT DO NOTHING;

-- ESCRIBALO -> finanzas.escribalo  (11 col)
INSERT INTO "finanzas"."escribalo" ("codi_escr", "fecha", "nro_escr", "anio", "inic", "de", "para", "asunto", "codi_usua_gene", "fech_inic", "fech_fin")
SELECT
       NULLIF(rtrim("codi_escr"::text), '')::varchar(10) AS "codi_escr",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("nro_escr"::text), '')::varchar(6) AS "nro_escr",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("inic"::text), '')::varchar(10) AS "inic",
       NULLIF(rtrim("de"::text), '')::varchar(200) AS "de",
       NULLIF(rtrim("para"::text), '')::varchar(200) AS "para",
       NULLIF(rtrim("asunto"::text), '')::varchar(200) AS "asunto",
       NULLIF(rtrim("codi_usua_gene"::text), '')::varchar(5) AS "codi_usua_gene",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_fin"::text), '')::timestamp(3) AS "fech_fin"
FROM "legacy_raw"."escribalo"
ON CONFLICT DO NOTHING;

-- ESCRIBALO_DETA -> finanzas.escribalo_deta  (13 col)
INSERT INTO "finanzas"."escribalo_deta" ("codi_escr", "codi_contable", "fecha", "regb", "codi_vouc", "codi_rela", "codi_mone", "importe", "esta", "codi_agru", "nro_docu", "subdia", "codi_tipo_docu")
SELECT
       NULLIF(rtrim("codi_escr"::text), '')::varchar(10) AS "codi_escr",
       NULLIF(rtrim("codi_contable"::text), '')::varchar(10) AS "codi_contable",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("regb"::text), '')::varchar(7) AS "regb",
       NULLIF(rtrim("codi_vouc"::text), '')::varchar(10) AS "codi_vouc",
       NULLIF(rtrim("codi_rela"::text), '')::varchar(10) AS "codi_rela",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(10) AS "codi_mone",
       NULLIF(btrim("importe"::text), '')::numeric(12,4) AS "importe",
       NULLIF(btrim("esta"::text), '')::boolean AS "esta",
       NULLIF(rtrim("codi_agru"::text), '')::varchar(10) AS "codi_agru",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(50) AS "nro_docu",
       NULLIF(rtrim("subdia"::text), '')::varchar(1) AS "subdia",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu"
FROM "legacy_raw"."escribalo_deta"
ON CONFLICT DO NOTHING;

-- Letra_Calculo -> finanzas.letra_calculo  (15 col)
INSERT INTO "finanzas"."letra_calculo" ("codi_letra", "anio", "codi_contable", "nro_cuen_banco", "nro_cuen_amor", "nro_cuen_inte", "fech_venc", "importe_amor", "importe_inte", "tipo_situ", "observacion", "fecha", "tipo", "saldo", "codi_mone")
SELECT
       NULLIF(rtrim("codi_letra"::text), '')::varchar(3) AS "codi_letra",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("codi_contable"::text), '')::varchar(10) AS "codi_contable",
       NULLIF(rtrim("nro_cuen_banco"::text), '')::varchar(7) AS "nro_cuen_banco",
       NULLIF(rtrim("nro_cuen_amor"::text), '')::varchar(7) AS "nro_cuen_amor",
       NULLIF(rtrim("nro_cuen_inte"::text), '')::varchar(7) AS "nro_cuen_inte",
       NULLIF(btrim("fech_venc"::text), '')::timestamp(3) AS "fech_venc",
       NULLIF(btrim("importe_amor"::text), '')::numeric(18,2) AS "importe_amor",
       NULLIF(btrim("importe_inte"::text), '')::numeric(18,2) AS "importe_inte",
       NULLIF(rtrim("tipo_situ"::text), '')::varchar(2) AS "tipo_situ",
       NULLIF(rtrim("observacion"::text), '')::varchar(50) AS "observacion",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo",
       NULLIF(btrim("saldo"::text), '')::numeric(18,2) AS "saldo",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone"
FROM "legacy_raw"."letra_calculo"
ON CONFLICT DO NOTHING;

-- LETRAS_PRODUCTOS -> finanzas.letras_productos  (3 col)
INSERT INTO "finanzas"."letras_productos" ("registro", "codi_prod", "cantidad")
SELECT
       NULLIF(rtrim("registro"::text), '')::varchar(11) AS "registro",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,2) AS "cantidad"
FROM "legacy_raw"."letras_productos"
ON CONFLICT DO NOTHING;

-- PAGOS_JUICIOS -> finanzas.pagos_juicios  (6 col)
INSERT INTO "finanzas"."pagos_juicios" ("codi_juic", "nro_pago", "fech_pago", "codi_mone", "monto", "observacion")
SELECT
       NULLIF(rtrim("codi_juic"::text), '')::varchar(6) AS "codi_juic",
       NULLIF(rtrim("nro_pago"::text), '')::varchar(4) AS "nro_pago",
       NULLIF(btrim("fech_pago"::text), '')::timestamp(3) AS "fech_pago",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto",
       NULLIF(rtrim("observacion"::text), '')::varchar(150) AS "observacion"
FROM "legacy_raw"."pagos_juicios"
ON CONFLICT DO NOTHING;

-- Polizas -> finanzas.polizas  (12 col)
INSERT INTO "finanzas"."polizas" ("codi_poli", "descripcion", "tipo", "codi_clie_prov", "codi_unid_oper", "fech_adqui", "fech_vigen", "n_meses_pago", "dia_pago", "codi_mone", "monto_mensual", "dias_aviso")
SELECT
       NULLIF(btrim("codi_poli"::text), '')::bigint AS "codi_poli",
       NULLIF(rtrim("descripcion"::text), '')::varchar(50) AS "descripcion",
       NULLIF(rtrim("tipo"::text), '')::varchar(20) AS "tipo",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(btrim("fech_adqui"::text), '')::timestamp(3) AS "fech_adqui",
       NULLIF(btrim("fech_vigen"::text), '')::timestamp(3) AS "fech_vigen",
       NULLIF(btrim("n_meses_pago"::text), '')::integer AS "n_meses_pago",
       NULLIF(btrim("dia_pago"::text), '')::integer AS "dia_pago",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("monto_mensual"::text), '')::numeric(18,2) AS "monto_mensual",
       NULLIF(btrim("dias_aviso"::text), '')::integer AS "dias_aviso"
FROM "legacy_raw"."polizas"
ON CONFLICT DO NOTHING;

-- pres_grup -> finanzas.pres_grup  (2 col)
INSERT INTO "finanzas"."pres_grup" ("codi_grup", "desc_grup")
SELECT
       NULLIF(rtrim("codi_grup"::text), '')::varchar(2) AS "codi_grup",
       NULLIF(rtrim("desc_grup"::text), '')::varchar(40) AS "desc_grup"
FROM "legacy_raw"."pres_grup"
ON CONFLICT DO NOTHING;

-- PRES_PAGO -> finanzas.pres_pago  (3 col)
INSERT INTO "finanzas"."pres_pago" ("codi_pres", "desc_pres", "codi_grup")
SELECT
       NULLIF(rtrim("codi_pres"::text), '')::varchar(4) AS "codi_pres",
       NULLIF(rtrim("desc_pres"::text), '')::varchar(40) AS "desc_pres",
       NULLIF(rtrim("codi_grup"::text), '')::varchar(2) AS "codi_grup"
FROM "legacy_raw"."pres_pago"
ON CONFLICT DO NOTHING;

-- Presupuesto -> finanzas.presupuesto  (4 col)
INSERT INTO "finanzas"."presupuesto" ("codi_presu", "desc_presu", "fecha", "nro_cuen")
SELECT
       NULLIF(rtrim("codi_presu"::text), '')::varchar(5) AS "codi_presu",
       NULLIF(rtrim("desc_presu"::text), '')::varchar(50) AS "desc_presu",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen"
FROM "legacy_raw"."presupuesto"
ON CONFLICT DO NOTHING;

-- Recibo_egreso -> finanzas.recibo_egreso  (11 col)
INSERT INTO "finanzas"."recibo_egreso" ("codi_recibo", "fecha_recibo", "fecha", "nro_cuen", "nro_docu", "importe", "importe_d", "glosa", "tipo_cambio", "codi_pers", "codi_orde_comp")
SELECT
       NULLIF(rtrim("codi_recibo"::text), '')::varchar(6) AS "codi_recibo",
       NULLIF(btrim("fecha_recibo"::text), '')::timestamp(3) AS "fecha_recibo",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(20) AS "nro_docu",
       NULLIF(btrim("importe"::text), '')::numeric(18,2) AS "importe",
       NULLIF(btrim("importe_d"::text), '')::numeric(18,2) AS "importe_d",
       NULLIF(rtrim("glosa"::text), '')::varchar(500) AS "glosa",
       NULLIF(btrim("tipo_cambio"::text), '')::numeric(18,4) AS "tipo_cambio",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_orde_comp"::text), '')::varchar(10) AS "codi_orde_comp"
FROM "legacy_raw"."recibo_egreso"
ON CONFLICT DO NOTHING;

-- REGISTRO_PAGOS -> finanzas.registro_pagos  (19 col)
INSERT INTO "finanzas"."registro_pagos" ("id_sec", "fecha_reg", "numero", "documento", "medio_pago", "cuota", "codi_clie_prov", "concepto", "codigo", "fecha", "codi_mone", "importe", "comentario", "fecha_pago", "observaciones", "activo", "condicion", "codi_clie_pers", "clie_pers")
SELECT
       NULLIF(btrim("id_sec"::text), '')::bigint AS "id_sec",
       NULLIF(btrim("fecha_reg"::text), '')::timestamp(3) AS "fecha_reg",
       NULLIF(btrim("numero"::text), '')::bigint AS "numero",
       NULLIF(rtrim("documento"::text), '')::varchar(50) AS "documento",
       NULLIF(rtrim("medio_pago"::text), '')::varchar(50) AS "medio_pago",
       NULLIF(rtrim("cuota"::text), '')::varchar(25) AS "cuota",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("concepto"::text), '')::varchar(250) AS "concepto",
       NULLIF(rtrim("codigo"::text), '')::varchar(35) AS "codigo",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("importe"::text), '')::numeric(18,2) AS "importe",
       NULLIF(rtrim("comentario"::text), '')::varchar(255) AS "comentario",
       NULLIF(btrim("fecha_pago"::text), '')::timestamp(3) AS "fecha_pago",
       NULLIF(rtrim("observaciones"::text), '')::varchar(255) AS "observaciones",
       NULLIF(rtrim("activo"::text), '')::varchar(1) AS "activo",
       NULLIF(rtrim("condicion"::text), '')::varchar(1) AS "condicion",
       NULLIF(rtrim("codi_clie_pers"::text), '')::varchar(5) AS "codi_clie_pers",
       NULLIF(rtrim("clie_pers"::text), '')::varchar(150) AS "clie_pers"
FROM "legacy_raw"."registro_pagos"
ON CONFLICT DO NOTHING;

-- RUBROS_CAJA -> finanzas.rubros_caja  (3 col)
INSERT INTO "finanzas"."rubros_caja" ("id_rubro", "desc_rubro", "i_o")
SELECT
       NULLIF(btrim("id_rubro"::text), '')::integer AS "id_rubro",
       NULLIF(rtrim("desc_rubro"::text), '')::varchar(100) AS "desc_rubro",
       NULLIF(btrim("i_o"::text), '')::integer AS "i_o"
FROM "legacy_raw"."rubros_caja"
ON CONFLICT DO NOTHING;

-- RUBROS_CAJA_DETALLE -> finanzas.rubros_caja_detalle  (4 col)
INSERT INTO "finanzas"."rubros_caja_detalle" ("id_rubro", "tipo_reemb", "i_o", "codi_alma")
SELECT
       NULLIF(btrim("id_rubro"::text), '')::integer AS "id_rubro",
       NULLIF(rtrim("tipo_reemb"::text), '')::varchar(3) AS "tipo_reemb",
       NULLIF(btrim("i_o"::text), '')::integer AS "i_o",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma"
FROM "legacy_raw"."rubros_caja_detalle"
ON CONFLICT DO NOTHING;

-- SALD_CONC_BANC -> finanzas.sald_conc_banc  (7 col)
INSERT INTO "finanzas"."sald_conc_banc" ("codi_sald_banc", "anio", "mes", "nro_cuen", "sald_libr", "esta_cuen", "sald_ante")
SELECT
       NULLIF(rtrim("codi_sald_banc"::text), '')::varchar(10) AS "codi_sald_banc",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(btrim("sald_libr"::text), '')::numeric(18,4) AS "sald_libr",
       NULLIF(btrim("esta_cuen"::text), '')::numeric(18,4) AS "esta_cuen",
       NULLIF(btrim("sald_ante"::text), '')::numeric(18,4) AS "sald_ante"
FROM "legacy_raw"."sald_conc_banc"
ON CONFLICT DO NOTHING;

-- SALDO_BANCOS -> finanzas.saldo_bancos  (4 col)
INSERT INTO "finanzas"."saldo_bancos" ("fecha", "nro_cuen", "codi_mone", "saldo")
SELECT
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("saldo"::text), '')::numeric(12,3) AS "saldo"
FROM "legacy_raw"."saldo_bancos"
ON CONFLICT DO NOTHING;

-- SALDO_MONEDA -> finanzas.saldo_moneda  (6 col)
INSERT INTO "finanzas"."saldo_moneda" ("id", "fecha", "moneda", "cant_s", "cant_d", "codi_alma")
SELECT
       NULLIF(btrim("id"::text), '')::bigint AS "id",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(btrim("moneda"::text), '')::numeric(18,3) AS "moneda",
       NULLIF(btrim("cant_s"::text), '')::integer AS "cant_s",
       NULLIF(btrim("cant_d"::text), '')::integer AS "cant_d",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma"
FROM "legacy_raw"."saldo_moneda"
ON CONFLICT DO NOTHING;

-- SEGUROS -> finanzas.seguros  (3 col)
INSERT INTO "finanzas"."seguros" ("codi_segu", "desc_segu", "codi_clie_prov")
SELECT
       NULLIF(btrim("codi_segu"::text), '')::smallint AS "codi_segu",
       NULLIF(rtrim("desc_segu"::text), '')::varchar(50) AS "desc_segu",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov"
FROM "legacy_raw"."seguros"
ON CONFLICT DO NOTHING;

-- TIPO_CTA -> finanzas.tipo_cta  (5 col)
INSERT INTO "finanzas"."tipo_cta" ("cod_cta", "desc_cta", "grupo", "orden", "descgrupo")
SELECT
       NULLIF(rtrim("cod_cta"::text), '')::varchar(1) AS "cod_cta",
       NULLIF(rtrim("desc_cta"::text), '')::varchar(20) AS "desc_cta",
       NULLIF(rtrim("grupo"::text), '')::varchar(1) AS "grupo",
       NULLIF(btrim("orden"::text), '')::smallint AS "orden",
       NULLIF(rtrim("descgrupo"::text), '')::varchar(50) AS "descgrupo"
FROM "legacy_raw"."tipo_cta"
ON CONFLICT DO NOTHING;

-- TIPO_CTA_BANC -> finanzas.tipo_cta_banc  (5 col)
INSERT INTO "finanzas"."tipo_cta_banc" ("codi_tipo_cuen_banc", "desc_tipo_cuen_banc", "nemo", "nro_cero_tc", "tipo_cuen_tc")
SELECT
       NULLIF(rtrim("codi_tipo_cuen_banc"::text), '')::varchar(2) AS "codi_tipo_cuen_banc",
       NULLIF(rtrim("desc_tipo_cuen_banc"::text), '')::varchar(50) AS "desc_tipo_cuen_banc",
       NULLIF(rtrim("nemo"::text), '')::varchar(10) AS "nemo",
       NULLIF(btrim("nro_cero_tc"::text), '')::smallint AS "nro_cero_tc",
       NULLIF(rtrim("tipo_cuen_tc"::text), '')::varchar(2) AS "tipo_cuen_tc"
FROM "legacy_raw"."tipo_cta_banc"
ON CONFLICT DO NOTHING;

-- TIPO_CTA_CTE -> finanzas.tipo_cta_cte  (3 col)
INSERT INTO "finanzas"."tipo_cta_cte" ("codi_tipo_cta_cte", "desc_tipo_cta_cte", "nemo_tipo_cta_cte")
SELECT
       NULLIF(rtrim("codi_tipo_cta_cte"::text), '')::varchar(2) AS "codi_tipo_cta_cte",
       NULLIF(rtrim("desc_tipo_cta_cte"::text), '')::varchar(100) AS "desc_tipo_cta_cte",
       NULLIF(rtrim("nemo_tipo_cta_cte"::text), '')::varchar(20) AS "nemo_tipo_cta_cte"
FROM "legacy_raw"."tipo_cta_cte"
ON CONFLICT DO NOTHING;

-- TIPO_FORM_PAGO -> finanzas.tipo_form_pago  (4 col)
INSERT INTO "finanzas"."tipo_form_pago" ("codi_form_pago", "desc_form_pago", "nemo_form_pago", "codi_tipo_pago")
SELECT
       NULLIF(rtrim("codi_form_pago"::text), '')::varchar(2) AS "codi_form_pago",
       NULLIF(rtrim("desc_form_pago"::text), '')::varchar(100) AS "desc_form_pago",
       NULLIF(rtrim("nemo_form_pago"::text), '')::varchar(20) AS "nemo_form_pago",
       NULLIF(btrim("codi_tipo_pago"::text), '')::smallint AS "codi_tipo_pago"
FROM "legacy_raw"."tipo_form_pago"
ON CONFLICT DO NOTHING;

-- TIPO_MEDIO_PAGO -> finanzas.tipo_medio_pago  (4 col)
INSERT INTO "finanzas"."tipo_medio_pago" ("codi_tipo_medio_pago", "codi_sunat", "desc_tipo_medio_pago", "nemo")
SELECT
       NULLIF(btrim("codi_tipo_medio_pago"::text), '')::smallint AS "codi_tipo_medio_pago",
       NULLIF(rtrim("codi_sunat"::text), '')::varchar(3) AS "codi_sunat",
       NULLIF(rtrim("desc_tipo_medio_pago"::text), '')::varchar(250) AS "desc_tipo_medio_pago",
       NULLIF(rtrim("nemo"::text), '')::varchar(30) AS "nemo"
FROM "legacy_raw"."tipo_medio_pago"
ON CONFLICT DO NOTHING;

-- TIPO_REEMBOLSO -> finanzas.tipo_reembolso  (6 col)
INSERT INTO "finanzas"."tipo_reembolso" ("tipo_reemb", "desc_reemb", "cta_con", "cta_sin", "estado", "codi_alma")
SELECT
       NULLIF(rtrim("tipo_reemb"::text), '')::varchar(3) AS "tipo_reemb",
       NULLIF(rtrim("desc_reemb"::text), '')::varchar(50) AS "desc_reemb",
       NULLIF(rtrim("cta_con"::text), '')::varchar(7) AS "cta_con",
       NULLIF(rtrim("cta_sin"::text), '')::varchar(7) AS "cta_sin",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma"
FROM "legacy_raw"."tipo_reembolso"
ON CONFLICT DO NOTHING;

-- TIPO_REEMBOLSO_ALMACEN -> finanzas.tipo_reembolso_almacen  (2 col)
INSERT INTO "finanzas"."tipo_reembolso_almacen" ("tipo_reemb", "codi_alma")
SELECT
       NULLIF(rtrim("tipo_reemb"::text), '')::varchar(3) AS "tipo_reemb",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma"
FROM "legacy_raw"."tipo_reembolso_almacen"
ON CONFLICT DO NOTHING;

-- Tipo_Situ_Cheq -> finanzas.tipo_situ_cheq  (3 col)
INSERT INTO "finanzas"."tipo_situ_cheq" ("codi_situ_cheq", "desc_situ_cheq", "tipo_situ_letra")
SELECT
       NULLIF(rtrim("codi_situ_cheq"::text), '')::varchar(2) AS "codi_situ_cheq",
       NULLIF(rtrim("desc_situ_cheq"::text), '')::varchar(50) AS "desc_situ_cheq",
       NULLIF(rtrim("tipo_situ_letra"::text), '')::varchar(1) AS "tipo_situ_letra"
FROM "legacy_raw"."tipo_situ_cheq"
ON CONFLICT DO NOTHING;

-- TIPO_SITU_CONC_BANC -> finanzas.tipo_situ_conc_banc  (3 col)
INSERT INTO "finanzas"."tipo_situ_conc_banc" ("codi_tipo_situ_conc_banc", "desc_tipo_situ_conc_banc", "simb_tipo_situ_conc_banc")
SELECT
       NULLIF(rtrim("codi_tipo_situ_conc_banc"::text), '')::varchar(2) AS "codi_tipo_situ_conc_banc",
       NULLIF(rtrim("desc_tipo_situ_conc_banc"::text), '')::varchar(50) AS "desc_tipo_situ_conc_banc",
       NULLIF(rtrim("simb_tipo_situ_conc_banc"::text), '')::varchar(3) AS "simb_tipo_situ_conc_banc"
FROM "legacy_raw"."tipo_situ_conc_banc"
ON CONFLICT DO NOTHING;

-- TIPOS_PAGO_WARRANT -> finanzas.tipos_pago_warrant  (3 col)
INSERT INTO "finanzas"."tipos_pago_warrant" ("codi_tpago", "desc_tipo", "nemo_tipo")
SELECT
       NULLIF(btrim("codi_tpago"::text), '')::integer AS "codi_tpago",
       NULLIF(rtrim("desc_tipo"::text), '')::varchar(50) AS "desc_tipo",
       NULLIF(rtrim("nemo_tipo"::text), '')::varchar(50) AS "nemo_tipo"
FROM "legacy_raw"."tipos_pago_warrant"
ON CONFLICT DO NOTHING;

-- WARRANT_CONTROL -> finanzas.warrant_control  (25 col)
INSERT INTO "finanzas"."warrant_control" ("codi_warr", "fecha", "almacenera", "banco_nro", "codi_banc", "codi_alma", "nro_warr", "tm_alma", "ingr_warr", "sali_cant", "stock", "valor_warr", "i_o", "codi_mone", "tpc", "disponible", "periodo", "broker", "comprador", "fecha_emba", "codi_tpago", "num_pago", "valor_fina", "tm_cred", "valor_cred")
SELECT
       NULLIF(btrim("codi_warr"::text), '')::bigint AS "codi_warr",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("almacenera"::text), '')::varchar(5) AS "almacenera",
       NULLIF(rtrim("banco_nro"::text), '')::varchar(20) AS "banco_nro",
       NULLIF(rtrim("codi_banc"::text), '')::varchar(7) AS "codi_banc",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("nro_warr"::text), '')::varchar(50) AS "nro_warr",
       NULLIF(btrim("tm_alma"::text), '')::numeric(18,3) AS "tm_alma",
       NULLIF(btrim("ingr_warr"::text), '')::numeric(18,3) AS "ingr_warr",
       NULLIF(btrim("sali_cant"::text), '')::numeric(18,3) AS "sali_cant",
       NULLIF(btrim("stock"::text), '')::numeric(18,3) AS "stock",
       NULLIF(btrim("valor_warr"::text), '')::numeric(18,3) AS "valor_warr",
       NULLIF(rtrim("i_o"::text), '')::varchar(1) AS "i_o",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("tpc"::text), '')::numeric(18,4) AS "tpc",
       NULLIF(btrim("disponible"::text), '')::numeric(18,3) AS "disponible",
       NULLIF(rtrim("periodo"::text), '')::varchar(4) AS "periodo",
       NULLIF(rtrim("broker"::text), '')::varchar(5) AS "broker",
       NULLIF(rtrim("comprador"::text), '')::varchar(5) AS "comprador",
       NULLIF(btrim("fecha_emba"::text), '')::timestamp(3) AS "fecha_emba",
       NULLIF(btrim("codi_tpago"::text), '')::integer AS "codi_tpago",
       NULLIF(rtrim("num_pago"::text), '')::varchar(50) AS "num_pago",
       NULLIF(btrim("valor_fina"::text), '')::numeric(18,3) AS "valor_fina",
       NULLIF(btrim("tm_cred"::text), '')::numeric(18,3) AS "tm_cred",
       NULLIF(btrim("valor_cred"::text), '')::numeric(18,3) AS "valor_cred"
FROM "legacy_raw"."warrant_control"
ON CONFLICT DO NOTHING;

-- WARRANT_PAGOS -> finanzas.warrant_pagos  (6 col)
INSERT INTO "finanzas"."warrant_pagos" ("codi_pwarr", "nro_warr", "fecha_pago", "canti_cancel", "monto_paga", "periodo")
SELECT
       NULLIF(btrim("codi_pwarr"::text), '')::bigint AS "codi_pwarr",
       NULLIF(rtrim("nro_warr"::text), '')::varchar(50) AS "nro_warr",
       NULLIF(btrim("fecha_pago"::text), '')::timestamp(3) AS "fecha_pago",
       NULLIF(btrim("canti_cancel"::text), '')::numeric(18,3) AS "canti_cancel",
       NULLIF(btrim("monto_paga"::text), '')::numeric(18,3) AS "monto_paga",
       NULLIF(rtrim("periodo"::text), '')::varchar(4) AS "periodo"
FROM "legacy_raw"."warrant_pagos"
ON CONFLICT DO NOTHING;

-- reajuste de secuencias de identidad del legado
SELECT setval(pg_get_serial_sequence('"finanzas"."bancos_disponible"', 'id_sec'),
              (SELECT COALESCE(MAX("id_sec"), 1) FROM "finanzas"."bancos_disponible"),
              (SELECT COUNT(*) > 0 FROM "finanzas"."bancos_disponible"));
SELECT setval(pg_get_serial_sequence('"finanzas"."polizas"', 'codi_poli'),
              (SELECT COALESCE(MAX("codi_poli"), 1) FROM "finanzas"."polizas"),
              (SELECT COUNT(*) > 0 FROM "finanzas"."polizas"));
SELECT setval(pg_get_serial_sequence('"finanzas"."registro_pagos"', 'id_sec'),
              (SELECT COALESCE(MAX("id_sec"), 1) FROM "finanzas"."registro_pagos"),
              (SELECT COUNT(*) > 0 FROM "finanzas"."registro_pagos"));

COMMIT;

-- =====================================================================
-- ESQUEMA logistica  (80 tablas)
-- =====================================================================
BEGIN;
SET LOCAL session_replication_role = replica;

-- ACABADO -> logistica.acabado  (3 col)
INSERT INTO "logistica"."acabado" ("codi_acab", "desc_acab", "nemo_aca")
SELECT
       NULLIF(btrim("codi_acab"::text), '')::smallint AS "codi_acab",
       NULLIF(rtrim("desc_acab"::text), '')::varchar(100) AS "desc_acab",
       NULLIF(rtrim("nemo_aca"::text), '')::varchar(50) AS "nemo_aca"
FROM "legacy_raw"."acabado"
ON CONFLICT DO NOTHING;

-- ACEPTACION_LISTA_REQUE -> logistica.aceptacion_lista_reque  (6 col)
INSERT INTO "logistica"."aceptacion_lista_reque" ("codi_deta_list_requ", "codi_pers", "aceptacion", "nro_jera", "fech_acep", "cantidad")
SELECT
       NULLIF(rtrim("codi_deta_list_requ"::text), '')::varchar(10) AS "codi_deta_list_requ",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("aceptacion"::text), '')::boolean AS "aceptacion",
       NULLIF(btrim("nro_jera"::text), '')::smallint AS "nro_jera",
       NULLIF(btrim("fech_acep"::text), '')::timestamp(3) AS "fech_acep",
       NULLIF(btrim("cantidad"::text), '')::numeric(9,2) AS "cantidad"
FROM "legacy_raw"."aceptacion_lista_reque"
ON CONFLICT DO NOTHING;

-- ALMACEN -> logistica.almacen  (23 col)
INSERT INTO "logistica"."almacen" ("codi_alma", "desc_alma", "direccion", "telefono", "nemo_alma", "ubicacion", "tipo", "codi_luga", "codi_clie_prov", "codi_alma_princi", "codi_unid_oper", "nro_cuen", "representante", "nro_cuen_d", "distrito", "correo", "ruta", "impresora", "codi_alma_desc", "codigo_estable", "activo", "codigo_ubigeo", "dist_alma")
SELECT
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("desc_alma"::text), '')::varchar(100) AS "desc_alma",
       NULLIF(rtrim("direccion"::text), '')::varchar(100) AS "direccion",
       NULLIF(rtrim("telefono"::text), '')::varchar(50) AS "telefono",
       NULLIF(rtrim("nemo_alma"::text), '')::varchar(20) AS "nemo_alma",
       NULLIF(rtrim("ubicacion"::text), '')::varchar(50) AS "ubicacion",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo",
       NULLIF(rtrim("codi_luga"::text), '')::varchar(3) AS "codi_luga",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_alma_princi"::text), '')::varchar(2) AS "codi_alma_princi",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("representante"::text), '')::varchar(5) AS "representante",
       NULLIF(rtrim("nro_cuen_d"::text), '')::varchar(7) AS "nro_cuen_d",
       NULLIF(rtrim("distrito"::text), '')::varchar(100) AS "distrito",
       NULLIF(rtrim("correo"::text), '')::varchar(150) AS "correo",
       NULLIF(rtrim("ruta"::text), '')::varchar(255) AS "ruta",
       NULLIF(rtrim("impresora"::text), '')::varchar(150) AS "impresora",
       NULLIF(rtrim("codi_alma_desc"::text), '')::varchar(2) AS "codi_alma_desc",
       NULLIF(rtrim("codigo_estable"::text), '')::varchar(4) AS "codigo_estable",
       NULLIF(rtrim("activo"::text), '')::varchar(1) AS "activo",
       NULLIF(rtrim("codigo_ubigeo"::text), '')::varchar(6) AS "codigo_ubigeo",
       NULLIF(btrim("dist_alma"::text), '')::integer AS "dist_alma"
FROM "legacy_raw"."almacen"
ON CONFLICT DO NOTHING;

-- ALMACEN_DOC_REGULARIZAR -> logistica.almacen_doc_regularizar  (7 col)
INSERT INTO "logistica"."almacen_doc_regularizar" ("idd_sec", "codi_alma", "codi_tipo_docu", "serie_alma", "nro_docu_empieza", "fecha", "creacion")
SELECT
       NULLIF(btrim("idd_sec"::text), '')::bigint AS "idd_sec",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("serie_alma"::text), '')::varchar(5) AS "serie_alma",
       NULLIF(btrim("nro_docu_empieza"::text), '')::bigint AS "nro_docu_empieza",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(btrim("creacion"::text), '')::timestamp(3) AS "creacion"
FROM "legacy_raw"."almacen_doc_regularizar"
ON CONFLICT DO NOTHING;

-- Almacen_Producto -> logistica.almacen_producto  (11 col)
INSERT INTO "logistica"."almacen_producto" ("codi_alma", "codi_prod", "prec_costo", "stock_alma", "stock_min_alma", "stock_temp_alma", "prec_prom_alma", "prec_porc_uti_men", "prec_porc_uti_may", "prec_porc_uti_esp", "prec")
SELECT
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("prec_costo"::text), '')::numeric(18,3) AS "prec_costo",
       NULLIF(btrim("stock_alma"::text), '')::numeric(18,2) AS "stock_alma",
       NULLIF(btrim("stock_min_alma"::text), '')::numeric(18,2) AS "stock_min_alma",
       NULLIF(btrim("stock_temp_alma"::text), '')::numeric(18,2) AS "stock_temp_alma",
       NULLIF(btrim("prec_prom_alma"::text), '')::numeric(18,3) AS "prec_prom_alma",
       NULLIF(btrim("prec_porc_uti_men"::text), '')::numeric(18,2) AS "prec_porc_uti_men",
       NULLIF(btrim("prec_porc_uti_may"::text), '')::numeric(18,2) AS "prec_porc_uti_may",
       NULLIF(btrim("prec_porc_uti_esp"::text), '')::numeric(18,2) AS "prec_porc_uti_esp",
       NULLIF(btrim("prec"::text), '')::numeric(18,2) AS "prec"
FROM "legacy_raw"."almacen_producto"
ON CONFLICT DO NOTHING;

-- Almacen_Usuario -> logistica.almacen_usuario  (2 col)
INSERT INTO "logistica"."almacen_usuario" ("codi_alma", "codi_usua")
SELECT
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua"
FROM "legacy_raw"."almacen_usuario"
ON CONFLICT DO NOTHING;

-- ALMACENES -> logistica.almacenes  (3 col)
INSERT INTO "logistica"."almacenes" ("codi_alma", "desc_alma", "ubic_alma")
SELECT
       NULLIF(rtrim("codi_alma"::text), '')::varchar(3) AS "codi_alma",
       NULLIF(rtrim("desc_alma"::text), '')::varchar(50) AS "desc_alma",
       NULLIF(rtrim("ubic_alma"::text), '')::varchar(100) AS "ubic_alma"
FROM "legacy_raw"."almacenes"
ON CONFLICT DO NOTHING;

-- CCNU_CLASES -> logistica.ccnu_clases  (3 col)
INSERT INTO "logistica"."ccnu_clases" ("codi_clas", "codi_fami", "desc_clas")
SELECT
       NULLIF(rtrim("codi_clas"::text), '')::varchar(6) AS "codi_clas",
       NULLIF(rtrim("codi_fami"::text), '')::varchar(4) AS "codi_fami",
       NULLIF(rtrim("desc_clas"::text), '')::varchar(250) AS "desc_clas"
FROM "legacy_raw"."ccnu_clases"
ON CONFLICT DO NOTHING;

-- CCNU_FAMILIAS -> logistica.ccnu_familias  (3 col)
INSERT INTO "logistica"."ccnu_familias" ("codi_fami", "cod_seg", "desc_fami")
SELECT
       NULLIF(rtrim("codi_fami"::text), '')::varchar(4) AS "codi_fami",
       NULLIF(rtrim("cod_seg"::text), '')::varchar(2) AS "cod_seg",
       NULLIF(rtrim("desc_fami"::text), '')::varchar(250) AS "desc_fami"
FROM "legacy_raw"."ccnu_familias"
ON CONFLICT DO NOTHING;

-- CCNU_PRODUCTOS -> logistica.ccnu_productos  (3 col)
INSERT INTO "logistica"."ccnu_productos" ("codi_prod_sunat", "codi_clas", "desc_prod_sunat")
SELECT
       NULLIF(rtrim("codi_prod_sunat"::text), '')::varchar(8) AS "codi_prod_sunat",
       NULLIF(rtrim("codi_clas"::text), '')::varchar(6) AS "codi_clas",
       NULLIF(rtrim("desc_prod_sunat"::text), '')::varchar(250) AS "desc_prod_sunat"
FROM "legacy_raw"."ccnu_productos"
ON CONFLICT DO NOTHING;

-- CCNU_SEGMENTOS -> logistica.ccnu_segmentos  (2 col)
INSERT INTO "logistica"."ccnu_segmentos" ("cod_seg", "desc_seg")
SELECT
       NULLIF(rtrim("cod_seg"::text), '')::varchar(2) AS "cod_seg",
       NULLIF(rtrim("desc_seg"::text), '')::varchar(250) AS "desc_seg"
FROM "legacy_raw"."ccnu_segmentos"
ON CONFLICT DO NOTHING;

-- COLOR -> logistica.color  (2 col)
INSERT INTO "logistica"."color" ("codi_color", "desc_color")
SELECT
       NULLIF(btrim("codi_color"::text), '')::smallint AS "codi_color",
       NULLIF(rtrim("desc_color"::text), '')::varchar(100) AS "desc_color"
FROM "legacy_raw"."color"
ON CONFLICT DO NOTHING;

-- compromisos_pactados -> logistica.compromisos_pactados  (10 col)
INSERT INTO "logistica"."compromisos_pactados" ("codi_comp", "nro_comp", "fecha", "codi_alma", "codi_clie_prov", "tipo", "observaciones", "fecha_venc", "lugar", "codi_mone")
SELECT
       NULLIF(btrim("codi_comp"::text), '')::bigint AS "codi_comp",
       NULLIF(btrim("nro_comp"::text), '')::bigint AS "nro_comp",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo",
       NULLIF(rtrim("observaciones"::text), '')::varchar(250) AS "observaciones",
       NULLIF(btrim("fecha_venc"::text), '')::timestamp(3) AS "fecha_venc",
       NULLIF(rtrim("lugar"::text), '')::varchar(50) AS "lugar",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone"
FROM "legacy_raw"."compromisos_pactados"
ON CONFLICT DO NOTHING;

-- compromisos_pactados_deta -> logistica.compromisos_pactados_deta  (6 col)
INSERT INTO "logistica"."compromisos_pactados_deta" ("codi_comp", "codi_deta", "codi_prod", "cantidad", "p_unit", "total")
SELECT
       NULLIF(btrim("codi_comp"::text), '')::bigint AS "codi_comp",
       NULLIF(btrim("codi_deta"::text), '')::integer AS "codi_deta",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,3) AS "cantidad",
       NULLIF(btrim("p_unit"::text), '')::numeric(18,3) AS "p_unit",
       NULLIF(btrim("total"::text), '')::numeric(18,3) AS "total"
FROM "legacy_raw"."compromisos_pactados_deta"
ON CONFLICT DO NOTHING;

-- CONTROL_PROBLEMAS -> logistica.control_problemas  (5 col)
INSERT INTO "logistica"."control_problemas" ("id_control", "nro_control", "fecha", "descripcion", "hecho_por")
SELECT
       NULLIF(btrim("id_control"::text), '')::bigint AS "id_control",
       NULLIF(btrim("nro_control"::text), '')::bigint AS "nro_control",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("descripcion"::text), '')::varchar(255) AS "descripcion",
       NULLIF(rtrim("hecho_por"::text), '')::varchar(5) AS "hecho_por"
FROM "legacy_raw"."control_problemas"
ON CONFLICT DO NOTHING;

-- CONTROL_PROBLEMAS_DETALLE -> logistica.control_problemas_detalle  (5 col)
INSERT INTO "logistica"."control_problemas_detalle" ("id_control", "id_sec", "id_sub_fami_prod", "opcion", "dosis")
SELECT
       NULLIF(btrim("id_control"::text), '')::bigint AS "id_control",
       NULLIF(btrim("id_sec"::text), '')::integer AS "id_sec",
       NULLIF(rtrim("id_sub_fami_prod"::text), '')::varchar(4) AS "id_sub_fami_prod",
       NULLIF(rtrim("opcion"::text), '')::varchar(255) AS "opcion",
       NULLIF(rtrim("dosis"::text), '')::varchar(255) AS "dosis"
FROM "legacy_raw"."control_problemas_detalle"
ON CONFLICT DO NOTHING;

-- COTIZACION_DE_PEDIDOS -> logistica.cotizacion_de_pedidos  (9 col)
INSERT INTO "logistica"."cotizacion_de_pedidos" ("codi_coti", "fech_coti", "tiem_plaz_cred", "codi_unid_medi", "estado", "codi_mone", "prec_tota_coti", "codi_orde_pedi", "codi_list_requ_orig")
SELECT
       NULLIF(rtrim("codi_coti"::text), '')::varchar(10) AS "codi_coti",
       NULLIF(btrim("fech_coti"::text), '')::timestamp(3) AS "fech_coti",
       NULLIF(btrim("tiem_plaz_cred"::text), '')::integer AS "tiem_plaz_cred",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("prec_tota_coti"::text), '')::numeric(12,2) AS "prec_tota_coti",
       NULLIF(rtrim("codi_orde_pedi"::text), '')::varchar(10) AS "codi_orde_pedi",
       NULLIF(rtrim("codi_list_requ_orig"::text), '')::varchar(8) AS "codi_list_requ_orig"
FROM "legacy_raw"."cotizacion_de_pedidos"
ON CONFLICT DO NOTHING;

-- COTIZACION_DETA -> logistica.cotizacion_deta  (7 col)
INSERT INTO "logistica"."cotizacion_deta" ("codi_coti", "codi_deta", "codi_prod", "cantidad", "stock", "p_unit", "total")
SELECT
       NULLIF(btrim("codi_coti"::text), '')::bigint AS "codi_coti",
       NULLIF(btrim("codi_deta"::text), '')::integer AS "codi_deta",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,3) AS "cantidad",
       NULLIF(btrim("stock"::text), '')::numeric(18,3) AS "stock",
       NULLIF(btrim("p_unit"::text), '')::numeric(18,3) AS "p_unit",
       NULLIF(btrim("total"::text), '')::numeric(18,3) AS "total"
FROM "legacy_raw"."cotizacion_deta"
ON CONFLICT DO NOTHING;

-- DETALLE_COTIZACION_PEDIDO -> logistica.detalle_cotizacion_pedido  (8 col)
INSERT INTO "logistica"."detalle_cotizacion_pedido" ("codi_deta_coti", "codi_coti", "codi_prod", "cantidad", "codi_unid_medi_tiem", "tiem_resp", "codi_mone", "prec_unit")
SELECT
       NULLIF(rtrim("codi_deta_coti"::text), '')::varchar(12) AS "codi_deta_coti",
       NULLIF(rtrim("codi_coti"::text), '')::varchar(10) AS "codi_coti",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(9,2) AS "cantidad",
       NULLIF(rtrim("codi_unid_medi_tiem"::text), '')::varchar(2) AS "codi_unid_medi_tiem",
       NULLIF(btrim("tiem_resp"::text), '')::numeric(18,2) AS "tiem_resp",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("prec_unit"::text), '')::numeric(18,2) AS "prec_unit"
FROM "legacy_raw"."detalle_cotizacion_pedido"
ON CONFLICT DO NOTHING;

-- DETALLE_DOCU_SALI -> logistica.detalle_docu_sali  (29 col)
INSERT INTO "logistica"."detalle_docu_sali" ("codi_deta_docu_sali", "codi_docu_sali", "nro_cuen", "codi_prod", "cantidad", "prec_costo", "prec_prom", "stoc_sali", "fech_ulti_sali", "cant_ulti_sali", "codi_orde_pedi", "codi_unid_oper", "codi_alma", "codi_alma_desti", "codi_deta_orde_pedi", "prec_kard", "concen_iqf", "prodserviqf", "canti_prodserviqf", "um_prodserviqf", "deseiqf", "canti_deseiqf", "um_deseiqf", "canti_rhpm_iqf", "um_rhpm_iqf", "moti_rhpm_iqf", "observaciones", "prec_unit", "nro_cuen_ni")
SELECT
       NULLIF(rtrim("codi_deta_docu_sali"::text), '')::varchar(12) AS "codi_deta_docu_sali",
       NULLIF(rtrim("codi_docu_sali"::text), '')::varchar(10) AS "codi_docu_sali",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(10,4) AS "cantidad",
       NULLIF(btrim("prec_costo"::text), '')::numeric(18,4) AS "prec_costo",
       NULLIF(btrim("prec_prom"::text), '')::numeric(12,4) AS "prec_prom",
       NULLIF(btrim("stoc_sali"::text), '')::numeric(12,4) AS "stoc_sali",
       NULLIF(btrim("fech_ulti_sali"::text), '')::timestamp(3) AS "fech_ulti_sali",
       NULLIF(btrim("cant_ulti_sali"::text), '')::numeric(12,4) AS "cant_ulti_sali",
       NULLIF(rtrim("codi_orde_pedi"::text), '')::varchar(10) AS "codi_orde_pedi",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_alma_desti"::text), '')::varchar(2) AS "codi_alma_desti",
       NULLIF(rtrim("codi_deta_orde_pedi"::text), '')::varchar(12) AS "codi_deta_orde_pedi",
       NULLIF(btrim("prec_kard"::text), '')::numeric(18,4) AS "prec_kard",
       NULLIF(btrim("concen_iqf"::text), '')::bigint AS "concen_iqf",
       NULLIF(rtrim("prodserviqf"::text), '')::varchar(50) AS "prodserviqf",
       NULLIF(btrim("canti_prodserviqf"::text), '')::bigint AS "canti_prodserviqf",
       NULLIF(rtrim("um_prodserviqf"::text), '')::varchar(2) AS "um_prodserviqf",
       NULLIF(rtrim("deseiqf"::text), '')::varchar(50) AS "deseiqf",
       NULLIF(btrim("canti_deseiqf"::text), '')::bigint AS "canti_deseiqf",
       NULLIF(rtrim("um_deseiqf"::text), '')::varchar(2) AS "um_deseiqf",
       NULLIF(btrim("canti_rhpm_iqf"::text), '')::bigint AS "canti_rhpm_iqf",
       NULLIF(rtrim("um_rhpm_iqf"::text), '')::varchar(2) AS "um_rhpm_iqf",
       NULLIF(rtrim("moti_rhpm_iqf"::text), '')::varchar(50) AS "moti_rhpm_iqf",
       NULLIF(rtrim("observaciones"::text), '')::varchar(50) AS "observaciones",
       NULLIF(btrim("prec_unit"::text), '')::numeric(18,6) AS "prec_unit",
       NULLIF(rtrim("nro_cuen_ni"::text), '')::varchar(7) AS "nro_cuen_ni"
FROM "legacy_raw"."detalle_docu_sali"
ON CONFLICT DO NOTHING;

-- DETALLE_LISTAREQUERIMIENTOS -> logistica.detalle_listarequerimientos  (13 col)
INSERT INTO "logistica"."detalle_listarequerimientos" ("codi_deta_list_requ", "codi_list_requ", "codi_prod", "cantidad", "nro_cuen", "stoc_ulti", "stoc_temp_ulti", "ulti_prec", "codi_mone_ulti_prec", "cuen_cost", "fech_ulti_requ", "codi_unid_oper", "codi_alma")
SELECT
       NULLIF(rtrim("codi_deta_list_requ"::text), '')::varchar(10) AS "codi_deta_list_requ",
       NULLIF(rtrim("codi_list_requ"::text), '')::varchar(8) AS "codi_list_requ",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(10,4) AS "cantidad",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(btrim("stoc_ulti"::text), '')::numeric(15,4) AS "stoc_ulti",
       NULLIF(btrim("stoc_temp_ulti"::text), '')::numeric(15,4) AS "stoc_temp_ulti",
       NULLIF(btrim("ulti_prec"::text), '')::numeric(18,4) AS "ulti_prec",
       NULLIF(rtrim("codi_mone_ulti_prec"::text), '')::varchar(2) AS "codi_mone_ulti_prec",
       NULLIF(rtrim("cuen_cost"::text), '')::varchar(7) AS "cuen_cost",
       NULLIF(btrim("fech_ulti_requ"::text), '')::timestamp(3) AS "fech_ulti_requ",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma"
FROM "legacy_raw"."detalle_listarequerimientos"
ON CONFLICT DO NOTHING;

-- DETALLE_NOTA_INGRESO -> logistica.detalle_nota_ingreso  (26 col)
INSERT INTO "logistica"."detalle_nota_ingreso" ("codi_nota_ingr", "nro_item_nota_ingr", "codi_prod", "cantidad", "codi_mone", "prec_unit", "codi_unid_oper", "nro_cuen", "prec_kard", "stoc_ulti", "stoc_temp_ulti", "prec_ulti", "porc_detr", "codi_deta_orde_comp", "codi_mone_ulti_prec", "codi_alma", "codi_deta_orde_pedi", "codi_tipo_enva", "num_enva", "exceso", "faltante", "observaciones", "concen_iqf", "dscto_porcentaje", "prec_compra", "tipo_compra")
SELECT
       NULLIF(rtrim("codi_nota_ingr"::text), '')::varchar(10) AS "codi_nota_ingr",
       NULLIF(rtrim("nro_item_nota_ingr"::text), '')::varchar(12) AS "nro_item_nota_ingr",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,4) AS "cantidad",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("prec_unit"::text), '')::numeric(18,4) AS "prec_unit",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(btrim("prec_kard"::text), '')::numeric(18,4) AS "prec_kard",
       NULLIF(btrim("stoc_ulti"::text), '')::numeric(15,4) AS "stoc_ulti",
       NULLIF(btrim("stoc_temp_ulti"::text), '')::numeric(15,4) AS "stoc_temp_ulti",
       NULLIF(btrim("prec_ulti"::text), '')::numeric(18,4) AS "prec_ulti",
       NULLIF(btrim("porc_detr"::text), '')::numeric(15,4) AS "porc_detr",
       NULLIF(rtrim("codi_deta_orde_comp"::text), '')::varchar(12) AS "codi_deta_orde_comp",
       NULLIF(rtrim("codi_mone_ulti_prec"::text), '')::varchar(2) AS "codi_mone_ulti_prec",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_deta_orde_pedi"::text), '')::varchar(12) AS "codi_deta_orde_pedi",
       NULLIF(btrim("codi_tipo_enva"::text), '')::smallint AS "codi_tipo_enva",
       NULLIF(btrim("num_enva"::text), '')::smallint AS "num_enva",
       NULLIF(btrim("exceso"::text), '')::numeric(18,4) AS "exceso",
       NULLIF(btrim("faltante"::text), '')::numeric(18,4) AS "faltante",
       NULLIF(rtrim("observaciones"::text), '')::varchar(50) AS "observaciones",
       NULLIF(btrim("concen_iqf"::text), '')::numeric(18,2) AS "concen_iqf",
       NULLIF(btrim("dscto_porcentaje"::text), '')::numeric(18,3) AS "dscto_porcentaje",
       NULLIF(btrim("prec_compra"::text), '')::numeric(18,4) AS "prec_compra",
       NULLIF(rtrim("tipo_compra"::text), '')::varchar(1) AS "tipo_compra"
FROM "legacy_raw"."detalle_nota_ingreso"
ON CONFLICT DO NOTHING;

-- DETALLE_ORDEN_COMPRA -> logistica.detalle_orden_compra  (18 col)
INSERT INTO "logistica"."detalle_orden_compra" ("codi_deta_orde_comp", "codi_orde_comp", "codi_prod", "cantidad", "precio", "codi_mone", "nro_cuen", "tipo_desc", "descuento", "prec_orig", "codi_deta_orde_pedi", "codi_unid_oper", "codi_alma", "proc_pedi", "fecha_venc", "tipo_compra", "codi_unid_medi_orde", "tipo_prod")
SELECT
       NULLIF(rtrim("codi_deta_orde_comp"::text), '')::varchar(12) AS "codi_deta_orde_comp",
       NULLIF(rtrim("codi_orde_comp"::text), '')::varchar(10) AS "codi_orde_comp",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,4) AS "cantidad",
       NULLIF(btrim("precio"::text), '')::numeric(18,4) AS "precio",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(btrim("tipo_desc"::text), '')::integer AS "tipo_desc",
       NULLIF(btrim("descuento"::text), '')::numeric(12,4) AS "descuento",
       NULLIF(btrim("prec_orig"::text), '')::numeric(18,4) AS "prec_orig",
       NULLIF(rtrim("codi_deta_orde_pedi"::text), '')::varchar(12) AS "codi_deta_orde_pedi",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("proc_pedi"::text), '')::varchar(1) AS "proc_pedi",
       NULLIF(btrim("fecha_venc"::text), '')::timestamp(3) AS "fecha_venc",
       NULLIF(rtrim("tipo_compra"::text), '')::varchar(1) AS "tipo_compra",
       NULLIF(rtrim("codi_unid_medi_orde"::text), '')::varchar(2) AS "codi_unid_medi_orde",
       NULLIF(rtrim("tipo_prod"::text), '')::varchar(5) AS "tipo_prod"
FROM "legacy_raw"."detalle_orden_compra"
ON CONFLICT DO NOTHING;

-- DETALLE_ORDEN_COMPRA_DISTRIBUCION -> logistica.detalle_orden_compra_distribucion  (4 col)
INSERT INTO "logistica"."detalle_orden_compra_distribucion" ("codi_orde_comp", "codi_prod", "codi_alma", "cantidad")
SELECT
       NULLIF(rtrim("codi_orde_comp"::text), '')::varchar(10) AS "codi_orde_comp",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,4) AS "cantidad"
FROM "legacy_raw"."detalle_orden_compra_distribucion"
ON CONFLICT DO NOTHING;

-- DETALLE_ORDEN_DE_PEDIDO -> logistica.detalle_orden_de_pedido  (21 col)
INSERT INTO "logistica"."detalle_orden_de_pedido" ("codi_deta_orde_pedi", "codi_orde_pedi", "codi_prod", "cantidad", "nro_cuen", "estado", "prec_prom", "prec_ulti", "codi_mone_prec_ulti", "codi_clie_prov_ulti", "stoc_ulti", "stoc_temp_ulti", "nro_ulti_sali", "fech_ulti_sali", "cant_ulti_sali", "cons_prom", "cuen_cost", "luga_aten", "codi_unid_oper", "codi_alma", "prec_venta")
SELECT
       NULLIF(rtrim("codi_deta_orde_pedi"::text), '')::varchar(12) AS "codi_deta_orde_pedi",
       NULLIF(rtrim("codi_orde_pedi"::text), '')::varchar(10) AS "codi_orde_pedi",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(10,4) AS "cantidad",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(btrim("prec_prom"::text), '')::numeric(12,3) AS "prec_prom",
       NULLIF(btrim("prec_ulti"::text), '')::numeric(12,3) AS "prec_ulti",
       NULLIF(rtrim("codi_mone_prec_ulti"::text), '')::varchar(2) AS "codi_mone_prec_ulti",
       NULLIF(rtrim("codi_clie_prov_ulti"::text), '')::varchar(5) AS "codi_clie_prov_ulti",
       NULLIF(btrim("stoc_ulti"::text), '')::numeric(15,4) AS "stoc_ulti",
       NULLIF(btrim("stoc_temp_ulti"::text), '')::numeric(15,4) AS "stoc_temp_ulti",
       NULLIF(rtrim("nro_ulti_sali"::text), '')::varchar(10) AS "nro_ulti_sali",
       NULLIF(btrim("fech_ulti_sali"::text), '')::timestamp(3) AS "fech_ulti_sali",
       NULLIF(btrim("cant_ulti_sali"::text), '')::numeric(15,4) AS "cant_ulti_sali",
       NULLIF(btrim("cons_prom"::text), '')::numeric(15,4) AS "cons_prom",
       NULLIF(rtrim("cuen_cost"::text), '')::varchar(7) AS "cuen_cost",
       NULLIF(rtrim("luga_aten"::text), '')::varchar(4) AS "luga_aten",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("prec_venta"::text), '')::numeric(18,3) AS "prec_venta"
FROM "legacy_raw"."detalle_orden_de_pedido"
ON CONFLICT DO NOTHING;

-- DETALLE_ORDEN_SERVICIO -> logistica.detalle_orden_servicio  (14 col)
INSERT INTO "logistica"."detalle_orden_servicio" ("codi_deta_orde_comp", "codi_orde_comp", "codi_prod", "desc_serv", "cantidad", "precio", "codi_mone", "nro_cuen", "tipo_desc", "descuento", "prec_orig", "codi_deta_orde_pedi", "codi_unid_medi", "codi_unid_oper")
SELECT
       NULLIF(rtrim("codi_deta_orde_comp"::text), '')::varchar(12) AS "codi_deta_orde_comp",
       NULLIF(rtrim("codi_orde_comp"::text), '')::varchar(10) AS "codi_orde_comp",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("desc_serv"::text), '')::varchar(250) AS "desc_serv",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,4) AS "cantidad",
       NULLIF(btrim("precio"::text), '')::numeric(12,4) AS "precio",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(btrim("tipo_desc"::text), '')::boolean AS "tipo_desc",
       NULLIF(btrim("descuento"::text), '')::numeric(12,4) AS "descuento",
       NULLIF(btrim("prec_orig"::text), '')::numeric(12,4) AS "prec_orig",
       NULLIF(rtrim("codi_deta_orde_pedi"::text), '')::varchar(12) AS "codi_deta_orde_pedi",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper"
FROM "legacy_raw"."detalle_orden_servicio"
ON CONFLICT DO NOTHING;

-- DETALLE_SALIDA_MATERIALES -> logistica.detalle_salida_materiales  (15 col)
INSERT INTO "logistica"."detalle_salida_materiales" ("codi_deta_docu_sali", "codi_docu_sali", "nro_cuen", "codi_prod", "desc_prod", "codi_unid_medi_prod", "cantidad", "peso", "codi_unid_medi_peso", "codi_unid_oper", "con_reto", "indi_reto", "codi_deta_orig", "tipo_orig", "codi_alma")
SELECT
       NULLIF(rtrim("codi_deta_docu_sali"::text), '')::varchar(12) AS "codi_deta_docu_sali",
       NULLIF(rtrim("codi_docu_sali"::text), '')::varchar(10) AS "codi_docu_sali",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("desc_prod"::text), '')::varchar(250) AS "desc_prod",
       NULLIF(rtrim("codi_unid_medi_prod"::text), '')::varchar(2) AS "codi_unid_medi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,4) AS "cantidad",
       NULLIF(btrim("peso"::text), '')::numeric(18,4) AS "peso",
       NULLIF(rtrim("codi_unid_medi_peso"::text), '')::varchar(2) AS "codi_unid_medi_peso",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("con_reto"::text), '')::varchar(1) AS "con_reto",
       NULLIF(rtrim("indi_reto"::text), '')::varchar(1) AS "indi_reto",
       NULLIF(rtrim("codi_deta_orig"::text), '')::varchar(12) AS "codi_deta_orig",
       NULLIF(rtrim("tipo_orig"::text), '')::varchar(1) AS "tipo_orig",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma"
FROM "legacy_raw"."detalle_salida_materiales"
ON CONFLICT DO NOTHING;

-- DOCU_SALI_MATE -> logistica.docu_sali_mate  (38 col)
INSERT INTO "logistica"."docu_sali_mate" ("codi_docu_sali", "codi_unid_oper_rece", "codi_tipo_docu_sali", "codi_orde_pedi", "codi_pers_emis", "codi_pers_rece", "fech_emis", "codi_turn", "codi_unid_nego", "codi_clie_prov", "nro_seri_docu_sali", "nro_docu_sali", "motivo", "observacion", "tipo_sali", "tipo_dest", "codi_pers_reci_mate", "moti_sali", "codi_puer_sali", "estado", "viveres", "codi_emba", "codi_sema_pesc", "nro_sali", "kilometraje", "kilo_mill", "codi_alma", "codi_alma_desti", "codi_fact", "condicion", "fech_reg_fact", "codi_tipo_docu_cont", "nro_seri_docu_cont", "nro_docu_cont", "importe", "igv", "prec_tota", "contab")
SELECT
       NULLIF(rtrim("codi_docu_sali"::text), '')::varchar(10) AS "codi_docu_sali",
       NULLIF(rtrim("codi_unid_oper_rece"::text), '')::varchar(5) AS "codi_unid_oper_rece",
       NULLIF(rtrim("codi_tipo_docu_sali"::text), '')::varchar(4) AS "codi_tipo_docu_sali",
       NULLIF(rtrim("codi_orde_pedi"::text), '')::varchar(10) AS "codi_orde_pedi",
       NULLIF(rtrim("codi_pers_emis"::text), '')::varchar(5) AS "codi_pers_emis",
       NULLIF(rtrim("codi_pers_rece"::text), '')::varchar(5) AS "codi_pers_rece",
       NULLIF(btrim("fech_emis"::text), '')::timestamp(3) AS "fech_emis",
       NULLIF(rtrim("codi_turn"::text), '')::varchar(2) AS "codi_turn",
       NULLIF(rtrim("codi_unid_nego"::text), '')::varchar(2) AS "codi_unid_nego",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("nro_seri_docu_sali"::text), '')::varchar(5) AS "nro_seri_docu_sali",
       NULLIF(rtrim("nro_docu_sali"::text), '')::varchar(10) AS "nro_docu_sali",
       NULLIF(rtrim("motivo"::text), '')::varchar(150) AS "motivo",
       NULLIF(rtrim("observacion"::text), '')::varchar(150) AS "observacion",
       NULLIF(rtrim("tipo_sali"::text), '')::varchar(20) AS "tipo_sali",
       NULLIF(rtrim("tipo_dest"::text), '')::varchar(2) AS "tipo_dest",
       NULLIF(rtrim("codi_pers_reci_mate"::text), '')::varchar(5) AS "codi_pers_reci_mate",
       NULLIF(rtrim("moti_sali"::text), '')::varchar(10) AS "moti_sali",
       NULLIF(rtrim("codi_puer_sali"::text), '')::varchar(2) AS "codi_puer_sali",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(btrim("viveres"::text), '')::boolean AS "viveres",
       NULLIF(rtrim("codi_emba"::text), '')::varchar(5) AS "codi_emba",
       NULLIF(rtrim("codi_sema_pesc"::text), '')::varchar(5) AS "codi_sema_pesc",
       NULLIF(rtrim("nro_sali"::text), '')::varchar(10) AS "nro_sali",
       NULLIF(btrim("kilometraje"::text), '')::numeric(18,2) AS "kilometraje",
       NULLIF(btrim("kilo_mill"::text), '')::numeric(18,2) AS "kilo_mill",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_alma_desti"::text), '')::varchar(2) AS "codi_alma_desti",
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(rtrim("condicion"::text), '')::varchar(1) AS "condicion",
       NULLIF(btrim("fech_reg_fact"::text), '')::timestamp(3) AS "fech_reg_fact",
       NULLIF(rtrim("codi_tipo_docu_cont"::text), '')::varchar(4) AS "codi_tipo_docu_cont",
       NULLIF(rtrim("nro_seri_docu_cont"::text), '')::varchar(5) AS "nro_seri_docu_cont",
       NULLIF(rtrim("nro_docu_cont"::text), '')::varchar(10) AS "nro_docu_cont",
       NULLIF(btrim("importe"::text), '')::numeric(18,4) AS "importe",
       NULLIF(btrim("igv"::text), '')::numeric(18,4) AS "igv",
       NULLIF(btrim("prec_tota"::text), '')::numeric(18,4) AS "prec_tota",
       NULLIF(btrim("contab"::text), '')::integer AS "contab"
FROM "legacy_raw"."docu_sali_mate"
ON CONFLICT DO NOTHING;

-- DOCU_SALI_X_ORDE_PEDI -> logistica.docu_sali_x_orde_pedi  (2 col)
INSERT INTO "logistica"."docu_sali_x_orde_pedi" ("codi_docu_sali", "codi_orde_pedi")
SELECT
       NULLIF(rtrim("codi_docu_sali"::text), '')::varchar(10) AS "codi_docu_sali",
       NULLIF(rtrim("codi_orde_pedi"::text), '')::varchar(10) AS "codi_orde_pedi"
FROM "legacy_raw"."docu_sali_x_orde_pedi"
ON CONFLICT DO NOTHING;

-- FAMILIA_PRODUCTO -> logistica.familia_producto  (5 col)
INSERT INTO "logistica"."familia_producto" ("codi_fami_prod", "desc_fami_prod", "prod_serv", "nro_cuen", "cod_lin_pro")
SELECT
       NULLIF(rtrim("codi_fami_prod"::text), '')::varchar(2) AS "codi_fami_prod",
       NULLIF(rtrim("desc_fami_prod"::text), '')::varchar(100) AS "desc_fami_prod",
       NULLIF(rtrim("prod_serv"::text), '')::varchar(1) AS "prod_serv",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("cod_lin_pro"::text), '')::varchar(2) AS "cod_lin_pro"
FROM "legacy_raw"."familia_producto"
ON CONFLICT DO NOTHING;

-- KARDEX -> logistica.kardex  (42 col)
INSERT INTO "logistica"."kardex" ("codi_kard", "codi_prod", "codi_tipo_docu", "nro_seri", "nro_docu", "codi_unid_oper_soli", "codi_unid_oper_dest", "codi_cuen", "fech_tran", "cant_ingr", "cant_sali", "cant_saldo", "cant_saldo_alma", "prec_unit", "prec_prom", "prec_prom_alma", "valo_ingr", "valo_sali", "valo_saldo", "valo_ingr_alma", "valo_sali_alma", "valo_saldo_alma", "codi_mone", "tipo_camb", "i_o", "codi_docu_i_o", "concepto", "nro_guia", "periodo", "estado", "item", "codi_alma", "prodserviqf", "canti_prodserviqf", "um_prodserviqf", "deseiqf", "canti_deseiqf", "um_deseiqf", "canti_rhpm_iqf", "um_rhpm_iqf", "moti_rhpm_iqf", "creacion")
SELECT
       NULLIF(rtrim("codi_kard"::text), '')::varchar(20) AS "codi_kard",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("nro_seri"::text), '')::varchar(5) AS "nro_seri",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(15) AS "nro_docu",
       NULLIF(rtrim("codi_unid_oper_soli"::text), '')::varchar(5) AS "codi_unid_oper_soli",
       NULLIF(rtrim("codi_unid_oper_dest"::text), '')::varchar(5) AS "codi_unid_oper_dest",
       NULLIF(rtrim("codi_cuen"::text), '')::varchar(7) AS "codi_cuen",
       NULLIF(btrim("fech_tran"::text), '')::timestamp(3) AS "fech_tran",
       NULLIF(btrim("cant_ingr"::text), '')::numeric(18,4) AS "cant_ingr",
       NULLIF(btrim("cant_sali"::text), '')::numeric(18,4) AS "cant_sali",
       NULLIF(btrim("cant_saldo"::text), '')::numeric(18,4) AS "cant_saldo",
       NULLIF(btrim("cant_saldo_alma"::text), '')::numeric(18,4) AS "cant_saldo_alma",
       NULLIF(btrim("prec_unit"::text), '')::numeric(12,4) AS "prec_unit",
       NULLIF(btrim("prec_prom"::text), '')::numeric(12,4) AS "prec_prom",
       NULLIF(btrim("prec_prom_alma"::text), '')::numeric(18,4) AS "prec_prom_alma",
       NULLIF(btrim("valo_ingr"::text), '')::numeric(18,4) AS "valo_ingr",
       NULLIF(btrim("valo_sali"::text), '')::numeric(18,4) AS "valo_sali",
       NULLIF(btrim("valo_saldo"::text), '')::numeric(18,4) AS "valo_saldo",
       NULLIF(btrim("valo_ingr_alma"::text), '')::numeric(18,4) AS "valo_ingr_alma",
       NULLIF(btrim("valo_sali_alma"::text), '')::numeric(18,4) AS "valo_sali_alma",
       NULLIF(btrim("valo_saldo_alma"::text), '')::numeric(18,4) AS "valo_saldo_alma",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("tipo_camb"::text), '')::numeric(12,4) AS "tipo_camb",
       NULLIF(rtrim("i_o"::text), '')::varchar(1) AS "i_o",
       NULLIF(rtrim("codi_docu_i_o"::text), '')::varchar(10) AS "codi_docu_i_o",
       NULLIF(rtrim("concepto"::text), '')::varchar(250) AS "concepto",
       NULLIF(rtrim("nro_guia"::text), '')::varchar(15) AS "nro_guia",
       NULLIF(btrim("periodo"::text), '')::integer AS "periodo",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("item"::text), '')::varchar(12) AS "item",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("prodserviqf"::text), '')::varchar(50) AS "prodserviqf",
       NULLIF(btrim("canti_prodserviqf"::text), '')::numeric(18,4) AS "canti_prodserviqf",
       NULLIF(rtrim("um_prodserviqf"::text), '')::varchar(2) AS "um_prodserviqf",
       NULLIF(rtrim("deseiqf"::text), '')::varchar(50) AS "deseiqf",
       NULLIF(btrim("canti_deseiqf"::text), '')::numeric(18,4) AS "canti_deseiqf",
       NULLIF(rtrim("um_deseiqf"::text), '')::varchar(2) AS "um_deseiqf",
       NULLIF(btrim("canti_rhpm_iqf"::text), '')::bigint AS "canti_rhpm_iqf",
       NULLIF(rtrim("um_rhpm_iqf"::text), '')::varchar(2) AS "um_rhpm_iqf",
       NULLIF(rtrim("moti_rhpm_iqf"::text), '')::varchar(50) AS "moti_rhpm_iqf",
       NULLIF(btrim("creacion"::text), '')::timestamp(3) AS "creacion"
FROM "legacy_raw"."kardex"
ON CONFLICT DO NOTHING;

-- KARDEX_ALMACENES -> logistica.kardex_almacenes  (61 col)
INSERT INTO "logistica"."kardex_almacenes" ("codigo", "codi_transa", "codi_alma", "item", "codi_prod", "i_o", "cantidad", "precio", "total", "codi_unid_medi", "codi_mone", "tipo_cambio", "ingr_cant", "sali_cant", "prec_unit", "prec_prom", "stock", "ingr_valo", "egre_valo", "saldo_valo", "periodo", "fecha", "exonerado", "igv", "venta", "valorigv", "nro_cuen", "productor", "acidez", "cantcolpex", "entradafisico", "salidafisico", "promfisico", "stockfisico", "ingresofisico", "egresofisico", "saldofisico", "transporte", "placa", "ticket", "codi_tipo_docu", "serguia", "nroguia", "codi_moti_tras", "nro_vales", "indice_rela", "codi_tipo_enva", "num_enva", "exceso", "faltante", "observaciones", "concen_iqf", "prodserviqf", "canti_prodserviqf", "um_prodserviqf", "deseiqf", "canti_deseiqf", "um_deseiqf", "canti_rhpm_iqf", "um_rhpm_iqf", "moti_rhpm_iqf")
SELECT
       NULLIF(btrim("codigo"::text), '')::bigint AS "codigo",
       NULLIF(btrim("codi_transa"::text), '')::bigint AS "codi_transa",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("item"::text), '')::integer AS "item",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("i_o"::text), '')::varchar(1) AS "i_o",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,4) AS "cantidad",
       NULLIF(btrim("precio"::text), '')::numeric(18,4) AS "precio",
       NULLIF(btrim("total"::text), '')::numeric(18,2) AS "total",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(50) AS "codi_unid_medi",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("tipo_cambio"::text), '')::numeric(18,4) AS "tipo_cambio",
       NULLIF(btrim("ingr_cant"::text), '')::numeric(18,4) AS "ingr_cant",
       NULLIF(btrim("sali_cant"::text), '')::numeric(18,4) AS "sali_cant",
       NULLIF(btrim("prec_unit"::text), '')::numeric(18,4) AS "prec_unit",
       NULLIF(btrim("prec_prom"::text), '')::numeric(18,4) AS "prec_prom",
       NULLIF(btrim("stock"::text), '')::numeric(18,4) AS "stock",
       NULLIF(btrim("ingr_valo"::text), '')::numeric(18,4) AS "ingr_valo",
       NULLIF(btrim("egre_valo"::text), '')::numeric(18,4) AS "egre_valo",
       NULLIF(btrim("saldo_valo"::text), '')::numeric(18,4) AS "saldo_valo",
       NULLIF(btrim("periodo"::text), '')::integer AS "periodo",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("exonerado"::text), '')::varchar(1) AS "exonerado",
       NULLIF(btrim("igv"::text), '')::numeric(18,2) AS "igv",
       NULLIF(btrim("venta"::text), '')::numeric(18,2) AS "venta",
       NULLIF(btrim("valorigv"::text), '')::numeric(18,2) AS "valorigv",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("productor"::text), '')::varchar(5) AS "productor",
       NULLIF(btrim("acidez"::text), '')::numeric(18,3) AS "acidez",
       NULLIF(btrim("cantcolpex"::text), '')::numeric(18,4) AS "cantcolpex",
       NULLIF(btrim("entradafisico"::text), '')::numeric(18,4) AS "entradafisico",
       NULLIF(btrim("salidafisico"::text), '')::numeric(18,4) AS "salidafisico",
       NULLIF(btrim("promfisico"::text), '')::numeric(18,4) AS "promfisico",
       NULLIF(btrim("stockfisico"::text), '')::numeric(18,4) AS "stockfisico",
       NULLIF(btrim("ingresofisico"::text), '')::numeric(18,4) AS "ingresofisico",
       NULLIF(btrim("egresofisico"::text), '')::numeric(18,4) AS "egresofisico",
       NULLIF(btrim("saldofisico"::text), '')::numeric(18,4) AS "saldofisico",
       NULLIF(rtrim("transporte"::text), '')::varchar(4) AS "transporte",
       NULLIF(rtrim("placa"::text), '')::varchar(10) AS "placa",
       NULLIF(rtrim("ticket"::text), '')::varchar(10) AS "ticket",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("serguia"::text), '')::varchar(5) AS "serguia",
       NULLIF(rtrim("nroguia"::text), '')::varchar(10) AS "nroguia",
       NULLIF(rtrim("codi_moti_tras"::text), '')::varchar(2) AS "codi_moti_tras",
       NULLIF(btrim("nro_vales"::text), '')::bigint AS "nro_vales",
       NULLIF(btrim("indice_rela"::text), '')::bigint AS "indice_rela",
       NULLIF(btrim("codi_tipo_enva"::text), '')::smallint AS "codi_tipo_enva",
       NULLIF(btrim("num_enva"::text), '')::smallint AS "num_enva",
       NULLIF(btrim("exceso"::text), '')::numeric(18,4) AS "exceso",
       NULLIF(btrim("faltante"::text), '')::numeric(18,4) AS "faltante",
       NULLIF(rtrim("observaciones"::text), '')::varchar(50) AS "observaciones",
       NULLIF(btrim("concen_iqf"::text), '')::numeric(18,2) AS "concen_iqf",
       NULLIF(rtrim("prodserviqf"::text), '')::varchar(50) AS "prodserviqf",
       NULLIF(btrim("canti_prodserviqf"::text), '')::bigint AS "canti_prodserviqf",
       NULLIF(rtrim("um_prodserviqf"::text), '')::varchar(2) AS "um_prodserviqf",
       NULLIF(rtrim("deseiqf"::text), '')::varchar(50) AS "deseiqf",
       NULLIF(btrim("canti_deseiqf"::text), '')::bigint AS "canti_deseiqf",
       NULLIF(rtrim("um_deseiqf"::text), '')::varchar(2) AS "um_deseiqf",
       NULLIF(btrim("canti_rhpm_iqf"::text), '')::bigint AS "canti_rhpm_iqf",
       NULLIF(rtrim("um_rhpm_iqf"::text), '')::varchar(2) AS "um_rhpm_iqf",
       NULLIF(rtrim("moti_rhpm_iqf"::text), '')::varchar(50) AS "moti_rhpm_iqf"
FROM "legacy_raw"."kardex_almacenes"
ON CONFLICT DO NOTHING;

-- KIT_DETA -> logistica.kit_deta  (4 col)
INSERT INTO "logistica"."kit_deta" ("codi_kit_inte", "nro_item", "codi_prod", "cantidad")
SELECT
       NULLIF(rtrim("codi_kit_inte"::text), '')::varchar(4) AS "codi_kit_inte",
       NULLIF(btrim("nro_item"::text), '')::integer AS "nro_item",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(9,2) AS "cantidad"
FROM "legacy_raw"."kit_deta"
ON CONFLICT DO NOTHING;

-- KITS -> logistica.kits  (5 col)
INSERT INTO "logistica"."kits" ("codi_kit_inte", "codi_kit_marc", "desc_kit", "marc_kit", "abre_kit")
SELECT
       NULLIF(rtrim("codi_kit_inte"::text), '')::varchar(4) AS "codi_kit_inte",
       NULLIF(rtrim("codi_kit_marc"::text), '')::varchar(15) AS "codi_kit_marc",
       NULLIF(rtrim("desc_kit"::text), '')::varchar(150) AS "desc_kit",
       NULLIF(rtrim("marc_kit"::text), '')::varchar(50) AS "marc_kit",
       NULLIF(rtrim("abre_kit"::text), '')::varchar(20) AS "abre_kit"
FROM "legacy_raw"."kits"
ON CONFLICT DO NOTHING;

-- LINEA_FAMILIA_PRO -> logistica.linea_familia_pro  (2 col)
INSERT INTO "logistica"."linea_familia_pro" ("cod_lin_pro", "des_lin_pro")
SELECT
       NULLIF(rtrim("cod_lin_pro"::text), '')::varchar(2) AS "cod_lin_pro",
       NULLIF(rtrim("des_lin_pro"::text), '')::varchar(100) AS "des_lin_pro"
FROM "legacy_raw"."linea_familia_pro"
ON CONFLICT DO NOTHING;

-- LISTA_DE_REQUERIMIENTOS -> logistica.lista_de_requerimientos  (17 col)
INSERT INTO "logistica"."lista_de_requerimientos" ("codi_list_requ", "fech_list_requ", "codi_pers_resp", "estado", "codi_unid_oper_soli", "codi_unid_oper_dest", "pedi_trab", "motivo", "tipo_uso", "mant_acti", "observacion", "observacion_2", "observacion_3", "observacion_4", "observacion_5", "prio", "codi_alma")
SELECT
       NULLIF(rtrim("codi_list_requ"::text), '')::varchar(8) AS "codi_list_requ",
       NULLIF(btrim("fech_list_requ"::text), '')::timestamp(3) AS "fech_list_requ",
       NULLIF(rtrim("codi_pers_resp"::text), '')::varchar(5) AS "codi_pers_resp",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("codi_unid_oper_soli"::text), '')::varchar(5) AS "codi_unid_oper_soli",
       NULLIF(rtrim("codi_unid_oper_dest"::text), '')::varchar(5) AS "codi_unid_oper_dest",
       NULLIF(rtrim("pedi_trab"::text), '')::varchar(1) AS "pedi_trab",
       NULLIF(rtrim("motivo"::text), '')::varchar(250) AS "motivo",
       NULLIF(rtrim("tipo_uso"::text), '')::varchar(1) AS "tipo_uso",
       NULLIF(rtrim("mant_acti"::text), '')::varchar(1) AS "mant_acti",
       NULLIF(rtrim("observacion"::text), '')::varchar(1500) AS "observacion",
       NULLIF(rtrim("observacion_2"::text), '')::varchar(200) AS "observacion_2",
       NULLIF(rtrim("observacion_3"::text), '')::varchar(200) AS "observacion_3",
       NULLIF(rtrim("observacion_4"::text), '')::varchar(200) AS "observacion_4",
       NULLIF(rtrim("observacion_5"::text), '')::varchar(200) AS "observacion_5",
       NULLIF(btrim("prio"::text), '')::smallint AS "prio",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma"
FROM "legacy_raw"."lista_de_requerimientos"
ON CONFLICT DO NOTHING;

-- LOTE_SITUACION -> logistica.lote_situacion  (2 col)
INSERT INTO "logistica"."lote_situacion" ("id_situ", "descripcion")
SELECT
       NULLIF(btrim("id_situ"::text), '')::integer AS "id_situ",
       NULLIF(rtrim("descripcion"::text), '')::varchar(100) AS "descripcion"
FROM "legacy_raw"."lote_situacion"
ON CONFLICT DO NOTHING;

-- MARCA -> logistica.marca  (2 col)
INSERT INTO "logistica"."marca" ("codi_marca", "desc_marca")
SELECT
       NULLIF(rtrim("codi_marca"::text), '')::varchar(4) AS "codi_marca",
       NULLIF(rtrim("desc_marca"::text), '')::varchar(50) AS "desc_marca"
FROM "legacy_raw"."marca"
ON CONFLICT DO NOTHING;

-- MATERIAL -> logistica.material  (2 col)
INSERT INTO "logistica"."material" ("codi_material", "desc_material")
SELECT
       NULLIF(btrim("codi_material"::text), '')::integer AS "codi_material",
       NULLIF(rtrim("desc_material"::text), '')::varchar(50) AS "desc_material"
FROM "legacy_raw"."material"
ON CONFLICT DO NOTHING;

-- NOTA_INGR_POR_ORDE_COMP -> logistica.nota_ingr_por_orde_comp  (2 col)
INSERT INTO "logistica"."nota_ingr_por_orde_comp" ("codi_orde_comp", "codi_nota_ingr")
SELECT
       NULLIF(rtrim("codi_orde_comp"::text), '')::varchar(10) AS "codi_orde_comp",
       NULLIF(rtrim("codi_nota_ingr"::text), '')::varchar(10) AS "codi_nota_ingr"
FROM "legacy_raw"."nota_ingr_por_orde_comp"
ON CONFLICT DO NOTHING;

-- NOTA_INGRESO -> logistica.nota_ingreso  (43 col)
INSERT INTO "logistica"."nota_ingreso" ("codi_nota_ingr", "codi_clie_prov", "codi_tipo_docu", "nro_seri", "nro_docu", "codi_unid_oper_soli", "codi_unid_oper_dest", "fech_nota_ingr", "tipo_nota_ingr", "importe", "codi_pers_vist_buen", "codi_pers_elab", "codi_mone", "prec_tota", "observaciones", "codi_turn", "codi_unid_nego", "nro_seri_docu_cont", "nro_docu_cont", "codi_tipo_docu_cont", "fech_guia_remi", "fech_reg_fact", "fech_proceso", "contab", "tipo_camb", "afecto", "estado", "codi_sema", "prov_pesc", "viveres", "codi_emba", "nro_nota_ingr", "igv", "otro_afec", "otro_no_afec", "codi_alma", "codi_alma_desti", "codi_docu_sali", "codi_transportista", "registro", "fech_venc_fact", "codi_chof", "codi_alma_dest")
SELECT
       NULLIF(rtrim("codi_nota_ingr"::text), '')::varchar(10) AS "codi_nota_ingr",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("nro_seri"::text), '')::varchar(5) AS "nro_seri",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(15) AS "nro_docu",
       NULLIF(rtrim("codi_unid_oper_soli"::text), '')::varchar(5) AS "codi_unid_oper_soli",
       NULLIF(rtrim("codi_unid_oper_dest"::text), '')::varchar(5) AS "codi_unid_oper_dest",
       NULLIF(btrim("fech_nota_ingr"::text), '')::timestamp(3) AS "fech_nota_ingr",
       NULLIF(rtrim("tipo_nota_ingr"::text), '')::varchar(20) AS "tipo_nota_ingr",
       NULLIF(btrim("importe"::text), '')::numeric(12,4) AS "importe",
       NULLIF(rtrim("codi_pers_vist_buen"::text), '')::varchar(5) AS "codi_pers_vist_buen",
       NULLIF(rtrim("codi_pers_elab"::text), '')::varchar(5) AS "codi_pers_elab",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("prec_tota"::text), '')::numeric(12,4) AS "prec_tota",
       NULLIF(rtrim("observaciones"::text), '')::varchar(100) AS "observaciones",
       NULLIF(rtrim("codi_turn"::text), '')::varchar(2) AS "codi_turn",
       NULLIF(rtrim("codi_unid_nego"::text), '')::varchar(2) AS "codi_unid_nego",
       NULLIF(rtrim("nro_seri_docu_cont"::text), '')::varchar(5) AS "nro_seri_docu_cont",
       NULLIF(rtrim("nro_docu_cont"::text), '')::varchar(15) AS "nro_docu_cont",
       NULLIF(rtrim("codi_tipo_docu_cont"::text), '')::varchar(4) AS "codi_tipo_docu_cont",
       NULLIF(btrim("fech_guia_remi"::text), '')::timestamp(3) AS "fech_guia_remi",
       NULLIF(btrim("fech_reg_fact"::text), '')::timestamp(3) AS "fech_reg_fact",
       NULLIF(btrim("fech_proceso"::text), '')::timestamp(3) AS "fech_proceso",
       NULLIF(btrim("contab"::text), '')::boolean AS "contab",
       NULLIF(btrim("tipo_camb"::text), '')::numeric(15,4) AS "tipo_camb",
       NULLIF(btrim("afecto"::text), '')::boolean AS "afecto",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(rtrim("prov_pesc"::text), '')::varchar(5) AS "prov_pesc",
       NULLIF(btrim("viveres"::text), '')::boolean AS "viveres",
       NULLIF(rtrim("codi_emba"::text), '')::varchar(5) AS "codi_emba",
       NULLIF(rtrim("nro_nota_ingr"::text), '')::varchar(10) AS "nro_nota_ingr",
       NULLIF(btrim("igv"::text), '')::numeric(18,4) AS "igv",
       NULLIF(btrim("otro_afec"::text), '')::numeric(18,4) AS "otro_afec",
       NULLIF(btrim("otro_no_afec"::text), '')::numeric(18,4) AS "otro_no_afec",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_alma_desti"::text), '')::varchar(2) AS "codi_alma_desti",
       NULLIF(rtrim("codi_docu_sali"::text), '')::varchar(10) AS "codi_docu_sali",
       NULLIF(rtrim("codi_transportista"::text), '')::varchar(5) AS "codi_transportista",
       NULLIF(rtrim("registro"::text), '')::varchar(10) AS "registro",
       NULLIF(btrim("fech_venc_fact"::text), '')::timestamp(3) AS "fech_venc_fact",
       NULLIF(rtrim("codi_chof"::text), '')::varchar(4) AS "codi_chof",
       NULLIF(rtrim("codi_alma_dest"::text), '')::varchar(2) AS "codi_alma_dest"
FROM "legacy_raw"."nota_ingreso"
ON CONFLICT DO NOTHING;

-- ORDE_SERV_X_PROY -> logistica.orde_serv_x_proy  (2 col)
INSERT INTO "logistica"."orde_serv_x_proy" ("codi_orde_comp", "codi_proy")
SELECT
       NULLIF(rtrim("codi_orde_comp"::text), '')::varchar(10) AS "codi_orde_comp",
       NULLIF(rtrim("codi_proy"::text), '')::varchar(10) AS "codi_proy"
FROM "legacy_raw"."orde_serv_x_proy"
ON CONFLICT DO NOTHING;

-- ORDEN_COMPRA_DETALLE -> logistica.orden_compra_detalle  (23 col)
INSERT INTO "logistica"."orden_compra_detalle" ("codi_orde", "item", "codi_prod", "cantidad", "precio", "codi_unid_medi", "total", "nro_cuen", "saldo", "igv", "venta", "valorigv", "estado", "codi_alma", "exonerado", "acidez", "serguia", "nroguia", "transporte", "placa", "codi_moti_tras", "pesocolp", "ticket")
SELECT
       NULLIF(btrim("codi_orde"::text), '')::bigint AS "codi_orde",
       NULLIF(btrim("item"::text), '')::integer AS "item",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,4) AS "cantidad",
       NULLIF(btrim("precio"::text), '')::numeric(18,4) AS "precio",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(btrim("total"::text), '')::numeric(18,2) AS "total",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(btrim("saldo"::text), '')::numeric(18,4) AS "saldo",
       NULLIF(btrim("igv"::text), '')::numeric(18,2) AS "igv",
       NULLIF(btrim("venta"::text), '')::numeric(18,2) AS "venta",
       NULLIF(btrim("valorigv"::text), '')::numeric(18,2) AS "valorigv",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("exonerado"::text), '')::varchar(1) AS "exonerado",
       NULLIF(btrim("acidez"::text), '')::numeric(18,3) AS "acidez",
       NULLIF(rtrim("serguia"::text), '')::varchar(5) AS "serguia",
       NULLIF(rtrim("nroguia"::text), '')::varchar(10) AS "nroguia",
       NULLIF(rtrim("transporte"::text), '')::varchar(5) AS "transporte",
       NULLIF(rtrim("placa"::text), '')::varchar(10) AS "placa",
       NULLIF(rtrim("codi_moti_tras"::text), '')::varchar(2) AS "codi_moti_tras",
       NULLIF(btrim("pesocolp"::text), '')::numeric(18,4) AS "pesocolp",
       NULLIF(rtrim("ticket"::text), '')::varchar(10) AS "ticket"
FROM "legacy_raw"."orden_compra_detalle"
ON CONFLICT DO NOTHING;

-- ORDEN_COMPRA_PEDIDO_COTIZA -> logistica.orden_compra_pedido_cotiza  (3 col)
INSERT INTO "logistica"."orden_compra_pedido_cotiza" ("codi_orde_comp", "codi_docu", "codi_tipo_docu")
SELECT
       NULLIF(rtrim("codi_orde_comp"::text), '')::varchar(10) AS "codi_orde_comp",
       NULLIF(rtrim("codi_docu"::text), '')::varchar(10) AS "codi_docu",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu"
FROM "legacy_raw"."orden_compra_pedido_cotiza"
ON CONFLICT DO NOTHING;

-- ORDEN_DE_COMPRA -> logistica.orden_de_compra  (65 col)
INSERT INTO "logistica"."orden_de_compra" ("codi_orde_comp", "codi_clie_prov", "fecha", "estado", "codi_mone", "importe", "codi_unid_oper_soli", "codi_unid_oper_dest", "cond_pago", "fech_entr", "luga_entr", "codi_unid_medi", "tiem_plaz_cred", "atencion", "nro_coti", "tipo_desc", "descuento", "sub_tota", "codi_tipo_docu_cont", "igv", "rent_cuar_cate", "ies", "total", "pedi_trab", "detraccion", "tota_detr", "nro_orde_comp", "contab", "tipo_gene", "obse_1", "obse_2", "obse_3", "obse_4", "obse_5", "obse_6", "obse_7", "obse_8", "obse_9", "obse_10", "valo_vent", "nro_guia", "nro_fact", "afec_rete", "hech_por", "modi_por", "auto_por", "soli_por", "nro_pres", "desc_cond_pago", "nro_seri", "codi_alma", "otro_no_afec", "codi_bien_serv", "porc_detra", "apro_por", "codi_ofi", "anulado", "motivo", "fech_docu_cont", "anio", "factor", "nro_comp", "codi_trans", "dias", "codi_luga")
SELECT
       NULLIF(rtrim("codi_orde_comp"::text), '')::varchar(10) AS "codi_orde_comp",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("importe"::text), '')::numeric(18,4) AS "importe",
       NULLIF(rtrim("codi_unid_oper_soli"::text), '')::varchar(5) AS "codi_unid_oper_soli",
       NULLIF(rtrim("codi_unid_oper_dest"::text), '')::varchar(5) AS "codi_unid_oper_dest",
       NULLIF(rtrim("cond_pago"::text), '')::varchar(10) AS "cond_pago",
       NULLIF(btrim("fech_entr"::text), '')::timestamp(3) AS "fech_entr",
       NULLIF(rtrim("luga_entr"::text), '')::varchar(100) AS "luga_entr",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(btrim("tiem_plaz_cred"::text), '')::bigint AS "tiem_plaz_cred",
       NULLIF(rtrim("atencion"::text), '')::varchar(100) AS "atencion",
       NULLIF(rtrim("nro_coti"::text), '')::varchar(20) AS "nro_coti",
       NULLIF(btrim("tipo_desc"::text), '')::boolean AS "tipo_desc",
       NULLIF(btrim("descuento"::text), '')::numeric(18,4) AS "descuento",
       NULLIF(btrim("sub_tota"::text), '')::numeric(18,4) AS "sub_tota",
       NULLIF(rtrim("codi_tipo_docu_cont"::text), '')::varchar(4) AS "codi_tipo_docu_cont",
       NULLIF(btrim("igv"::text), '')::numeric(18,4) AS "igv",
       NULLIF(btrim("rent_cuar_cate"::text), '')::numeric(18,4) AS "rent_cuar_cate",
       NULLIF(btrim("ies"::text), '')::numeric(18,4) AS "ies",
       NULLIF(btrim("total"::text), '')::numeric(18,4) AS "total",
       NULLIF(rtrim("pedi_trab"::text), '')::varchar(1) AS "pedi_trab",
       NULLIF(btrim("detraccion"::text), '')::boolean AS "detraccion",
       NULLIF(btrim("tota_detr"::text), '')::numeric(18,4) AS "tota_detr",
       NULLIF(rtrim("nro_orde_comp"::text), '')::varchar(10) AS "nro_orde_comp",
       NULLIF(btrim("contab"::text), '')::boolean AS "contab",
       NULLIF(rtrim("tipo_gene"::text), '')::varchar(1) AS "tipo_gene",
       NULLIF(rtrim("obse_1"::text), '')::varchar(255) AS "obse_1",
       NULLIF(rtrim("obse_2"::text), '')::varchar(250) AS "obse_2",
       NULLIF(rtrim("obse_3"::text), '')::varchar(250) AS "obse_3",
       NULLIF(rtrim("obse_4"::text), '')::varchar(250) AS "obse_4",
       NULLIF(rtrim("obse_5"::text), '')::varchar(250) AS "obse_5",
       NULLIF(rtrim("obse_6"::text), '')::varchar(250) AS "obse_6",
       NULLIF(rtrim("obse_7"::text), '')::varchar(250) AS "obse_7",
       NULLIF(rtrim("obse_8"::text), '')::varchar(250) AS "obse_8",
       NULLIF(rtrim("obse_9"::text), '')::varchar(250) AS "obse_9",
       NULLIF(rtrim("obse_10"::text), '')::varchar(250) AS "obse_10",
       NULLIF(btrim("valo_vent"::text), '')::boolean AS "valo_vent",
       NULLIF(rtrim("nro_guia"::text), '')::varchar(20) AS "nro_guia",
       NULLIF(rtrim("nro_fact"::text), '')::varchar(20) AS "nro_fact",
       NULLIF(btrim("afec_rete"::text), '')::boolean AS "afec_rete",
       NULLIF(rtrim("hech_por"::text), '')::varchar(5) AS "hech_por",
       NULLIF(rtrim("modi_por"::text), '')::varchar(5) AS "modi_por",
       NULLIF(rtrim("auto_por"::text), '')::varchar(5) AS "auto_por",
       NULLIF(rtrim("soli_por"::text), '')::varchar(5) AS "soli_por",
       NULLIF(rtrim("nro_pres"::text), '')::varchar(50) AS "nro_pres",
       NULLIF(rtrim("desc_cond_pago"::text), '')::varchar(100) AS "desc_cond_pago",
       NULLIF(rtrim("nro_seri"::text), '')::varchar(5) AS "nro_seri",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("otro_no_afec"::text), '')::bigint AS "otro_no_afec",
       NULLIF(rtrim("codi_bien_serv"::text), '')::varchar(5) AS "codi_bien_serv",
       NULLIF(btrim("porc_detra"::text), '')::numeric(12,2) AS "porc_detra",
       NULLIF(rtrim("apro_por"::text), '')::varchar(5) AS "apro_por",
       NULLIF(btrim("codi_ofi"::text), '')::bigint AS "codi_ofi",
       NULLIF(rtrim("anulado"::text), '')::varchar(1) AS "anulado",
       NULLIF(rtrim("motivo"::text), '')::varchar(255) AS "motivo",
       NULLIF(btrim("fech_docu_cont"::text), '')::timestamp(3) AS "fech_docu_cont",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(btrim("factor"::text), '')::integer AS "factor",
       NULLIF(btrim("nro_comp"::text), '')::bigint AS "nro_comp",
       NULLIF(rtrim("codi_trans"::text), '')::varchar(4) AS "codi_trans",
       NULLIF(btrim("dias"::text), '')::integer AS "dias",
       NULLIF(rtrim("codi_luga"::text), '')::varchar(2) AS "codi_luga"
FROM "legacy_raw"."orden_de_compra"
ON CONFLICT DO NOTHING;

-- ORDEN_DE_PEDIDO -> logistica.orden_de_pedido  (19 col)
INSERT INTO "logistica"."orden_de_pedido" ("codi_orde_pedi", "fech_pedi", "estado", "codi_list_requ", "observacion", "observacion_2", "observacion_3", "observacion_4", "observacion_5", "nro_orde_pedi", "pedi_trab", "codi_pers_resp", "codi_unid_oper_soli", "codi_unid_oper_dest", "motivo", "tipo_uso", "mant_acti", "prio", "codi_alma")
SELECT
       NULLIF(rtrim("codi_orde_pedi"::text), '')::varchar(10) AS "codi_orde_pedi",
       NULLIF(btrim("fech_pedi"::text), '')::timestamp(3) AS "fech_pedi",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("codi_list_requ"::text), '')::varchar(8) AS "codi_list_requ",
       NULLIF(rtrim("observacion"::text), '')::varchar(250) AS "observacion",
       NULLIF(rtrim("observacion_2"::text), '')::varchar(200) AS "observacion_2",
       NULLIF(rtrim("observacion_3"::text), '')::varchar(200) AS "observacion_3",
       NULLIF(rtrim("observacion_4"::text), '')::varchar(200) AS "observacion_4",
       NULLIF(rtrim("observacion_5"::text), '')::varchar(200) AS "observacion_5",
       NULLIF(rtrim("nro_orde_pedi"::text), '')::varchar(10) AS "nro_orde_pedi",
       NULLIF(rtrim("pedi_trab"::text), '')::varchar(1) AS "pedi_trab",
       NULLIF(rtrim("codi_pers_resp"::text), '')::varchar(5) AS "codi_pers_resp",
       NULLIF(rtrim("codi_unid_oper_soli"::text), '')::varchar(5) AS "codi_unid_oper_soli",
       NULLIF(rtrim("codi_unid_oper_dest"::text), '')::varchar(5) AS "codi_unid_oper_dest",
       NULLIF(rtrim("motivo"::text), '')::varchar(250) AS "motivo",
       NULLIF(rtrim("tipo_uso"::text), '')::varchar(1) AS "tipo_uso",
       NULLIF(rtrim("mant_acti"::text), '')::varchar(1) AS "mant_acti",
       NULLIF(btrim("prio"::text), '')::smallint AS "prio",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma"
FROM "legacy_raw"."orden_de_pedido"
ON CONFLICT DO NOTHING;

-- ORDEN_DESPACHO_COMBUSTIBLE -> logistica.orden_despacho_combustible  (9 col)
INSERT INTO "logistica"."orden_despacho_combustible" ("codi_orden_des", "nro_orden_des", "codi_orden_soli", "tipo", "fecha", "codi_mone", "codi_clie_prov", "elabora_por", "autoriza_por")
SELECT
       NULLIF(btrim("codi_orden_des"::text), '')::bigint AS "codi_orden_des",
       NULLIF(btrim("nro_orden_des"::text), '')::bigint AS "nro_orden_des",
       NULLIF(btrim("codi_orden_soli"::text), '')::bigint AS "codi_orden_soli",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("elabora_por"::text), '')::varchar(5) AS "elabora_por",
       NULLIF(rtrim("autoriza_por"::text), '')::varchar(5) AS "autoriza_por"
FROM "legacy_raw"."orden_despacho_combustible"
ON CONFLICT DO NOTHING;

-- ORDEN_DESPACHO_COMBUSTIBLE_DETA -> logistica.orden_despacho_combustible_deta  (9 col)
INSERT INTO "logistica"."orden_despacho_combustible_deta" ("codi_orden_des", "codi_deta", "codi_tracto", "codi_trans", "codi_prod", "cantidad", "precio", "importe", "valor")
SELECT
       NULLIF(btrim("codi_orden_des"::text), '')::bigint AS "codi_orden_des",
       NULLIF(btrim("codi_deta"::text), '')::bigint AS "codi_deta",
       NULLIF(rtrim("codi_tracto"::text), '')::varchar(5) AS "codi_tracto",
       NULLIF(rtrim("codi_trans"::text), '')::varchar(4) AS "codi_trans",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,2) AS "cantidad",
       NULLIF(btrim("precio"::text), '')::numeric(18,2) AS "precio",
       NULLIF(btrim("importe"::text), '')::numeric(18,2) AS "importe",
       NULLIF(btrim("valor"::text), '')::numeric(18,2) AS "valor"
FROM "legacy_raw"."orden_despacho_combustible_deta"
ON CONFLICT DO NOTHING;

-- prec_prom_inve -> logistica.prec_prom_inve  (2 col)
INSERT INTO "logistica"."prec_prom_inve" ("prod", "precio")
SELECT
       NULLIF(rtrim("prod"::text), '')::varchar(8) AS "prod",
       NULLIF(btrim("precio"::text), '')::numeric(15,4) AS "precio"
FROM "legacy_raw"."prec_prom_inve"
ON CONFLICT DO NOTHING;

-- PRESENTACION -> logistica.presentacion  (3 col)
INSERT INTO "logistica"."presentacion" ("cod_pres", "desc_pres", "um")
SELECT
       NULLIF(btrim("cod_pres"::text), '')::integer AS "cod_pres",
       NULLIF(rtrim("desc_pres"::text), '')::varchar(50) AS "desc_pres",
       NULLIF(rtrim("um"::text), '')::varchar(2) AS "um"
FROM "legacy_raw"."presentacion"
ON CONFLICT DO NOTHING;

-- PRINCIPIO_ACTIVO -> logistica.principio_activo  (2 col)
INSERT INTO "logistica"."principio_activo" ("codi_prin", "descripcion")
SELECT
       NULLIF(rtrim("codi_prin"::text), '')::varchar(3) AS "codi_prin",
       NULLIF(rtrim("descripcion"::text), '')::varchar(100) AS "descripcion"
FROM "legacy_raw"."principio_activo"
ON CONFLICT DO NOTHING;

-- PRINCIPIO_X_PRODUCTO -> logistica.principio_x_producto  (3 col)
INSERT INTO "logistica"."principio_x_producto" ("codi_prod", "sec", "codi_prin")
SELECT
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("sec"::text), '')::integer AS "sec",
       NULLIF(rtrim("codi_prin"::text), '')::varchar(3) AS "codi_prin"
FROM "legacy_raw"."principio_x_producto"
ON CONFLICT DO NOTHING;

-- PRODUCTO_ALMACEN_LOTE -> logistica.producto_almacen_lote  (17 col)
INSERT INTO "logistica"."producto_almacen_lote" ("codi_prod_alma_lote", "codi_alma", "codi_prod", "lote", "fec_vence", "stock", "ubicacion", "condicion", "situacion", "fech_vence_real", "p_arreglo", "s_arreglo", "iden", "codi_orde_comp", "correlativo", "canti_salida_venta", "fec_ingreso")
SELECT
       NULLIF(btrim("codi_prod_alma_lote"::text), '')::bigint AS "codi_prod_alma_lote",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("lote"::text), '')::varchar(30) AS "lote",
       NULLIF(btrim("fec_vence"::text), '')::timestamp(3) AS "fec_vence",
       NULLIF(btrim("stock"::text), '')::numeric(18,2) AS "stock",
       NULLIF(rtrim("ubicacion"::text), '')::varchar(50) AS "ubicacion",
       NULLIF(rtrim("condicion"::text), '')::varchar(1) AS "condicion",
       NULLIF(btrim("situacion"::text), '')::integer AS "situacion",
       NULLIF(btrim("fech_vence_real"::text), '')::timestamp(3) AS "fech_vence_real",
       NULLIF(rtrim("p_arreglo"::text), '')::varchar(255) AS "p_arreglo",
       NULLIF(rtrim("s_arreglo"::text), '')::varchar(255) AS "s_arreglo",
       NULLIF(rtrim("iden"::text), '')::varchar(50) AS "iden",
       NULLIF(rtrim("codi_orde_comp"::text), '')::varchar(10) AS "codi_orde_comp",
       NULLIF(btrim("correlativo"::text), '')::integer AS "correlativo",
       NULLIF(btrim("canti_salida_venta"::text), '')::numeric(18,2) AS "canti_salida_venta",
       NULLIF(btrim("fec_ingreso"::text), '')::timestamp(3) AS "fec_ingreso"
FROM "legacy_raw"."producto_almacen_lote"
ON CONFLICT DO NOTHING;

-- PRODUCTO_ALMACEN_LOTE_PEDIDO -> logistica.producto_almacen_lote_pedido  (12 col)
INSERT INTO "logistica"."producto_almacen_lote_pedido" ("id", "codi_prod_alma_lote", "codi_alma", "codi_prod", "lote", "fec_vence", "stock", "ubicacion", "condicion", "situacion", "codi_orden_pedi", "canti_salida_venta")
SELECT
       NULLIF(btrim("id"::text), '')::bigint AS "id",
       NULLIF(btrim("codi_prod_alma_lote"::text), '')::bigint AS "codi_prod_alma_lote",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("lote"::text), '')::varchar(30) AS "lote",
       NULLIF(btrim("fec_vence"::text), '')::timestamp(3) AS "fec_vence",
       NULLIF(btrim("stock"::text), '')::numeric(18,2) AS "stock",
       NULLIF(rtrim("ubicacion"::text), '')::varchar(50) AS "ubicacion",
       NULLIF(rtrim("condicion"::text), '')::varchar(1) AS "condicion",
       NULLIF(btrim("situacion"::text), '')::integer AS "situacion",
       NULLIF(btrim("codi_orden_pedi"::text), '')::integer AS "codi_orden_pedi",
       NULLIF(btrim("canti_salida_venta"::text), '')::numeric(18,2) AS "canti_salida_venta"
FROM "legacy_raw"."producto_almacen_lote_pedido"
ON CONFLICT DO NOTHING;

-- PRODUCTOS -> logistica.productos  (41 col)
INSERT INTO "logistica"."productos" ("codi_prod", "desc_prod", "codi_sub_fami_prod", "codi_unid_medi", "codi_mone", "prec_prom", "stock", "stoc_mini", "stoc_maxi", "punt_repe", "fech_venc", "esta_prod", "stoc_temp", "ubicacion", "nro_cuen", "iqf", "porc_detr", "poli_prec", "exonerado", "prec_list_1", "prec_list_2", "cost_prod", "analisis", "material", "codi_clie_prov", "cod_pres", "fec_registro", "prec_prov", "descto_compra", "descto_porcenta", "cod_impuesto", "tcambio", "nro_decim_precio", "costo_oper", "codi_aux", "id_tipocomi", "codi_tipo_exis", "peso", "rotacion", "codi_prod_sunat", "esta_acti")
SELECT
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("desc_prod"::text), '')::varchar(150) AS "desc_prod",
       NULLIF(rtrim("codi_sub_fami_prod"::text), '')::varchar(4) AS "codi_sub_fami_prod",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("prec_prom"::text), '')::numeric(14,2) AS "prec_prom",
       NULLIF(btrim("stock"::text), '')::numeric(9,2) AS "stock",
       NULLIF(btrim("stoc_mini"::text), '')::numeric(9,2) AS "stoc_mini",
       NULLIF(btrim("stoc_maxi"::text), '')::numeric(9,2) AS "stoc_maxi",
       NULLIF(btrim("punt_repe"::text), '')::numeric(9,2) AS "punt_repe",
       NULLIF(btrim("fech_venc"::text), '')::timestamp(3) AS "fech_venc",
       NULLIF(rtrim("esta_prod"::text), '')::varchar(25) AS "esta_prod",
       NULLIF(btrim("stoc_temp"::text), '')::numeric(9,2) AS "stoc_temp",
       NULLIF(rtrim("ubicacion"::text), '')::varchar(50) AS "ubicacion",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(btrim("iqf"::text), '')::boolean AS "iqf",
       NULLIF(btrim("porc_detr"::text), '')::numeric(15,4) AS "porc_detr",
       NULLIF(btrim("poli_prec"::text), '')::numeric(18,4) AS "poli_prec",
       NULLIF(rtrim("exonerado"::text), '')::varchar(1) AS "exonerado",
       NULLIF(btrim("prec_list_1"::text), '')::numeric(15,4) AS "prec_list_1",
       NULLIF(btrim("prec_list_2"::text), '')::numeric(15,4) AS "prec_list_2",
       NULLIF(btrim("cost_prod"::text), '')::numeric(15,4) AS "cost_prod",
       NULLIF(btrim("analisis"::text), '')::smallint AS "analisis",
       NULLIF(btrim("material"::text), '')::smallint AS "material",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("cod_pres"::text), '')::integer AS "cod_pres",
       NULLIF(btrim("fec_registro"::text), '')::timestamp(3) AS "fec_registro",
       NULLIF(btrim("prec_prov"::text), '')::numeric(19,4) AS "prec_prov",
       NULLIF(btrim("descto_compra"::text), '')::numeric(19,4) AS "descto_compra",
       NULLIF(btrim("descto_porcenta"::text), '')::numeric(19,4) AS "descto_porcenta",
       NULLIF(btrim("cod_impuesto"::text), '')::integer AS "cod_impuesto",
       NULLIF(btrim("tcambio"::text), '')::numeric(9,3) AS "tcambio",
       NULLIF(btrim("nro_decim_precio"::text), '')::integer AS "nro_decim_precio",
       NULLIF(btrim("costo_oper"::text), '')::numeric(18,2) AS "costo_oper",
       NULLIF(rtrim("codi_aux"::text), '')::varchar(8) AS "codi_aux",
       NULLIF(btrim("id_tipocomi"::text), '')::integer AS "id_tipocomi",
       NULLIF(rtrim("codi_tipo_exis"::text), '')::varchar(2) AS "codi_tipo_exis",
       NULLIF(btrim("peso"::text), '')::numeric(18,3) AS "peso",
       NULLIF(btrim("rotacion"::text), '')::integer AS "rotacion",
       NULLIF(rtrim("codi_prod_sunat"::text), '')::varchar(8) AS "codi_prod_sunat",
       NULLIF(rtrim("esta_acti"::text), '')::varchar(1) AS "esta_acti"
FROM "legacy_raw"."productos"
ON CONFLICT DO NOTHING;

-- PRODUCTOS_BAJA -> logistica.productos_baja  (3 col)
INSERT INTO "logistica"."productos_baja" ("id_ven", "codi_prod", "codi_rota")
SELECT
       NULLIF(btrim("id_ven"::text), '')::integer AS "id_ven",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("codi_rota"::text), '')::bigint AS "codi_rota"
FROM "legacy_raw"."productos_baja"
ON CONFLICT DO NOTHING;

-- PRODUCTOS_BAJA_ROTACION -> logistica.productos_baja_rotacion  (2 col)
INSERT INTO "logistica"."productos_baja_rotacion" ("codi_rota", "descripcion")
SELECT
       NULLIF(btrim("codi_rota"::text), '')::bigint AS "codi_rota",
       NULLIF(rtrim("descripcion"::text), '')::varchar(150) AS "descripcion"
FROM "legacy_raw"."productos_baja_rotacion"
ON CONFLICT DO NOTHING;

-- PRODUCTOS_EVENTOS -> logistica.productos_eventos  (7 col)
INSERT INTO "logistica"."productos_eventos" ("codi_prod", "codi_alma", "fecha", "evento", "tipo", "hecho_por", "activo")
SELECT
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("evento"::text), '')::varchar(255) AS "evento",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo",
       NULLIF(rtrim("hecho_por"::text), '')::varchar(5) AS "hecho_por",
       NULLIF(rtrim("activo"::text), '')::varchar(1) AS "activo"
FROM "legacy_raw"."productos_eventos"
ON CONFLICT DO NOTHING;

-- PRODUCTOS_LOTES_INGRE_SALI -> logistica.productos_lotes_ingre_sali  (5 col)
INSERT INTO "logistica"."productos_lotes_ingre_sali" ("codi_deta_ingre_sali", "codi_prod_alma_lote", "cantidad", "io", "codi_ingr_sali")
SELECT
       NULLIF(rtrim("codi_deta_ingre_sali"::text), '')::varchar(12) AS "codi_deta_ingre_sali",
       NULLIF(btrim("codi_prod_alma_lote"::text), '')::bigint AS "codi_prod_alma_lote",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,2) AS "cantidad",
       NULLIF(btrim("io"::text), '')::integer AS "io",
       NULLIF(rtrim("codi_ingr_sali"::text), '')::varchar(10) AS "codi_ingr_sali"
FROM "legacy_raw"."productos_lotes_ingre_sali"
ON CONFLICT DO NOTHING;

-- PRODUCTOS_LOTES_NOTA_VENTA -> logistica.productos_lotes_nota_venta  (4 col)
INSERT INTO "logistica"."productos_lotes_nota_venta" ("codi_deta_ingre_sali", "codi_prod_alma_lote", "cantidad", "codi_nota_venta")
SELECT
       NULLIF(rtrim("codi_deta_ingre_sali"::text), '')::varchar(12) AS "codi_deta_ingre_sali",
       NULLIF(btrim("codi_prod_alma_lote"::text), '')::bigint AS "codi_prod_alma_lote",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,2) AS "cantidad",
       NULLIF(btrim("codi_nota_venta"::text), '')::bigint AS "codi_nota_venta"
FROM "legacy_raw"."productos_lotes_nota_venta"
ON CONFLICT DO NOTHING;

-- PRODUCTOS_LOTES_VALE_CRED -> logistica.productos_lotes_vale_cred  (4 col)
INSERT INTO "logistica"."productos_lotes_vale_cred" ("codi_deta_ingre_sali", "codi_prod_alma_lote", "cantidad", "codi_vale")
SELECT
       NULLIF(rtrim("codi_deta_ingre_sali"::text), '')::varchar(12) AS "codi_deta_ingre_sali",
       NULLIF(btrim("codi_prod_alma_lote"::text), '')::bigint AS "codi_prod_alma_lote",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,2) AS "cantidad",
       NULLIF(btrim("codi_vale"::text), '')::bigint AS "codi_vale"
FROM "legacy_raw"."productos_lotes_vale_cred"
ON CONFLICT DO NOTHING;

-- PRODUCTOS_MATRIZ -> logistica.productos_matriz  (4 col)
INSERT INTO "logistica"."productos_matriz" ("id_mat", "codi_prod", "codi_rota", "fecha")
SELECT
       NULLIF(btrim("id_mat"::text), '')::bigint AS "id_mat",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("codi_rota"::text), '')::bigint AS "codi_rota",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha"
FROM "legacy_raw"."productos_matriz"
ON CONFLICT DO NOTHING;

-- PRODUCTOS_PRECIO -> logistica.productos_precio  (4 col)
INSERT INTO "logistica"."productos_precio" ("codi_item", "codi_deta_nota_ingr", "codi_prod", "precio")
SELECT
       NULLIF(btrim("codi_item"::text), '')::bigint AS "codi_item",
       NULLIF(rtrim("codi_deta_nota_ingr"::text), '')::varchar(12) AS "codi_deta_nota_ingr",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("precio"::text), '')::numeric(18,4) AS "precio"
FROM "legacy_raw"."productos_precio"
ON CONFLICT DO NOTHING;

-- PRODUCTOS_SIN_VENTA -> logistica.productos_sin_venta  (10 col)
INSERT INTO "logistica"."productos_sin_venta" ("fecha", "codi_prod", "desc_prod", "codi_alma", "ultimaventa", "plazo", "diassinventa", "observaciones", "codi_usua", "creacion")
SELECT
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("desc_prod"::text), '')::varchar(150) AS "desc_prod",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("ultimaventa"::text), '')::timestamp(3) AS "ultimaventa",
       NULLIF(btrim("plazo"::text), '')::timestamp(3) AS "plazo",
       NULLIF(btrim("diassinventa"::text), '')::bigint AS "diassinventa",
       NULLIF(rtrim("observaciones"::text), '')::varchar(255) AS "observaciones",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(btrim("creacion"::text), '')::timestamp(3) AS "creacion"
FROM "legacy_raw"."productos_sin_venta"
ON CONFLICT DO NOTHING;

-- PROVEEDOR_PRODUCTOS -> logistica.proveedor_productos  (2 col)
INSERT INTO "logistica"."proveedor_productos" ("codi_clie_prov", "codi_fami_prod")
SELECT
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_fami_prod"::text), '')::varchar(2) AS "codi_fami_prod"
FROM "legacy_raw"."proveedor_productos"
ON CONFLICT DO NOTHING;

-- PROYECTO -> logistica.proyecto  (3 col)
INSERT INTO "logistica"."proyecto" ("codi_proy", "desc_proy", "fech_proy")
SELECT
       NULLIF(rtrim("codi_proy"::text), '')::varchar(10) AS "codi_proy",
       NULLIF(rtrim("desc_proy"::text), '')::varchar(100) AS "desc_proy",
       NULLIF(btrim("fech_proy"::text), '')::timestamp(3) AS "fech_proy"
FROM "legacy_raw"."proyecto"
ON CONFLICT DO NOTHING;

-- REGISTRO_ORDEN_PEDIDO -> logistica.registro_orden_pedido  (14 col)
INSERT INTO "logistica"."registro_orden_pedido" ("codi_orden_pedi", "codi_pers_resp", "codi_unid_oper_soli", "codi_unid_oper_dest", "motivo", "observacion", "codi_guia", "fecha", "estado", "envio", "apro_por", "libe_por", "codi_alma_orig", "super_por")
SELECT
       NULLIF(btrim("codi_orden_pedi"::text), '')::bigint AS "codi_orden_pedi",
       NULLIF(rtrim("codi_pers_resp"::text), '')::varchar(5) AS "codi_pers_resp",
       NULLIF(rtrim("codi_unid_oper_soli"::text), '')::varchar(2) AS "codi_unid_oper_soli",
       NULLIF(rtrim("codi_unid_oper_dest"::text), '')::varchar(2) AS "codi_unid_oper_dest",
       NULLIF(rtrim("motivo"::text), '')::varchar(250) AS "motivo",
       NULLIF(rtrim("observacion"::text), '')::text AS "observacion",
       NULLIF(btrim("codi_guia"::text), '')::bigint AS "codi_guia",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("envio"::text), '')::varchar(1) AS "envio",
       NULLIF(rtrim("apro_por"::text), '')::varchar(5) AS "apro_por",
       NULLIF(rtrim("libe_por"::text), '')::varchar(5) AS "libe_por",
       NULLIF(rtrim("codi_alma_orig"::text), '')::varchar(2) AS "codi_alma_orig",
       NULLIF(rtrim("super_por"::text), '')::varchar(5) AS "super_por"
FROM "legacy_raw"."registro_orden_pedido"
ON CONFLICT DO NOTHING;

-- REGISTRO_ORDEN_PEDIDO_DETA -> logistica.registro_orden_pedido_deta  (5 col)
INSERT INTO "logistica"."registro_orden_pedido_deta" ("codi_orden_pedi", "codi_deta", "codi_prod", "cantidad", "cantidad_aux")
SELECT
       NULLIF(btrim("codi_orden_pedi"::text), '')::bigint AS "codi_orden_pedi",
       NULLIF(btrim("codi_deta"::text), '')::integer AS "codi_deta",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,3) AS "cantidad",
       NULLIF(btrim("cantidad_aux"::text), '')::numeric(12,2) AS "cantidad_aux"
FROM "legacy_raw"."registro_orden_pedido_deta"
ON CONFLICT DO NOTHING;

-- REGISTRO_PRODUCTO -> logistica.registro_producto  (6 col)
INSERT INTO "logistica"."registro_producto" ("codi_regi_prod", "cultivo", "area", "codi_alma", "cod_zona", "cod_cultivo")
SELECT
       NULLIF(btrim("codi_regi_prod"::text), '')::bigint AS "codi_regi_prod",
       NULLIF(rtrim("cultivo"::text), '')::varchar(250) AS "cultivo",
       NULLIF(rtrim("area"::text), '')::varchar(250) AS "area",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("cod_zona"::text), '')::bigint AS "cod_zona",
       NULLIF(btrim("cod_cultivo"::text), '')::integer AS "cod_cultivo"
FROM "legacy_raw"."registro_producto"
ON CONFLICT DO NOTHING;

-- REGISTRO_PRODUCTO_DETA -> logistica.registro_producto_deta  (19 col)
INSERT INTO "logistica"."registro_producto_deta" ("codi_regi_prod", "codi_deta", "codi_prod", "cantidad", "q1_1", "q2_1", "q1_2", "q2_2", "q1_3", "q2_3", "q1_4", "q2_4", "q1_5", "q2_5", "q1_6", "q2_6", "nro_diacult", "cod_eta", "enfermedades")
SELECT
       NULLIF(btrim("codi_regi_prod"::text), '')::bigint AS "codi_regi_prod",
       NULLIF(btrim("codi_deta"::text), '')::integer AS "codi_deta",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,3) AS "cantidad",
       NULLIF(btrim("q1_1"::text), '')::numeric(18,3) AS "q1_1",
       NULLIF(btrim("q2_1"::text), '')::numeric(18,3) AS "q2_1",
       NULLIF(btrim("q1_2"::text), '')::numeric(18,3) AS "q1_2",
       NULLIF(btrim("q2_2"::text), '')::numeric(18,3) AS "q2_2",
       NULLIF(btrim("q1_3"::text), '')::numeric(18,3) AS "q1_3",
       NULLIF(btrim("q2_3"::text), '')::numeric(18,3) AS "q2_3",
       NULLIF(btrim("q1_4"::text), '')::numeric(18,3) AS "q1_4",
       NULLIF(btrim("q2_4"::text), '')::numeric(18,3) AS "q2_4",
       NULLIF(btrim("q1_5"::text), '')::numeric(18,3) AS "q1_5",
       NULLIF(btrim("q2_5"::text), '')::numeric(18,3) AS "q2_5",
       NULLIF(btrim("q1_6"::text), '')::numeric(18,3) AS "q1_6",
       NULLIF(btrim("q2_6"::text), '')::numeric(18,3) AS "q2_6",
       NULLIF(btrim("nro_diacult"::text), '')::integer AS "nro_diacult",
       NULLIF(btrim("cod_eta"::text), '')::bigint AS "cod_eta",
       NULLIF(rtrim("enfermedades"::text), '')::varchar(150) AS "enfermedades"
FROM "legacy_raw"."registro_producto_deta"
ON CONFLICT DO NOTHING;

-- SALI_MATE_X_DOCU_SALI -> logistica.sali_mate_x_docu_sali  (3 col)
INSERT INTO "logistica"."sali_mate_x_docu_sali" ("codi_docu_sali_mate", "codi_docu_sali", "tipo_docu_orig_sali")
SELECT
       NULLIF(rtrim("codi_docu_sali_mate"::text), '')::varchar(10) AS "codi_docu_sali_mate",
       NULLIF(rtrim("codi_docu_sali"::text), '')::varchar(10) AS "codi_docu_sali",
       NULLIF(rtrim("tipo_docu_orig_sali"::text), '')::varchar(2) AS "tipo_docu_orig_sali"
FROM "legacy_raw"."sali_mate_x_docu_sali"
ON CONFLICT DO NOTHING;

-- SALI_MATE_X_PROY -> logistica.sali_mate_x_proy  (2 col)
INSERT INTO "logistica"."sali_mate_x_proy" ("codi_docu_sali", "codi_proy")
SELECT
       NULLIF(rtrim("codi_docu_sali"::text), '')::varchar(10) AS "codi_docu_sali",
       NULLIF(rtrim("codi_proy"::text), '')::varchar(10) AS "codi_proy"
FROM "legacy_raw"."sali_mate_x_proy"
ON CONFLICT DO NOTHING;

-- SALIDA_MATERIAL -> logistica.salida_material  (59 col)
INSERT INTO "logistica"."salida_material" ("codi_docu_sali", "nro_seri", "nro_docu_sali", "codi_tipo_docu", "fech_emis", "fech_inic_tras", "codi_domi_part", "domi_part_dist", "domi_part_prov", "domi_part_depa", "domi_part_dire", "dest_codi_clie_prov", "dest_apel_o_razo_soci", "dest_dire", "dest_iden", "dest_tipo_docu_iden", "codi_domi_lleg", "domi_lleg_dist", "domi_lleg_prov", "domi_lleg_depa", "domi_lleg_dire", "codi_unid_tran", "codi_trans", "codi_tipo_docu_comp_pago", "comp_pago_seri", "comp_pago_nro", "codi_moti_tras", "moti_tras_desc", "codi_mone_cost", "cost_mini", "codi_unid_medi_peso", "peso_tota", "estado", "tipo_gene", "codi_pers_emit_guia", "codi_pers_reci_guia", "apel_1_reci_guia", "apel_2_reci_guia", "nomb_1_reci_guia", "nomb_2_reci_guia", "codi_unid_oper_rece", "observacion", "moti_sali", "apel_1_chof", "apel_2_chof", "nomb_1_chof", "nomb_2_chof", "lice_cond_chof", "dni_chof", "con_reto", "indi_reto", "indi_devo_mate_emba", "cimt", "codi_alma", "marca_transpo", "nro_placa_transpo", "empre_trans_razo_soci", "empre_trans_ruc", "empre_trans_domici")
SELECT
       NULLIF(rtrim("codi_docu_sali"::text), '')::varchar(10) AS "codi_docu_sali",
       NULLIF(rtrim("nro_seri"::text), '')::varchar(3) AS "nro_seri",
       NULLIF(rtrim("nro_docu_sali"::text), '')::varchar(7) AS "nro_docu_sali",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(btrim("fech_emis"::text), '')::timestamp(3) AS "fech_emis",
       NULLIF(btrim("fech_inic_tras"::text), '')::timestamp(3) AS "fech_inic_tras",
       NULLIF(rtrim("codi_domi_part"::text), '')::varchar(4) AS "codi_domi_part",
       NULLIF(rtrim("domi_part_dist"::text), '')::varchar(30) AS "domi_part_dist",
       NULLIF(rtrim("domi_part_prov"::text), '')::varchar(30) AS "domi_part_prov",
       NULLIF(rtrim("domi_part_depa"::text), '')::varchar(30) AS "domi_part_depa",
       NULLIF(rtrim("domi_part_dire"::text), '')::varchar(200) AS "domi_part_dire",
       NULLIF(rtrim("dest_codi_clie_prov"::text), '')::varchar(5) AS "dest_codi_clie_prov",
       NULLIF(rtrim("dest_apel_o_razo_soci"::text), '')::varchar(200) AS "dest_apel_o_razo_soci",
       NULLIF(rtrim("dest_dire"::text), '')::varchar(200) AS "dest_dire",
       NULLIF(rtrim("dest_iden"::text), '')::varchar(15) AS "dest_iden",
       NULLIF(rtrim("dest_tipo_docu_iden"::text), '')::varchar(4) AS "dest_tipo_docu_iden",
       NULLIF(rtrim("codi_domi_lleg"::text), '')::varchar(4) AS "codi_domi_lleg",
       NULLIF(rtrim("domi_lleg_dist"::text), '')::varchar(30) AS "domi_lleg_dist",
       NULLIF(rtrim("domi_lleg_prov"::text), '')::varchar(30) AS "domi_lleg_prov",
       NULLIF(rtrim("domi_lleg_depa"::text), '')::varchar(30) AS "domi_lleg_depa",
       NULLIF(rtrim("domi_lleg_dire"::text), '')::varchar(200) AS "domi_lleg_dire",
       NULLIF(rtrim("codi_unid_tran"::text), '')::varchar(4) AS "codi_unid_tran",
       NULLIF(rtrim("codi_trans"::text), '')::varchar(4) AS "codi_trans",
       NULLIF(rtrim("codi_tipo_docu_comp_pago"::text), '')::varchar(4) AS "codi_tipo_docu_comp_pago",
       NULLIF(rtrim("comp_pago_seri"::text), '')::varchar(5) AS "comp_pago_seri",
       NULLIF(rtrim("comp_pago_nro"::text), '')::varchar(15) AS "comp_pago_nro",
       NULLIF(rtrim("codi_moti_tras"::text), '')::varchar(2) AS "codi_moti_tras",
       NULLIF(rtrim("moti_tras_desc"::text), '')::varchar(200) AS "moti_tras_desc",
       NULLIF(rtrim("codi_mone_cost"::text), '')::varchar(2) AS "codi_mone_cost",
       NULLIF(btrim("cost_mini"::text), '')::numeric(15,4) AS "cost_mini",
       NULLIF(rtrim("codi_unid_medi_peso"::text), '')::varchar(4) AS "codi_unid_medi_peso",
       NULLIF(btrim("peso_tota"::text), '')::numeric(15,4) AS "peso_tota",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("tipo_gene"::text), '')::varchar(1) AS "tipo_gene",
       NULLIF(rtrim("codi_pers_emit_guia"::text), '')::varchar(5) AS "codi_pers_emit_guia",
       NULLIF(rtrim("codi_pers_reci_guia"::text), '')::varchar(5) AS "codi_pers_reci_guia",
       NULLIF(rtrim("apel_1_reci_guia"::text), '')::varchar(50) AS "apel_1_reci_guia",
       NULLIF(rtrim("apel_2_reci_guia"::text), '')::varchar(50) AS "apel_2_reci_guia",
       NULLIF(rtrim("nomb_1_reci_guia"::text), '')::varchar(50) AS "nomb_1_reci_guia",
       NULLIF(rtrim("nomb_2_reci_guia"::text), '')::varchar(50) AS "nomb_2_reci_guia",
       NULLIF(rtrim("codi_unid_oper_rece"::text), '')::varchar(5) AS "codi_unid_oper_rece",
       NULLIF(rtrim("observacion"::text), '')::varchar(200) AS "observacion",
       NULLIF(rtrim("moti_sali"::text), '')::varchar(200) AS "moti_sali",
       NULLIF(rtrim("apel_1_chof"::text), '')::varchar(30) AS "apel_1_chof",
       NULLIF(rtrim("apel_2_chof"::text), '')::varchar(30) AS "apel_2_chof",
       NULLIF(rtrim("nomb_1_chof"::text), '')::varchar(30) AS "nomb_1_chof",
       NULLIF(rtrim("nomb_2_chof"::text), '')::varchar(30) AS "nomb_2_chof",
       NULLIF(rtrim("lice_cond_chof"::text), '')::varchar(20) AS "lice_cond_chof",
       NULLIF(rtrim("dni_chof"::text), '')::varchar(20) AS "dni_chof",
       NULLIF(rtrim("con_reto"::text), '')::varchar(1) AS "con_reto",
       NULLIF(rtrim("indi_reto"::text), '')::varchar(1) AS "indi_reto",
       NULLIF(rtrim("indi_devo_mate_emba"::text), '')::varchar(1) AS "indi_devo_mate_emba",
       NULLIF(rtrim("cimt"::text), '')::varchar(20) AS "cimt",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("marca_transpo"::text), '')::varchar(20) AS "marca_transpo",
       NULLIF(rtrim("nro_placa_transpo"::text), '')::varchar(20) AS "nro_placa_transpo",
       NULLIF(rtrim("empre_trans_razo_soci"::text), '')::varchar(50) AS "empre_trans_razo_soci",
       NULLIF(rtrim("empre_trans_ruc"::text), '')::varchar(15) AS "empre_trans_ruc",
       NULLIF(rtrim("empre_trans_domici"::text), '')::varchar(50) AS "empre_trans_domici"
FROM "legacy_raw"."salida_material"
ON CONFLICT DO NOTHING;

-- SUB_FAMILIA_PRODUCTO -> logistica.sub_familia_producto  (4 col)
INSERT INTO "logistica"."sub_familia_producto" ("codi_sub_fami_prod", "desc_sub_fami_prod", "codi_fami_prod", "poli_prec_adic")
SELECT
       NULLIF(rtrim("codi_sub_fami_prod"::text), '')::varchar(4) AS "codi_sub_fami_prod",
       NULLIF(rtrim("desc_sub_fami_prod"::text), '')::varchar(100) AS "desc_sub_fami_prod",
       NULLIF(rtrim("codi_fami_prod"::text), '')::varchar(2) AS "codi_fami_prod",
       NULLIF(btrim("poli_prec_adic"::text), '')::numeric(9,4) AS "poli_prec_adic"
FROM "legacy_raw"."sub_familia_producto"
ON CONFLICT DO NOTHING;

-- TIPO_ACEPTACION -> logistica.tipo_aceptacion  (3 col)
INSERT INTO "logistica"."tipo_aceptacion" ("codi_tipo_acep", "desc_acep_requ", "nemo")
SELECT
       NULLIF(rtrim("codi_tipo_acep"::text), '')::varchar(2) AS "codi_tipo_acep",
       NULLIF(rtrim("desc_acep_requ"::text), '')::varchar(50) AS "desc_acep_requ",
       NULLIF(rtrim("nemo"::text), '')::varchar(4) AS "nemo"
FROM "legacy_raw"."tipo_aceptacion"
ON CONFLICT DO NOTHING;

-- TIPO_ENVASES -> logistica.tipo_envases  (2 col)
INSERT INTO "logistica"."tipo_envases" ("codi_tipo_enva", "desc_emva")
SELECT
       NULLIF(btrim("codi_tipo_enva"::text), '')::smallint AS "codi_tipo_enva",
       NULLIF(rtrim("desc_emva"::text), '')::varchar(50) AS "desc_emva"
FROM "legacy_raw"."tipo_envases"
ON CONFLICT DO NOTHING;

-- TIPO_EXISTENCIA -> logistica.tipo_existencia  (4 col)
INSERT INTO "logistica"."tipo_existencia" ("codi_tipo_exis", "codi_sunat", "desc_tipo_exis", "nemo")
SELECT
       NULLIF(rtrim("codi_tipo_exis"::text), '')::varchar(2) AS "codi_tipo_exis",
       NULLIF(rtrim("codi_sunat"::text), '')::varchar(2) AS "codi_sunat",
       NULLIF(rtrim("desc_tipo_exis"::text), '')::varchar(100) AS "desc_tipo_exis",
       NULLIF(rtrim("nemo"::text), '')::varchar(30) AS "nemo"
FROM "legacy_raw"."tipo_existencia"
ON CONFLICT DO NOTHING;

-- TIPO_INGR_SALI -> logistica.tipo_ingr_sali  (8 col)
INSERT INTO "logistica"."tipo_ingr_sali" ("codi_tipo_is", "desc_tipo_is", "nemo_tipo_is", "i_s", "codi_sunat_moti_tras", "desc_sunat_moti_tras", "contabilizar", "nro_cuen")
SELECT
       NULLIF(rtrim("codi_tipo_is"::text), '')::varchar(2) AS "codi_tipo_is",
       NULLIF(rtrim("desc_tipo_is"::text), '')::varchar(100) AS "desc_tipo_is",
       NULLIF(rtrim("nemo_tipo_is"::text), '')::varchar(15) AS "nemo_tipo_is",
       NULLIF(rtrim("i_s"::text), '')::varchar(1) AS "i_s",
       NULLIF(rtrim("codi_sunat_moti_tras"::text), '')::varchar(2) AS "codi_sunat_moti_tras",
       NULLIF(rtrim("desc_sunat_moti_tras"::text), '')::varchar(50) AS "desc_sunat_moti_tras",
       NULLIF(btrim("contabilizar"::text), '')::smallint AS "contabilizar",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen"
FROM "legacy_raw"."tipo_ingr_sali"
ON CONFLICT DO NOTHING;

-- UNID_OPER_DIVI -> logistica.unid_oper_divi  (3 col)
INSERT INTO "logistica"."unid_oper_divi" ("codi_divi_unid_oper", "desc_divi_unid_oper", "codi_tipo_unid_oper")
SELECT
       NULLIF(rtrim("codi_divi_unid_oper"::text), '')::varchar(3) AS "codi_divi_unid_oper",
       NULLIF(rtrim("desc_divi_unid_oper"::text), '')::varchar(200) AS "desc_divi_unid_oper",
       NULLIF(rtrim("codi_tipo_unid_oper"::text), '')::varchar(2) AS "codi_tipo_unid_oper"
FROM "legacy_raw"."unid_oper_divi"
ON CONFLICT DO NOTHING;

-- VALE_SALIDA -> logistica.vale_salida  (27 col)
INSERT INTO "logistica"."vale_salida" ("codi_sali", "codi_alma", "nro_vale", "fecha", "codi_mone", "codi_tipo_docu", "serie", "numero", "codi_clie_prov", "codi_moti_tras", "tpc", "observacion", "codi_alma_dest", "codi_pers", "correlativo", "codi_orde", "anulado", "subt", "igv", "total", "transporte", "placa", "prov_dest", "chofer", "periodo", "indice_rela", "procedencia")
SELECT
       NULLIF(btrim("codi_sali"::text), '')::bigint AS "codi_sali",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("nro_vale"::text), '')::bigint AS "nro_vale",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("serie"::text), '')::varchar(3) AS "serie",
       NULLIF(rtrim("numero"::text), '')::varchar(10) AS "numero",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_moti_tras"::text), '')::varchar(2) AS "codi_moti_tras",
       NULLIF(btrim("tpc"::text), '')::numeric(18,4) AS "tpc",
       NULLIF(rtrim("observacion"::text), '')::varchar(250) AS "observacion",
       NULLIF(rtrim("codi_alma_dest"::text), '')::varchar(2) AS "codi_alma_dest",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("correlativo"::text), '')::bigint AS "correlativo",
       NULLIF(btrim("codi_orde"::text), '')::bigint AS "codi_orde",
       NULLIF(rtrim("anulado"::text), '')::varchar(1) AS "anulado",
       NULLIF(btrim("subt"::text), '')::numeric(18,2) AS "subt",
       NULLIF(btrim("igv"::text), '')::numeric(18,2) AS "igv",
       NULLIF(btrim("total"::text), '')::numeric(18,2) AS "total",
       NULLIF(rtrim("transporte"::text), '')::varchar(5) AS "transporte",
       NULLIF(rtrim("placa"::text), '')::varchar(10) AS "placa",
       NULLIF(rtrim("prov_dest"::text), '')::varchar(5) AS "prov_dest",
       NULLIF(rtrim("chofer"::text), '')::varchar(4) AS "chofer",
       NULLIF(rtrim("periodo"::text), '')::varchar(4) AS "periodo",
       NULLIF(btrim("indice_rela"::text), '')::bigint AS "indice_rela",
       NULLIF(rtrim("procedencia"::text), '')::varchar(3) AS "procedencia"
FROM "legacy_raw"."vale_salida"
ON CONFLICT DO NOTHING;

-- reajuste de secuencias de identidad del legado
SELECT setval(pg_get_serial_sequence('"logistica"."almacen_doc_regularizar"', 'idd_sec'),
              (SELECT COALESCE(MAX("idd_sec"), 1) FROM "logistica"."almacen_doc_regularizar"),
              (SELECT COUNT(*) > 0 FROM "logistica"."almacen_doc_regularizar"));
SELECT setval(pg_get_serial_sequence('"logistica"."principio_x_producto"', 'sec'),
              (SELECT COALESCE(MAX("sec"), 1) FROM "logistica"."principio_x_producto"),
              (SELECT COUNT(*) > 0 FROM "logistica"."principio_x_producto"));
SELECT setval(pg_get_serial_sequence('"logistica"."producto_almacen_lote"', 'codi_prod_alma_lote'),
              (SELECT COALESCE(MAX("codi_prod_alma_lote"), 1) FROM "logistica"."producto_almacen_lote"),
              (SELECT COUNT(*) > 0 FROM "logistica"."producto_almacen_lote"));
SELECT setval(pg_get_serial_sequence('"logistica"."producto_almacen_lote_pedido"', 'id'),
              (SELECT COALESCE(MAX("id"), 1) FROM "logistica"."producto_almacen_lote_pedido"),
              (SELECT COUNT(*) > 0 FROM "logistica"."producto_almacen_lote_pedido"));
SELECT setval(pg_get_serial_sequence('"logistica"."productos_baja_rotacion"', 'codi_rota'),
              (SELECT COALESCE(MAX("codi_rota"), 1) FROM "logistica"."productos_baja_rotacion"),
              (SELECT COUNT(*) > 0 FROM "logistica"."productos_baja_rotacion"));
SELECT setval(pg_get_serial_sequence('"logistica"."productos_matriz"', 'id_mat'),
              (SELECT COALESCE(MAX("id_mat"), 1) FROM "logistica"."productos_matriz"),
              (SELECT COUNT(*) > 0 FROM "logistica"."productos_matriz"));
SELECT setval(pg_get_serial_sequence('"logistica"."productos_precio"', 'codi_item'),
              (SELECT COALESCE(MAX("codi_item"), 1) FROM "logistica"."productos_precio"),
              (SELECT COUNT(*) > 0 FROM "logistica"."productos_precio"));

COMMIT;

-- =====================================================================
-- ESQUEMA maestros  (44 tablas)
-- =====================================================================
BEGIN;
SET LOCAL session_replication_role = replica;

-- ACTI_ECON_PRIN -> maestros.acti_econ_prin  (3 col)
INSERT INTO "maestros"."acti_econ_prin" ("codi_acti_econ", "desc_acti_econ", "nemo_acti_econ")
SELECT
       NULLIF(rtrim("codi_acti_econ"::text), '')::varchar(4) AS "codi_acti_econ",
       NULLIF(rtrim("desc_acti_econ"::text), '')::varchar(200) AS "desc_acti_econ",
       NULLIF(rtrim("nemo_acti_econ"::text), '')::varchar(20) AS "nemo_acti_econ"
FROM "legacy_raw"."acti_econ_prin"
ON CONFLICT DO NOTHING;

-- ADUANA -> maestros.aduana  (3 col)
INSERT INTO "maestros"."aduana" ("codi_aduana", "codi_sunat", "desc_aduana")
SELECT
       NULLIF(btrim("codi_aduana"::text), '')::smallint AS "codi_aduana",
       NULLIF(rtrim("codi_sunat"::text), '')::varchar(3) AS "codi_sunat",
       NULLIF(rtrim("desc_aduana"::text), '')::varchar(200) AS "desc_aduana"
FROM "legacy_raw"."aduana"
ON CONFLICT DO NOTHING;

-- CLIE_PROV_SUSPEN_CTA_CATEG -> maestros.clie_prov_suspen_cta_categ  (6 col)
INSERT INTO "maestros"."clie_prov_suspen_cta_categ" ("codi_clie_prov_sups_cta_categ", "codi_clie_prov", "nro_operacion", "fech_inicio", "anio", "medio_presentacion")
SELECT
       NULLIF(btrim("codi_clie_prov_sups_cta_categ"::text), '')::bigint AS "codi_clie_prov_sups_cta_categ",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("nro_operacion"::text), '')::varchar(15) AS "nro_operacion",
       NULLIF(btrim("fech_inicio"::text), '')::timestamp(3) AS "fech_inicio",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("medio_presentacion"::text), '')::varchar(1) AS "medio_presentacion"
FROM "legacy_raw"."clie_prov_suspen_cta_categ"
ON CONFLICT DO NOTHING;

-- Cliente_Natural -> maestros.cliente_natural  (6 col)
INSERT INTO "maestros"."cliente_natural" ("id_clie_natu", "apellidos", "nombres", "nro_docu", "direccion", "codi_clie_prov")
SELECT
       NULLIF(btrim("id_clie_natu"::text), '')::integer AS "id_clie_natu",
       NULLIF(rtrim("apellidos"::text), '')::varchar(50) AS "apellidos",
       NULLIF(rtrim("nombres"::text), '')::varchar(50) AS "nombres",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(20) AS "nro_docu",
       NULLIF(rtrim("direccion"::text), '')::varchar(100) AS "direccion",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov"
FROM "legacy_raw"."cliente_natural"
ON CONFLICT DO NOTHING;

-- CLIENTE_PROVEEDOR -> maestros.cliente_proveedor  (36 col)
INSERT INTO "maestros"."cliente_proveedor" ("codi_clie_prov", "tipo_pers", "razo_soci", "nomb_1", "nomb_2", "apel_1", "apel_2", "ruc", "repr_lega", "denominacion", "direccion", "tele_1", "tele_2", "fax", "e_mail", "tipo_rela", "distrito", "provincia", "departamento", "codi_acti_econ", "suje_detr", "abreviatura", "propio", "reten", "nro_certificado", "codi_tipo_docu_iden", "fech_naci", "sexo", "codi_nacion", "essalud_vida", "domiciliado", "dv", "esta_acti", "frecuencia", "codi_ubi_dist", "codi_sunat_esta")
SELECT
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("tipo_pers"::text), '')::varchar(12) AS "tipo_pers",
       NULLIF(rtrim("razo_soci"::text), '')::varchar(100) AS "razo_soci",
       NULLIF(rtrim("nomb_1"::text), '')::varchar(30) AS "nomb_1",
       NULLIF(rtrim("nomb_2"::text), '')::varchar(30) AS "nomb_2",
       NULLIF(rtrim("apel_1"::text), '')::varchar(30) AS "apel_1",
       NULLIF(rtrim("apel_2"::text), '')::varchar(30) AS "apel_2",
       NULLIF(rtrim("ruc"::text), '')::varchar(15) AS "ruc",
       NULLIF(rtrim("repr_lega"::text), '')::varchar(120) AS "repr_lega",
       NULLIF(rtrim("denominacion"::text), '')::varchar(100) AS "denominacion",
       NULLIF(rtrim("direccion"::text), '')::varchar(150) AS "direccion",
       NULLIF(rtrim("tele_1"::text), '')::varchar(12) AS "tele_1",
       NULLIF(rtrim("tele_2"::text), '')::varchar(12) AS "tele_2",
       NULLIF(rtrim("fax"::text), '')::varchar(12) AS "fax",
       NULLIF(rtrim("e_mail"::text), '')::varchar(150) AS "e_mail",
       NULLIF(rtrim("tipo_rela"::text), '')::varchar(25) AS "tipo_rela",
       NULLIF(rtrim("distrito"::text), '')::varchar(50) AS "distrito",
       NULLIF(rtrim("provincia"::text), '')::varchar(50) AS "provincia",
       NULLIF(rtrim("departamento"::text), '')::varchar(50) AS "departamento",
       NULLIF(rtrim("codi_acti_econ"::text), '')::varchar(4) AS "codi_acti_econ",
       NULLIF(btrim("suje_detr"::text), '')::boolean AS "suje_detr",
       NULLIF(rtrim("abreviatura"::text), '')::varchar(30) AS "abreviatura",
       NULLIF(btrim("propio"::text), '')::boolean AS "propio",
       NULLIF(rtrim("reten"::text), '')::varchar(1) AS "reten",
       NULLIF(rtrim("nro_certificado"::text), '')::varchar(4) AS "nro_certificado",
       NULLIF(btrim("codi_tipo_docu_iden"::text), '')::smallint AS "codi_tipo_docu_iden",
       NULLIF(btrim("fech_naci"::text), '')::timestamp(3) AS "fech_naci",
       NULLIF(rtrim("sexo"::text), '')::varchar(1) AS "sexo",
       NULLIF(btrim("codi_nacion"::text), '')::smallint AS "codi_nacion",
       NULLIF(rtrim("essalud_vida"::text), '')::varchar(1) AS "essalud_vida",
       NULLIF(rtrim("domiciliado"::text), '')::varchar(1) AS "domiciliado",
       NULLIF(btrim("dv"::text), '')::smallint AS "dv",
       NULLIF(rtrim("esta_acti"::text), '')::varchar(1) AS "esta_acti",
       NULLIF(rtrim("frecuencia"::text), '')::varchar(2) AS "frecuencia",
       NULLIF(btrim("codi_ubi_dist"::text), '')::integer AS "codi_ubi_dist",
       NULLIF(rtrim("codi_sunat_esta"::text), '')::varchar(4) AS "codi_sunat_esta"
FROM "legacy_raw"."cliente_proveedor"
ON CONFLICT DO NOTHING;

-- CODIGOS_LDISTANCIA -> maestros.codigos_ldistancia  (2 col)
INSERT INTO "maestros"."codigos_ldistancia" ("codi_ldistanci", "descripcion")
SELECT
       NULLIF(rtrim("codi_ldistanci"::text), '')::varchar(3) AS "codi_ldistanci",
       NULLIF(rtrim("descripcion"::text), '')::varchar(50) AS "descripcion"
FROM "legacy_raw"."codigos_ldistancia"
ON CONFLICT DO NOTHING;

-- CULTIVOS -> maestros.cultivos  (3 col)
INSERT INTO "maestros"."cultivos" ("cod_cultivo", "desc_cultivo", "nro_dias")
SELECT
       NULLIF(btrim("cod_cultivo"::text), '')::integer AS "cod_cultivo",
       NULLIF(rtrim("desc_cultivo"::text), '')::varchar(100) AS "desc_cultivo",
       NULLIF(btrim("nro_dias"::text), '')::integer AS "nro_dias"
FROM "legacy_raw"."cultivos"
ON CONFLICT DO NOTHING;

-- Documentos -> maestros.documentos  (3 col)
INSERT INTO "maestros"."documentos" ("codi_tipo_docu", "serie", "nro_actual")
SELECT
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(btrim("serie"::text), '')::smallint AS "serie",
       NULLIF(btrim("nro_actual"::text), '')::integer AS "nro_actual"
FROM "legacy_raw"."documentos"
ON CONFLICT DO NOTHING;

-- Domicilio -> maestros.domicilio  (5 col)
INSERT INTO "maestros"."domicilio" ("codi_domi", "desc_domi", "distrito", "provincia", "departamento")
SELECT
       NULLIF(rtrim("codi_domi"::text), '')::varchar(4) AS "codi_domi",
       NULLIF(rtrim("desc_domi"::text), '')::varchar(150) AS "desc_domi",
       NULLIF(rtrim("distrito"::text), '')::varchar(30) AS "distrito",
       NULLIF(rtrim("provincia"::text), '')::varchar(30) AS "provincia",
       NULLIF(rtrim("departamento"::text), '')::varchar(30) AS "departamento"
FROM "legacy_raw"."domicilio"
ON CONFLICT DO NOTHING;

-- ESTABLECIMIENTO -> maestros.establecimiento  (3 col)
INSERT INTO "maestros"."establecimiento" ("codi_esta", "codi_esta_sunat", "desc_esta")
SELECT
       NULLIF(btrim("codi_esta"::text), '')::smallint AS "codi_esta",
       NULLIF(rtrim("codi_esta_sunat"::text), '')::varchar(2) AS "codi_esta_sunat",
       NULLIF(rtrim("desc_esta"::text), '')::varchar(100) AS "desc_esta"
FROM "legacy_raw"."establecimiento"
ON CONFLICT DO NOTHING;

-- ESTADOS -> maestros.estados  (2 col)
INSERT INTO "maestros"."estados" ("estado", "desc_esta")
SELECT
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("desc_esta"::text), '')::varchar(50) AS "desc_esta"
FROM "legacy_raw"."estados"
ON CONFLICT DO NOTHING;

-- ETAPA_FENOLOGICA -> maestros.etapa_fenologica  (2 col)
INSERT INTO "maestros"."etapa_fenologica" ("cod_eta", "desc_eta")
SELECT
       NULLIF(btrim("cod_eta"::text), '')::bigint AS "cod_eta",
       NULLIF(rtrim("desc_eta"::text), '')::varchar(100) AS "desc_eta"
FROM "legacy_raw"."etapa_fenologica"
ON CONFLICT DO NOTHING;

-- EVENTO -> maestros.evento  (13 col)
INSERT INTO "maestros"."evento" ("codi_plan", "nro_even", "evento", "tipo", "fecha", "duracion", "h_ini", "h_fin", "ubicacion", "notas", "informe", "codi_alma", "codi_pers")
SELECT
       NULLIF(btrim("codi_plan"::text), '')::bigint AS "codi_plan",
       NULLIF(rtrim("nro_even"::text), '')::varchar(12) AS "nro_even",
       NULLIF(rtrim("evento"::text), '')::varchar(100) AS "evento",
       NULLIF(rtrim("tipo"::text), '')::varchar(20) AS "tipo",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(btrim("duracion"::text), '')::timestamp(3) AS "duracion",
       NULLIF(btrim("h_ini"::text), '')::timestamp(3) AS "h_ini",
       NULLIF(btrim("h_fin"::text), '')::timestamp(3) AS "h_fin",
       NULLIF(rtrim("ubicacion"::text), '')::varchar(150) AS "ubicacion",
       NULLIF(rtrim("notas"::text), '')::text AS "notas",
       NULLIF(rtrim("informe"::text), '')::text AS "informe",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers"
FROM "legacy_raw"."evento"
ON CONFLICT DO NOTHING;

-- FERIADOS -> maestros.feriados  (5 col)
INSERT INTO "maestros"."feriados" ("mes", "dia", "anio", "desc_feri", "fecha")
SELECT
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("dia"::text), '')::varchar(2) AS "dia",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("desc_feri"::text), '')::varchar(50) AS "desc_feri",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha"
FROM "legacy_raw"."feriados"
ON CONFLICT DO NOTHING;

-- MONEDAS -> maestros.monedas  (4 col)
INSERT INTO "maestros"."monedas" ("codi_mone", "desc_mone", "simbolo", "codi_sunat")
SELECT
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("desc_mone"::text), '')::varchar(50) AS "desc_mone",
       NULLIF(rtrim("simbolo"::text), '')::varchar(10) AS "simbolo",
       NULLIF(btrim("codi_sunat"::text), '')::smallint AS "codi_sunat"
FROM "legacy_raw"."monedas"
ON CONFLICT DO NOTHING;

-- MOTIVOS -> maestros.motivos  (2 col)
INSERT INTO "maestros"."motivos" ("codi_moti", "desc_moti")
SELECT
       NULLIF(rtrim("codi_moti"::text), '')::varchar(3) AS "codi_moti",
       NULLIF(rtrim("desc_moti"::text), '')::varchar(100) AS "desc_moti"
FROM "legacy_raw"."motivos"
ON CONFLICT DO NOTHING;

-- NACION -> maestros.nacion  (3 col)
INSERT INTO "maestros"."nacion" ("codi_nacion", "codi_nacion_sunat", "desc_nacion")
SELECT
       NULLIF(btrim("codi_nacion"::text), '')::smallint AS "codi_nacion",
       NULLIF(rtrim("codi_nacion_sunat"::text), '')::varchar(4) AS "codi_nacion_sunat",
       NULLIF(rtrim("desc_nacion"::text), '')::varchar(150) AS "desc_nacion"
FROM "legacy_raw"."nacion"
ON CONFLICT DO NOTHING;

-- PAIS_EMISOR -> maestros.pais_emisor  (2 col)
INSERT INTO "maestros"."pais_emisor" ("codi_pais_emi", "descripcion")
SELECT
       NULLIF(rtrim("codi_pais_emi"::text), '')::varchar(3) AS "codi_pais_emi",
       NULLIF(rtrim("descripcion"::text), '')::varchar(150) AS "descripcion"
FROM "legacy_raw"."pais_emisor"
ON CONFLICT DO NOTHING;

-- REFERENCIAS -> maestros.referencias  (2 col)
INSERT INTO "maestros"."referencias" ("codi_refe", "descrip_refe")
SELECT
       NULLIF(rtrim("codi_refe"::text), '')::varchar(2) AS "codi_refe",
       NULLIF(rtrim("descrip_refe"::text), '')::varchar(100) AS "descrip_refe"
FROM "legacy_raw"."referencias"
ON CONFLICT DO NOTHING;

-- SEMANA -> maestros.semana  (6 col)
INSERT INTO "maestros"."semana" ("codi_sema", "nro_sema", "fech_inic", "fech_term", "aniomes", "codi_tipo_pers")
SELECT
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(btrim("nro_sema"::text), '')::smallint AS "nro_sema",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_term"::text), '')::timestamp(3) AS "fech_term",
       NULLIF(rtrim("aniomes"::text), '')::varchar(6) AS "aniomes",
       NULLIF(rtrim("codi_tipo_pers"::text), '')::varchar(2) AS "codi_tipo_pers"
FROM "legacy_raw"."semana"
ON CONFLICT DO NOTHING;

-- TELEFONO -> maestros.telefono  (4 col)
INSERT INTO "maestros"."telefono" ("codi_pers", "nro_tele", "tipo_tele", "observacion")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("nro_tele"::text), '')::varchar(12) AS "nro_tele",
       NULLIF(rtrim("tipo_tele"::text), '')::varchar(20) AS "tipo_tele",
       NULLIF(rtrim("observacion"::text), '')::varchar(50) AS "observacion"
FROM "legacy_raw"."telefono"
ON CONFLICT DO NOTHING;

-- Terceros -> maestros.terceros  (3 col)
INSERT INTO "maestros"."terceros" ("dni", "datos", "codi_carg")
SELECT
       NULLIF(rtrim("dni"::text), '')::varchar(10) AS "dni",
       NULLIF(rtrim("datos"::text), '')::varchar(100) AS "datos",
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg"
FROM "legacy_raw"."terceros"
ON CONFLICT DO NOTHING;

-- TIPO_CAMBIO_A_DOLAR -> maestros.tipo_cambio_a_dolar  (6 col)
INSERT INTO "maestros"."tipo_cambio_a_dolar" ("codi_mone_orig", "fech_camb", "compra", "venta", "codi_mone_camb", "venta_comer_d_a_s")
SELECT
       NULLIF(rtrim("codi_mone_orig"::text), '')::varchar(2) AS "codi_mone_orig",
       NULLIF(btrim("fech_camb"::text), '')::timestamp(3) AS "fech_camb",
       NULLIF(btrim("compra"::text), '')::numeric(9,4) AS "compra",
       NULLIF(btrim("venta"::text), '')::numeric(9,4) AS "venta",
       NULLIF(rtrim("codi_mone_camb"::text), '')::varchar(2) AS "codi_mone_camb",
       NULLIF(btrim("venta_comer_d_a_s"::text), '')::numeric(9,4) AS "venta_comer_d_a_s"
FROM "legacy_raw"."tipo_cambio_a_dolar"
ON CONFLICT DO NOTHING;

-- TIPO_DOCU_IDEN -> maestros.tipo_docu_iden  (4 col)
INSERT INTO "maestros"."tipo_docu_iden" ("codi_tipo_docu_iden", "codi_sunat", "desc_tipo_docu_iden", "nemo")
SELECT
       NULLIF(btrim("codi_tipo_docu_iden"::text), '')::smallint AS "codi_tipo_docu_iden",
       NULLIF(btrim("codi_sunat"::text), '')::smallint AS "codi_sunat",
       NULLIF(rtrim("desc_tipo_docu_iden"::text), '')::varchar(100) AS "desc_tipo_docu_iden",
       NULLIF(rtrim("nemo"::text), '')::varchar(20) AS "nemo"
FROM "legacy_raw"."tipo_docu_iden"
ON CONFLICT DO NOTHING;

-- TIPO_DOCUMENTO -> maestros.tipo_documento  (8 col)
INSERT INTO "maestros"."tipo_documento" ("codi_tipo_docu", "desc_tipo_docu", "tipo_cont", "nemo", "forma_pago", "codi_tipo_essa", "tipo_sunat", "codi_sunat")
SELECT
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("desc_tipo_docu"::text), '')::varchar(150) AS "desc_tipo_docu",
       NULLIF(rtrim("tipo_cont"::text), '')::varchar(1) AS "tipo_cont",
       NULLIF(rtrim("nemo"::text), '')::varchar(3) AS "nemo",
       NULLIF(rtrim("forma_pago"::text), '')::varchar(3) AS "forma_pago",
       NULLIF(btrim("codi_tipo_essa"::text), '')::smallint AS "codi_tipo_essa",
       NULLIF(rtrim("tipo_sunat"::text), '')::varchar(2) AS "tipo_sunat",
       NULLIF(rtrim("codi_sunat"::text), '')::varchar(2) AS "codi_sunat"
FROM "legacy_raw"."tipo_documento"
ON CONFLICT DO NOTHING;

-- TIPO_EMPRESA -> maestros.tipo_empresa  (3 col)
INSERT INTO "maestros"."tipo_empresa" ("codi_tipo_empr", "desc_tipo_empr", "nemo")
SELECT
       NULLIF(rtrim("codi_tipo_empr"::text), '')::varchar(2) AS "codi_tipo_empr",
       NULLIF(rtrim("desc_tipo_empr"::text), '')::varchar(50) AS "desc_tipo_empr",
       NULLIF(rtrim("nemo"::text), '')::varchar(20) AS "nemo"
FROM "legacy_raw"."tipo_empresa"
ON CONFLICT DO NOTHING;

-- TIPO_MEDIDA -> maestros.tipo_medida  (2 col)
INSERT INTO "maestros"."tipo_medida" ("codigo", "desc_medida")
SELECT
       NULLIF(rtrim("codigo"::text), '')::varchar(2) AS "codigo",
       NULLIF(rtrim("desc_medida"::text), '')::varchar(50) AS "desc_medida"
FROM "legacy_raw"."tipo_medida"
ON CONFLICT DO NOTHING;

-- TIPO_PAGO -> maestros.tipo_pago  (4 col)
INSERT INTO "maestros"."tipo_pago" ("codi_tipo_medio_pago", "codi_sunat", "desc_tipo_medio_pago", "nemo")
SELECT
       NULLIF(btrim("codi_tipo_medio_pago"::text), '')::smallint AS "codi_tipo_medio_pago",
       NULLIF(rtrim("codi_sunat"::text), '')::varchar(3) AS "codi_sunat",
       NULLIF(rtrim("desc_tipo_medio_pago"::text), '')::varchar(250) AS "desc_tipo_medio_pago",
       NULLIF(rtrim("nemo"::text), '')::varchar(30) AS "nemo"
FROM "legacy_raw"."tipo_pago"
ON CONFLICT DO NOTHING;

-- TIPO_UNID_OPER -> maestros.tipo_unid_oper  (3 col)
INSERT INTO "maestros"."tipo_unid_oper" ("codi_tipo_unid_oper", "desc_tipo_unid_oper", "nemo")
SELECT
       NULLIF(rtrim("codi_tipo_unid_oper"::text), '')::varchar(2) AS "codi_tipo_unid_oper",
       NULLIF(rtrim("desc_tipo_unid_oper"::text), '')::varchar(100) AS "desc_tipo_unid_oper",
       NULLIF(rtrim("nemo"::text), '')::varchar(4) AS "nemo"
FROM "legacy_raw"."tipo_unid_oper"
ON CONFLICT DO NOTHING;

-- TRANSACCIONES -> maestros.transacciones  (2 col)
INSERT INTO "maestros"."transacciones" ("codi_tran", "desc_tran")
SELECT
       NULLIF(rtrim("codi_tran"::text), '')::varchar(3) AS "codi_tran",
       NULLIF(rtrim("desc_tran"::text), '')::varchar(20) AS "desc_tran"
FROM "legacy_raw"."transacciones"
ON CONFLICT DO NOTHING;

-- Transportistas -> maestros.transportistas  (6 col)
INSERT INTO "maestros"."transportistas" ("codi_trans", "desc_trans", "iden", "direccion", "nro_lice_cond", "nextel")
SELECT
       NULLIF(rtrim("codi_trans"::text), '')::varchar(4) AS "codi_trans",
       NULLIF(rtrim("desc_trans"::text), '')::varchar(100) AS "desc_trans",
       NULLIF(rtrim("iden"::text), '')::varchar(20) AS "iden",
       NULLIF(rtrim("direccion"::text), '')::varchar(150) AS "direccion",
       NULLIF(rtrim("nro_lice_cond"::text), '')::varchar(25) AS "nro_lice_cond",
       NULLIF(rtrim("nextel"::text), '')::varchar(15) AS "nextel"
FROM "legacy_raw"."transportistas"
ON CONFLICT DO NOTHING;

-- UBIGEO_DISTRITO -> maestros.ubigeo_distrito  (4 col)
INSERT INTO "maestros"."ubigeo_distrito" ("codi_ubi_dist", "codi_ubi_dist_sunat", "desc_ubi_dist", "codi_ubi_prov_sunat")
SELECT
       NULLIF(btrim("codi_ubi_dist"::text), '')::smallint AS "codi_ubi_dist",
       NULLIF(rtrim("codi_ubi_dist_sunat"::text), '')::varchar(6) AS "codi_ubi_dist_sunat",
       NULLIF(rtrim("desc_ubi_dist"::text), '')::varchar(100) AS "desc_ubi_dist",
       NULLIF(rtrim("codi_ubi_prov_sunat"::text), '')::varchar(4) AS "codi_ubi_prov_sunat"
FROM "legacy_raw"."ubigeo_distrito"
ON CONFLICT DO NOTHING;

-- UBIGEO_PROVINCIA -> maestros.ubigeo_provincia  (4 col)
INSERT INTO "maestros"."ubigeo_provincia" ("codi_ubi_prov", "codi_ubi_prov_sunat", "desc_ubi_prov", "codi_ubi_reg_sunat")
SELECT
       NULLIF(btrim("codi_ubi_prov"::text), '')::smallint AS "codi_ubi_prov",
       NULLIF(rtrim("codi_ubi_prov_sunat"::text), '')::varchar(4) AS "codi_ubi_prov_sunat",
       NULLIF(rtrim("desc_ubi_prov"::text), '')::varchar(100) AS "desc_ubi_prov",
       NULLIF(rtrim("codi_ubi_reg_sunat"::text), '')::varchar(2) AS "codi_ubi_reg_sunat"
FROM "legacy_raw"."ubigeo_provincia"
ON CONFLICT DO NOTHING;

-- UBIGEO_REGION -> maestros.ubigeo_region  (3 col)
INSERT INTO "maestros"."ubigeo_region" ("codi_ubi_reg", "codi_ubi_reg_sunat", "desc_ubi_reg")
SELECT
       NULLIF(btrim("codi_ubi_reg"::text), '')::smallint AS "codi_ubi_reg",
       NULLIF(rtrim("codi_ubi_reg_sunat"::text), '')::varchar(2) AS "codi_ubi_reg_sunat",
       NULLIF(rtrim("desc_ubi_reg"::text), '')::varchar(100) AS "desc_ubi_reg"
FROM "legacy_raw"."ubigeo_region"
ON CONFLICT DO NOTHING;

-- UNID_OPER -> maestros.unid_oper  (5 col)
INSERT INTO "maestros"."unid_oper" ("codi_unid_oper", "desc_unid_oper", "codi_pers", "ubicacion", "codi_lcc")
SELECT
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("desc_unid_oper"::text), '')::varchar(100) AS "desc_unid_oper",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("ubicacion"::text), '')::varchar(100) AS "ubicacion",
       NULLIF(rtrim("codi_lcc"::text), '')::varchar(5) AS "codi_lcc"
FROM "legacy_raw"."unid_oper"
ON CONFLICT DO NOTHING;

-- UNIDAD_MEDIDA -> maestros.unidad_medida  (6 col)
INSERT INTO "maestros"."unidad_medida" ("codi_unid_medi", "desc_unid_medi", "tipo_unid_medi", "simb_unid_medi", "codi_sunat", "unid_medi_inte")
SELECT
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(rtrim("desc_unid_medi"::text), '')::varchar(100) AS "desc_unid_medi",
       NULLIF(rtrim("tipo_unid_medi"::text), '')::varchar(50) AS "tipo_unid_medi",
       NULLIF(rtrim("simb_unid_medi"::text), '')::varchar(3) AS "simb_unid_medi",
       NULLIF(rtrim("codi_sunat"::text), '')::varchar(2) AS "codi_sunat",
       NULLIF(rtrim("unid_medi_inte"::text), '')::varchar(3) AS "unid_medi_inte"
FROM "legacy_raw"."unidad_medida"
ON CONFLICT DO NOTHING;

-- UNIDAD_MEDIDA_INTER -> maestros.unidad_medida_inter  (5 col)
INSERT INTO "maestros"."unidad_medida_inter" ("codi_unid_medi", "desc_unid_medi", "tipo_unid_medi", "simb_unid_medi", "codi_sunat")
SELECT
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(5) AS "codi_unid_medi",
       NULLIF(rtrim("desc_unid_medi"::text), '')::varchar(255) AS "desc_unid_medi",
       NULLIF(rtrim("tipo_unid_medi"::text), '')::varchar(50) AS "tipo_unid_medi",
       NULLIF(rtrim("simb_unid_medi"::text), '')::varchar(3) AS "simb_unid_medi",
       NULLIF(rtrim("codi_sunat"::text), '')::varchar(2) AS "codi_sunat"
FROM "legacy_raw"."unidad_medida_inter"
ON CONFLICT DO NOTHING;

-- UNIDAD_MEDIDA_SUNAT -> maestros.unidad_medida_sunat  (2 col)
INSERT INTO "maestros"."unidad_medida_sunat" ("codigo", "desc_unid")
SELECT
       NULLIF(rtrim("codigo"::text), '')::varchar(2) AS "codigo",
       NULLIF(rtrim("desc_unid"::text), '')::varchar(50) AS "desc_unid"
FROM "legacy_raw"."unidad_medida_sunat"
ON CONFLICT DO NOTHING;

-- UNIDAD_NEGOCIO -> maestros.unidad_negocio  (2 col)
INSERT INTO "maestros"."unidad_negocio" ("codi_unid_nego", "desc_unid_nego")
SELECT
       NULLIF(rtrim("codi_unid_nego"::text), '')::varchar(2) AS "codi_unid_nego",
       NULLIF(rtrim("desc_unid_nego"::text), '')::varchar(50) AS "desc_unid_nego"
FROM "legacy_raw"."unidad_negocio"
ON CONFLICT DO NOTHING;

-- VALORES_UNITARIOS -> maestros.valores_unitarios  (3 col)
INSERT INTO "maestros"."valores_unitarios" ("codi_valo_unit", "desc_valo_unit", "nemo")
SELECT
       NULLIF(btrim("codi_valo_unit"::text), '')::integer AS "codi_valo_unit",
       NULLIF(rtrim("desc_valo_unit"::text), '')::varchar(50) AS "desc_valo_unit",
       NULLIF(rtrim("nemo"::text), '')::varchar(4) AS "nemo"
FROM "legacy_raw"."valores_unitarios"
ON CONFLICT DO NOTHING;

-- VALORES_UNITARIOS_ANUALES -> maestros.valores_unitarios_anuales  (6 col)
INSERT INTO "maestros"."valores_unitarios_anuales" ("codi_valo_unit", "fech_asig", "fech_asig_fin", "valor", "tipo_valo", "esta_acti")
SELECT
       NULLIF(btrim("codi_valo_unit"::text), '')::integer AS "codi_valo_unit",
       NULLIF(btrim("fech_asig"::text), '')::timestamp(3) AS "fech_asig",
       NULLIF(btrim("fech_asig_fin"::text), '')::timestamp(3) AS "fech_asig_fin",
       NULLIF(btrim("valor"::text), '')::numeric(12,2) AS "valor",
       NULLIF(btrim("tipo_valo"::text), '')::boolean AS "tipo_valo",
       NULLIF(btrim("esta_acti"::text), '')::boolean AS "esta_acti"
FROM "legacy_raw"."valores_unitarios_anuales"
ON CONFLICT DO NOTHING;

-- VIA -> maestros.via  (4 col)
INSERT INTO "maestros"."via" ("codi_via", "codi_via_sunat", "desc_via", "nemo_via")
SELECT
       NULLIF(btrim("codi_via"::text), '')::smallint AS "codi_via",
       NULLIF(rtrim("codi_via_sunat"::text), '')::varchar(2) AS "codi_via_sunat",
       NULLIF(rtrim("desc_via"::text), '')::varchar(20) AS "desc_via",
       NULLIF(rtrim("nemo_via"::text), '')::varchar(5) AS "nemo_via"
FROM "legacy_raw"."via"
ON CONFLICT DO NOTHING;

-- ZONA -> maestros.zona  (4 col)
INSERT INTO "maestros"."zona" ("codi_zona", "codi_zona_sunat", "desc_zona", "nemo_zona")
SELECT
       NULLIF(btrim("codi_zona"::text), '')::smallint AS "codi_zona",
       NULLIF(rtrim("codi_zona_sunat"::text), '')::varchar(2) AS "codi_zona_sunat",
       NULLIF(rtrim("desc_zona"::text), '')::varchar(50) AS "desc_zona",
       NULLIF(rtrim("nemo_zona"::text), '')::varchar(5) AS "nemo_zona"
FROM "legacy_raw"."zona"
ON CONFLICT DO NOTHING;

-- ZONAS -> maestros.zonas  (2 col)
INSERT INTO "maestros"."zonas" ("cod_zona", "desc_zona")
SELECT
       NULLIF(btrim("cod_zona"::text), '')::bigint AS "cod_zona",
       NULLIF(rtrim("desc_zona"::text), '')::varchar(100) AS "desc_zona"
FROM "legacy_raw"."zonas"
ON CONFLICT DO NOTHING;

COMMIT;

-- =====================================================================
-- ESQUEMA produccion  (40 tablas)
-- =====================================================================
BEGIN;
SET LOCAL session_replication_role = replica;

-- Analisis_Aceite -> produccion.analisis_aceite  (11 col)
INSERT INTO "produccion"."analisis_aceite" ("cod_analisis", "codi_ingr", "codi_alma", "item", "codi_prod", "i_o", "condicion", "fecha_analisis", "fecha_registro", "codi_usua", "estado_ingreso")
SELECT
       NULLIF(btrim("cod_analisis"::text), '')::bigint AS "cod_analisis",
       NULLIF(btrim("codi_ingr"::text), '')::bigint AS "codi_ingr",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("item"::text), '')::integer AS "item",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("i_o"::text), '')::varchar(1) AS "i_o",
       NULLIF(btrim("condicion"::text), '')::smallint AS "condicion",
       NULLIF(btrim("fecha_analisis"::text), '')::timestamp(3) AS "fecha_analisis",
       NULLIF(btrim("fecha_registro"::text), '')::timestamp(3) AS "fecha_registro",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(btrim("estado_ingreso"::text), '')::smallint AS "estado_ingreso"
FROM "legacy_raw"."analisis_aceite"
ON CONFLICT DO NOTHING;

-- Analisis_Parametro -> produccion.analisis_parametro  (4 col)
INSERT INTO "produccion"."analisis_parametro" ("cod_analisis", "cod_param", "valor", "estado")
SELECT
       NULLIF(btrim("cod_analisis"::text), '')::bigint AS "cod_analisis",
       NULLIF(btrim("cod_param"::text), '')::smallint AS "cod_param",
       NULLIF(btrim("valor"::text), '')::numeric(18,2) AS "valor",
       NULLIF(btrim("estado"::text), '')::smallint AS "estado"
FROM "legacy_raw"."analisis_parametro"
ON CONFLICT DO NOTHING;

-- CONSUMO_COMBUSTIBLE -> produccion.consumo_combustible  (6 col)
INSERT INTO "produccion"."consumo_combustible" ("codi_cons_comb", "codi_unid_tran", "anio", "mes", "kilo_inic", "kilo_fina")
SELECT
       NULLIF(rtrim("codi_cons_comb"::text), '')::varchar(5) AS "codi_cons_comb",
       NULLIF(rtrim("codi_unid_tran"::text), '')::varchar(4) AS "codi_unid_tran",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(btrim("kilo_inic"::text), '')::numeric(18,2) AS "kilo_inic",
       NULLIF(btrim("kilo_fina"::text), '')::numeric(18,2) AS "kilo_fina"
FROM "legacy_raw"."consumo_combustible"
ON CONFLICT DO NOTHING;

-- DERECHOPESCA -> produccion.derechopesca  (11 col)
INSERT INTO "produccion"."derechopesca" ("mesanio", "codi_unid_oper", "captura", "factor", "derecho", "porcentaje", "derechopor", "credito", "deducion", "total", "aplicar")
SELECT
       NULLIF(rtrim("mesanio"::text), '')::varchar(6) AS "mesanio",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(btrim("captura"::text), '')::numeric(12,3) AS "captura",
       NULLIF(btrim("factor"::text), '')::numeric(12,3) AS "factor",
       NULLIF(btrim("derecho"::text), '')::numeric(12,3) AS "derecho",
       NULLIF(btrim("porcentaje"::text), '')::numeric(12,3) AS "porcentaje",
       NULLIF(btrim("derechopor"::text), '')::numeric(12,3) AS "derechopor",
       NULLIF(btrim("credito"::text), '')::numeric(12,3) AS "credito",
       NULLIF(btrim("deducion"::text), '')::numeric(12,3) AS "deducion",
       NULLIF(btrim("total"::text), '')::numeric(12,3) AS "total",
       NULLIF(rtrim("aplicar"::text), '')::varchar(1) AS "aplicar"
FROM "legacy_raw"."derechopesca"
ON CONFLICT DO NOTHING;

-- DESTINOS_PESCA -> produccion.destinos_pesca  (3 col)
INSERT INTO "produccion"."destinos_pesca" ("codi_dest", "desc_dest", "abrev")
SELECT
       NULLIF(rtrim("codi_dest"::text), '')::varchar(3) AS "codi_dest",
       NULLIF(rtrim("desc_dest"::text), '')::varchar(250) AS "desc_dest",
       NULLIF(rtrim("abrev"::text), '')::varchar(30) AS "abrev"
FROM "legacy_raw"."destinos_pesca"
ON CONFLICT DO NOTHING;

-- DETALLE_FACTURA_PESCA -> produccion.detalle_factura_pesca  (5 col)
INSERT INTO "produccion"."detalle_factura_pesca" ("codi_fact_pesc", "codi_deta_zarp", "cant_tone", "prec_unit", "sub_tota")
SELECT
       NULLIF(rtrim("codi_fact_pesc"::text), '')::varchar(10) AS "codi_fact_pesc",
       NULLIF(rtrim("codi_deta_zarp"::text), '')::varchar(15) AS "codi_deta_zarp",
       NULLIF(btrim("cant_tone"::text), '')::numeric(12,3) AS "cant_tone",
       NULLIF(btrim("prec_unit"::text), '')::numeric(12,3) AS "prec_unit",
       NULLIF(btrim("sub_tota"::text), '')::numeric(12,3) AS "sub_tota"
FROM "legacy_raw"."detalle_factura_pesca"
ON CONFLICT DO NOTHING;

-- DETALLE_ZARPE -> produccion.detalle_zarpe  (15 col)
INSERT INTO "produccion"."detalle_zarpe" ("codi_deta_zarp", "codi_zarp", "codi_espe", "cantidad", "codi_unid_medi_cant", "tama_mini_espe", "tama_maxi_espe", "codi_unid_medi_tama", "codi_clie_prov", "seri_guia", "nro_guia", "prec_pact", "tipo_docu", "estado", "incigv")
SELECT
       NULLIF(rtrim("codi_deta_zarp"::text), '')::varchar(15) AS "codi_deta_zarp",
       NULLIF(rtrim("codi_zarp"::text), '')::varchar(10) AS "codi_zarp",
       NULLIF(rtrim("codi_espe"::text), '')::varchar(2) AS "codi_espe",
       NULLIF(btrim("cantidad"::text), '')::numeric(12,3) AS "cantidad",
       NULLIF(rtrim("codi_unid_medi_cant"::text), '')::varchar(2) AS "codi_unid_medi_cant",
       NULLIF(btrim("tama_mini_espe"::text), '')::numeric(12,2) AS "tama_mini_espe",
       NULLIF(btrim("tama_maxi_espe"::text), '')::numeric(12,2) AS "tama_maxi_espe",
       NULLIF(rtrim("codi_unid_medi_tama"::text), '')::varchar(2) AS "codi_unid_medi_tama",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("seri_guia"::text), '')::varchar(5) AS "seri_guia",
       NULLIF(rtrim("nro_guia"::text), '')::varchar(10) AS "nro_guia",
       NULLIF(btrim("prec_pact"::text), '')::numeric(12,3) AS "prec_pact",
       NULLIF(rtrim("tipo_docu"::text), '')::varchar(2) AS "tipo_docu",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("incigv"::text), '')::varchar(1) AS "incigv"
FROM "legacy_raw"."detalle_zarpe"
ON CONFLICT DO NOTHING;

-- EMBA_VENC_CERT -> produccion.emba_venc_cert  (7 col)
INSERT INTO "produccion"."emba_venc_cert" ("codi_venc_cert", "codi_unid_oper", "codi_tipo_cert", "fech_inic", "fech_term", "periodo", "observacion")
SELECT
       NULLIF(rtrim("codi_venc_cert"::text), '')::varchar(6) AS "codi_venc_cert",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_tipo_cert"::text), '')::varchar(2) AS "codi_tipo_cert",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_term"::text), '')::timestamp(3) AS "fech_term",
       NULLIF(rtrim("periodo"::text), '')::varchar(10) AS "periodo",
       NULLIF(rtrim("observacion"::text), '')::varchar(200) AS "observacion"
FROM "legacy_raw"."emba_venc_cert"
ON CONFLICT DO NOTHING;

-- EMBAR_CARAC -> produccion.embar_carac  (25 col)
INSERT INTO "produccion"."embar_carac" ("codi_unid_oper", "eslora", "manga", "puntual", "nro_mamp_esta_tran", "nro_mamp_esta_long", "nro_cubi_bajo_cubi", "nro_cubi_sobr_cubi", "nro_mast", "nro_bode", "nro_cuad", "nro_grua", "form_popa", "form_proa", "marc_moto", "mode_moto", "seri_moto", "pote_moto", "unid_medi_pote", "tipo_comb", "nro_tanq_comb", "capa_tanq_comb", "tipo_agua", "nro_tanq_agua", "capa_tanq_agua")
SELECT
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(btrim("eslora"::text), '')::numeric(12,3) AS "eslora",
       NULLIF(btrim("manga"::text), '')::numeric(12,3) AS "manga",
       NULLIF(btrim("puntual"::text), '')::numeric(12,3) AS "puntual",
       NULLIF(btrim("nro_mamp_esta_tran"::text), '')::smallint AS "nro_mamp_esta_tran",
       NULLIF(btrim("nro_mamp_esta_long"::text), '')::smallint AS "nro_mamp_esta_long",
       NULLIF(btrim("nro_cubi_bajo_cubi"::text), '')::smallint AS "nro_cubi_bajo_cubi",
       NULLIF(btrim("nro_cubi_sobr_cubi"::text), '')::smallint AS "nro_cubi_sobr_cubi",
       NULLIF(btrim("nro_mast"::text), '')::smallint AS "nro_mast",
       NULLIF(btrim("nro_bode"::text), '')::smallint AS "nro_bode",
       NULLIF(btrim("nro_cuad"::text), '')::smallint AS "nro_cuad",
       NULLIF(btrim("nro_grua"::text), '')::smallint AS "nro_grua",
       NULLIF(rtrim("form_popa"::text), '')::varchar(30) AS "form_popa",
       NULLIF(rtrim("form_proa"::text), '')::varchar(30) AS "form_proa",
       NULLIF(rtrim("marc_moto"::text), '')::varchar(30) AS "marc_moto",
       NULLIF(rtrim("mode_moto"::text), '')::varchar(30) AS "mode_moto",
       NULLIF(rtrim("seri_moto"::text), '')::varchar(30) AS "seri_moto",
       NULLIF(btrim("pote_moto"::text), '')::numeric(12,3) AS "pote_moto",
       NULLIF(rtrim("unid_medi_pote"::text), '')::varchar(2) AS "unid_medi_pote",
       NULLIF(rtrim("tipo_comb"::text), '')::varchar(30) AS "tipo_comb",
       NULLIF(btrim("nro_tanq_comb"::text), '')::smallint AS "nro_tanq_comb",
       NULLIF(btrim("capa_tanq_comb"::text), '')::numeric(12,3) AS "capa_tanq_comb",
       NULLIF(rtrim("tipo_agua"::text), '')::varchar(30) AS "tipo_agua",
       NULLIF(btrim("nro_tanq_agua"::text), '')::smallint AS "nro_tanq_agua",
       NULLIF(btrim("capa_tanq_agua"::text), '')::numeric(12,3) AS "capa_tanq_agua"
FROM "legacy_raw"."embar_carac"
ON CONFLICT DO NOTHING;

-- EMBARCACIONES -> produccion.embarcaciones  (57 col)
INSERT INTO "produccion"."embarcaciones" ("codi_unid_oper", "desc_unid_oper", "capa_bode", "capa_neta", "nro_matri", "luga_cons", "porc_dist", "estado", "codi_caja", "grupo", "subsidio", "orden", "montoboni", "prop_terc", "nemo_emba", "detra", "fech_cese", "arqu_brut", "arqu_neto", "mate_casc", "colo_casc", "mate_supe_estr", "colo_supe_estr", "montopatron", "codi_mone_patron", "monto_segundo", "codi_mone_segun", "aplica_segun", "conserva", "codi_clie_prov", "monto_adic", "codi_mone_adic", "sunat_adic", "eslora", "manga", "puntual", "nro_mamp_esta_tran", "nro_cubi_bajo_cubi", "nro_cubi_sobr_cubi", "nro_mast", "nro_bode", "nro_cuad", "nro_grua", "form_popa", "form_proa", "marc_moto", "mode_moto", "seri_moto", "pote_moto", "unid_medi_pote", "tipo_comb", "nro_tanq_comb", "capa_tanq_comb", "tipo_agua", "nro_tanq_agua", "capa_tanq_agua", "nro_mamp_esta_long")
SELECT
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("desc_unid_oper"::text), '')::varchar(100) AS "desc_unid_oper",
       NULLIF(btrim("capa_bode"::text), '')::numeric(12,3) AS "capa_bode",
       NULLIF(btrim("capa_neta"::text), '')::numeric(12,3) AS "capa_neta",
       NULLIF(rtrim("nro_matri"::text), '')::varchar(15) AS "nro_matri",
       NULLIF(rtrim("luga_cons"::text), '')::varchar(50) AS "luga_cons",
       NULLIF(btrim("porc_dist"::text), '')::numeric(12,3) AS "porc_dist",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("codi_caja"::text), '')::varchar(10) AS "codi_caja",
       NULLIF(rtrim("grupo"::text), '')::varchar(10) AS "grupo",
       NULLIF(btrim("subsidio"::text), '')::numeric(18,2) AS "subsidio",
       NULLIF(btrim("orden"::text), '')::smallint AS "orden",
       NULLIF(btrim("montoboni"::text), '')::numeric(12,3) AS "montoboni",
       NULLIF(rtrim("prop_terc"::text), '')::varchar(1) AS "prop_terc",
       NULLIF(rtrim("nemo_emba"::text), '')::varchar(10) AS "nemo_emba",
       NULLIF(btrim("detra"::text), '')::numeric(18,2) AS "detra",
       NULLIF(btrim("fech_cese"::text), '')::timestamp(3) AS "fech_cese",
       NULLIF(btrim("arqu_brut"::text), '')::numeric(9,4) AS "arqu_brut",
       NULLIF(btrim("arqu_neto"::text), '')::numeric(9,4) AS "arqu_neto",
       NULLIF(rtrim("mate_casc"::text), '')::varchar(50) AS "mate_casc",
       NULLIF(rtrim("colo_casc"::text), '')::varchar(50) AS "colo_casc",
       NULLIF(rtrim("mate_supe_estr"::text), '')::varchar(50) AS "mate_supe_estr",
       NULLIF(rtrim("colo_supe_estr"::text), '')::varchar(50) AS "colo_supe_estr",
       NULLIF(btrim("montopatron"::text), '')::numeric(18,3) AS "montopatron",
       NULLIF(rtrim("codi_mone_patron"::text), '')::varchar(2) AS "codi_mone_patron",
       NULLIF(btrim("monto_segundo"::text), '')::numeric(18,3) AS "monto_segundo",
       NULLIF(rtrim("codi_mone_segun"::text), '')::varchar(2) AS "codi_mone_segun",
       NULLIF(rtrim("aplica_segun"::text), '')::varchar(1) AS "aplica_segun",
       NULLIF(btrim("conserva"::text), '')::numeric(12,3) AS "conserva",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("monto_adic"::text), '')::numeric(12,3) AS "monto_adic",
       NULLIF(rtrim("codi_mone_adic"::text), '')::varchar(2) AS "codi_mone_adic",
       NULLIF(btrim("sunat_adic"::text), '')::numeric(12,3) AS "sunat_adic",
       NULLIF(btrim("eslora"::text), '')::bigint AS "eslora",
       NULLIF(btrim("manga"::text), '')::bigint AS "manga",
       NULLIF(btrim("puntual"::text), '')::bigint AS "puntual",
       NULLIF(btrim("nro_mamp_esta_tran"::text), '')::smallint AS "nro_mamp_esta_tran",
       NULLIF(btrim("nro_cubi_bajo_cubi"::text), '')::smallint AS "nro_cubi_bajo_cubi",
       NULLIF(btrim("nro_cubi_sobr_cubi"::text), '')::smallint AS "nro_cubi_sobr_cubi",
       NULLIF(btrim("nro_mast"::text), '')::smallint AS "nro_mast",
       NULLIF(btrim("nro_bode"::text), '')::smallint AS "nro_bode",
       NULLIF(btrim("nro_cuad"::text), '')::smallint AS "nro_cuad",
       NULLIF(btrim("nro_grua"::text), '')::smallint AS "nro_grua",
       NULLIF(rtrim("form_popa"::text), '')::varchar(30) AS "form_popa",
       NULLIF(rtrim("form_proa"::text), '')::varchar(30) AS "form_proa",
       NULLIF(rtrim("marc_moto"::text), '')::varchar(30) AS "marc_moto",
       NULLIF(rtrim("mode_moto"::text), '')::varchar(30) AS "mode_moto",
       NULLIF(rtrim("seri_moto"::text), '')::varchar(30) AS "seri_moto",
       NULLIF(btrim("pote_moto"::text), '')::bigint AS "pote_moto",
       NULLIF(rtrim("unid_medi_pote"::text), '')::varchar(2) AS "unid_medi_pote",
       NULLIF(rtrim("tipo_comb"::text), '')::varchar(30) AS "tipo_comb",
       NULLIF(btrim("nro_tanq_comb"::text), '')::smallint AS "nro_tanq_comb",
       NULLIF(btrim("capa_tanq_comb"::text), '')::bigint AS "capa_tanq_comb",
       NULLIF(rtrim("tipo_agua"::text), '')::varchar(30) AS "tipo_agua",
       NULLIF(btrim("nro_tanq_agua"::text), '')::smallint AS "nro_tanq_agua",
       NULLIF(btrim("capa_tanq_agua"::text), '')::bigint AS "capa_tanq_agua",
       NULLIF(btrim("nro_mamp_esta_long"::text), '')::smallint AS "nro_mamp_esta_long"
FROM "legacy_raw"."embarcaciones"
ON CONFLICT DO NOTHING;

-- ESPECIES -> produccion.especies  (4 col)
INSERT INTO "produccion"."especies" ("codi_espe", "desc_espe", "descuento", "tipo_cons")
SELECT
       NULLIF(rtrim("codi_espe"::text), '')::varchar(2) AS "codi_espe",
       NULLIF(rtrim("desc_espe"::text), '')::varchar(50) AS "desc_espe",
       NULLIF(btrim("descuento"::text), '')::numeric(18,3) AS "descuento",
       NULLIF(rtrim("tipo_cons"::text), '')::varchar(1) AS "tipo_cons"
FROM "legacy_raw"."especies"
ON CONFLICT DO NOTHING;

-- INFORME_ACIDEZ -> produccion.informe_acidez  (11 col)
INSERT INTO "produccion"."informe_acidez" ("codi_alma", "fecha", "peso", "superior", "medio", "compo", "fondo", "solidos", "altura", "observaciones", "hora")
SELECT
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("fecha"::text), '')::varchar(10) AS "fecha",
       NULLIF(btrim("peso"::text), '')::numeric(18,2) AS "peso",
       NULLIF(btrim("superior"::text), '')::numeric(18,2) AS "superior",
       NULLIF(btrim("medio"::text), '')::numeric(18,2) AS "medio",
       NULLIF(btrim("compo"::text), '')::numeric(18,2) AS "compo",
       NULLIF(btrim("fondo"::text), '')::numeric(18,2) AS "fondo",
       NULLIF(btrim("solidos"::text), '')::numeric(18,2) AS "solidos",
       NULLIF(btrim("altura"::text), '')::numeric(18,2) AS "altura",
       NULLIF(rtrim("observaciones"::text), '')::varchar(100) AS "observaciones",
       NULLIF(rtrim("hora"::text), '')::varchar(10) AS "hora"
FROM "legacy_raw"."informe_acidez"
ON CONFLICT DO NOTHING;

-- LUGAR_ORIGEN -> produccion.lugar_origen  (2 col)
INSERT INTO "produccion"."lugar_origen" ("codi_luga", "desc_luga")
SELECT
       NULLIF(rtrim("codi_luga"::text), '')::varchar(3) AS "codi_luga",
       NULLIF(rtrim("desc_luga"::text), '')::varchar(200) AS "desc_luga"
FROM "legacy_raw"."lugar_origen"
ON CONFLICT DO NOTHING;

-- Nota_ingreso_Aceite -> produccion.nota_ingreso_aceite  (33 col)
INSERT INTO "produccion"."nota_ingreso_aceite" ("codi_ingr", "codi_alma", "nro_ingr", "fecha", "codi_mone", "codi_tipo_docu", "serie", "numero", "codi_clie_prov", "codi_moti_tras", "tpc", "observacion", "codi_orde", "rela_vale", "anulado", "subt", "igv", "total", "orden_compra", "productor", "transporte", "placa", "codi_doc", "serfact", "nrofact", "fecha_fact", "codi_sali", "chofer", "periodo", "indice_rela", "procedencia", "contabilizado", "codi_unid_oper_prod")
SELECT
       NULLIF(btrim("codi_ingr"::text), '')::bigint AS "codi_ingr",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("nro_ingr"::text), '')::bigint AS "nro_ingr",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("serie"::text), '')::varchar(3) AS "serie",
       NULLIF(rtrim("numero"::text), '')::varchar(10) AS "numero",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_moti_tras"::text), '')::varchar(2) AS "codi_moti_tras",
       NULLIF(btrim("tpc"::text), '')::numeric(18,4) AS "tpc",
       NULLIF(rtrim("observacion"::text), '')::varchar(250) AS "observacion",
       NULLIF(btrim("codi_orde"::text), '')::bigint AS "codi_orde",
       NULLIF(btrim("rela_vale"::text), '')::bigint AS "rela_vale",
       NULLIF(rtrim("anulado"::text), '')::varchar(1) AS "anulado",
       NULLIF(btrim("subt"::text), '')::numeric(18,2) AS "subt",
       NULLIF(btrim("igv"::text), '')::numeric(18,2) AS "igv",
       NULLIF(btrim("total"::text), '')::numeric(18,2) AS "total",
       NULLIF(btrim("orden_compra"::text), '')::bigint AS "orden_compra",
       NULLIF(rtrim("productor"::text), '')::varchar(5) AS "productor",
       NULLIF(rtrim("transporte"::text), '')::varchar(5) AS "transporte",
       NULLIF(rtrim("placa"::text), '')::varchar(10) AS "placa",
       NULLIF(rtrim("codi_doc"::text), '')::varchar(4) AS "codi_doc",
       NULLIF(rtrim("serfact"::text), '')::varchar(5) AS "serfact",
       NULLIF(rtrim("nrofact"::text), '')::varchar(10) AS "nrofact",
       NULLIF(btrim("fecha_fact"::text), '')::timestamp(0) AS "fecha_fact",
       NULLIF(btrim("codi_sali"::text), '')::bigint AS "codi_sali",
       NULLIF(rtrim("chofer"::text), '')::varchar(4) AS "chofer",
       NULLIF(rtrim("periodo"::text), '')::varchar(4) AS "periodo",
       NULLIF(btrim("indice_rela"::text), '')::bigint AS "indice_rela",
       NULLIF(rtrim("procedencia"::text), '')::varchar(3) AS "procedencia",
       NULLIF(btrim("contabilizado"::text), '')::boolean AS "contabilizado",
       NULLIF(rtrim("codi_unid_oper_prod"::text), '')::varchar(5) AS "codi_unid_oper_prod"
FROM "legacy_raw"."nota_ingreso_aceite"
ON CONFLICT DO NOTHING;

-- NroTrip_Embar -> produccion.nrotrip_embar  (2 col)
INSERT INTO "produccion"."nrotrip_embar" ("codi_unid_oper", "nro_trip")
SELECT
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(btrim("nro_trip"::text), '')::integer AS "nro_trip"
FROM "legacy_raw"."nrotrip_embar"
ON CONFLICT DO NOTHING;

-- ORDEN_COMPRA_ACEITE -> produccion.orden_compra_aceite  (25 col)
INSERT INTO "produccion"."orden_compra_aceite" ("codi_orde", "nro_orde", "codi_alma", "fecha", "codi_mone", "codi_tipo_docu", "serie", "numero", "codi_clie_prov", "codi_moti_tras", "tpc", "observacion", "codi_alma_dest", "contabilizado", "codi_vouc", "subt", "igv", "total", "productor", "transporte", "placa", "serfact", "nrofact", "codi_doc", "periodo")
SELECT
       NULLIF(btrim("codi_orde"::text), '')::bigint AS "codi_orde",
       NULLIF(btrim("nro_orde"::text), '')::bigint AS "nro_orde",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("serie"::text), '')::varchar(3) AS "serie",
       NULLIF(rtrim("numero"::text), '')::varchar(10) AS "numero",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_moti_tras"::text), '')::varchar(2) AS "codi_moti_tras",
       NULLIF(btrim("tpc"::text), '')::numeric(18,4) AS "tpc",
       NULLIF(rtrim("observacion"::text), '')::varchar(250) AS "observacion",
       NULLIF(rtrim("codi_alma_dest"::text), '')::varchar(2) AS "codi_alma_dest",
       NULLIF(rtrim("contabilizado"::text), '')::varchar(1) AS "contabilizado",
       NULLIF(rtrim("codi_vouc"::text), '')::varchar(10) AS "codi_vouc",
       NULLIF(btrim("subt"::text), '')::numeric(18,2) AS "subt",
       NULLIF(btrim("igv"::text), '')::numeric(18,2) AS "igv",
       NULLIF(btrim("total"::text), '')::numeric(18,2) AS "total",
       NULLIF(rtrim("productor"::text), '')::varchar(5) AS "productor",
       NULLIF(rtrim("transporte"::text), '')::varchar(5) AS "transporte",
       NULLIF(rtrim("placa"::text), '')::varchar(10) AS "placa",
       NULLIF(rtrim("serfact"::text), '')::varchar(5) AS "serfact",
       NULLIF(rtrim("nrofact"::text), '')::varchar(10) AS "nrofact",
       NULLIF(rtrim("codi_doc"::text), '')::varchar(4) AS "codi_doc",
       NULLIF(rtrim("periodo"::text), '')::varchar(4) AS "periodo"
FROM "legacy_raw"."orden_compra_aceite"
ON CONFLICT DO NOTHING;

-- ORDEN_PRODUCCION -> produccion.orden_produccion  (35 col)
INSERT INTO "produccion"."orden_produccion" ("codi_orde_produc", "nro_orde_produc", "fecha_orde_produc", "codi_clie", "descripcion", "nro_oc_clie", "fecha_entrega", "prec_unit", "cantidad", "codi_unid_medi", "tama1", "tama2", "codi_unid_medit", "otros_acabado", "observaciones", "codi_usua", "estado", "tipo_pers", "id_clie_natu", "codi_mone", "tama", "nroordefisico", "otro_material", "cliente", "direccion", "nro_docu", "descripcion_item", "material", "color", "acabado", "serv_prod", "total", "codi_tipo_op", "aurtoriza_por", "solicitado_por")
SELECT
       NULLIF(btrim("codi_orde_produc"::text), '')::integer AS "codi_orde_produc",
       NULLIF(btrim("nro_orde_produc"::text), '')::integer AS "nro_orde_produc",
       NULLIF(btrim("fecha_orde_produc"::text), '')::timestamp(3) AS "fecha_orde_produc",
       NULLIF(rtrim("codi_clie"::text), '')::varchar(5) AS "codi_clie",
       NULLIF(rtrim("descripcion"::text), '')::varchar(200) AS "descripcion",
       NULLIF(rtrim("nro_oc_clie"::text), '')::varchar(25) AS "nro_oc_clie",
       NULLIF(btrim("fecha_entrega"::text), '')::timestamp(3) AS "fecha_entrega",
       NULLIF(btrim("prec_unit"::text), '')::numeric(18,8) AS "prec_unit",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,2) AS "cantidad",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(btrim("tama1"::text), '')::numeric(9,2) AS "tama1",
       NULLIF(btrim("tama2"::text), '')::numeric(9,2) AS "tama2",
       NULLIF(rtrim("codi_unid_medit"::text), '')::varchar(2) AS "codi_unid_medit",
       NULLIF(rtrim("otros_acabado"::text), '')::varchar(200) AS "otros_acabado",
       NULLIF(rtrim("observaciones"::text), '')::varchar(800) AS "observaciones",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("tipo_pers"::text), '')::varchar(1) AS "tipo_pers",
       NULLIF(btrim("id_clie_natu"::text), '')::integer AS "id_clie_natu",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("tama"::text), '')::varchar(25) AS "tama",
       NULLIF(btrim("nroordefisico"::text), '')::smallint AS "nroordefisico",
       NULLIF(rtrim("otro_material"::text), '')::varchar(50) AS "otro_material",
       NULLIF(rtrim("cliente"::text), '')::varchar(75) AS "cliente",
       NULLIF(rtrim("direccion"::text), '')::varchar(75) AS "direccion",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(20) AS "nro_docu",
       NULLIF(rtrim("descripcion_item"::text), '')::varchar(1000) AS "descripcion_item",
       NULLIF(rtrim("material"::text), '')::varchar(200) AS "material",
       NULLIF(rtrim("color"::text), '')::varchar(200) AS "color",
       NULLIF(rtrim("acabado"::text), '')::varchar(200) AS "acabado",
       NULLIF(rtrim("serv_prod"::text), '')::varchar(1) AS "serv_prod",
       NULLIF(btrim("total"::text), '')::numeric(18,2) AS "total",
       NULLIF(btrim("codi_tipo_op"::text), '')::integer AS "codi_tipo_op",
       NULLIF(rtrim("aurtoriza_por"::text), '')::varchar(5) AS "aurtoriza_por",
       NULLIF(rtrim("solicitado_por"::text), '')::varchar(5) AS "solicitado_por"
FROM "legacy_raw"."orden_produccion"
ON CONFLICT DO NOTHING;

-- ORDEN_PRODUCCION_FACTURA -> produccion.orden_produccion_factura  (2 col)
INSERT INTO "produccion"."orden_produccion_factura" ("codi_orde_produc", "codi_fact")
SELECT
       NULLIF(btrim("codi_orde_produc"::text), '')::integer AS "codi_orde_produc",
       NULLIF(btrim("codi_fact"::text), '')::integer AS "codi_fact"
FROM "legacy_raw"."orden_produccion_factura"
ON CONFLICT DO NOTHING;

-- PARTE_CARGO -> produccion.parte_cargo  (8 col)
INSERT INTO "produccion"."parte_cargo" ("codi_carg", "fech_asig", "codi_unid_oper", "parte", "adicional", "espe_part", "espe_adic", "empresa")
SELECT
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg",
       NULLIF(btrim("fech_asig"::text), '')::timestamp(3) AS "fech_asig",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(btrim("parte"::text), '')::numeric(12,3) AS "parte",
       NULLIF(btrim("adicional"::text), '')::numeric(12,3) AS "adicional",
       NULLIF(btrim("espe_part"::text), '')::numeric(12,3) AS "espe_part",
       NULLIF(btrim("espe_adic"::text), '')::numeric(12,3) AS "espe_adic",
       NULLIF(btrim("empresa"::text), '')::numeric(12,3) AS "empresa"
FROM "legacy_raw"."parte_cargo"
ON CONFLICT DO NOTHING;

-- POZAS -> produccion.pozas  (2 col)
INSERT INTO "produccion"."pozas" ("codi_poza", "desc_poza")
SELECT
       NULLIF(rtrim("codi_poza"::text), '')::varchar(2) AS "codi_poza",
       NULLIF(rtrim("desc_poza"::text), '')::varchar(50) AS "desc_poza"
FROM "legacy_raw"."pozas"
ON CONFLICT DO NOTHING;

-- PRECIO_PACTADO -> produccion.precio_pactado  (5 col)
INSERT INTO "produccion"."precio_pactado" ("codi_sema", "codi_clie_prov", "codi_espe", "prec_pact", "codi_mone")
SELECT
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_espe"::text), '')::varchar(2) AS "codi_espe",
       NULLIF(btrim("prec_pact"::text), '')::numeric(9,3) AS "prec_pact",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone"
FROM "legacy_raw"."precio_pactado"
ON CONFLICT DO NOTHING;

-- PRECIO_SNP -> produccion.precio_snp  (12 col)
INSERT INTO "produccion"."precio_snp" ("codi_prec", "codi_sema", "codi_espe", "precio", "codi_mone", "jueves", "viernes", "sabado", "domingo", "lunes", "martes", "miercoles")
SELECT
       NULLIF(rtrim("codi_prec"::text), '')::varchar(10) AS "codi_prec",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(rtrim("codi_espe"::text), '')::varchar(2) AS "codi_espe",
       NULLIF(btrim("precio"::text), '')::numeric(12,3) AS "precio",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("jueves"::text), '')::numeric(18,2) AS "jueves",
       NULLIF(btrim("viernes"::text), '')::numeric(18,2) AS "viernes",
       NULLIF(btrim("sabado"::text), '')::numeric(18,2) AS "sabado",
       NULLIF(btrim("domingo"::text), '')::numeric(18,2) AS "domingo",
       NULLIF(btrim("lunes"::text), '')::numeric(18,2) AS "lunes",
       NULLIF(btrim("martes"::text), '')::numeric(18,2) AS "martes",
       NULLIF(btrim("miercoles"::text), '')::numeric(18,2) AS "miercoles"
FROM "legacy_raw"."precio_snp"
ON CONFLICT DO NOTHING;

-- propias_terceros -> produccion.propias_terceros  (2 col)
INSERT INTO "produccion"."propias_terceros" ("codi_tipo", "desc_tipo")
SELECT
       NULLIF(rtrim("codi_tipo"::text), '')::varchar(1) AS "codi_tipo",
       NULLIF(rtrim("desc_tipo"::text), '')::varchar(10) AS "desc_tipo"
FROM "legacy_raw"."propias_terceros"
ON CONFLICT DO NOTHING;

-- Puerto -> produccion.puerto  (2 col)
INSERT INTO "produccion"."puerto" ("codi_puer", "desc_puer")
SELECT
       NULLIF(rtrim("codi_puer"::text), '')::varchar(2) AS "codi_puer",
       NULLIF(rtrim("desc_puer"::text), '')::varchar(30) AS "desc_puer"
FROM "legacy_raw"."puerto"
ON CONFLICT DO NOTHING;

-- RATIO_PRODUCCION -> produccion.ratio_produccion  (6 col)
INSERT INTO "produccion"."ratio_produccion" ("codi_rati_prod", "codi_turn", "codi_rati", "fech_rati_prod", "valo_rati_prod", "codi_unid_nego")
SELECT
       NULLIF(rtrim("codi_rati_prod"::text), '')::varchar(10) AS "codi_rati_prod",
       NULLIF(rtrim("codi_turn"::text), '')::varchar(2) AS "codi_turn",
       NULLIF(rtrim("codi_rati"::text), '')::varchar(2) AS "codi_rati",
       NULLIF(btrim("fech_rati_prod"::text), '')::timestamp(3) AS "fech_rati_prod",
       NULLIF(btrim("valo_rati_prod"::text), '')::numeric(12,3) AS "valo_rati_prod",
       NULLIF(rtrim("codi_unid_nego"::text), '')::varchar(2) AS "codi_unid_nego"
FROM "legacy_raw"."ratio_produccion"
ON CONFLICT DO NOTHING;

-- Saldo_Poza -> produccion.saldo_poza  (8 col)
INSERT INTO "produccion"."saldo_poza" ("codi_sald_poza", "codi_turn", "codi_poza", "sald_ante", "cant_desc_poza", "cons_prod", "sald_fina", "fecha")
SELECT
       NULLIF(rtrim("codi_sald_poza"::text), '')::varchar(10) AS "codi_sald_poza",
       NULLIF(rtrim("codi_turn"::text), '')::varchar(2) AS "codi_turn",
       NULLIF(rtrim("codi_poza"::text), '')::varchar(2) AS "codi_poza",
       NULLIF(btrim("sald_ante"::text), '')::numeric(12,3) AS "sald_ante",
       NULLIF(btrim("cant_desc_poza"::text), '')::numeric(12,3) AS "cant_desc_poza",
       NULLIF(btrim("cons_prod"::text), '')::numeric(12,3) AS "cons_prod",
       NULLIF(btrim("sald_fina"::text), '')::numeric(12,3) AS "sald_fina",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha"
FROM "legacy_raw"."saldo_poza"
ON CONFLICT DO NOTHING;

-- SALDO_TANQUES -> produccion.saldo_tanques  (8 col)
INSERT INTO "produccion"."saldo_tanques" ("codi_sald_tanq", "codi_tanq_auxi", "codi_turn", "petr_ante", "petr_ingr", "petr_sali", "petr_fina", "fecha")
SELECT
       NULLIF(rtrim("codi_sald_tanq"::text), '')::varchar(10) AS "codi_sald_tanq",
       NULLIF(rtrim("codi_tanq_auxi"::text), '')::varchar(3) AS "codi_tanq_auxi",
       NULLIF(rtrim("codi_turn"::text), '')::varchar(2) AS "codi_turn",
       NULLIF(btrim("petr_ante"::text), '')::numeric(12,3) AS "petr_ante",
       NULLIF(btrim("petr_ingr"::text), '')::numeric(12,3) AS "petr_ingr",
       NULLIF(btrim("petr_sali"::text), '')::numeric(12,3) AS "petr_sali",
       NULLIF(btrim("petr_fina"::text), '')::numeric(12,3) AS "petr_fina",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha"
FROM "legacy_raw"."saldo_tanques"
ON CONFLICT DO NOTHING;

-- SISTEMAS_EMBARCACIONES -> produccion.sistemas_embarcaciones  (3 col)
INSERT INTO "produccion"."sistemas_embarcaciones" ("codi_sist_emba", "desc_sist_emba", "nemo_sist_emba")
SELECT
       NULLIF(rtrim("codi_sist_emba"::text), '')::varchar(2) AS "codi_sist_emba",
       NULLIF(rtrim("desc_sist_emba"::text), '')::varchar(100) AS "desc_sist_emba",
       NULLIF(rtrim("nemo_sist_emba"::text), '')::varchar(20) AS "nemo_sist_emba"
FROM "legacy_raw"."sistemas_embarcaciones"
ON CONFLICT DO NOTHING;

-- SITU_EMBA -> produccion.situ_emba  (3 col)
INSERT INTO "produccion"."situ_emba" ("codi_situ", "desc_situ", "nemo_situ")
SELECT
       NULLIF(rtrim("codi_situ"::text), '')::varchar(2) AS "codi_situ",
       NULLIF(rtrim("desc_situ"::text), '')::varchar(50) AS "desc_situ",
       NULLIF(rtrim("nemo_situ"::text), '')::varchar(10) AS "nemo_situ"
FROM "legacy_raw"."situ_emba"
ON CONFLICT DO NOTHING;

-- Taller_Diario -> produccion.taller_diario  (6 col)
INSERT INTO "produccion"."taller_diario" ("codi_tall", "codi_unid_oper", "codi_item", "fecha", "descripcion", "monto")
SELECT
       NULLIF(rtrim("codi_tall"::text), '')::varchar(2) AS "codi_tall",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_item"::text), '')::varchar(3) AS "codi_item",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("descripcion"::text), '')::varchar(150) AS "descripcion",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto"
FROM "legacy_raw"."taller_diario"
ON CONFLICT DO NOTHING;

-- Talleres -> produccion.talleres  (2 col)
INSERT INTO "produccion"."talleres" ("codi_tall", "nombre")
SELECT
       NULLIF(rtrim("codi_tall"::text), '')::varchar(2) AS "codi_tall",
       NULLIF(rtrim("nombre"::text), '')::varchar(30) AS "nombre"
FROM "legacy_raw"."talleres"
ON CONFLICT DO NOTHING;

-- TANQ_AUXILIAR -> produccion.tanq_auxiliar  (3 col)
INSERT INTO "produccion"."tanq_auxiliar" ("codi_tanq_auxi", "desc_tanq_auxi", "stoc_tanq_auxi")
SELECT
       NULLIF(rtrim("codi_tanq_auxi"::text), '')::varchar(3) AS "codi_tanq_auxi",
       NULLIF(rtrim("desc_tanq_auxi"::text), '')::varchar(50) AS "desc_tanq_auxi",
       NULLIF(btrim("stoc_tanq_auxi"::text), '')::numeric(12,3) AS "stoc_tanq_auxi"
FROM "legacy_raw"."tanq_auxiliar"
ON CONFLICT DO NOTHING;

-- TANQUES -> produccion.tanques  (4 col)
INSERT INTO "produccion"."tanques" ("codi_tanq", "desc_tanq", "stoc_tanq", "capa_tanq")
SELECT
       NULLIF(rtrim("codi_tanq"::text), '')::varchar(2) AS "codi_tanq",
       NULLIF(rtrim("desc_tanq"::text), '')::varchar(50) AS "desc_tanq",
       NULLIF(btrim("stoc_tanq"::text), '')::numeric(12,3) AS "stoc_tanq",
       NULLIF(btrim("capa_tanq"::text), '')::numeric(12,3) AS "capa_tanq"
FROM "legacy_raw"."tanques"
ON CONFLICT DO NOTHING;

-- TIPO_CERT_EMBA -> produccion.tipo_cert_emba  (3 col)
INSERT INTO "produccion"."tipo_cert_emba" ("codi_tipo_cert", "desc_tipo_cert", "nemo_tipo_cert")
SELECT
       NULLIF(rtrim("codi_tipo_cert"::text), '')::varchar(2) AS "codi_tipo_cert",
       NULLIF(rtrim("desc_tipo_cert"::text), '')::varchar(100) AS "desc_tipo_cert",
       NULLIF(rtrim("nemo_tipo_cert"::text), '')::varchar(20) AS "nemo_tipo_cert"
FROM "legacy_raw"."tipo_cert_emba"
ON CONFLICT DO NOTHING;

-- TIPO_DESTINO -> produccion.tipo_destino  (3 col)
INSERT INTO "produccion"."tipo_destino" ("codi_tipo_dest", "desc_tipo_dest", "nemo")
SELECT
       NULLIF(rtrim("codi_tipo_dest"::text), '')::varchar(2) AS "codi_tipo_dest",
       NULLIF(rtrim("desc_tipo_dest"::text), '')::varchar(100) AS "desc_tipo_dest",
       NULLIF(rtrim("nemo"::text), '')::varchar(4) AS "nemo"
FROM "legacy_raw"."tipo_destino"
ON CONFLICT DO NOTHING;

-- TIPO_TITU_PESC -> produccion.tipo_titu_pesc  (4 col)
INSERT INTO "produccion"."tipo_titu_pesc" ("codi_tipo_titu_pesc", "desc_tipo_titu_pesc", "abre", "orden")
SELECT
       NULLIF(rtrim("codi_tipo_titu_pesc"::text), '')::varchar(2) AS "codi_tipo_titu_pesc",
       NULLIF(rtrim("desc_tipo_titu_pesc"::text), '')::varchar(50) AS "desc_tipo_titu_pesc",
       NULLIF(rtrim("abre"::text), '')::varchar(20) AS "abre",
       NULLIF(btrim("orden"::text), '')::integer AS "orden"
FROM "legacy_raw"."tipo_titu_pesc"
ON CONFLICT DO NOTHING;

-- TIPOS_ORDEN_PRODUCCION -> produccion.tipos_orden_produccion  (3 col)
INSERT INTO "produccion"."tipos_orden_produccion" ("codi_tipo_op", "desc_tipo_op", "nemo")
SELECT
       NULLIF(btrim("codi_tipo_op"::text), '')::integer AS "codi_tipo_op",
       NULLIF(rtrim("desc_tipo_op"::text), '')::varchar(50) AS "desc_tipo_op",
       NULLIF(rtrim("nemo"::text), '')::varchar(20) AS "nemo"
FROM "legacy_raw"."tipos_orden_produccion"
ON CONFLICT DO NOTHING;

-- ZARP_OBSE -> produccion.zarp_obse  (5 col)
INSERT INTO "produccion"."zarp_obse" ("codi_zarp", "nro_obse", "desc_obse", "nro_cuen", "codi_sist_emba")
SELECT
       NULLIF(rtrim("codi_zarp"::text), '')::varchar(10) AS "codi_zarp",
       NULLIF(btrim("nro_obse"::text), '')::smallint AS "nro_obse",
       NULLIF(rtrim("desc_obse"::text), '')::varchar(250) AS "desc_obse",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("codi_sist_emba"::text), '')::varchar(2) AS "codi_sist_emba"
FROM "legacy_raw"."zarp_obse"
ON CONFLICT DO NOTHING;

-- ZARPE_COMBUSTIBLE -> produccion.zarpe_combustible  (13 col)
INSERT INTO "produccion"."zarpe_combustible" ("codi_zarp", "codi_petr", "ser_fact", "nro_fact", "cant_petr", "prec_petr", "tipo_doc", "estado", "valo_vent", "igv", "valo_tota", "codi_mone", "tc")
SELECT
       NULLIF(rtrim("codi_zarp"::text), '')::varchar(10) AS "codi_zarp",
       NULLIF(rtrim("codi_petr"::text), '')::varchar(3) AS "codi_petr",
       NULLIF(rtrim("ser_fact"::text), '')::varchar(5) AS "ser_fact",
       NULLIF(rtrim("nro_fact"::text), '')::varchar(10) AS "nro_fact",
       NULLIF(btrim("cant_petr"::text), '')::numeric(12,3) AS "cant_petr",
       NULLIF(btrim("prec_petr"::text), '')::numeric(12,4) AS "prec_petr",
       NULLIF(rtrim("tipo_doc"::text), '')::varchar(1) AS "tipo_doc",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(btrim("valo_vent"::text), '')::numeric(12,3) AS "valo_vent",
       NULLIF(btrim("igv"::text), '')::numeric(12,3) AS "igv",
       NULLIF(btrim("valo_tota"::text), '')::numeric(12,3) AS "valo_tota",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("tc"::text), '')::numeric(18,4) AS "tc"
FROM "legacy_raw"."zarpe_combustible"
ON CONFLICT DO NOTHING;

-- ZARPES -> produccion.zarpes  (43 col)
INSERT INTO "produccion"."zarpes" ("codi_zarp", "fech_repo", "codi_sema", "fech_desc", "codi_unid_oper", "codi_puer", "zona_pesc", "fech_zarp", "fech_arri", "zona_arri", "zona_pesc_arri", "codi_unid_medi", "pesc_esti", "pesc_real", "fech_inic_desc", "fech_term_desc", "obse_pesc", "cord_capt", "temp_capt", "nume_cala", "fech_posi_arri", "codi_puer2", "comb_reci", "codi_clie_prov", "codi_prov_petr", "nro_cgs", "fech_sgs", "desc_sgs", "luga_desc", "obse_pesc2", "obse_pesc3", "luga_fond", "codi_patr", "orom_mp", "orom_ma1", "orom_ma2", "codi_situ", "pesc_tota", "codi_sema_fact", "codi_sama_fact", "refrigerada", "conserva", "fondeada")
SELECT
       NULLIF(rtrim("codi_zarp"::text), '')::varchar(10) AS "codi_zarp",
       NULLIF(btrim("fech_repo"::text), '')::timestamp(3) AS "fech_repo",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(btrim("fech_desc"::text), '')::timestamp(3) AS "fech_desc",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_puer"::text), '')::varchar(2) AS "codi_puer",
       NULLIF(rtrim("zona_pesc"::text), '')::varchar(75) AS "zona_pesc",
       NULLIF(btrim("fech_zarp"::text), '')::timestamp(3) AS "fech_zarp",
       NULLIF(btrim("fech_arri"::text), '')::timestamp(3) AS "fech_arri",
       NULLIF(rtrim("zona_arri"::text), '')::varchar(75) AS "zona_arri",
       NULLIF(rtrim("zona_pesc_arri"::text), '')::varchar(75) AS "zona_pesc_arri",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(btrim("pesc_esti"::text), '')::numeric(18,3) AS "pesc_esti",
       NULLIF(btrim("pesc_real"::text), '')::numeric(18,3) AS "pesc_real",
       NULLIF(btrim("fech_inic_desc"::text), '')::timestamp(3) AS "fech_inic_desc",
       NULLIF(btrim("fech_term_desc"::text), '')::timestamp(3) AS "fech_term_desc",
       NULLIF(rtrim("obse_pesc"::text), '')::varchar(150) AS "obse_pesc",
       NULLIF(rtrim("cord_capt"::text), '')::varchar(25) AS "cord_capt",
       NULLIF(rtrim("temp_capt"::text), '')::varchar(20) AS "temp_capt",
       NULLIF(btrim("nume_cala"::text), '')::integer AS "nume_cala",
       NULLIF(btrim("fech_posi_arri"::text), '')::timestamp(3) AS "fech_posi_arri",
       NULLIF(rtrim("codi_puer2"::text), '')::varchar(2) AS "codi_puer2",
       NULLIF(btrim("comb_reci"::text), '')::bigint AS "comb_reci",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_prov_petr"::text), '')::varchar(5) AS "codi_prov_petr",
       NULLIF(rtrim("nro_cgs"::text), '')::varchar(10) AS "nro_cgs",
       NULLIF(btrim("fech_sgs"::text), '')::timestamp(3) AS "fech_sgs",
       NULLIF(btrim("desc_sgs"::text), '')::numeric(18,3) AS "desc_sgs",
       NULLIF(rtrim("luga_desc"::text), '')::varchar(200) AS "luga_desc",
       NULLIF(rtrim("obse_pesc2"::text), '')::varchar(250) AS "obse_pesc2",
       NULLIF(rtrim("obse_pesc3"::text), '')::varchar(250) AS "obse_pesc3",
       NULLIF(rtrim("luga_fond"::text), '')::varchar(250) AS "luga_fond",
       NULLIF(rtrim("codi_patr"::text), '')::varchar(5) AS "codi_patr",
       NULLIF(btrim("orom_mp"::text), '')::numeric(18,4) AS "orom_mp",
       NULLIF(btrim("orom_ma1"::text), '')::numeric(18,4) AS "orom_ma1",
       NULLIF(btrim("orom_ma2"::text), '')::numeric(18,4) AS "orom_ma2",
       NULLIF(rtrim("codi_situ"::text), '')::varchar(2) AS "codi_situ",
       NULLIF(btrim("pesc_tota"::text), '')::numeric(18,3) AS "pesc_tota",
       NULLIF(rtrim("codi_sema_fact"::text), '')::varchar(8) AS "codi_sema_fact",
       NULLIF(rtrim("codi_sama_fact"::text), '')::varchar(8) AS "codi_sama_fact",
       NULLIF(rtrim("refrigerada"::text), '')::varchar(1) AS "refrigerada",
       NULLIF(rtrim("conserva"::text), '')::varchar(1) AS "conserva",
       NULLIF(btrim("fondeada"::text), '')::boolean AS "fondeada"
FROM "legacy_raw"."zarpes"
ON CONFLICT DO NOTHING;

-- reajuste de secuencias de identidad del legado
SELECT setval(pg_get_serial_sequence('"produccion"."analisis_aceite"', 'cod_analisis'),
              (SELECT COALESCE(MAX("cod_analisis"), 1) FROM "produccion"."analisis_aceite"),
              (SELECT COUNT(*) > 0 FROM "produccion"."analisis_aceite"));

COMMIT;

-- =====================================================================
-- ESQUEMA rrhh  (123 tablas)
-- =====================================================================
BEGIN;
SET LOCAL session_replication_role = replica;

-- ABOGADOS -> rrhh.abogados  (5 col)
INSERT INTO "rrhh"."abogados" ("codi_abog", "apel_1", "apel_2", "nomb_1", "nomb_2")
SELECT
       NULLIF(rtrim("codi_abog"::text), '')::varchar(3) AS "codi_abog",
       NULLIF(rtrim("apel_1"::text), '')::varchar(50) AS "apel_1",
       NULLIF(rtrim("apel_2"::text), '')::varchar(50) AS "apel_2",
       NULLIF(rtrim("nomb_1"::text), '')::varchar(50) AS "nomb_1",
       NULLIF(rtrim("nomb_2"::text), '')::varchar(50) AS "nomb_2"
FROM "legacy_raw"."abogados"
ON CONFLICT DO NOTHING;

-- ACTIVIDAD -> rrhh.actividad  (3 col)
INSERT INTO "rrhh"."actividad" ("codi_acti", "codi_acti_sunat", "desc_acti")
SELECT
       NULLIF(btrim("codi_acti"::text), '')::smallint AS "codi_acti",
       NULLIF(rtrim("codi_acti_sunat"::text), '')::varchar(5) AS "codi_acti_sunat",
       NULLIF(rtrim("desc_acti"::text), '')::varchar(100) AS "desc_acti"
FROM "legacy_raw"."actividad"
ON CONFLICT DO NOTHING;

-- Adelanto_EP_terceros -> rrhh.adelanto_ep_terceros  (9 col)
INSERT INTO "rrhh"."adelanto_ep_terceros" ("codi_adel_terc", "codi_unid_oper", "nro_adel", "fech_adel", "moti_adel", "esta_pago", "codi_mone_adel", "mont_adel", "codi_sema")
SELECT
       NULLIF(rtrim("codi_adel_terc"::text), '')::varchar(6) AS "codi_adel_terc",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(btrim("nro_adel"::text), '')::integer AS "nro_adel",
       NULLIF(btrim("fech_adel"::text), '')::timestamp(3) AS "fech_adel",
       NULLIF(rtrim("moti_adel"::text), '')::varchar(100) AS "moti_adel",
       NULLIF(btrim("esta_pago"::text), '')::boolean AS "esta_pago",
       NULLIF(rtrim("codi_mone_adel"::text), '')::varchar(2) AS "codi_mone_adel",
       NULLIF(btrim("mont_adel"::text), '')::numeric(12,2) AS "mont_adel",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema"
FROM "legacy_raw"."adelanto_ep_terceros"
ON CONFLICT DO NOTHING;

-- ADELANTOS -> rrhh.adelantos  (13 col)
INSERT INTO "rrhh"."adelantos" ("codi_adel", "codi_pers", "nro_adel", "fech_adel", "moti_adel", "esta_pago", "codi_mone_adel", "mont_adel", "tipo_adel", "inte_tiem_desc", "mont_pago", "saldo", "regi_adel")
SELECT
       NULLIF(rtrim("codi_adel"::text), '')::varchar(6) AS "codi_adel",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("nro_adel"::text), '')::integer AS "nro_adel",
       NULLIF(btrim("fech_adel"::text), '')::timestamp(3) AS "fech_adel",
       NULLIF(rtrim("moti_adel"::text), '')::varchar(100) AS "moti_adel",
       NULLIF(btrim("esta_pago"::text), '')::boolean AS "esta_pago",
       NULLIF(rtrim("codi_mone_adel"::text), '')::varchar(2) AS "codi_mone_adel",
       NULLIF(btrim("mont_adel"::text), '')::numeric(12,2) AS "mont_adel",
       NULLIF(rtrim("tipo_adel"::text), '')::varchar(5) AS "tipo_adel",
       NULLIF(rtrim("inte_tiem_desc"::text), '')::varchar(20) AS "inte_tiem_desc",
       NULLIF(btrim("mont_pago"::text), '')::numeric(12,2) AS "mont_pago",
       NULLIF(btrim("saldo"::text), '')::numeric(12,2) AS "saldo",
       NULLIF(rtrim("regi_adel"::text), '')::varchar(10) AS "regi_adel"
FROM "legacy_raw"."adelantos"
ON CONFLICT DO NOTHING;

-- AREA_GRUP -> rrhh.area_grup  (3 col)
INSERT INTO "rrhh"."area_grup" ("codi_area_grup", "desc_area_grup", "jera_area")
SELECT
       NULLIF(rtrim("codi_area_grup"::text), '')::varchar(2) AS "codi_area_grup",
       NULLIF(rtrim("desc_area_grup"::text), '')::varchar(100) AS "desc_area_grup",
       NULLIF(btrim("jera_area"::text), '')::smallint AS "jera_area"
FROM "legacy_raw"."area_grup"
ON CONFLICT DO NOTHING;

-- AREAS -> rrhh.areas  (4 col)
INSERT INTO "rrhh"."areas" ("codi_area", "nomb_area", "ubica", "area_grup")
SELECT
       NULLIF(rtrim("codi_area"::text), '')::varchar(2) AS "codi_area",
       NULLIF(rtrim("nomb_area"::text), '')::varchar(50) AS "nomb_area",
       NULLIF(rtrim("ubica"::text), '')::varchar(50) AS "ubica",
       NULLIF(rtrim("area_grup"::text), '')::varchar(2) AS "area_grup"
FROM "legacy_raw"."areas"
ON CONFLICT DO NOTHING;

-- ASISTENCIA_MAQUI_MOTOR -> rrhh.asistencia_maqui_motor  (3 col)
INSERT INTO "rrhh"."asistencia_maqui_motor" ("codi_pers", "fech_asis", "asis_pers")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("fech_asis"::text), '')::timestamp(3) AS "fech_asis",
       NULLIF(btrim("asis_pers"::text), '')::boolean AS "asis_pers"
FROM "legacy_raw"."asistencia_maqui_motor"
ON CONFLICT DO NOTHING;

-- ASISTENCIA_MOTORISTA -> rrhh.asistencia_motorista  (6 col)
INSERT INTO "rrhh"."asistencia_motorista" ("mesanio", "codi_unid_oper", "codi_pers", "codi_carg", "dias_traba_quin", "dias_traba_mens")
SELECT
       NULLIF(rtrim("mesanio"::text), '')::varchar(6) AS "mesanio",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg",
       NULLIF(btrim("dias_traba_quin"::text), '')::integer AS "dias_traba_quin",
       NULLIF(btrim("dias_traba_mens"::text), '')::integer AS "dias_traba_mens"
FROM "legacy_raw"."asistencia_motorista"
ON CONFLICT DO NOTHING;

-- ASISTENCIA_PERSONAL -> rrhh.asistencia_personal  (7 col)
INSERT INTO "rrhh"."asistencia_personal" ("codi_pers", "fecha", "turno", "he1", "hs1", "codi_usua", "codi_usua_modi")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("fecha"::text), '')::varchar(10) AS "fecha",
       NULLIF(btrim("turno"::text), '')::integer AS "turno",
       NULLIF(btrim("he1"::text), '')::timestamp(3) AS "he1",
       NULLIF(btrim("hs1"::text), '')::timestamp(3) AS "hs1",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(rtrim("codi_usua_modi"::text), '')::varchar(5) AS "codi_usua_modi"
FROM "legacy_raw"."asistencia_personal"
ON CONFLICT DO NOTHING;

-- ASISTENCIA_TRIPULANTES_PESCA -> rrhh.asistencia_tripulantes_pesca  (20 col)
INSERT INTO "rrhh"."asistencia_tripulantes_pesca" ("codi_sema", "codi_unid_oper", "codi_pers", "codi_carg", "jueves", "viernes", "sabado", "domingo", "lunes", "martes", "miercoles", "juev_carg", "vier_carg", "saba_carg", "domi_carg", "lune_carg", "mart_carg", "mier_carg", "nro_asis", "mesanio")
SELECT
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg",
       NULLIF(rtrim("jueves"::text), '')::varchar(1) AS "jueves",
       NULLIF(rtrim("viernes"::text), '')::varchar(1) AS "viernes",
       NULLIF(rtrim("sabado"::text), '')::varchar(1) AS "sabado",
       NULLIF(rtrim("domingo"::text), '')::varchar(1) AS "domingo",
       NULLIF(rtrim("lunes"::text), '')::varchar(1) AS "lunes",
       NULLIF(rtrim("martes"::text), '')::varchar(1) AS "martes",
       NULLIF(rtrim("miercoles"::text), '')::varchar(1) AS "miercoles",
       NULLIF(rtrim("juev_carg"::text), '')::varchar(4) AS "juev_carg",
       NULLIF(rtrim("vier_carg"::text), '')::varchar(4) AS "vier_carg",
       NULLIF(rtrim("saba_carg"::text), '')::varchar(4) AS "saba_carg",
       NULLIF(rtrim("domi_carg"::text), '')::varchar(4) AS "domi_carg",
       NULLIF(rtrim("lune_carg"::text), '')::varchar(4) AS "lune_carg",
       NULLIF(rtrim("mart_carg"::text), '')::varchar(4) AS "mart_carg",
       NULLIF(rtrim("mier_carg"::text), '')::varchar(4) AS "mier_carg",
       NULLIF(rtrim("nro_asis"::text), '')::varchar(1) AS "nro_asis",
       NULLIF(rtrim("mesanio"::text), '')::varchar(6) AS "mesanio"
FROM "legacy_raw"."asistencia_tripulantes_pesca"
ON CONFLICT DO NOTHING;

-- AUTO_TRAB_CENT_OPER -> rrhh.auto_trab_cent_oper  (13 col)
INSERT INTO "rrhh"."auto_trab_cent_oper" ("codi_auto_trab_co", "nro_auto", "fecha", "unid_oper_soli", "unid_oper_co", "codi_puer_oper", "lugar", "codi_usua_soli", "codi_usua_jefe_tall", "codi_usua_auto_mant", "codi_usua_auto_flot", "desc_gene_trab", "desc_gene_trab_1")
SELECT
       NULLIF(rtrim("codi_auto_trab_co"::text), '')::varchar(5) AS "codi_auto_trab_co",
       NULLIF(btrim("nro_auto"::text), '')::integer AS "nro_auto",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("unid_oper_soli"::text), '')::varchar(5) AS "unid_oper_soli",
       NULLIF(rtrim("unid_oper_co"::text), '')::varchar(5) AS "unid_oper_co",
       NULLIF(rtrim("codi_puer_oper"::text), '')::varchar(2) AS "codi_puer_oper",
       NULLIF(rtrim("lugar"::text), '')::varchar(250) AS "lugar",
       NULLIF(rtrim("codi_usua_soli"::text), '')::varchar(5) AS "codi_usua_soli",
       NULLIF(rtrim("codi_usua_jefe_tall"::text), '')::varchar(5) AS "codi_usua_jefe_tall",
       NULLIF(rtrim("codi_usua_auto_mant"::text), '')::varchar(5) AS "codi_usua_auto_mant",
       NULLIF(rtrim("codi_usua_auto_flot"::text), '')::varchar(5) AS "codi_usua_auto_flot",
       NULLIF(rtrim("desc_gene_trab"::text), '')::varchar(250) AS "desc_gene_trab",
       NULLIF(rtrim("desc_gene_trab_1"::text), '')::varchar(250) AS "desc_gene_trab_1"
FROM "legacy_raw"."auto_trab_cent_oper"
ON CONFLICT DO NOTHING;

-- AUTO_TRAB_CENT_OPER_DETA -> rrhh.auto_trab_cent_oper_deta  (13 col)
INSERT INTO "rrhh"."auto_trab_cent_oper_deta" ("codi_auto_trab_co", "nro_deta", "codi_pers", "fech_inic", "fech_term", "nume_hora_norm", "nume_hora_25", "nume_hora_35", "nume_hora_noct", "situ_hora_25", "situ_hora_35", "situ_hora_noct", "deta_trab")
SELECT
       NULLIF(rtrim("codi_auto_trab_co"::text), '')::varchar(5) AS "codi_auto_trab_co",
       NULLIF(btrim("nro_deta"::text), '')::smallint AS "nro_deta",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_term"::text), '')::timestamp(3) AS "fech_term",
       NULLIF(btrim("nume_hora_norm"::text), '')::numeric(9,2) AS "nume_hora_norm",
       NULLIF(btrim("nume_hora_25"::text), '')::numeric(9,2) AS "nume_hora_25",
       NULLIF(btrim("nume_hora_35"::text), '')::numeric(9,2) AS "nume_hora_35",
       NULLIF(btrim("nume_hora_noct"::text), '')::numeric(9,2) AS "nume_hora_noct",
       NULLIF(rtrim("situ_hora_25"::text), '')::varchar(2) AS "situ_hora_25",
       NULLIF(rtrim("situ_hora_35"::text), '')::varchar(2) AS "situ_hora_35",
       NULLIF(rtrim("situ_hora_noct"::text), '')::varchar(2) AS "situ_hora_noct",
       NULLIF(rtrim("deta_trab"::text), '')::varchar(250) AS "deta_trab"
FROM "legacy_raw"."auto_trab_cent_oper_deta"
ON CONFLICT DO NOTHING;

-- CALC_UTIL_DETA -> rrhh.calc_util_deta  (7 col)
INSERT INTO "rrhh"."calc_util_deta" ("codi_pers", "anio", "codi_conc", "valor", "monto", "codi_auxi", "nro_pago")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("codi_conc"::text), '')::varchar(7) AS "codi_conc",
       NULLIF(btrim("valor"::text), '')::numeric(18,2) AS "valor",
       NULLIF(btrim("monto"::text), '')::numeric(18,2) AS "monto",
       NULLIF(rtrim("codi_auxi"::text), '')::varchar(10) AS "codi_auxi",
       NULLIF(btrim("nro_pago"::text), '')::integer AS "nro_pago"
FROM "legacy_raw"."calc_util_deta"
ON CONFLICT DO NOTHING;

-- CALC_UTIL_PERS -> rrhh.calc_util_pers  (10 col)
INSERT INTO "rrhh"."calc_util_pers" ("anio", "codi_pers", "apellidos", "nombres", "remu_perc", "dias_labo", "liq_remu_perc", "liq_dias_labo", "liq_tota", "mes")
SELECT
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("apellidos"::text), '')::varchar(50) AS "apellidos",
       NULLIF(rtrim("nombres"::text), '')::varchar(50) AS "nombres",
       NULLIF(btrim("remu_perc"::text), '')::numeric(18,2) AS "remu_perc",
       NULLIF(btrim("dias_labo"::text), '')::bigint AS "dias_labo",
       NULLIF(btrim("liq_remu_perc"::text), '')::numeric(18,2) AS "liq_remu_perc",
       NULLIF(btrim("liq_dias_labo"::text), '')::numeric(18,2) AS "liq_dias_labo",
       NULLIF(btrim("liq_tota"::text), '')::numeric(18,2) AS "liq_tota",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes"
FROM "legacy_raw"."calc_util_pers"
ON CONFLICT DO NOTHING;

-- CALC_UTIL_TOTA -> rrhh.calc_util_tota  (5 col)
INSERT INTO "rrhh"."calc_util_tota" ("anio", "renta_neta", "participacion", "remu_perc_tota", "dias_labo_tota")
SELECT
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(btrim("renta_neta"::text), '')::numeric(18,2) AS "renta_neta",
       NULLIF(btrim("participacion"::text), '')::numeric(18,2) AS "participacion",
       NULLIF(btrim("remu_perc_tota"::text), '')::numeric(18,2) AS "remu_perc_tota",
       NULLIF(btrim("dias_labo_tota"::text), '')::bigint AS "dias_labo_tota"
FROM "legacy_raw"."calc_util_tota"
ON CONFLICT DO NOTHING;

-- CARGOS -> rrhh.cargos  (7 col)
INSERT INTO "rrhh"."cargos" ("codi_carg", "tipo_carg", "desc_cargo", "abrev", "carg_mostrar", "jera", "codi_ocu")
SELECT
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg",
       NULLIF(rtrim("tipo_carg"::text), '')::varchar(50) AS "tipo_carg",
       NULLIF(rtrim("desc_cargo"::text), '')::varchar(150) AS "desc_cargo",
       NULLIF(rtrim("abrev"::text), '')::varchar(2) AS "abrev",
       NULLIF(rtrim("carg_mostrar"::text), '')::varchar(100) AS "carg_mostrar",
       NULLIF(btrim("jera"::text), '')::smallint AS "jera",
       NULLIF(btrim("codi_ocu"::text), '')::smallint AS "codi_ocu"
FROM "legacy_raw"."cargos"
ON CONFLICT DO NOTHING;

-- CATEGORIA_OCUPACIONAL -> rrhh.categoria_ocupacional  (6 col)
INSERT INTO "rrhh"."categoria_ocupacional" ("cod_categ_ocup", "desc_categ_ocup", "codigo_sunat", "privador", "publico", "otro")
SELECT
       NULLIF(btrim("cod_categ_ocup"::text), '')::integer AS "cod_categ_ocup",
       NULLIF(rtrim("desc_categ_ocup"::text), '')::varchar(100) AS "desc_categ_ocup",
       NULLIF(btrim("codigo_sunat"::text), '')::integer AS "codigo_sunat",
       NULLIF(rtrim("privador"::text), '')::varchar(1) AS "privador",
       NULLIF(rtrim("publico"::text), '')::varchar(1) AS "publico",
       NULLIF(rtrim("otro"::text), '')::varchar(1) AS "otro"
FROM "legacy_raw"."categoria_ocupacional"
ON CONFLICT DO NOTHING;

-- CATEGORIA_TRABAJADOR -> rrhh.categoria_trabajador  (5 col)
INSERT INTO "rrhh"."categoria_trabajador" ("codi_cate_trab", "desc_cate_trab", "abre_cate_trab", "orde_cate_trab", "codi_sunat")
SELECT
       NULLIF(btrim("codi_cate_trab"::text), '')::smallint AS "codi_cate_trab",
       NULLIF(rtrim("desc_cate_trab"::text), '')::varchar(50) AS "desc_cate_trab",
       NULLIF(rtrim("abre_cate_trab"::text), '')::varchar(12) AS "abre_cate_trab",
       NULLIF(btrim("orde_cate_trab"::text), '')::smallint AS "orde_cate_trab",
       NULLIF(btrim("codi_sunat"::text), '')::integer AS "codi_sunat"
FROM "legacy_raw"."categoria_trabajador"
ON CONFLICT DO NOTHING;

-- CONCEPTOS -> rrhh.conceptos  (6 col)
INSERT INTO "rrhh"."conceptos" ("codi_conc", "desc_conc", "esta_acti", "nemo", "codi_sub_concep_sunat", "variable")
SELECT
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(rtrim("desc_conc"::text), '')::varchar(60) AS "desc_conc",
       NULLIF(btrim("esta_acti"::text), '')::boolean AS "esta_acti",
       NULLIF(rtrim("nemo"::text), '')::varchar(20) AS "nemo",
       NULLIF(btrim("codi_sub_concep_sunat"::text), '')::smallint AS "codi_sub_concep_sunat",
       NULLIF(rtrim("variable"::text), '')::varchar(3) AS "variable"
FROM "legacy_raw"."conceptos"
ON CONFLICT DO NOTHING;

-- CONCEPTOS_AFECTOS_PLANILLAS -> rrhh.conceptos_afectos_planillas  (9 col)
INSERT INTO "rrhh"."conceptos_afectos_planillas" ("codi_conc", "codi_tipo_plan", "fech_regi", "afecto", "esta_acti", "codi_valo_unit", "rubro", "grupo", "formula")
SELECT
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(rtrim("codi_tipo_plan"::text), '')::varchar(2) AS "codi_tipo_plan",
       NULLIF(btrim("fech_regi"::text), '')::timestamp(3) AS "fech_regi",
       NULLIF(btrim("afecto"::text), '')::boolean AS "afecto",
       NULLIF(btrim("esta_acti"::text), '')::boolean AS "esta_acti",
       NULLIF(btrim("codi_valo_unit"::text), '')::integer AS "codi_valo_unit",
       NULLIF(rtrim("rubro"::text), '')::varchar(2) AS "rubro",
       NULLIF(rtrim("grupo"::text), '')::varchar(1) AS "grupo",
       NULLIF(rtrim("formula"::text), '')::varchar(250) AS "formula"
FROM "legacy_raw"."conceptos_afectos_planillas"
ON CONFLICT DO NOTHING;

-- CONCEPTOS_CONTABLES -> rrhh.conceptos_contables  (12 col)
INSERT INTO "rrhh"."conceptos_contables" ("codi_conc", "nro_cuen", "codi_conc_fina", "carg_abon", "tipo_cont", "codi_tipo_plan", "codi_tipo_prov", "codi_tipo_pers", "codi_uni_oper", "fact_mult", "codi_sist_pens", "codi_rela")
SELECT
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("codi_conc_fina"::text), '')::varchar(6) AS "codi_conc_fina",
       NULLIF(rtrim("carg_abon"::text), '')::varchar(1) AS "carg_abon",
       NULLIF(rtrim("tipo_cont"::text), '')::varchar(1) AS "tipo_cont",
       NULLIF(rtrim("codi_tipo_plan"::text), '')::varchar(2) AS "codi_tipo_plan",
       NULLIF(rtrim("codi_tipo_prov"::text), '')::varchar(2) AS "codi_tipo_prov",
       NULLIF(rtrim("codi_tipo_pers"::text), '')::varchar(2) AS "codi_tipo_pers",
       NULLIF(rtrim("codi_uni_oper"::text), '')::varchar(5) AS "codi_uni_oper",
       NULLIF(btrim("fact_mult"::text), '')::numeric(9,4) AS "fact_mult",
       NULLIF(rtrim("codi_sist_pens"::text), '')::varchar(2) AS "codi_sist_pens",
       NULLIF(rtrim("codi_rela"::text), '')::varchar(5) AS "codi_rela"
FROM "legacy_raw"."conceptos_contables"
ON CONFLICT DO NOTHING;

-- CONSTANCIA_JUICIOS -> rrhh.constancia_juicios  (15 col)
INSERT INTO "rrhh"."constancia_juicios" ("codi_juic", "nro_pago", "codi_pers", "codi_unid_oper", "registro", "bene_juic", "nro_reso", "juzgado", "valor", "semana", "fecha", "dni", "nro_asis", "tipo", "mesanio")
SELECT
       NULLIF(rtrim("codi_juic"::text), '')::varchar(6) AS "codi_juic",
       NULLIF(rtrim("nro_pago"::text), '')::varchar(4) AS "nro_pago",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("registro"::text), '')::varchar(10) AS "registro",
       NULLIF(rtrim("bene_juic"::text), '')::varchar(200) AS "bene_juic",
       NULLIF(rtrim("nro_reso"::text), '')::varchar(50) AS "nro_reso",
       NULLIF(rtrim("juzgado"::text), '')::varchar(200) AS "juzgado",
       NULLIF(btrim("valor"::text), '')::numeric(12,2) AS "valor",
       NULLIF(rtrim("semana"::text), '')::varchar(8) AS "semana",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("dni"::text), '')::varchar(11) AS "dni",
       NULLIF(rtrim("nro_asis"::text), '')::varchar(1) AS "nro_asis",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo",
       NULLIF(rtrim("mesanio"::text), '')::varchar(6) AS "mesanio"
FROM "legacy_raw"."constancia_juicios"
ON CONFLICT DO NOTHING;

-- CONTRATOS_PERSONAL -> rrhh.contratos_personal  (29 col)
INSERT INTO "rrhh"."contratos_personal" ("codi_pers", "codi_cont_pers", "fech_inic_cont", "fech_fin_cont", "fech_sali", "esta_cont", "suel_basi", "observacion", "codi_unid_oper", "codi_carg", "tipo_cont", "grup_ocup", "moda_cont", "arti_moda", "comp_aseg", "tipo_prac", "cent_estu_prac", "hora_labo_diar", "hora_prac", "hora_teor", "hora_entr_1", "hora_sali_1", "hora_entr_2", "hora_sali_2", "titu_prac", "hora_dias", "deno_cent_estu_prac", "fech_pres_prac", "tiem_dura")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_cont_pers"::text), '')::varchar(5) AS "codi_cont_pers",
       NULLIF(btrim("fech_inic_cont"::text), '')::timestamp(3) AS "fech_inic_cont",
       NULLIF(btrim("fech_fin_cont"::text), '')::timestamp(3) AS "fech_fin_cont",
       NULLIF(btrim("fech_sali"::text), '')::timestamp(3) AS "fech_sali",
       NULLIF(btrim("esta_cont"::text), '')::boolean AS "esta_cont",
       NULLIF(btrim("suel_basi"::text), '')::numeric(18,2) AS "suel_basi",
       NULLIF(rtrim("observacion"::text), '')::varchar(100) AS "observacion",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg",
       NULLIF(rtrim("tipo_cont"::text), '')::varchar(10) AS "tipo_cont",
       NULLIF(rtrim("grup_ocup"::text), '')::varchar(50) AS "grup_ocup",
       NULLIF(rtrim("moda_cont"::text), '')::varchar(50) AS "moda_cont",
       NULLIF(rtrim("arti_moda"::text), '')::varchar(6) AS "arti_moda",
       NULLIF(rtrim("comp_aseg"::text), '')::varchar(150) AS "comp_aseg",
       NULLIF(rtrim("tipo_prac"::text), '')::varchar(20) AS "tipo_prac",
       NULLIF(rtrim("cent_estu_prac"::text), '')::varchar(150) AS "cent_estu_prac",
       NULLIF(btrim("hora_labo_diar"::text), '')::smallint AS "hora_labo_diar",
       NULLIF(btrim("hora_prac"::text), '')::smallint AS "hora_prac",
       NULLIF(btrim("hora_teor"::text), '')::smallint AS "hora_teor",
       NULLIF(btrim("hora_entr_1"::text), '')::timestamp(3) AS "hora_entr_1",
       NULLIF(btrim("hora_sali_1"::text), '')::timestamp(3) AS "hora_sali_1",
       NULLIF(btrim("hora_entr_2"::text), '')::timestamp(3) AS "hora_entr_2",
       NULLIF(btrim("hora_sali_2"::text), '')::timestamp(3) AS "hora_sali_2",
       NULLIF(rtrim("titu_prac"::text), '')::varchar(250) AS "titu_prac",
       NULLIF(rtrim("hora_dias"::text), '')::varchar(250) AS "hora_dias",
       NULLIF(rtrim("deno_cent_estu_prac"::text), '')::varchar(50) AS "deno_cent_estu_prac",
       NULLIF(btrim("fech_pres_prac"::text), '')::timestamp(3) AS "fech_pres_prac",
       NULLIF(rtrim("tiem_dura"::text), '')::varchar(100) AS "tiem_dura"
FROM "legacy_raw"."contratos_personal"
ON CONFLICT DO NOTHING;

-- CONVENIO_EVITA_DOBLE_TRIBUTACION -> rrhh.convenio_evita_doble_tributacion  (3 col)
INSERT INTO "rrhh"."convenio_evita_doble_tributacion" ("cod_conv_evita_dob_tribu", "desc_conv_evita_dob_tribu", "cod_sunat")
SELECT
       NULLIF(btrim("cod_conv_evita_dob_tribu"::text), '')::integer AS "cod_conv_evita_dob_tribu",
       NULLIF(rtrim("desc_conv_evita_dob_tribu"::text), '')::varchar(50) AS "desc_conv_evita_dob_tribu",
       NULLIF(btrim("cod_sunat"::text), '')::integer AS "cod_sunat"
FROM "legacy_raw"."convenio_evita_doble_tributacion"
ON CONFLICT DO NOTHING;

-- DATOS_CTS -> rrhh.datos_cts  (23 col)
INSERT INTO "rrhh"."datos_cts" ("codi_plan_cts", "codi_pers", "fech_inic", "fech_term", "tipo_pago", "desc_tipo_pago", "codi_mone", "fech_pago", "codi_tipo_plan", "anio", "mes", "nro_cheq_oper", "importe", "impo_dola", "codi_tipo_pers", "tipo_camb", "esta_pago", "fech_venc", "mont_inte_diar", "codi_banc", "tipo_cts", "codi_unid_oper", "interes")
SELECT
       NULLIF(rtrim("codi_plan_cts"::text), '')::varchar(10) AS "codi_plan_cts",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_term"::text), '')::timestamp(3) AS "fech_term",
       NULLIF(rtrim("tipo_pago"::text), '')::varchar(50) AS "tipo_pago",
       NULLIF(rtrim("desc_tipo_pago"::text), '')::varchar(50) AS "desc_tipo_pago",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("fech_pago"::text), '')::timestamp(3) AS "fech_pago",
       NULLIF(rtrim("codi_tipo_plan"::text), '')::varchar(2) AS "codi_tipo_plan",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("nro_cheq_oper"::text), '')::varchar(30) AS "nro_cheq_oper",
       NULLIF(btrim("importe"::text), '')::numeric(12,2) AS "importe",
       NULLIF(btrim("impo_dola"::text), '')::numeric(12,2) AS "impo_dola",
       NULLIF(rtrim("codi_tipo_pers"::text), '')::varchar(2) AS "codi_tipo_pers",
       NULLIF(btrim("tipo_camb"::text), '')::numeric(9,4) AS "tipo_camb",
       NULLIF(rtrim("esta_pago"::text), '')::varchar(1) AS "esta_pago",
       NULLIF(btrim("fech_venc"::text), '')::timestamp(3) AS "fech_venc",
       NULLIF(btrim("mont_inte_diar"::text), '')::numeric(12,6) AS "mont_inte_diar",
       NULLIF(rtrim("codi_banc"::text), '')::varchar(2) AS "codi_banc",
       NULLIF(rtrim("tipo_cts"::text), '')::varchar(1) AS "tipo_cts",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(btrim("interes"::text), '')::numeric(12,2) AS "interes"
FROM "legacy_raw"."datos_cts"
ON CONFLICT DO NOTHING;

-- DEMANDAS -> rrhh.demandas  (21 col)
INSERT INTO "rrhh"."demandas" ("codi_dema", "nro_expe", "materia", "codi_juez", "codi_juzg", "codi_espe", "codi_pers", "codi_clie_prov", "fech_ingr", "codi_unid_oper", "codi_carg", "antecedente", "anio", "secretaria", "estado", "fech_rece", "codi_abog", "proceso", "monto_dema", "nombres", "situ_actu")
SELECT
       NULLIF(rtrim("codi_dema"::text), '')::varchar(10) AS "codi_dema",
       NULLIF(rtrim("nro_expe"::text), '')::varchar(100) AS "nro_expe",
       NULLIF(rtrim("materia"::text), '')::varchar(150) AS "materia",
       NULLIF(rtrim("codi_juez"::text), '')::varchar(3) AS "codi_juez",
       NULLIF(rtrim("codi_juzg"::text), '')::varchar(2) AS "codi_juzg",
       NULLIF(rtrim("codi_espe"::text), '')::varchar(3) AS "codi_espe",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("fech_ingr"::text), '')::timestamp(3) AS "fech_ingr",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg",
       NULLIF(rtrim("antecedente"::text), '')::text AS "antecedente",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("secretaria"::text), '')::varchar(200) AS "secretaria",
       NULLIF(rtrim("estado"::text), '')::varchar(50) AS "estado",
       NULLIF(btrim("fech_rece"::text), '')::timestamp(3) AS "fech_rece",
       NULLIF(rtrim("codi_abog"::text), '')::varchar(3) AS "codi_abog",
       NULLIF(rtrim("proceso"::text), '')::varchar(20) AS "proceso",
       NULLIF(btrim("monto_dema"::text), '')::numeric(18,2) AS "monto_dema",
       NULLIF(rtrim("nombres"::text), '')::varchar(200) AS "nombres",
       NULLIF(rtrim("situ_actu"::text), '')::text AS "situ_actu"
FROM "legacy_raw"."demandas"
ON CONFLICT DO NOTHING;

-- DERECHO_HABIENTE -> rrhh.derecho_habiente  (40 col)
INSERT INTO "rrhh"."derecho_habiente" ("codi_pers", "codi_dere_habi", "tipo_rela", "nomb_1", "nomb_2", "apel_1", "apel_2", "codi_tipo_docu", "nro_docu_iden", "fech_naci", "sexo", "situacion", "moti_baja", "domicilio", "incapacidad", "cert_medi", "codi_tipo_docu_iden", "codi_vinc_fami", "tipo_doc_acred_pater", "nro_doc_acred_pater", "fech_alta", "fech_baja", "codi_moti_baja_dh", "nro_resolu_direct", "codi_via", "nomb_via", "num_via", "interior_via", "codi_zona", "nomb_zona", "referencia", "codi_ubi_reg", "codi_ubi_prov", "codi_ubi_dist", "codi_pais", "mesconcep", "codi_docu_vinculo", "codi_ldistanci", "telefono", "correo")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("codi_dere_habi"::text), '')::smallint AS "codi_dere_habi",
       NULLIF(rtrim("tipo_rela"::text), '')::varchar(40) AS "tipo_rela",
       NULLIF(rtrim("nomb_1"::text), '')::varchar(30) AS "nomb_1",
       NULLIF(rtrim("nomb_2"::text), '')::varchar(30) AS "nomb_2",
       NULLIF(rtrim("apel_1"::text), '')::varchar(30) AS "apel_1",
       NULLIF(rtrim("apel_2"::text), '')::varchar(30) AS "apel_2",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("nro_docu_iden"::text), '')::varchar(30) AS "nro_docu_iden",
       NULLIF(btrim("fech_naci"::text), '')::timestamp(3) AS "fech_naci",
       NULLIF(rtrim("sexo"::text), '')::varchar(1) AS "sexo",
       NULLIF(rtrim("situacion"::text), '')::varchar(1) AS "situacion",
       NULLIF(rtrim("moti_baja"::text), '')::varchar(1) AS "moti_baja",
       NULLIF(rtrim("domicilio"::text), '')::varchar(1) AS "domicilio",
       NULLIF(btrim("incapacidad"::text), '')::boolean AS "incapacidad",
       NULLIF(rtrim("cert_medi"::text), '')::varchar(20) AS "cert_medi",
       NULLIF(btrim("codi_tipo_docu_iden"::text), '')::smallint AS "codi_tipo_docu_iden",
       NULLIF(btrim("codi_vinc_fami"::text), '')::smallint AS "codi_vinc_fami",
       NULLIF(btrim("tipo_doc_acred_pater"::text), '')::smallint AS "tipo_doc_acred_pater",
       NULLIF(rtrim("nro_doc_acred_pater"::text), '')::varchar(20) AS "nro_doc_acred_pater",
       NULLIF(btrim("fech_alta"::text), '')::timestamp(3) AS "fech_alta",
       NULLIF(btrim("fech_baja"::text), '')::timestamp(3) AS "fech_baja",
       NULLIF(btrim("codi_moti_baja_dh"::text), '')::smallint AS "codi_moti_baja_dh",
       NULLIF(rtrim("nro_resolu_direct"::text), '')::varchar(20) AS "nro_resolu_direct",
       NULLIF(btrim("codi_via"::text), '')::smallint AS "codi_via",
       NULLIF(rtrim("nomb_via"::text), '')::varchar(20) AS "nomb_via",
       NULLIF(rtrim("num_via"::text), '')::varchar(4) AS "num_via",
       NULLIF(rtrim("interior_via"::text), '')::varchar(4) AS "interior_via",
       NULLIF(btrim("codi_zona"::text), '')::smallint AS "codi_zona",
       NULLIF(rtrim("nomb_zona"::text), '')::varchar(20) AS "nomb_zona",
       NULLIF(rtrim("referencia"::text), '')::varchar(40) AS "referencia",
       NULLIF(btrim("codi_ubi_reg"::text), '')::smallint AS "codi_ubi_reg",
       NULLIF(btrim("codi_ubi_prov"::text), '')::smallint AS "codi_ubi_prov",
       NULLIF(btrim("codi_ubi_dist"::text), '')::smallint AS "codi_ubi_dist",
       NULLIF(rtrim("codi_pais"::text), '')::varchar(3) AS "codi_pais",
       NULLIF(rtrim("mesconcep"::text), '')::varchar(6) AS "mesconcep",
       NULLIF(btrim("codi_docu_vinculo"::text), '')::integer AS "codi_docu_vinculo",
       NULLIF(rtrim("codi_ldistanci"::text), '')::varchar(3) AS "codi_ldistanci",
       NULLIF(rtrim("telefono"::text), '')::varchar(10) AS "telefono",
       NULLIF(rtrim("correo"::text), '')::varchar(70) AS "correo"
FROM "legacy_raw"."derecho_habiente"
ON CONFLICT DO NOTHING;

-- DESPLAZAN_PERSONAL -> rrhh.desplazan_personal  (5 col)
INSERT INTO "rrhh"."desplazan_personal" ("codi_desplazan_pers", "codi_clie_prov", "codi_acti", "fecha_inic", "fecha_fin")
SELECT
       NULLIF(btrim("codi_desplazan_pers"::text), '')::integer AS "codi_desplazan_pers",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("codi_acti"::text), '')::smallint AS "codi_acti",
       NULLIF(btrim("fecha_inic"::text), '')::timestamp(3) AS "fecha_inic",
       NULLIF(btrim("fecha_fin"::text), '')::timestamp(3) AS "fecha_fin"
FROM "legacy_raw"."desplazan_personal"
ON CONFLICT DO NOTHING;

-- DESPLAZO_PERSONAL -> rrhh.desplazo_personal  (7 col)
INSERT INTO "rrhh"."desplazo_personal" ("codi_despla_pers", "fecha_inicio", "fecha_fin", "codi_estable", "indicador", "codi_clie_prov", "codi_acti")
SELECT
       NULLIF(btrim("codi_despla_pers"::text), '')::integer AS "codi_despla_pers",
       NULLIF(btrim("fecha_inicio"::text), '')::timestamp(3) AS "fecha_inicio",
       NULLIF(btrim("fecha_fin"::text), '')::timestamp(3) AS "fecha_fin",
       NULLIF(rtrim("codi_estable"::text), '')::varchar(4) AS "codi_estable",
       NULLIF(rtrim("indicador"::text), '')::varchar(1) AS "indicador",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("codi_acti"::text), '')::smallint AS "codi_acti"
FROM "legacy_raw"."desplazo_personal"
ON CONFLICT DO NOTHING;

-- DETA_INGR_GRAT_TRIP -> rrhh.deta_ingr_grat_trip  (14 col)
INSERT INTO "rrhh"."deta_ingr_grat_trip" ("codi_sema", "anio", "codi_pers", "codi_carg", "codi_unid_oper", "grati", "importe", "porc_part", "nro_sema", "codi_tipo_plan", "mesanio_prov", "codi_plan_orig", "mes", "tipo_camb")
SELECT
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_carg"::text), '')::varchar(5) AS "codi_carg",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(btrim("grati"::text), '')::numeric(12,3) AS "grati",
       NULLIF(btrim("importe"::text), '')::numeric(12,3) AS "importe",
       NULLIF(btrim("porc_part"::text), '')::numeric(12,3) AS "porc_part",
       NULLIF(btrim("nro_sema"::text), '')::smallint AS "nro_sema",
       NULLIF(rtrim("codi_tipo_plan"::text), '')::varchar(2) AS "codi_tipo_plan",
       NULLIF(rtrim("mesanio_prov"::text), '')::varchar(6) AS "mesanio_prov",
       NULLIF(rtrim("codi_plan_orig"::text), '')::varchar(2) AS "codi_plan_orig",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(btrim("tipo_camb"::text), '')::numeric(9,4) AS "tipo_camb"
FROM "legacy_raw"."deta_ingr_grat_trip"
ON CONFLICT DO NOTHING;

-- Dias_Trab -> rrhh.dias_trab  (4 col)
INSERT INTO "rrhh"."dias_trab" ("codi_pers", "codi_unid_oper", "codi_sema", "dias")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(btrim("dias"::text), '')::bigint AS "dias"
FROM "legacy_raw"."dias_trab"
ON CONFLICT DO NOTHING;

-- DOCUMENTO_VINCULO -> rrhh.documento_vinculo  (5 col)
INSERT INTO "rrhh"."documento_vinculo" ("codi_docu_vinculo", "codi_docu_vinculo_sunat", "descipcion_docu", "descripcion_abre", "vinculo")
SELECT
       NULLIF(btrim("codi_docu_vinculo"::text), '')::integer AS "codi_docu_vinculo",
       NULLIF(rtrim("codi_docu_vinculo_sunat"::text), '')::varchar(3) AS "codi_docu_vinculo_sunat",
       NULLIF(rtrim("descipcion_docu"::text), '')::varchar(100) AS "descipcion_docu",
       NULLIF(rtrim("descripcion_abre"::text), '')::varchar(100) AS "descripcion_abre",
       NULLIF(rtrim("vinculo"::text), '')::varchar(5) AS "vinculo"
FROM "legacy_raw"."documento_vinculo"
ON CONFLICT DO NOTHING;

-- ENTIDAD_SALUD -> rrhh.entidad_salud  (4 col)
INSERT INTO "rrhh"."entidad_salud" ("codi_enti", "codi_enti_sunat", "ruc", "desc_enti")
SELECT
       NULLIF(btrim("codi_enti"::text), '')::smallint AS "codi_enti",
       NULLIF(btrim("codi_enti_sunat"::text), '')::smallint AS "codi_enti_sunat",
       NULLIF(rtrim("ruc"::text), '')::varchar(11) AS "ruc",
       NULLIF(rtrim("desc_enti"::text), '')::varchar(150) AS "desc_enti"
FROM "legacy_raw"."entidad_salud"
ON CONFLICT DO NOTHING;

-- ESPECIALISTAS -> rrhh.especialistas  (6 col)
INSERT INTO "rrhh"."especialistas" ("codi_espe", "apel_1", "apel_2", "nomb_1", "nomb_2", "dni")
SELECT
       NULLIF(rtrim("codi_espe"::text), '')::varchar(3) AS "codi_espe",
       NULLIF(rtrim("apel_1"::text), '')::varchar(50) AS "apel_1",
       NULLIF(rtrim("apel_2"::text), '')::varchar(50) AS "apel_2",
       NULLIF(rtrim("nomb_1"::text), '')::varchar(50) AS "nomb_1",
       NULLIF(rtrim("nomb_2"::text), '')::varchar(50) AS "nomb_2",
       NULLIF(rtrim("dni"::text), '')::varchar(12) AS "dni"
FROM "legacy_raw"."especialistas"
ON CONFLICT DO NOTHING;

-- Extr_Cont_Liqu_pesc -> rrhh.extr_cont_liqu_pesc  (5 col)
INSERT INTO "rrhh"."extr_cont_liqu_pesc" ("codi_sema", "codi_clie_prov", "prec_pact", "dscto", "codi_banc")
SELECT
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("prec_pact"::text), '')::numeric(18,2) AS "prec_pact",
       NULLIF(btrim("dscto"::text), '')::bigint AS "dscto",
       NULLIF(rtrim("codi_banc"::text), '')::varchar(2) AS "codi_banc"
FROM "legacy_raw"."extr_cont_liqu_pesc"
ON CONFLICT DO NOTHING;

-- EXTRA_CONTA -> rrhh.extra_conta  (7 col)
INSERT INTO "rrhh"."extra_conta" ("ruc", "tm", "prec_tm", "comb", "pre_comb", "fdo_rete", "up")
SELECT
       NULLIF(rtrim("ruc"::text), '')::varchar(11) AS "ruc",
       NULLIF(btrim("tm"::text), '')::numeric(18,3) AS "tm",
       NULLIF(btrim("prec_tm"::text), '')::numeric(18,2) AS "prec_tm",
       NULLIF(btrim("comb"::text), '')::bigint AS "comb",
       NULLIF(btrim("pre_comb"::text), '')::numeric(18,4) AS "pre_comb",
       NULLIF(btrim("fdo_rete"::text), '')::numeric(18,2) AS "fdo_rete",
       NULLIF(btrim("up"::text), '')::numeric(18,2) AS "up"
FROM "legacy_raw"."extra_conta"
ON CONFLICT DO NOTHING;

-- GRAT_TRIP_DETA_CONC -> rrhh.grat_trip_deta_conc  (12 col)
INSERT INTO "rrhh"."grat_trip_deta_conc" ("codi_pers", "codi_sema_inic", "codi_sema_fin", "anio", "codi_conc", "monto", "valor", "codi_tipo_plan", "mesanio_prov", "codi_juic", "mes", "codi_unid_oper")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_sema_inic"::text), '')::varchar(8) AS "codi_sema_inic",
       NULLIF(rtrim("codi_sema_fin"::text), '')::varchar(8) AS "codi_sema_fin",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(btrim("monto"::text), '')::numeric(12,3) AS "monto",
       NULLIF(btrim("valor"::text), '')::numeric(12,3) AS "valor",
       NULLIF(rtrim("codi_tipo_plan"::text), '')::varchar(2) AS "codi_tipo_plan",
       NULLIF(rtrim("mesanio_prov"::text), '')::varchar(6) AS "mesanio_prov",
       NULLIF(rtrim("codi_juic"::text), '')::varchar(6) AS "codi_juic",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper"
FROM "legacy_raw"."grat_trip_deta_conc"
ON CONFLICT DO NOTHING;

-- HORA_LABO_SEMA -> rrhh.hora_labo_sema  (25 col)
INSERT INTO "rrhh"."hora_labo_sema" ("codi_pers", "fech_inic", "fech_term", "d_01", "d_02", "d_03", "d_04", "d_05", "d_06", "d_07", "anio", "mes", "hora_rein_norm", "hora_25_rein_norm", "hora_35_rein_norm", "hora_rein_domi", "hora_25_rein_domi", "hora_35_rein_domi", "hora_rein_feri", "hora_25_rein_feri", "hora_35_rein_feri", "observaciones", "indi_tiem", "codi_tipo_pers", "semana")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_term"::text), '')::timestamp(3) AS "fech_term",
       NULLIF(btrim("d_01"::text), '')::numeric(9,2) AS "d_01",
       NULLIF(btrim("d_02"::text), '')::numeric(9,2) AS "d_02",
       NULLIF(btrim("d_03"::text), '')::numeric(9,2) AS "d_03",
       NULLIF(btrim("d_04"::text), '')::numeric(9,2) AS "d_04",
       NULLIF(btrim("d_05"::text), '')::numeric(9,2) AS "d_05",
       NULLIF(btrim("d_06"::text), '')::numeric(9,2) AS "d_06",
       NULLIF(btrim("d_07"::text), '')::numeric(9,2) AS "d_07",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(btrim("hora_rein_norm"::text), '')::numeric(9,2) AS "hora_rein_norm",
       NULLIF(btrim("hora_25_rein_norm"::text), '')::numeric(9,2) AS "hora_25_rein_norm",
       NULLIF(btrim("hora_35_rein_norm"::text), '')::numeric(9,2) AS "hora_35_rein_norm",
       NULLIF(btrim("hora_rein_domi"::text), '')::numeric(9,2) AS "hora_rein_domi",
       NULLIF(btrim("hora_25_rein_domi"::text), '')::numeric(9,2) AS "hora_25_rein_domi",
       NULLIF(btrim("hora_35_rein_domi"::text), '')::numeric(9,2) AS "hora_35_rein_domi",
       NULLIF(btrim("hora_rein_feri"::text), '')::numeric(9,2) AS "hora_rein_feri",
       NULLIF(btrim("hora_25_rein_feri"::text), '')::numeric(9,2) AS "hora_25_rein_feri",
       NULLIF(btrim("hora_35_rein_feri"::text), '')::numeric(9,2) AS "hora_35_rein_feri",
       NULLIF(rtrim("observaciones"::text), '')::varchar(250) AS "observaciones",
       NULLIF(rtrim("indi_tiem"::text), '')::varchar(1) AS "indi_tiem",
       NULLIF(rtrim("codi_tipo_pers"::text), '')::varchar(2) AS "codi_tipo_pers",
       NULLIF(btrim("semana"::text), '')::smallint AS "semana"
FROM "legacy_raw"."hora_labo_sema"
ON CONFLICT DO NOTHING;

-- HORA_PERS_FECH -> rrhh.hora_pers_fech  (4 col)
INSERT INTO "rrhh"."hora_pers_fech" ("codi_pers", "fech_inic", "fech_fin", "codi_hora")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_fin"::text), '')::timestamp(3) AS "fech_fin",
       NULLIF(btrim("codi_hora"::text), '')::smallint AS "codi_hora"
FROM "legacy_raw"."hora_pers_fech"
ON CONFLICT DO NOTHING;

-- HORA_PLAN_VACA_GRAT -> rrhh.hora_plan_vaca_grat  (12 col)
INSERT INTO "rrhh"."hora_plan_vaca_grat" ("codi_pers", "fech_inic", "codi_tipo_plan", "fech_term", "anio", "mes", "prom_remu_hora_25", "prom_remu_hora_35", "remu_otro_ingr", "nro_mese_paga", "nro_dias_paga", "moti_obse")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(rtrim("codi_tipo_plan"::text), '')::varchar(2) AS "codi_tipo_plan",
       NULLIF(btrim("fech_term"::text), '')::timestamp(3) AS "fech_term",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(btrim("prom_remu_hora_25"::text), '')::numeric(12,2) AS "prom_remu_hora_25",
       NULLIF(btrim("prom_remu_hora_35"::text), '')::numeric(12,2) AS "prom_remu_hora_35",
       NULLIF(btrim("remu_otro_ingr"::text), '')::numeric(12,2) AS "remu_otro_ingr",
       NULLIF(btrim("nro_mese_paga"::text), '')::smallint AS "nro_mese_paga",
       NULLIF(btrim("nro_dias_paga"::text), '')::smallint AS "nro_dias_paga",
       NULLIF(rtrim("moti_obse"::text), '')::varchar(200) AS "moti_obse"
FROM "legacy_raw"."hora_plan_vaca_grat"
ON CONFLICT DO NOTHING;

-- HORARIO -> rrhh.horario  (12 col)
INSERT INTO "rrhh"."horario" ("codi_hora", "descripcion", "he1n", "hs1n", "he2n", "hs2n", "he1s", "hs1s", "he2s", "hs2s", "hora_labo_dia", "hora_labo_dia_saba")
SELECT
       NULLIF(btrim("codi_hora"::text), '')::smallint AS "codi_hora",
       NULLIF(rtrim("descripcion"::text), '')::varchar(50) AS "descripcion",
       NULLIF(btrim("he1n"::text), '')::timestamp(3) AS "he1n",
       NULLIF(btrim("hs1n"::text), '')::timestamp(3) AS "hs1n",
       NULLIF(btrim("he2n"::text), '')::timestamp(3) AS "he2n",
       NULLIF(btrim("hs2n"::text), '')::timestamp(3) AS "hs2n",
       NULLIF(btrim("he1s"::text), '')::timestamp(3) AS "he1s",
       NULLIF(btrim("hs1s"::text), '')::timestamp(3) AS "hs1s",
       NULLIF(btrim("he2s"::text), '')::timestamp(3) AS "he2s",
       NULLIF(btrim("hs2s"::text), '')::timestamp(3) AS "hs2s",
       NULLIF(btrim("hora_labo_dia"::text), '')::numeric(9,2) AS "hora_labo_dia",
       NULLIF(btrim("hora_labo_dia_saba"::text), '')::numeric(9,2) AS "hora_labo_dia_saba"
FROM "legacy_raw"."horario"
ON CONFLICT DO NOTHING;

-- HORAS_LABORADAS -> rrhh.horas_laboradas  (44 col)
INSERT INTO "rrhh"."horas_laboradas" ("codi_pers", "fech_inic", "d_01", "d_02", "d_03", "d_04", "d_05", "d_06", "d_07", "d_08", "d_09", "d_10", "d_11", "d_12", "d_13", "d_14", "d_15", "d_16", "d_17", "d_18", "d_19", "d_20", "d_21", "d_22", "d_23", "d_24", "d_25", "d_26", "d_27", "d_28", "d_29", "d_30", "d_31", "hora_rein_norm", "hora_25_rein_norm", "hora_35_rein_norm", "hora_rein_domi", "hora_25_rein_domi", "hora_35_rein_domi", "hora_rein_feri", "hora_25_rein_feri", "hora_35_rein_feri", "observaciones", "indi_tiem")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("d_01"::text), '')::numeric(9,2) AS "d_01",
       NULLIF(btrim("d_02"::text), '')::numeric(9,2) AS "d_02",
       NULLIF(btrim("d_03"::text), '')::numeric(9,2) AS "d_03",
       NULLIF(btrim("d_04"::text), '')::numeric(9,2) AS "d_04",
       NULLIF(btrim("d_05"::text), '')::numeric(9,2) AS "d_05",
       NULLIF(btrim("d_06"::text), '')::numeric(9,2) AS "d_06",
       NULLIF(btrim("d_07"::text), '')::numeric(9,2) AS "d_07",
       NULLIF(btrim("d_08"::text), '')::numeric(9,2) AS "d_08",
       NULLIF(btrim("d_09"::text), '')::numeric(9,2) AS "d_09",
       NULLIF(btrim("d_10"::text), '')::numeric(9,2) AS "d_10",
       NULLIF(btrim("d_11"::text), '')::numeric(9,2) AS "d_11",
       NULLIF(btrim("d_12"::text), '')::numeric(9,2) AS "d_12",
       NULLIF(btrim("d_13"::text), '')::numeric(9,2) AS "d_13",
       NULLIF(btrim("d_14"::text), '')::numeric(9,2) AS "d_14",
       NULLIF(btrim("d_15"::text), '')::numeric(9,2) AS "d_15",
       NULLIF(btrim("d_16"::text), '')::numeric(9,2) AS "d_16",
       NULLIF(btrim("d_17"::text), '')::numeric(9,2) AS "d_17",
       NULLIF(btrim("d_18"::text), '')::numeric(9,2) AS "d_18",
       NULLIF(btrim("d_19"::text), '')::numeric(9,2) AS "d_19",
       NULLIF(btrim("d_20"::text), '')::numeric(9,2) AS "d_20",
       NULLIF(btrim("d_21"::text), '')::numeric(9,2) AS "d_21",
       NULLIF(btrim("d_22"::text), '')::numeric(9,2) AS "d_22",
       NULLIF(btrim("d_23"::text), '')::numeric(9,2) AS "d_23",
       NULLIF(btrim("d_24"::text), '')::numeric(9,2) AS "d_24",
       NULLIF(btrim("d_25"::text), '')::numeric(9,2) AS "d_25",
       NULLIF(btrim("d_26"::text), '')::numeric(9,2) AS "d_26",
       NULLIF(btrim("d_27"::text), '')::numeric(9,2) AS "d_27",
       NULLIF(btrim("d_28"::text), '')::numeric(9,2) AS "d_28",
       NULLIF(btrim("d_29"::text), '')::numeric(9,2) AS "d_29",
       NULLIF(btrim("d_30"::text), '')::numeric(9,2) AS "d_30",
       NULLIF(btrim("d_31"::text), '')::numeric(9,2) AS "d_31",
       NULLIF(btrim("hora_rein_norm"::text), '')::numeric(9,2) AS "hora_rein_norm",
       NULLIF(btrim("hora_25_rein_norm"::text), '')::numeric(9,2) AS "hora_25_rein_norm",
       NULLIF(btrim("hora_35_rein_norm"::text), '')::numeric(9,2) AS "hora_35_rein_norm",
       NULLIF(btrim("hora_rein_domi"::text), '')::numeric(9,2) AS "hora_rein_domi",
       NULLIF(btrim("hora_25_rein_domi"::text), '')::numeric(9,2) AS "hora_25_rein_domi",
       NULLIF(btrim("hora_35_rein_domi"::text), '')::numeric(9,2) AS "hora_35_rein_domi",
       NULLIF(btrim("hora_rein_feri"::text), '')::numeric(9,2) AS "hora_rein_feri",
       NULLIF(btrim("hora_25_rein_feri"::text), '')::numeric(9,2) AS "hora_25_rein_feri",
       NULLIF(btrim("hora_35_rein_feri"::text), '')::numeric(9,2) AS "hora_35_rein_feri",
       NULLIF(rtrim("observaciones"::text), '')::varchar(250) AS "observaciones",
       NULLIF(rtrim("indi_tiem"::text), '')::varchar(1) AS "indi_tiem"
FROM "legacy_raw"."horas_laboradas"
ON CONFLICT DO NOTHING;

-- INCREMENTOS_PERSONAL -> rrhh.incrementos_personal  (7 col)
INSERT INTO "rrhh"."incrementos_personal" ("codi_pers", "nro_incre", "desc_incr", "tipo_incre", "codi_mone", "valor", "esta_acti")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("nro_incre"::text), '')::smallint AS "nro_incre",
       NULLIF(rtrim("desc_incr"::text), '')::varchar(100) AS "desc_incr",
       NULLIF(btrim("tipo_incre"::text), '')::boolean AS "tipo_incre",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("valor"::text), '')::numeric(12,2) AS "valor",
       NULLIF(btrim("esta_acti"::text), '')::boolean AS "esta_acti"
FROM "legacy_raw"."incrementos_personal"
ON CONFLICT DO NOTHING;

-- INGRESOS_QUINTA_CATEG -> rrhh.ingresos_quinta_categ  (8 col)
INSERT INTO "rrhh"."ingresos_quinta_categ" ("codi_ingre", "codi_pers", "ano", "mes", "monto", "codi_clie_prov", "reten", "renta_reten")
SELECT
       NULLIF(btrim("codi_ingre"::text), '')::bigint AS "codi_ingre",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("año"::text), '')::varchar(4) AS "ano",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(btrim("monto"::text), '')::numeric(18,2) AS "monto",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("reten"::text), '')::numeric(12,2) AS "reten",
       NULLIF(btrim("renta_reten"::text), '')::numeric(12,2) AS "renta_reten"
FROM "legacy_raw"."ingresos_quinta_categ"
ON CONFLICT DO NOTHING;

-- JUECES -> rrhh.jueces  (7 col)
INSERT INTO "rrhh"."jueces" ("codi_juez", "apel_1", "apel_2", "nomb_1", "nomb_2", "dni", "cargo")
SELECT
       NULLIF(rtrim("codi_juez"::text), '')::varchar(3) AS "codi_juez",
       NULLIF(rtrim("apel_1"::text), '')::varchar(50) AS "apel_1",
       NULLIF(rtrim("apel_2"::text), '')::varchar(50) AS "apel_2",
       NULLIF(rtrim("nomb_1"::text), '')::varchar(50) AS "nomb_1",
       NULLIF(rtrim("nomb_2"::text), '')::varchar(50) AS "nomb_2",
       NULLIF(rtrim("dni"::text), '')::varchar(12) AS "dni",
       NULLIF(rtrim("cargo"::text), '')::varchar(50) AS "cargo"
FROM "legacy_raw"."jueces"
ON CONFLICT DO NOTHING;

-- JUICIOS -> rrhh.juicios  (21 col)
INSERT INTO "rrhh"."juicios" ("codi_juic", "codi_pers", "nro_juic", "fech_juic", "moti_juic", "esta_acti", "tipo_desc", "codi_mone", "mont_desc", "inte_tiem_desc", "apli_toda_remu", "pers_bene_juic", "dni_pers_bene", "nro_reso_judi", "juzgado", "apli_tope", "tope", "saldo", "codi_banc", "nro_cta_cte_bene", "codi_mone_cta_cte_bene")
SELECT
       NULLIF(rtrim("codi_juic"::text), '')::varchar(6) AS "codi_juic",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("nro_juic"::text), '')::integer AS "nro_juic",
       NULLIF(btrim("fech_juic"::text), '')::timestamp(3) AS "fech_juic",
       NULLIF(rtrim("moti_juic"::text), '')::varchar(100) AS "moti_juic",
       NULLIF(btrim("esta_acti"::text), '')::boolean AS "esta_acti",
       NULLIF(btrim("tipo_desc"::text), '')::boolean AS "tipo_desc",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("mont_desc"::text), '')::numeric(12,2) AS "mont_desc",
       NULLIF(rtrim("inte_tiem_desc"::text), '')::varchar(20) AS "inte_tiem_desc",
       NULLIF(btrim("apli_toda_remu"::text), '')::boolean AS "apli_toda_remu",
       NULLIF(rtrim("pers_bene_juic"::text), '')::varchar(200) AS "pers_bene_juic",
       NULLIF(rtrim("dni_pers_bene"::text), '')::varchar(10) AS "dni_pers_bene",
       NULLIF(rtrim("nro_reso_judi"::text), '')::varchar(50) AS "nro_reso_judi",
       NULLIF(rtrim("juzgado"::text), '')::varchar(200) AS "juzgado",
       NULLIF(btrim("apli_tope"::text), '')::boolean AS "apli_tope",
       NULLIF(btrim("tope"::text), '')::numeric(15,4) AS "tope",
       NULLIF(btrim("saldo"::text), '')::numeric(15,4) AS "saldo",
       NULLIF(rtrim("codi_banc"::text), '')::varchar(2) AS "codi_banc",
       NULLIF(rtrim("nro_cta_cte_bene"::text), '')::varchar(20) AS "nro_cta_cte_bene",
       NULLIF(rtrim("codi_mone_cta_cte_bene"::text), '')::varchar(2) AS "codi_mone_cta_cte_bene"
FROM "legacy_raw"."juicios"
ON CONFLICT DO NOTHING;

-- JUICIOS_EMPRESA -> rrhh.juicios_empresa  (13 col)
INSERT INTO "rrhh"."juicios_empresa" ("codi_juic_empr", "codi_pers", "fech_inic", "fech_term", "desc_juic", "codi_clie_prov", "codi_mone", "monto", "juzgado", "nomb_juez", "observacion", "nro_exp", "activo")
SELECT
       NULLIF(rtrim("codi_juic_empr"::text), '')::varchar(5) AS "codi_juic_empr",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_term"::text), '')::timestamp(3) AS "fech_term",
       NULLIF(rtrim("desc_juic"::text), '')::varchar(100) AS "desc_juic",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto",
       NULLIF(rtrim("juzgado"::text), '')::varchar(100) AS "juzgado",
       NULLIF(rtrim("nomb_juez"::text), '')::varchar(100) AS "nomb_juez",
       NULLIF(rtrim("observacion"::text), '')::varchar(200) AS "observacion",
       NULLIF(rtrim("nro_exp"::text), '')::varchar(15) AS "nro_exp",
       NULLIF(btrim("activo"::text), '')::boolean AS "activo"
FROM "legacy_raw"."juicios_empresa"
ON CONFLICT DO NOTHING;

-- JUZGADOS -> rrhh.juzgados  (4 col)
INSERT INTO "rrhh"."juzgados" ("codi_juzg", "desc_juzg", "ubicacion", "direccion")
SELECT
       NULLIF(rtrim("codi_juzg"::text), '')::varchar(2) AS "codi_juzg",
       NULLIF(rtrim("desc_juzg"::text), '')::varchar(200) AS "desc_juzg",
       NULLIF(rtrim("ubicacion"::text), '')::varchar(20) AS "ubicacion",
       NULLIF(rtrim("direccion"::text), '')::varchar(200) AS "direccion"
FROM "legacy_raw"."juzgados"
ON CONFLICT DO NOTHING;

-- LICENCIAS_POR_PERSONAL -> rrhh.licencias_por_personal  (14 col)
INSERT INTO "rrhh"."licencias_por_personal" ("codi_pers", "codi_tipo_lice", "motivo", "fech_inic", "fech_term", "esta_acti", "goce_habe", "nro_dias_remu", "observaciones", "nro_hora_remu", "codi_jefe_inme_auto", "codi_jefe_supe_auto", "codi_tipo_susp_labo", "nro_citt")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_tipo_lice"::text), '')::varchar(3) AS "codi_tipo_lice",
       NULLIF(rtrim("motivo"::text), '')::varchar(100) AS "motivo",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_term"::text), '')::timestamp(3) AS "fech_term",
       NULLIF(btrim("esta_acti"::text), '')::boolean AS "esta_acti",
       NULLIF(btrim("goce_habe"::text), '')::boolean AS "goce_habe",
       NULLIF(btrim("nro_dias_remu"::text), '')::integer AS "nro_dias_remu",
       NULLIF(rtrim("observaciones"::text), '')::varchar(200) AS "observaciones",
       NULLIF(btrim("nro_hora_remu"::text), '')::numeric(9,2) AS "nro_hora_remu",
       NULLIF(rtrim("codi_jefe_inme_auto"::text), '')::varchar(5) AS "codi_jefe_inme_auto",
       NULLIF(rtrim("codi_jefe_supe_auto"::text), '')::varchar(5) AS "codi_jefe_supe_auto",
       NULLIF(btrim("codi_tipo_susp_labo"::text), '')::smallint AS "codi_tipo_susp_labo",
       NULLIF(rtrim("nro_citt"::text), '')::varchar(15) AS "nro_citt"
FROM "legacy_raw"."licencias_por_personal"
ON CONFLICT DO NOTHING;

-- LUGAR_TRABAJO -> rrhh.lugar_trabajo  (3 col)
INSERT INTO "rrhh"."lugar_trabajo" ("codi_luga_trab", "nomb_luga_trab", "abre_luga_trab")
SELECT
       NULLIF(rtrim("codi_luga_trab"::text), '')::varchar(2) AS "codi_luga_trab",
       NULLIF(rtrim("nomb_luga_trab"::text), '')::varchar(50) AS "nomb_luga_trab",
       NULLIF(rtrim("abre_luga_trab"::text), '')::varchar(20) AS "abre_luga_trab"
FROM "legacy_raw"."lugar_trabajo"
ON CONFLICT DO NOTHING;

-- MODALIDAD_FORMATIVA -> rrhh.modalidad_formativa  (3 col)
INSERT INTO "rrhh"."modalidad_formativa" ("codi_moda_forma", "codi_moda_forma_sunat", "desc_moda_forma")
SELECT
       NULLIF(btrim("codi_moda_forma"::text), '')::smallint AS "codi_moda_forma",
       NULLIF(rtrim("codi_moda_forma_sunat"::text), '')::varchar(2) AS "codi_moda_forma_sunat",
       NULLIF(rtrim("desc_moda_forma"::text), '')::varchar(100) AS "desc_moda_forma"
FROM "legacy_raw"."modalidad_formativa"
ON CONFLICT DO NOTHING;

-- MOTI_BAJA_DH -> rrhh.moti_baja_dh  (3 col)
INSERT INTO "rrhh"."moti_baja_dh" ("codi_moti_baja_dh", "codi_moti_baja_dh_sunat", "desc_moti_baja_dh")
SELECT
       NULLIF(btrim("codi_moti_baja_dh"::text), '')::smallint AS "codi_moti_baja_dh",
       NULLIF(btrim("codi_moti_baja_dh_sunat"::text), '')::smallint AS "codi_moti_baja_dh_sunat",
       NULLIF(rtrim("desc_moti_baja_dh"::text), '')::varchar(100) AS "desc_moti_baja_dh"
FROM "legacy_raw"."moti_baja_dh"
ON CONFLICT DO NOTHING;

-- MOTI_FIN_PERIODO -> rrhh.moti_fin_periodo  (3 col)
INSERT INTO "rrhh"."moti_fin_periodo" ("codi_moti_fin_peri", "codi_moti_fin_peri_sunat", "desc_moti_fin_peri")
SELECT
       NULLIF(btrim("codi_moti_fin_peri"::text), '')::smallint AS "codi_moti_fin_peri",
       NULLIF(rtrim("codi_moti_fin_peri_sunat"::text), '')::varchar(2) AS "codi_moti_fin_peri_sunat",
       NULLIF(rtrim("desc_moti_fin_peri"::text), '')::varchar(100) AS "desc_moti_fin_peri"
FROM "legacy_raw"."moti_fin_periodo"
ON CONFLICT DO NOTHING;

-- NIVEL -> rrhh.nivel  (4 col)
INSERT INTO "rrhh"."nivel" ("codi_nivel", "codi_nivel_sunat", "desc_nivel", "nemo_nivel")
SELECT
       NULLIF(btrim("codi_nivel"::text), '')::smallint AS "codi_nivel",
       NULLIF(rtrim("codi_nivel_sunat"::text), '')::varchar(2) AS "codi_nivel_sunat",
       NULLIF(rtrim("desc_nivel"::text), '')::varchar(150) AS "desc_nivel",
       NULLIF(rtrim("nemo_nivel"::text), '')::varchar(20) AS "nemo_nivel"
FROM "legacy_raw"."nivel"
ON CONFLICT DO NOTHING;

-- OCUPACION -> rrhh.ocupacion  (4 col)
INSERT INTO "rrhh"."ocupacion" ("codi_ocu", "codi_ocu_sunat", "desc_ocu", "nemo_ocu")
SELECT
       NULLIF(btrim("codi_ocu"::text), '')::smallint AS "codi_ocu",
       NULLIF(rtrim("codi_ocu_sunat"::text), '')::varchar(6) AS "codi_ocu_sunat",
       NULLIF(rtrim("desc_ocu"::text), '')::varchar(250) AS "desc_ocu",
       NULLIF(rtrim("nemo_ocu"::text), '')::varchar(30) AS "nemo_ocu"
FROM "legacy_raw"."ocupacion"
ON CONFLICT DO NOTHING;

-- PAGOS_ADELANTOS -> rrhh.pagos_adelantos  (6 col)
INSERT INTO "rrhh"."pagos_adelantos" ("codi_adel", "nro_pago", "fech_pago", "codi_mone", "monto", "observacion")
SELECT
       NULLIF(rtrim("codi_adel"::text), '')::varchar(6) AS "codi_adel",
       NULLIF(rtrim("nro_pago"::text), '')::varchar(4) AS "nro_pago",
       NULLIF(btrim("fech_pago"::text), '')::timestamp(3) AS "fech_pago",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto",
       NULLIF(rtrim("observacion"::text), '')::varchar(150) AS "observacion"
FROM "legacy_raw"."pagos_adelantos"
ON CONFLICT DO NOTHING;

-- PAGOS_PRESTAMOS -> rrhh.pagos_prestamos  (6 col)
INSERT INTO "rrhh"."pagos_prestamos" ("codi_pres", "nro_pago", "fech_pago", "codi_mone", "monto", "observacion")
SELECT
       NULLIF(rtrim("codi_pres"::text), '')::varchar(6) AS "codi_pres",
       NULLIF(rtrim("nro_pago"::text), '')::varchar(4) AS "nro_pago",
       NULLIF(btrim("fech_pago"::text), '')::timestamp(3) AS "fech_pago",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto",
       NULLIF(rtrim("observacion"::text), '')::varchar(150) AS "observacion"
FROM "legacy_raw"."pagos_prestamos"
ON CONFLICT DO NOTHING;

-- PARAMETROS_QUINTA -> rrhh.parametros_quinta  (6 col)
INSERT INTO "rrhh"."parametros_quinta" ("nro_para", "fech_para", "esta_para", "nro_mini_uit", "nro_maxi_uit", "porcentaje")
SELECT
       NULLIF(btrim("nro_para"::text), '')::smallint AS "nro_para",
       NULLIF(btrim("fech_para"::text), '')::timestamp(3) AS "fech_para",
       NULLIF(btrim("esta_para"::text), '')::boolean AS "esta_para",
       NULLIF(btrim("nro_mini_uit"::text), '')::integer AS "nro_mini_uit",
       NULLIF(btrim("nro_maxi_uit"::text), '')::integer AS "nro_maxi_uit",
       NULLIF(btrim("porcentaje"::text), '')::numeric(9,2) AS "porcentaje"
FROM "legacy_raw"."parametros_quinta"
ON CONFLICT DO NOTHING;

-- PENSION -> rrhh.pension  (4 col)
INSERT INTO "rrhh"."pension" ("codi_pension", "codi_pension_sunat", "desc_pension", "nemo_pension")
SELECT
       NULLIF(btrim("codi_pension"::text), '')::smallint AS "codi_pension",
       NULLIF(btrim("codi_pension_sunat"::text), '')::smallint AS "codi_pension_sunat",
       NULLIF(rtrim("desc_pension"::text), '')::varchar(150) AS "desc_pension",
       NULLIF(rtrim("nemo_pension"::text), '')::varchar(15) AS "nemo_pension"
FROM "legacy_raw"."pension"
ON CONFLICT DO NOTHING;

-- PERIODICIDAD -> rrhh.periodicidad  (3 col)
INSERT INTO "rrhh"."periodicidad" ("codi_periodo", "codi_periodo_sunat", "desc_periodo")
SELECT
       NULLIF(btrim("codi_periodo"::text), '')::smallint AS "codi_periodo",
       NULLIF(btrim("codi_periodo_sunat"::text), '')::smallint AS "codi_periodo_sunat",
       NULLIF(rtrim("desc_periodo"::text), '')::varchar(50) AS "desc_periodo"
FROM "legacy_raw"."periodicidad"
ON CONFLICT DO NOTHING;

-- PERS_DATO_ADIC -> rrhh.pers_dato_adic  (11 col)
INSERT INTO "rrhh"."pers_dato_adic" ("codi_pers", "nro_cert_salu", "cert_ante_poli", "cert_ante_pena_alfa", "sabe_nadar", "smo", "tipo_smo", "carn_discamet", "lice_port_arma", "nro_carn_disc", "nro_lice_arma_alfa")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("nro_cert_salu"::text), '')::varchar(20) AS "nro_cert_salu",
       NULLIF(rtrim("cert_ante_poli"::text), '')::varchar(20) AS "cert_ante_poli",
       NULLIF(rtrim("cert_ante_pena_alfa"::text), '')::varchar(20) AS "cert_ante_pena_alfa",
       NULLIF(btrim("sabe_nadar"::text), '')::boolean AS "sabe_nadar",
       NULLIF(btrim("smo"::text), '')::boolean AS "smo",
       NULLIF(rtrim("tipo_smo"::text), '')::varchar(20) AS "tipo_smo",
       NULLIF(btrim("carn_discamet"::text), '')::boolean AS "carn_discamet",
       NULLIF(btrim("lice_port_arma"::text), '')::boolean AS "lice_port_arma",
       NULLIF(rtrim("nro_carn_disc"::text), '')::varchar(20) AS "nro_carn_disc",
       NULLIF(rtrim("nro_lice_arma_alfa"::text), '')::varchar(20) AS "nro_lice_arma_alfa"
FROM "legacy_raw"."pers_dato_adic"
ON CONFLICT DO NOTHING;

-- PERS_REFE_LABO -> rrhh.pers_refe_labo  (5 col)
INSERT INTO "rrhh"."pers_refe_labo" ("codi_pers", "fech_inic", "fech_term", "empresa", "cargo")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(10) AS "codi_pers",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_term"::text), '')::timestamp(3) AS "fech_term",
       NULLIF(rtrim("empresa"::text), '')::varchar(100) AS "empresa",
       NULLIF(rtrim("cargo"::text), '')::varchar(100) AS "cargo"
FROM "legacy_raw"."pers_refe_labo"
ON CONFLICT DO NOTHING;

-- Pers_Soli -> rrhh.pers_soli  (2 col)
INSERT INTO "rrhh"."pers_soli" ("codi_pers", "apel_pers")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("apel_pers"::text), '')::varchar(100) AS "apel_pers"
FROM "legacy_raw"."pers_soli"
ON CONFLICT DO NOTHING;

-- PERS_TRIP_VIGE_CERT -> rrhh.pers_trip_vige_cert  (7 col)
INSERT INTO "rrhh"."pers_trip_vige_cert" ("codi_vige_cert_trip", "codi_pers", "fech_inic_vige", "fech_term_vige", "nro_matr", "codi_carg", "tipo_titu")
SELECT
       NULLIF(rtrim("codi_vige_cert_trip"::text), '')::varchar(6) AS "codi_vige_cert_trip",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("fech_inic_vige"::text), '')::timestamp(3) AS "fech_inic_vige",
       NULLIF(btrim("fech_term_vige"::text), '')::timestamp(3) AS "fech_term_vige",
       NULLIF(rtrim("nro_matr"::text), '')::varchar(12) AS "nro_matr",
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg",
       NULLIF(rtrim("tipo_titu"::text), '')::varchar(2) AS "tipo_titu"
FROM "legacy_raw"."pers_trip_vige_cert"
ON CONFLICT DO NOTHING;

-- PERSONAL -> rrhh.personal  (96 col)
INSERT INTO "rrhh"."personal" ("codi_pers", "codi_tipo_docu", "nro_docu_iden", "apel_1", "apel_2", "nomb_1", "nomb_2", "codi_sist_pens", "codi_carg", "codi_area", "codi_mone_basi", "suel_basi", "fech_ingre", "essalud", "carn_essalud", "esta_civi", "fech_naci", "asig_fami", "esta_acti", "scrt", "comi_pesc", "nro_cupss", "afil_sind", "nro_censo", "tipo_cont", "codi_mone", "suel_neto", "carg_fami", "sexo", "nacionalidad", "direccion", "e_mail", "tipo_situ_labo", "segu_vida_ley", "nro_lib_emb", "fech_cese", "clave", "jubilado", "form_pago", "codi_anti", "mont_pago_come", "hora_labo", "codi_unid_oper", "fech_inic_jubi", "codi_rela", "moti_cese", "provincia", "distrito", "vcmto", "departamento", "observaciones", "codi_tipo_ries", "ubigeo", "foto_si_no", "fech_inic_afil", "dist_naci", "prov_naci", "codi_area_grup", "codi_sub_area_grup", "hora_auto", "grat", "vaca", "codi_luga_trab", "afecto_ley", "fotocheck", "horario", "codi_cate_trab", "apor_essa", "apor_sena", "apor_senc", "apor_cona", "tipo_sangr", "peso_kilo", "tall_metr", "codi_elem_costo", "codi_tipo_docu_iden", "codi_nacion", "codi_via", "nomb_via", "num_via", "interior_via", "codi_zona", "nomb_zona", "codi_ubi_reg", "codi_ubi_prov", "codi_ubi_dist", "telefono", "condi_domi", "codi_pension", "codi_situ_trab_pens", "codi_moti_fin_peri", "ruc", "labora_sabado", "refe_zona", "codi_empre_estab", "codi_pais_emi")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("nro_docu_iden"::text), '')::varchar(20) AS "nro_docu_iden",
       NULLIF(rtrim("apel_1"::text), '')::varchar(50) AS "apel_1",
       NULLIF(rtrim("apel_2"::text), '')::varchar(50) AS "apel_2",
       NULLIF(rtrim("nomb_1"::text), '')::varchar(50) AS "nomb_1",
       NULLIF(rtrim("nomb_2"::text), '')::varchar(50) AS "nomb_2",
       NULLIF(rtrim("codi_sist_pens"::text), '')::varchar(2) AS "codi_sist_pens",
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg",
       NULLIF(rtrim("codi_area"::text), '')::varchar(2) AS "codi_area",
       NULLIF(rtrim("codi_mone_basi"::text), '')::varchar(2) AS "codi_mone_basi",
       NULLIF(btrim("suel_basi"::text), '')::numeric(18,2) AS "suel_basi",
       NULLIF(btrim("fech_ingre"::text), '')::timestamp(3) AS "fech_ingre",
       NULLIF(btrim("essalud"::text), '')::boolean AS "essalud",
       NULLIF(rtrim("carn_essalud"::text), '')::varchar(30) AS "carn_essalud",
       NULLIF(rtrim("esta_civi"::text), '')::varchar(1) AS "esta_civi",
       NULLIF(btrim("fech_naci"::text), '')::timestamp(3) AS "fech_naci",
       NULLIF(btrim("asig_fami"::text), '')::boolean AS "asig_fami",
       NULLIF(btrim("esta_acti"::text), '')::boolean AS "esta_acti",
       NULLIF(btrim("scrt"::text), '')::boolean AS "scrt",
       NULLIF(btrim("comi_pesc"::text), '')::boolean AS "comi_pesc",
       NULLIF(rtrim("nro_cupss"::text), '')::varchar(20) AS "nro_cupss",
       NULLIF(btrim("afil_sind"::text), '')::boolean AS "afil_sind",
       NULLIF(rtrim("nro_censo"::text), '')::varchar(20) AS "nro_censo",
       NULLIF(rtrim("tipo_cont"::text), '')::varchar(1) AS "tipo_cont",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("suel_neto"::text), '')::numeric(18,2) AS "suel_neto",
       NULLIF(btrim("carg_fami"::text), '')::boolean AS "carg_fami",
       NULLIF(rtrim("sexo"::text), '')::varchar(1) AS "sexo",
       NULLIF(rtrim("nacionalidad"::text), '')::varchar(50) AS "nacionalidad",
       NULLIF(rtrim("direccion"::text), '')::varchar(150) AS "direccion",
       NULLIF(rtrim("e_mail"::text), '')::varchar(50) AS "e_mail",
       NULLIF(rtrim("tipo_situ_labo"::text), '')::varchar(1) AS "tipo_situ_labo",
       NULLIF(btrim("segu_vida_ley"::text), '')::boolean AS "segu_vida_ley",
       NULLIF(rtrim("nro_lib_emb"::text), '')::varchar(15) AS "nro_lib_emb",
       NULLIF(btrim("fech_cese"::text), '')::timestamp(3) AS "fech_cese",
       NULLIF(rtrim("clave"::text), '')::varchar(4) AS "clave",
       NULLIF(btrim("jubilado"::text), '')::boolean AS "jubilado",
       NULLIF(rtrim("form_pago"::text), '')::varchar(20) AS "form_pago",
       NULLIF(rtrim("codi_anti"::text), '')::varchar(10) AS "codi_anti",
       NULLIF(btrim("mont_pago_come"::text), '')::numeric(9,2) AS "mont_pago_come",
       NULLIF(btrim("hora_labo"::text), '')::numeric(9,2) AS "hora_labo",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(btrim("fech_inic_jubi"::text), '')::timestamp(3) AS "fech_inic_jubi",
       NULLIF(rtrim("codi_rela"::text), '')::varchar(5) AS "codi_rela",
       NULLIF(rtrim("moti_cese"::text), '')::varchar(200) AS "moti_cese",
       NULLIF(rtrim("provincia"::text), '')::varchar(70) AS "provincia",
       NULLIF(rtrim("distrito"::text), '')::varchar(30) AS "distrito",
       NULLIF(btrim("vcmto"::text), '')::timestamp(3) AS "vcmto",
       NULLIF(rtrim("departamento"::text), '')::varchar(60) AS "departamento",
       NULLIF(rtrim("observaciones"::text), '')::varchar(200) AS "observaciones",
       NULLIF(rtrim("codi_tipo_ries"::text), '')::varchar(2) AS "codi_tipo_ries",
       NULLIF(rtrim("ubigeo"::text), '')::varchar(10) AS "ubigeo",
       NULLIF(btrim("foto_si_no"::text), '')::boolean AS "foto_si_no",
       NULLIF(btrim("fech_inic_afil"::text), '')::timestamp(3) AS "fech_inic_afil",
       NULLIF(rtrim("dist_naci"::text), '')::varchar(100) AS "dist_naci",
       NULLIF(rtrim("prov_naci"::text), '')::varchar(100) AS "prov_naci",
       NULLIF(rtrim("codi_area_grup"::text), '')::varchar(2) AS "codi_area_grup",
       NULLIF(rtrim("codi_sub_area_grup"::text), '')::varchar(4) AS "codi_sub_area_grup",
       NULLIF(btrim("hora_auto"::text), '')::numeric(9,2) AS "hora_auto",
       NULLIF(btrim("grat"::text), '')::boolean AS "grat",
       NULLIF(btrim("vaca"::text), '')::boolean AS "vaca",
       NULLIF(rtrim("codi_luga_trab"::text), '')::varchar(2) AS "codi_luga_trab",
       NULLIF(btrim("afecto_ley"::text), '')::boolean AS "afecto_ley",
       NULLIF(btrim("fotocheck"::text), '')::integer AS "fotocheck",
       NULLIF(btrim("horario"::text), '')::smallint AS "horario",
       NULLIF(btrim("codi_cate_trab"::text), '')::smallint AS "codi_cate_trab",
       NULLIF(btrim("apor_essa"::text), '')::boolean AS "apor_essa",
       NULLIF(btrim("apor_sena"::text), '')::boolean AS "apor_sena",
       NULLIF(btrim("apor_senc"::text), '')::boolean AS "apor_senc",
       NULLIF(btrim("apor_cona"::text), '')::boolean AS "apor_cona",
       NULLIF(rtrim("tipo_sangr"::text), '')::varchar(5) AS "tipo_sangr",
       NULLIF(btrim("peso_kilo"::text), '')::numeric(9,2) AS "peso_kilo",
       NULLIF(btrim("tall_metr"::text), '')::numeric(9,2) AS "tall_metr",
       NULLIF(btrim("codi_elem_costo"::text), '')::smallint AS "codi_elem_costo",
       NULLIF(btrim("codi_tipo_docu_iden"::text), '')::smallint AS "codi_tipo_docu_iden",
       NULLIF(btrim("codi_nacion"::text), '')::smallint AS "codi_nacion",
       NULLIF(btrim("codi_via"::text), '')::smallint AS "codi_via",
       NULLIF(rtrim("nomb_via"::text), '')::varchar(20) AS "nomb_via",
       NULLIF(rtrim("num_via"::text), '')::varchar(4) AS "num_via",
       NULLIF(rtrim("interior_via"::text), '')::varchar(4) AS "interior_via",
       NULLIF(btrim("codi_zona"::text), '')::smallint AS "codi_zona",
       NULLIF(rtrim("nomb_zona"::text), '')::varchar(20) AS "nomb_zona",
       NULLIF(btrim("codi_ubi_reg"::text), '')::smallint AS "codi_ubi_reg",
       NULLIF(btrim("codi_ubi_prov"::text), '')::smallint AS "codi_ubi_prov",
       NULLIF(btrim("codi_ubi_dist"::text), '')::smallint AS "codi_ubi_dist",
       NULLIF(rtrim("telefono"::text), '')::varchar(8) AS "telefono",
       NULLIF(btrim("condi_domi"::text), '')::smallint AS "condi_domi",
       NULLIF(btrim("codi_pension"::text), '')::smallint AS "codi_pension",
       NULLIF(btrim("codi_situ_trab_pens"::text), '')::smallint AS "codi_situ_trab_pens",
       NULLIF(btrim("codi_moti_fin_peri"::text), '')::smallint AS "codi_moti_fin_peri",
       NULLIF(rtrim("ruc"::text), '')::varchar(11) AS "ruc",
       NULLIF(rtrim("labora_sabado"::text), '')::varchar(1) AS "labora_sabado",
       NULLIF(rtrim("refe_zona"::text), '')::varchar(40) AS "refe_zona",
       NULLIF(btrim("codi_empre_estab"::text), '')::integer AS "codi_empre_estab",
       NULLIF(rtrim("codi_pais_emi"::text), '')::varchar(3) AS "codi_pais_emi"
FROM "legacy_raw"."personal"
ON CONFLICT DO NOTHING;

-- PERSONAL_CATEGORIA -> rrhh.personal_categoria  (41 col)
INSERT INTO "rrhh"."personal_categoria" ("codi_pers_categ", "codi_pers", "tipo_cat_trab", "essalud", "ruc", "codi_elem_costo", "codi_tipo_docu_iden", "codi_tipo_cont", "condi_domi", "codi_tipo_pers", "codi_nivel", "codi_ocu", "discapacidad", "codi_pension", "fech_ingre", "nro_cupss", "scrt", "sctr_pension", "sujeto_reg_alter", "sujeto_jornada_max", "horario_noctur", "sindicalizado", "codi_periodo", "codi_enti", "codi_situ_trab_pens", "renta_qta_cat_exo_inaf", "regi_labo", "form_pago", "tipo_seg_med", "madre_resp_fam", "centro_form_prof", "codi_cate_trab", "codi_sist_pens", "infor_otros_ingr_qta_cat", "afi_eps_serv_prop", "codi_tipo_medio_pago", "cod_categ_ocup", "cod_conv_evita_dob_tribu", "afilia_asegura_pension", "codi_regi_labo", "afp_mixta")
SELECT
       NULLIF(btrim("codi_pers_categ"::text), '')::bigint AS "codi_pers_categ",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("tipo_cat_trab"::text), '')::varchar(1) AS "tipo_cat_trab",
       NULLIF(btrim("essalud"::text), '')::smallint AS "essalud",
       NULLIF(rtrim("ruc"::text), '')::varchar(11) AS "ruc",
       NULLIF(btrim("codi_elem_costo"::text), '')::smallint AS "codi_elem_costo",
       NULLIF(btrim("codi_tipo_docu_iden"::text), '')::smallint AS "codi_tipo_docu_iden",
       NULLIF(btrim("codi_tipo_cont"::text), '')::smallint AS "codi_tipo_cont",
       NULLIF(btrim("condi_domi"::text), '')::smallint AS "condi_domi",
       NULLIF(btrim("codi_tipo_pers"::text), '')::smallint AS "codi_tipo_pers",
       NULLIF(btrim("codi_nivel"::text), '')::smallint AS "codi_nivel",
       NULLIF(btrim("codi_ocu"::text), '')::smallint AS "codi_ocu",
       NULLIF(btrim("discapacidad"::text), '')::smallint AS "discapacidad",
       NULLIF(btrim("codi_pension"::text), '')::smallint AS "codi_pension",
       NULLIF(btrim("fech_ingre"::text), '')::timestamp(3) AS "fech_ingre",
       NULLIF(rtrim("nro_cupss"::text), '')::varchar(20) AS "nro_cupss",
       NULLIF(btrim("scrt"::text), '')::smallint AS "scrt",
       NULLIF(btrim("sctr_pension"::text), '')::smallint AS "sctr_pension",
       NULLIF(btrim("sujeto_reg_alter"::text), '')::smallint AS "sujeto_reg_alter",
       NULLIF(btrim("sujeto_jornada_max"::text), '')::smallint AS "sujeto_jornada_max",
       NULLIF(btrim("horario_noctur"::text), '')::smallint AS "horario_noctur",
       NULLIF(btrim("sindicalizado"::text), '')::smallint AS "sindicalizado",
       NULLIF(btrim("codi_periodo"::text), '')::smallint AS "codi_periodo",
       NULLIF(btrim("codi_enti"::text), '')::smallint AS "codi_enti",
       NULLIF(btrim("codi_situ_trab_pens"::text), '')::smallint AS "codi_situ_trab_pens",
       NULLIF(btrim("renta_qta_cat_exo_inaf"::text), '')::smallint AS "renta_qta_cat_exo_inaf",
       NULLIF(btrim("regi_labo"::text), '')::smallint AS "regi_labo",
       NULLIF(rtrim("form_pago"::text), '')::varchar(20) AS "form_pago",
       NULLIF(btrim("tipo_seg_med"::text), '')::smallint AS "tipo_seg_med",
       NULLIF(btrim("madre_resp_fam"::text), '')::smallint AS "madre_resp_fam",
       NULLIF(btrim("centro_form_prof"::text), '')::smallint AS "centro_form_prof",
       NULLIF(btrim("codi_cate_trab"::text), '')::smallint AS "codi_cate_trab",
       NULLIF(rtrim("codi_sist_pens"::text), '')::varchar(2) AS "codi_sist_pens",
       NULLIF(btrim("infor_otros_ingr_qta_cat"::text), '')::smallint AS "infor_otros_ingr_qta_cat",
       NULLIF(btrim("afi_eps_serv_prop"::text), '')::smallint AS "afi_eps_serv_prop",
       NULLIF(btrim("codi_tipo_medio_pago"::text), '')::smallint AS "codi_tipo_medio_pago",
       NULLIF(btrim("cod_categ_ocup"::text), '')::integer AS "cod_categ_ocup",
       NULLIF(btrim("cod_conv_evita_dob_tribu"::text), '')::integer AS "cod_conv_evita_dob_tribu",
       NULLIF(btrim("afilia_asegura_pension"::text), '')::integer AS "afilia_asegura_pension",
       NULLIF(rtrim("codi_regi_labo"::text), '')::varchar(2) AS "codi_regi_labo",
       NULLIF(btrim("afp_mixta"::text), '')::integer AS "afp_mixta"
FROM "legacy_raw"."personal_categoria"
ON CONFLICT DO NOTHING;

-- PERSONAL_OTROS_EMPLE_QTA_CAT -> rrhh.personal_otros_emple_qta_cat  (4 col)
INSERT INTO "rrhh"."personal_otros_emple_qta_cat" ("codi_poe", "codi_pers_categ", "ruc", "razon_social")
SELECT
       NULLIF(btrim("codi_poe"::text), '')::bigint AS "codi_poe",
       NULLIF(btrim("codi_pers_categ"::text), '')::bigint AS "codi_pers_categ",
       NULLIF(rtrim("ruc"::text), '')::varchar(11) AS "ruc",
       NULLIF(rtrim("razon_social"::text), '')::varchar(60) AS "razon_social"
FROM "legacy_raw"."personal_otros_emple_qta_cat"
ON CONFLICT DO NOTHING;

-- PERSONAL_PERIODO -> rrhh.personal_periodo  (9 col)
INSERT INTO "rrhh"."personal_periodo" ("codi_periodo", "codi_pers_categ", "fech_inicio", "fech_fin", "codi_moti_fin_peri", "codi_moda_forma", "nro_operacion", "anio", "medio_presenta")
SELECT
       NULLIF(btrim("codi_periodo"::text), '')::bigint AS "codi_periodo",
       NULLIF(btrim("codi_pers_categ"::text), '')::bigint AS "codi_pers_categ",
       NULLIF(btrim("fech_inicio"::text), '')::timestamp(3) AS "fech_inicio",
       NULLIF(btrim("fech_fin"::text), '')::timestamp(3) AS "fech_fin",
       NULLIF(btrim("codi_moti_fin_peri"::text), '')::smallint AS "codi_moti_fin_peri",
       NULLIF(btrim("codi_moda_forma"::text), '')::smallint AS "codi_moda_forma",
       NULLIF(rtrim("nro_operacion"::text), '')::varchar(15) AS "nro_operacion",
       NULLIF(btrim("anio"::text), '')::smallint AS "anio",
       NULLIF(btrim("medio_presenta"::text), '')::smallint AS "medio_presenta"
FROM "legacy_raw"."personal_periodo"
ON CONFLICT DO NOTHING;

-- PERSONAL_POR_TIPO_TRABAJADOR -> rrhh.personal_por_tipo_trabajador  (2 col)
INSERT INTO "rrhh"."personal_por_tipo_trabajador" ("codi_pers", "codi_tipo_pers")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_tipo_pers"::text), '')::varchar(2) AS "codi_tipo_pers"
FROM "legacy_raw"."personal_por_tipo_trabajador"
ON CONFLICT DO NOTHING;

-- personal_saludos -> rrhh.personal_saludos  (5 col)
INSERT INTO "rrhh"."personal_saludos" ("codi_pers", "saludo_1", "saludo_2", "saludo_3", "saludo_4")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("saludo_1"::text), '')::varchar(75) AS "saludo_1",
       NULLIF(rtrim("saludo_2"::text), '')::varchar(75) AS "saludo_2",
       NULLIF(rtrim("saludo_3"::text), '')::varchar(75) AS "saludo_3",
       NULLIF(rtrim("saludo_4"::text), '')::varchar(75) AS "saludo_4"
FROM "legacy_raw"."personal_saludos"
ON CONFLICT DO NOTHING;

-- PERSONAL_SEGUROS -> rrhh.personal_seguros  (6 col)
INSERT INTO "rrhh"."personal_seguros" ("codi_pers", "codi_segu", "fech_segu", "tipo_cant", "codi_mone", "valor")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("codi_segu"::text), '')::smallint AS "codi_segu",
       NULLIF(btrim("fech_segu"::text), '')::timestamp(3) AS "fech_segu",
       NULLIF(btrim("tipo_cant"::text), '')::boolean AS "tipo_cant",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("valor"::text), '')::numeric(12,3) AS "valor"
FROM "legacy_raw"."personal_seguros"
ON CONFLICT DO NOTHING;

-- PERSONAL_TURNO -> rrhh.personal_turno  (4 col)
INSERT INTO "rrhh"."personal_turno" ("codi_pers", "codi_turn", "fech_inic", "fech_term")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_turn"::text), '')::varchar(2) AS "codi_turn",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_term"::text), '')::timestamp(3) AS "fech_term"
FROM "legacy_raw"."personal_turno"
ON CONFLICT DO NOTHING;

-- PERSONAL_VALORES_DEFECTO -> rrhh.personal_valores_defecto  (51 col)
INSERT INTO "rrhh"."personal_valores_defecto" ("codi_tipo_docu", "codi_sist_pens", "codi_carg", "codi_area", "codi_mone_basi", "essalud", "esta_civi", "esta_acti", "scrt", "comi_pesc", "afil_sind", "tipo_cont", "codi_mone", "carg_fami", "sexo", "tipo_situ_labo", "segu_vida_ley", "jubilado", "form_pago", "hora_labo", "codi_tipo_ries", "foto_si_no", "hora_auto", "grat", "vaca", "codi_luga_trab", "afecto_ley", "fotocheck", "horario", "codi_cate_trab", "apor_essa", "apor_sena", "apor_senc", "apor_cona", "codi_elem_costo", "codi_tipo_docu_iden", "codi_nacion", "codi_ubi_dist", "condi_domi", "codi_pension", "codi_situ_trab_pens", "codi_moti_fin_peri", "labora_sabado", "regi_labo", "infor_otros_ingr_qta_cat", "renta_qta_cat_exo_inaf", "afi_eps_serv_prop", "sujeto_jornada_max", "codi_periodo", "sctr_pension", "sctr_salud")
SELECT
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("codi_sist_pens"::text), '')::varchar(2) AS "codi_sist_pens",
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg",
       NULLIF(rtrim("codi_area"::text), '')::varchar(2) AS "codi_area",
       NULLIF(rtrim("codi_mone_basi"::text), '')::varchar(2) AS "codi_mone_basi",
       NULLIF(btrim("essalud"::text), '')::boolean AS "essalud",
       NULLIF(rtrim("esta_civi"::text), '')::varchar(1) AS "esta_civi",
       NULLIF(btrim("esta_acti"::text), '')::boolean AS "esta_acti",
       NULLIF(btrim("scrt"::text), '')::boolean AS "scrt",
       NULLIF(btrim("comi_pesc"::text), '')::boolean AS "comi_pesc",
       NULLIF(btrim("afil_sind"::text), '')::boolean AS "afil_sind",
       NULLIF(rtrim("tipo_cont"::text), '')::varchar(2) AS "tipo_cont",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("carg_fami"::text), '')::boolean AS "carg_fami",
       NULLIF(rtrim("sexo"::text), '')::varchar(1) AS "sexo",
       NULLIF(rtrim("tipo_situ_labo"::text), '')::varchar(1) AS "tipo_situ_labo",
       NULLIF(btrim("segu_vida_ley"::text), '')::boolean AS "segu_vida_ley",
       NULLIF(btrim("jubilado"::text), '')::boolean AS "jubilado",
       NULLIF(rtrim("form_pago"::text), '')::varchar(20) AS "form_pago",
       NULLIF(btrim("hora_labo"::text), '')::numeric(9,2) AS "hora_labo",
       NULLIF(rtrim("codi_tipo_ries"::text), '')::varchar(2) AS "codi_tipo_ries",
       NULLIF(btrim("foto_si_no"::text), '')::boolean AS "foto_si_no",
       NULLIF(btrim("hora_auto"::text), '')::numeric(9,2) AS "hora_auto",
       NULLIF(btrim("grat"::text), '')::boolean AS "grat",
       NULLIF(btrim("vaca"::text), '')::boolean AS "vaca",
       NULLIF(rtrim("codi_luga_trab"::text), '')::varchar(2) AS "codi_luga_trab",
       NULLIF(btrim("afecto_ley"::text), '')::boolean AS "afecto_ley",
       NULLIF(btrim("fotocheck"::text), '')::integer AS "fotocheck",
       NULLIF(btrim("horario"::text), '')::smallint AS "horario",
       NULLIF(btrim("codi_cate_trab"::text), '')::smallint AS "codi_cate_trab",
       NULLIF(btrim("apor_essa"::text), '')::boolean AS "apor_essa",
       NULLIF(btrim("apor_sena"::text), '')::boolean AS "apor_sena",
       NULLIF(btrim("apor_senc"::text), '')::boolean AS "apor_senc",
       NULLIF(btrim("apor_cona"::text), '')::boolean AS "apor_cona",
       NULLIF(btrim("codi_elem_costo"::text), '')::smallint AS "codi_elem_costo",
       NULLIF(btrim("codi_tipo_docu_iden"::text), '')::smallint AS "codi_tipo_docu_iden",
       NULLIF(btrim("codi_nacion"::text), '')::smallint AS "codi_nacion",
       NULLIF(btrim("codi_ubi_dist"::text), '')::smallint AS "codi_ubi_dist",
       NULLIF(btrim("condi_domi"::text), '')::smallint AS "condi_domi",
       NULLIF(btrim("codi_pension"::text), '')::smallint AS "codi_pension",
       NULLIF(btrim("codi_situ_trab_pens"::text), '')::smallint AS "codi_situ_trab_pens",
       NULLIF(btrim("codi_moti_fin_peri"::text), '')::smallint AS "codi_moti_fin_peri",
       NULLIF(rtrim("labora_sabado"::text), '')::varchar(1) AS "labora_sabado",
       NULLIF(btrim("regi_labo"::text), '')::smallint AS "regi_labo",
       NULLIF(btrim("infor_otros_ingr_qta_cat"::text), '')::smallint AS "infor_otros_ingr_qta_cat",
       NULLIF(btrim("renta_qta_cat_exo_inaf"::text), '')::smallint AS "renta_qta_cat_exo_inaf",
       NULLIF(btrim("afi_eps_serv_prop"::text), '')::smallint AS "afi_eps_serv_prop",
       NULLIF(btrim("sujeto_jornada_max"::text), '')::smallint AS "sujeto_jornada_max",
       NULLIF(btrim("codi_periodo"::text), '')::smallint AS "codi_periodo",
       NULLIF(btrim("sctr_pension"::text), '')::smallint AS "sctr_pension",
       NULLIF(btrim("sctr_salud"::text), '')::smallint AS "sctr_salud"
FROM "legacy_raw"."personal_valores_defecto"
ON CONFLICT DO NOTHING;

-- PLAN_CONC_DESC -> rrhh.plan_conc_desc  (9 col)
INSERT INTO "rrhh"."plan_conc_desc" ("codi_prin", "codi_plan_conc", "codi_conc", "codi_desc", "nro_pago", "codi_tipo_trab", "indi_tipo_desc", "valor", "indi_tiem_desc")
SELECT
       NULLIF(rtrim("codi_prin"::text), '')::varchar(10) AS "codi_prin",
       NULLIF(rtrim("codi_plan_conc"::text), '')::varchar(10) AS "codi_plan_conc",
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(rtrim("codi_desc"::text), '')::varchar(10) AS "codi_desc",
       NULLIF(btrim("nro_pago"::text), '')::integer AS "nro_pago",
       NULLIF(rtrim("codi_tipo_trab"::text), '')::varchar(2) AS "codi_tipo_trab",
       NULLIF(rtrim("indi_tipo_desc"::text), '')::varchar(2) AS "indi_tipo_desc",
       NULLIF(btrim("valor"::text), '')::numeric(12,2) AS "valor",
       NULLIF(rtrim("indi_tiem_desc"::text), '')::varchar(10) AS "indi_tiem_desc"
FROM "legacy_raw"."plan_conc_desc"
ON CONFLICT DO NOTHING;

-- PLAN_CONC_INCR -> rrhh.plan_conc_incr  (7 col)
INSERT INTO "rrhh"."plan_conc_incr" ("codi_prin", "codi_plan_conc", "codi_conc", "codi_pers", "nro_incre", "codi_tipo_pers", "valor")
SELECT
       NULLIF(rtrim("codi_prin"::text), '')::varchar(10) AS "codi_prin",
       NULLIF(rtrim("codi_plan_conc"::text), '')::varchar(10) AS "codi_plan_conc",
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("nro_incre"::text), '')::integer AS "nro_incre",
       NULLIF(rtrim("codi_tipo_pers"::text), '')::varchar(2) AS "codi_tipo_pers",
       NULLIF(btrim("valor"::text), '')::numeric(12,2) AS "valor"
FROM "legacy_raw"."plan_conc_incr"
ON CONFLICT DO NOTHING;

-- PLANILLA_BONI_CONCEPTO -> rrhh.planilla_boni_concepto  (5 col)
INSERT INTO "rrhh"."planilla_boni_concepto" ("codi_plan_boni", "codi_conc", "afecto", "valor", "monto")
SELECT
       NULLIF(rtrim("codi_plan_boni"::text), '')::varchar(10) AS "codi_plan_boni",
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(rtrim("afecto"::text), '')::varchar(1) AS "afecto",
       NULLIF(btrim("valor"::text), '')::numeric(12,2) AS "valor",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto"
FROM "legacy_raw"."planilla_boni_concepto"
ON CONFLICT DO NOTHING;

-- PLANILLA_BONI_MOTO -> rrhh.planilla_boni_moto  (9 col)
INSERT INTO "rrhh"."planilla_boni_moto" ("codi_plan_boni", "mesanio", "codi_unid_oper", "codi_pers", "importe", "fech_pago", "form_pago", "nro_cheque", "tipo")
SELECT
       NULLIF(rtrim("codi_plan_boni"::text), '')::varchar(10) AS "codi_plan_boni",
       NULLIF(rtrim("mesanio"::text), '')::varchar(6) AS "mesanio",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("importe"::text), '')::numeric(12,2) AS "importe",
       NULLIF(btrim("fech_pago"::text), '')::timestamp(3) AS "fech_pago",
       NULLIF(rtrim("form_pago"::text), '')::varchar(15) AS "form_pago",
       NULLIF(rtrim("nro_cheque"::text), '')::varchar(15) AS "nro_cheque",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo"
FROM "legacy_raw"."planilla_boni_moto"
ON CONFLICT DO NOTHING;

-- Planilla_Boni_tripu -> rrhh.planilla_boni_tripu  (13 col)
INSERT INTO "rrhh"."planilla_boni_tripu" ("codi_plan_btri", "codi_sema", "codi_pers", "codi_tipo_plan", "estado", "importe", "form_pago", "nro_cheque", "fech_pago", "codi_unid_oper", "importe_especial", "nro_asis", "mesanio")
SELECT
       NULLIF(rtrim("codi_plan_btri"::text), '')::varchar(10) AS "codi_plan_btri",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_tipo_plan"::text), '')::varchar(2) AS "codi_tipo_plan",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(btrim("importe"::text), '')::numeric(10,2) AS "importe",
       NULLIF(rtrim("form_pago"::text), '')::varchar(20) AS "form_pago",
       NULLIF(rtrim("nro_cheque"::text), '')::varchar(30) AS "nro_cheque",
       NULLIF(btrim("fech_pago"::text), '')::timestamp(3) AS "fech_pago",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(btrim("importe_especial"::text), '')::numeric(12,3) AS "importe_especial",
       NULLIF(rtrim("nro_asis"::text), '')::varchar(1) AS "nro_asis",
       NULLIF(rtrim("mesanio"::text), '')::varchar(6) AS "mesanio"
FROM "legacy_raw"."planilla_boni_tripu"
ON CONFLICT DO NOTHING;

-- Planilla_BoniTri_Conceptos -> rrhh.planilla_bonitri_conceptos  (7 col)
INSERT INTO "rrhh"."planilla_bonitri_conceptos" ("codi_plan_btri", "codi_conc", "afecto", "valor", "monto", "especial", "codi")
SELECT
       NULLIF(rtrim("codi_plan_btri"::text), '')::varchar(10) AS "codi_plan_btri",
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(btrim("afecto"::text), '')::boolean AS "afecto",
       NULLIF(btrim("valor"::text), '')::numeric(12,2) AS "valor",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto",
       NULLIF(btrim("especial"::text), '')::numeric(12,3) AS "especial",
       NULLIF(rtrim("codi"::text), '')::varchar(2) AS "codi"
FROM "legacy_raw"."planilla_bonitri_conceptos"
ON CONFLICT DO NOTHING;

-- PLANILLA_CTS_CONCEPTOS -> rrhh.planilla_cts_conceptos  (5 col)
INSERT INTO "rrhh"."planilla_cts_conceptos" ("codi_plan_cts", "codi_conc", "afecto", "valor", "monto")
SELECT
       NULLIF(rtrim("codi_plan_cts"::text), '')::varchar(10) AS "codi_plan_cts",
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(btrim("afecto"::text), '')::boolean AS "afecto",
       NULLIF(btrim("valor"::text), '')::numeric(12,2) AS "valor",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto"
FROM "legacy_raw"."planilla_cts_conceptos"
ON CONFLICT DO NOTHING;

-- PLANILLA_DE_EMPLEADOS -> rrhh.planilla_de_empleados  (17 col)
INSERT INTO "rrhh"."planilla_de_empleados" ("codi_plan_empl", "anio", "mes", "codi_pers", "codi_tipo_plan", "fech_inic", "fech_term", "importe", "estado", "indi_tiem", "form_pago", "nro_cheq", "fech_pago", "codi_sist_pens", "codi_tipo_pers", "semana", "codi_unid_oper")
SELECT
       NULLIF(rtrim("codi_plan_empl"::text), '')::varchar(10) AS "codi_plan_empl",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_tipo_plan"::text), '')::varchar(2) AS "codi_tipo_plan",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_term"::text), '')::timestamp(3) AS "fech_term",
       NULLIF(btrim("importe"::text), '')::numeric(10,2) AS "importe",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("indi_tiem"::text), '')::varchar(5) AS "indi_tiem",
       NULLIF(rtrim("form_pago"::text), '')::varchar(20) AS "form_pago",
       NULLIF(rtrim("nro_cheq"::text), '')::varchar(30) AS "nro_cheq",
       NULLIF(btrim("fech_pago"::text), '')::timestamp(3) AS "fech_pago",
       NULLIF(rtrim("codi_sist_pens"::text), '')::varchar(2) AS "codi_sist_pens",
       NULLIF(rtrim("codi_tipo_pers"::text), '')::varchar(2) AS "codi_tipo_pers",
       NULLIF(btrim("semana"::text), '')::smallint AS "semana",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper"
FROM "legacy_raw"."planilla_de_empleados"
ON CONFLICT DO NOTHING;

-- PLANILLA_DE_OBREROS -> rrhh.planilla_de_obreros  (17 col)
INSERT INTO "rrhh"."planilla_de_obreros" ("codi_plan_obre", "fech_inic", "fech_term", "codi_pers", "codi_tipo_plan", "importe", "anio", "mes", "estado", "indi_tiem", "form_pago", "nro_cheq", "fech_pago", "codi_sist_pens", "codi_tipo_pers", "semana", "codi_unid_oper")
SELECT
       NULLIF(rtrim("codi_plan_obre"::text), '')::varchar(10) AS "codi_plan_obre",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_term"::text), '')::timestamp(3) AS "fech_term",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_tipo_plan"::text), '')::varchar(2) AS "codi_tipo_plan",
       NULLIF(btrim("importe"::text), '')::numeric(10,2) AS "importe",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("indi_tiem"::text), '')::varchar(5) AS "indi_tiem",
       NULLIF(rtrim("form_pago"::text), '')::varchar(20) AS "form_pago",
       NULLIF(rtrim("nro_cheq"::text), '')::varchar(30) AS "nro_cheq",
       NULLIF(btrim("fech_pago"::text), '')::timestamp(3) AS "fech_pago",
       NULLIF(rtrim("codi_sist_pens"::text), '')::varchar(2) AS "codi_sist_pens",
       NULLIF(rtrim("codi_tipo_pers"::text), '')::varchar(2) AS "codi_tipo_pers",
       NULLIF(btrim("semana"::text), '')::smallint AS "semana",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper"
FROM "legacy_raw"."planilla_de_obreros"
ON CONFLICT DO NOTHING;

-- PLANILLA_DE_TRIPULANTES -> rrhh.planilla_de_tripulantes  (13 col)
INSERT INTO "rrhh"."planilla_de_tripulantes" ("codi_plan_trip", "codi_sema", "codi_pers", "codi_tipo_plan", "estado", "importe", "form_pago", "nro_cheq", "fech_pago", "codi_unid_oper", "importe_especial", "nro_asis", "mesanio")
SELECT
       NULLIF(rtrim("codi_plan_trip"::text), '')::varchar(10) AS "codi_plan_trip",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_tipo_plan"::text), '')::varchar(2) AS "codi_tipo_plan",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(btrim("importe"::text), '')::numeric(10,2) AS "importe",
       NULLIF(rtrim("form_pago"::text), '')::varchar(20) AS "form_pago",
       NULLIF(rtrim("nro_cheq"::text), '')::varchar(30) AS "nro_cheq",
       NULLIF(btrim("fech_pago"::text), '')::timestamp(3) AS "fech_pago",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(btrim("importe_especial"::text), '')::numeric(12,2) AS "importe_especial",
       NULLIF(rtrim("nro_asis"::text), '')::varchar(1) AS "nro_asis",
       NULLIF(rtrim("mesanio"::text), '')::varchar(6) AS "mesanio"
FROM "legacy_raw"."planilla_de_tripulantes"
ON CONFLICT DO NOTHING;

-- PLANILLA_EMPLEADO_CONCEPTOS -> rrhh.planilla_empleado_conceptos  (5 col)
INSERT INTO "rrhh"."planilla_empleado_conceptos" ("codi_plan_empl", "codi_conc", "afecto", "valor", "monto")
SELECT
       NULLIF(rtrim("codi_plan_empl"::text), '')::varchar(10) AS "codi_plan_empl",
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(btrim("afecto"::text), '')::boolean AS "afecto",
       NULLIF(btrim("valor"::text), '')::numeric(12,2) AS "valor",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto"
FROM "legacy_raw"."planilla_empleado_conceptos"
ON CONFLICT DO NOTHING;

-- PLANILLA_GRATI_VACA -> rrhh.planilla_grati_vaca  (12 col)
INSERT INTO "rrhh"."planilla_grati_vaca" ("codi_plan_grva", "codi_sema", "codi_pers", "codi_tipo_plan", "estado", "importe", "form_pago", "nro_cheq", "fech_pago", "codi_unid_oper", "nro_asis", "mesanio")
SELECT
       NULLIF(rtrim("codi_plan_grva"::text), '')::varchar(10) AS "codi_plan_grva",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_tipo_plan"::text), '')::varchar(2) AS "codi_tipo_plan",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(btrim("importe"::text), '')::numeric(18,2) AS "importe",
       NULLIF(rtrim("form_pago"::text), '')::varchar(20) AS "form_pago",
       NULLIF(rtrim("nro_cheq"::text), '')::varchar(30) AS "nro_cheq",
       NULLIF(btrim("fech_pago"::text), '')::timestamp(3) AS "fech_pago",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("nro_asis"::text), '')::varchar(1) AS "nro_asis",
       NULLIF(rtrim("mesanio"::text), '')::varchar(6) AS "mesanio"
FROM "legacy_raw"."planilla_grati_vaca"
ON CONFLICT DO NOTHING;

-- PLANILLA_GRATI_VACA_CONCEP -> rrhh.planilla_grati_vaca_concep  (6 col)
INSERT INTO "rrhh"."planilla_grati_vaca_concep" ("codi_plan_grva", "codi_conc", "afecto", "valor", "monto", "codi")
SELECT
       NULLIF(rtrim("codi_plan_grva"::text), '')::varchar(10) AS "codi_plan_grva",
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(btrim("afecto"::text), '')::boolean AS "afecto",
       NULLIF(btrim("valor"::text), '')::numeric(18,2) AS "valor",
       NULLIF(btrim("monto"::text), '')::numeric(18,2) AS "monto",
       NULLIF(rtrim("codi"::text), '')::varchar(2) AS "codi"
FROM "legacy_raw"."planilla_grati_vaca_concep"
ON CONFLICT DO NOTHING;

-- PLANILLA_OBRERO_CONCEPTOS -> rrhh.planilla_obrero_conceptos  (5 col)
INSERT INTO "rrhh"."planilla_obrero_conceptos" ("codi_plan_obre", "codi_conc", "afecto", "valor", "monto")
SELECT
       NULLIF(rtrim("codi_plan_obre"::text), '')::varchar(10) AS "codi_plan_obre",
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(btrim("afecto"::text), '')::boolean AS "afecto",
       NULLIF(btrim("valor"::text), '')::numeric(12,2) AS "valor",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto"
FROM "legacy_raw"."planilla_obrero_conceptos"
ON CONFLICT DO NOTHING;

-- PLANILLA_PESCA_TRIPULANTES -> rrhh.planilla_pesca_tripulantes  (18 col)
INSERT INTO "rrhh"."planilla_pesca_tripulantes" ("codi_sema", "codi_unid_oper", "codi_pers", "codi_carg", "dia", "nom_dia", "pesc_real", "prec_snp", "porc_distr", "parte", "adicional", "monto", "refri", "espe_parte", "espe_adic", "espe_monto", "nro_asis", "mesanio")
SELECT
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg",
       NULLIF(btrim("dia"::text), '')::timestamp(3) AS "dia",
       NULLIF(rtrim("nom_dia"::text), '')::varchar(10) AS "nom_dia",
       NULLIF(btrim("pesc_real"::text), '')::numeric(12,3) AS "pesc_real",
       NULLIF(btrim("prec_snp"::text), '')::numeric(12,3) AS "prec_snp",
       NULLIF(btrim("porc_distr"::text), '')::numeric(12,3) AS "porc_distr",
       NULLIF(btrim("parte"::text), '')::numeric(12,3) AS "parte",
       NULLIF(btrim("adicional"::text), '')::numeric(12,3) AS "adicional",
       NULLIF(btrim("monto"::text), '')::numeric(12,3) AS "monto",
       NULLIF(btrim("refri"::text), '')::numeric(12,3) AS "refri",
       NULLIF(btrim("espe_parte"::text), '')::numeric(12,3) AS "espe_parte",
       NULLIF(btrim("espe_adic"::text), '')::numeric(12,3) AS "espe_adic",
       NULLIF(btrim("espe_monto"::text), '')::numeric(12,3) AS "espe_monto",
       NULLIF(rtrim("nro_asis"::text), '')::varchar(1) AS "nro_asis",
       NULLIF(rtrim("mesanio"::text), '')::varchar(6) AS "mesanio"
FROM "legacy_raw"."planilla_pesca_tripulantes"
ON CONFLICT DO NOTHING;

-- PLANILLA_SUBS_CONCEPTO -> rrhh.planilla_subs_concepto  (5 col)
INSERT INTO "rrhh"."planilla_subs_concepto" ("codi_plan_subs", "codi_conc", "afecto", "valor", "monto")
SELECT
       NULLIF(rtrim("codi_plan_subs"::text), '')::varchar(10) AS "codi_plan_subs",
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(rtrim("afecto"::text), '')::varchar(1) AS "afecto",
       NULLIF(btrim("valor"::text), '')::numeric(12,2) AS "valor",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto"
FROM "legacy_raw"."planilla_subs_concepto"
ON CONFLICT DO NOTHING;

-- PLANILLA_SUBSIDIO -> rrhh.planilla_subsidio  (10 col)
INSERT INTO "rrhh"."planilla_subsidio" ("codi_plan_subs", "mesanio", "codi_unid_oper", "codi_pers", "importe", "fech_pago", "form_pago", "nro_cheque", "tipo", "codi_sema")
SELECT
       NULLIF(rtrim("codi_plan_subs"::text), '')::varchar(10) AS "codi_plan_subs",
       NULLIF(rtrim("mesanio"::text), '')::varchar(6) AS "mesanio",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("importe"::text), '')::numeric(12,2) AS "importe",
       NULLIF(btrim("fech_pago"::text), '')::timestamp(3) AS "fech_pago",
       NULLIF(rtrim("form_pago"::text), '')::varchar(15) AS "form_pago",
       NULLIF(rtrim("nro_cheque"::text), '')::varchar(15) AS "nro_cheque",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema"
FROM "legacy_raw"."planilla_subsidio"
ON CONFLICT DO NOTHING;

-- PLANILLA_TRIPULANTE_CONCEPTOS -> rrhh.planilla_tripulante_conceptos  (7 col)
INSERT INTO "rrhh"."planilla_tripulante_conceptos" ("codi_plan_trip", "codi_conc", "afecto", "valor", "monto", "especial", "codi")
SELECT
       NULLIF(rtrim("codi_plan_trip"::text), '')::varchar(10) AS "codi_plan_trip",
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc",
       NULLIF(btrim("afecto"::text), '')::boolean AS "afecto",
       NULLIF(btrim("valor"::text), '')::numeric(12,2) AS "valor",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto",
       NULLIF(btrim("especial"::text), '')::numeric(12,2) AS "especial",
       NULLIF(rtrim("codi"::text), '')::varchar(2) AS "codi"
FROM "legacy_raw"."planilla_tripulante_conceptos"
ON CONFLICT DO NOTHING;

-- PRESTAMOS -> rrhh.prestamos  (16 col)
INSERT INTO "rrhh"."prestamos" ("codi_pres", "codi_pers", "nro_pres", "fech_pres", "moti_pres", "esta_acti", "tipo_desc", "codi_mone", "monto", "mont_desc", "inte_tiem_desc", "saldo", "presupuesto", "codi_baza", "registro", "codi_tipo_pres")
SELECT
       NULLIF(rtrim("codi_pres"::text), '')::varchar(6) AS "codi_pres",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("nro_pres"::text), '')::integer AS "nro_pres",
       NULLIF(btrim("fech_pres"::text), '')::timestamp(3) AS "fech_pres",
       NULLIF(rtrim("moti_pres"::text), '')::varchar(100) AS "moti_pres",
       NULLIF(btrim("esta_acti"::text), '')::boolean AS "esta_acti",
       NULLIF(btrim("tipo_desc"::text), '')::boolean AS "tipo_desc",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto",
       NULLIF(btrim("mont_desc"::text), '')::numeric(12,2) AS "mont_desc",
       NULLIF(rtrim("inte_tiem_desc"::text), '')::varchar(20) AS "inte_tiem_desc",
       NULLIF(btrim("saldo"::text), '')::numeric(12,2) AS "saldo",
       NULLIF(rtrim("presupuesto"::text), '')::varchar(10) AS "presupuesto",
       NULLIF(rtrim("codi_baza"::text), '')::varchar(2) AS "codi_baza",
       NULLIF(rtrim("registro"::text), '')::varchar(10) AS "registro",
       NULLIF(rtrim("codi_tipo_pres"::text), '')::varchar(2) AS "codi_tipo_pres"
FROM "legacy_raw"."prestamos"
ON CONFLICT DO NOTHING;

-- REGIMEN_LABORAL -> rrhh.regimen_laboral  (6 col)
INSERT INTO "rrhh"."regimen_laboral" ("codigo", "descripcion", "abreviada", "privado", "publico", "otros")
SELECT
       NULLIF(rtrim("codigo"::text), '')::varchar(2) AS "codigo",
       NULLIF(rtrim("descripcion"::text), '')::varchar(200) AS "descripcion",
       NULLIF(rtrim("abreviada"::text), '')::varchar(100) AS "abreviada",
       NULLIF(rtrim("privado"::text), '')::varchar(1) AS "privado",
       NULLIF(rtrim("publico"::text), '')::varchar(1) AS "publico",
       NULLIF(rtrim("otros"::text), '')::varchar(1) AS "otros"
FROM "legacy_raw"."regimen_laboral"
ON CONFLICT DO NOTHING;

-- RUBROS_SISTEMA_PENSIONES -> rrhh.rubros_sistema_pensiones  (4 col)
INSERT INTO "rrhh"."rubros_sistema_pensiones" ("codi_rubr", "desc_rubr", "tipo_cant", "esta_rubr")
SELECT
       NULLIF(rtrim("codi_rubr"::text), '')::varchar(3) AS "codi_rubr",
       NULLIF(rtrim("desc_rubr"::text), '')::varchar(50) AS "desc_rubr",
       NULLIF(rtrim("tipo_cant"::text), '')::varchar(1) AS "tipo_cant",
       NULLIF(btrim("esta_rubr"::text), '')::boolean AS "esta_rubr"
FROM "legacy_raw"."rubros_sistema_pensiones"
ON CONFLICT DO NOTHING;

-- SINDICATOS -> rrhh.sindicatos  (7 col)
INSERT INTO "rrhh"."sindicatos" ("codi_sind", "descrip", "tipo", "codi_clie_prov", "porcentaje", "tipo_valor", "nemo")
SELECT
       NULLIF(rtrim("codi_sind"::text), '')::varchar(2) AS "codi_sind",
       NULLIF(rtrim("descrip"::text), '')::varchar(100) AS "descrip",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("porcentaje"::text), '')::bigint AS "porcentaje",
       NULLIF(rtrim("tipo_valor"::text), '')::varchar(1) AS "tipo_valor",
       NULLIF(rtrim("nemo"::text), '')::varchar(30) AS "nemo"
FROM "legacy_raw"."sindicatos"
ON CONFLICT DO NOTHING;

-- SINDICATOS_PERSONAL -> rrhh.sindicatos_personal  (3 col)
INSERT INTO "rrhh"."sindicatos_personal" ("codi_sind", "codi_pers", "estado")
SELECT
       NULLIF(rtrim("codi_sind"::text), '')::varchar(2) AS "codi_sind",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado"
FROM "legacy_raw"."sindicatos_personal"
ON CONFLICT DO NOTHING;

-- SISTEMA_PENSIONES -> rrhh.sistema_pensiones  (6 col)
INSERT INTO "rrhh"."sistema_pensiones" ("codi_sist_pens", "desc_sist_pens", "nemo", "codi_rela", "codi_pension", "afpnet")
SELECT
       NULLIF(rtrim("codi_sist_pens"::text), '')::varchar(2) AS "codi_sist_pens",
       NULLIF(rtrim("desc_sist_pens"::text), '')::varchar(50) AS "desc_sist_pens",
       NULLIF(rtrim("nemo"::text), '')::varchar(10) AS "nemo",
       NULLIF(rtrim("codi_rela"::text), '')::varchar(5) AS "codi_rela",
       NULLIF(btrim("codi_pension"::text), '')::smallint AS "codi_pension",
       NULLIF(rtrim("afpnet"::text), '')::varchar(2) AS "afpnet"
FROM "legacy_raw"."sistema_pensiones"
ON CONFLICT DO NOTHING;

-- SITU_TRAB_PENS -> rrhh.situ_trab_pens  (5 col)
INSERT INTO "rrhh"."situ_trab_pens" ("codi_situ_trab_pens", "codi_situ_trab_pens_sunat", "afiliado_eps", "desc_situ_trab_pens", "codi_situ_trab_pens_plame")
SELECT
       NULLIF(btrim("codi_situ_trab_pens"::text), '')::smallint AS "codi_situ_trab_pens",
       NULLIF(btrim("codi_situ_trab_pens_sunat"::text), '')::smallint AS "codi_situ_trab_pens_sunat",
       NULLIF(btrim("afiliado_eps"::text), '')::smallint AS "afiliado_eps",
       NULLIF(rtrim("desc_situ_trab_pens"::text), '')::varchar(150) AS "desc_situ_trab_pens",
       NULLIF(btrim("codi_situ_trab_pens_plame"::text), '')::smallint AS "codi_situ_trab_pens_plame"
FROM "legacy_raw"."situ_trab_pens"
ON CONFLICT DO NOTHING;

-- SOLI_PRES -> rrhh.soli_pres  (19 col)
INSERT INTO "rrhh"."soli_pres" ("codi_soli_pres", "nro_soli_pres", "codi_pers", "fech_soli", "impo_soli", "situ_actu", "codi_usua_dato", "fech_regi_dato", "impo_otor", "form_desc", "nro_sema_desc", "peri_desc", "mes_desc", "plaz_pago", "fech_prim_pago", "nro_cuotas", "observacion", "observacion1", "desc_pres")
SELECT
       NULLIF(rtrim("codi_soli_pres"::text), '')::varchar(10) AS "codi_soli_pres",
       NULLIF(btrim("nro_soli_pres"::text), '')::integer AS "nro_soli_pres",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("fech_soli"::text), '')::timestamp(3) AS "fech_soli",
       NULLIF(btrim("impo_soli"::text), '')::numeric(15,4) AS "impo_soli",
       NULLIF(rtrim("situ_actu"::text), '')::varchar(50) AS "situ_actu",
       NULLIF(rtrim("codi_usua_dato"::text), '')::varchar(5) AS "codi_usua_dato",
       NULLIF(btrim("fech_regi_dato"::text), '')::timestamp(3) AS "fech_regi_dato",
       NULLIF(btrim("impo_otor"::text), '')::numeric(15,4) AS "impo_otor",
       NULLIF(rtrim("form_desc"::text), '')::varchar(50) AS "form_desc",
       NULLIF(btrim("nro_sema_desc"::text), '')::smallint AS "nro_sema_desc",
       NULLIF(btrim("peri_desc"::text), '')::integer AS "peri_desc",
       NULLIF(btrim("mes_desc"::text), '')::smallint AS "mes_desc",
       NULLIF(rtrim("plaz_pago"::text), '')::varchar(50) AS "plaz_pago",
       NULLIF(btrim("fech_prim_pago"::text), '')::timestamp(3) AS "fech_prim_pago",
       NULLIF(btrim("nro_cuotas"::text), '')::smallint AS "nro_cuotas",
       NULLIF(rtrim("observacion"::text), '')::varchar(250) AS "observacion",
       NULLIF(rtrim("observacion1"::text), '')::varchar(250) AS "observacion1",
       NULLIF(rtrim("desc_pres"::text), '')::varchar(1) AS "desc_pres"
FROM "legacy_raw"."soli_pres"
ON CONFLICT DO NOTHING;

-- SOLI_PRES_CRON_DEVO -> rrhh.soli_pres_cron_devo  (5 col)
INSERT INTO "rrhh"."soli_pres_cron_devo" ("codi_soli_pres", "nro_item", "nro_cuot", "fech_venc", "mont_cuot")
SELECT
       NULLIF(rtrim("codi_soli_pres"::text), '')::varchar(10) AS "codi_soli_pres",
       NULLIF(btrim("nro_item"::text), '')::smallint AS "nro_item",
       NULLIF(btrim("nro_cuot"::text), '')::smallint AS "nro_cuot",
       NULLIF(btrim("fech_venc"::text), '')::timestamp(3) AS "fech_venc",
       NULLIF(btrim("mont_cuot"::text), '')::numeric(15,4) AS "mont_cuot"
FROM "legacy_raw"."soli_pres_cron_devo"
ON CONFLICT DO NOTHING;

-- SOLI_PRES_INGR_DESC -> rrhh.soli_pres_ingr_desc  (5 col)
INSERT INTO "rrhh"."soli_pres_ingr_desc" ("codi_soli_pres", "nro_item", "tipo_mont", "desc_mont", "monto")
SELECT
       NULLIF(rtrim("codi_soli_pres"::text), '')::varchar(10) AS "codi_soli_pres",
       NULLIF(btrim("nro_item"::text), '')::smallint AS "nro_item",
       NULLIF(rtrim("tipo_mont"::text), '')::varchar(1) AS "tipo_mont",
       NULLIF(rtrim("desc_mont"::text), '')::varchar(100) AS "desc_mont",
       NULLIF(btrim("monto"::text), '')::numeric(15,4) AS "monto"
FROM "legacy_raw"."soli_pres_ingr_desc"
ON CONFLICT DO NOTHING;

-- SUB_AREA_GRUP -> rrhh.sub_area_grup  (5 col)
INSERT INTO "rrhh"."sub_area_grup" ("codi_sub_area_grup", "desc_sub_area_grup", "nemo_sub_area_grup", "nro_jera", "codi_area_grup")
SELECT
       NULLIF(rtrim("codi_sub_area_grup"::text), '')::varchar(4) AS "codi_sub_area_grup",
       NULLIF(rtrim("desc_sub_area_grup"::text), '')::varchar(200) AS "desc_sub_area_grup",
       NULLIF(rtrim("nemo_sub_area_grup"::text), '')::varchar(30) AS "nemo_sub_area_grup",
       NULLIF(btrim("nro_jera"::text), '')::integer AS "nro_jera",
       NULLIF(rtrim("codi_area_grup"::text), '')::varchar(2) AS "codi_area_grup"
FROM "legacy_raw"."sub_area_grup"
ON CONFLICT DO NOTHING;

-- SUBSIDIOS -> rrhh.subsidios  (16 col)
INSERT INTO "rrhh"."subsidios" ("mesanio", "codi_pers", "codi_unid_oper", "codi_carg", "monto", "dias", "codi_sema", "certificado", "fecha_inicio", "fecha_fin", "codi_mone", "tipocambio", "pagoempresa", "pagoessalud", "fechapago", "observaciones")
SELECT
       NULLIF(rtrim("mesanio"::text), '')::varchar(6) AS "mesanio",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto",
       NULLIF(btrim("dias"::text), '')::integer AS "dias",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(rtrim("certificado"::text), '')::varchar(50) AS "certificado",
       NULLIF(btrim("fecha_inicio"::text), '')::timestamp(3) AS "fecha_inicio",
       NULLIF(btrim("fecha_fin"::text), '')::timestamp(3) AS "fecha_fin",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("tipocambio"::text), '')::numeric(18,3) AS "tipocambio",
       NULLIF(rtrim("pagoempresa"::text), '')::varchar(1) AS "pagoempresa",
       NULLIF(rtrim("pagoessalud"::text), '')::varchar(1) AS "pagoessalud",
       NULLIF(btrim("fechapago"::text), '')::timestamp(3) AS "fechapago",
       NULLIF(rtrim("observaciones"::text), '')::varchar(250) AS "observaciones"
FROM "legacy_raw"."subsidios"
ON CONFLICT DO NOTHING;

-- TIPO_CARGO -> rrhh.tipo_cargo  (2 col)
INSERT INTO "rrhh"."tipo_cargo" ("codi_tipo_carg", "desc_tipo_carg")
SELECT
       NULLIF(rtrim("codi_tipo_carg"::text), '')::varchar(2) AS "codi_tipo_carg",
       NULLIF(rtrim("desc_tipo_carg"::text), '')::varchar(50) AS "desc_tipo_carg"
FROM "legacy_raw"."tipo_cargo"
ON CONFLICT DO NOTHING;

-- TIPO_COMIDA -> rrhh.tipo_comida  (2 col)
INSERT INTO "rrhh"."tipo_comida" ("codi_tipo_comi", "desc_tipo_comi")
SELECT
       NULLIF(rtrim("codi_tipo_comi"::text), '')::varchar(2) AS "codi_tipo_comi",
       NULLIF(rtrim("desc_tipo_comi"::text), '')::varchar(25) AS "desc_tipo_comi"
FROM "legacy_raw"."tipo_comida"
ON CONFLICT DO NOTHING;

-- TIPO_CONCEPTOS -> rrhh.tipo_conceptos  (2 col)
INSERT INTO "rrhh"."tipo_conceptos" ("codi_tipo", "descripcion")
SELECT
       NULLIF(rtrim("codi_tipo"::text), '')::varchar(1) AS "codi_tipo",
       NULLIF(rtrim("descripcion"::text), '')::varchar(20) AS "descripcion"
FROM "legacy_raw"."tipo_conceptos"
ON CONFLICT DO NOTHING;

-- TIPO_CONTRATO -> rrhh.tipo_contrato  (3 col)
INSERT INTO "rrhh"."tipo_contrato" ("codi_tipo_cont", "codi_tipo_cont_sunat", "desc_tipo_cont")
SELECT
       NULLIF(btrim("codi_tipo_cont"::text), '')::smallint AS "codi_tipo_cont",
       NULLIF(rtrim("codi_tipo_cont_sunat"::text), '')::varchar(2) AS "codi_tipo_cont_sunat",
       NULLIF(rtrim("desc_tipo_cont"::text), '')::varchar(100) AS "desc_tipo_cont"
FROM "legacy_raw"."tipo_contrato"
ON CONFLICT DO NOTHING;

-- TIPO_PERSONAL -> rrhh.tipo_personal  (4 col)
INSERT INTO "rrhh"."tipo_personal" ("codi_tipo_pers", "codi_tipo_pers_sunat", "desc_tipo_pers", "nemo_tipo_pers")
SELECT
       NULLIF(btrim("codi_tipo_pers"::text), '')::smallint AS "codi_tipo_pers",
       NULLIF(rtrim("codi_tipo_pers_sunat"::text), '')::varchar(2) AS "codi_tipo_pers_sunat",
       NULLIF(rtrim("desc_tipo_pers"::text), '')::varchar(100) AS "desc_tipo_pers",
       NULLIF(rtrim("nemo_tipo_pers"::text), '')::varchar(50) AS "nemo_tipo_pers"
FROM "legacy_raw"."tipo_personal"
ON CONFLICT DO NOTHING;

-- TIPO_PLAN_NEMO -> rrhh.tipo_plan_nemo  (5 col)
INSERT INTO "rrhh"."tipo_plan_nemo" ("codi_nemo_plan", "nemo_plan", "desc_nemo_plan", "codi_tipo_plan", "codi_tipo_pers")
SELECT
       NULLIF(rtrim("codi_nemo_plan"::text), '')::varchar(2) AS "codi_nemo_plan",
       NULLIF(rtrim("nemo_plan"::text), '')::varchar(2) AS "nemo_plan",
       NULLIF(rtrim("desc_nemo_plan"::text), '')::varchar(100) AS "desc_nemo_plan",
       NULLIF(rtrim("codi_tipo_plan"::text), '')::varchar(2) AS "codi_tipo_plan",
       NULLIF(rtrim("codi_tipo_pers"::text), '')::varchar(2) AS "codi_tipo_pers"
FROM "legacy_raw"."tipo_plan_nemo"
ON CONFLICT DO NOTHING;

-- TIPO_PRESTAMO -> rrhh.tipo_prestamo  (3 col)
INSERT INTO "rrhh"."tipo_prestamo" ("codi_tipo_pres", "desc_tipo_pres", "nemo_tipo_pres")
SELECT
       NULLIF(rtrim("codi_tipo_pres"::text), '')::varchar(2) AS "codi_tipo_pres",
       NULLIF(rtrim("desc_tipo_pres"::text), '')::varchar(50) AS "desc_tipo_pres",
       NULLIF(rtrim("nemo_tipo_pres"::text), '')::varchar(10) AS "nemo_tipo_pres"
FROM "legacy_raw"."tipo_prestamo"
ON CONFLICT DO NOTHING;

-- TIPO_RIES_TASA -> rrhh.tipo_ries_tasa  (5 col)
INSERT INTO "rrhh"."tipo_ries_tasa" ("codi_tipo_ries", "fech_inic", "fech_fin", "codi_tipo_pers", "tasa")
SELECT
       NULLIF(rtrim("codi_tipo_ries"::text), '')::varchar(2) AS "codi_tipo_ries",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_fin"::text), '')::timestamp(3) AS "fech_fin",
       NULLIF(rtrim("codi_tipo_pers"::text), '')::varchar(2) AS "codi_tipo_pers",
       NULLIF(btrim("tasa"::text), '')::numeric(9,4) AS "tasa"
FROM "legacy_raw"."tipo_ries_tasa"
ON CONFLICT DO NOTHING;

-- TIPO_RIESGO -> rrhh.tipo_riesgo  (3 col)
INSERT INTO "rrhh"."tipo_riesgo" ("codi_tipo_ries", "desc_tipo_ries", "nemo")
SELECT
       NULLIF(rtrim("codi_tipo_ries"::text), '')::varchar(2) AS "codi_tipo_ries",
       NULLIF(rtrim("desc_tipo_ries"::text), '')::varchar(200) AS "desc_tipo_ries",
       NULLIF(rtrim("nemo"::text), '')::varchar(10) AS "nemo"
FROM "legacy_raw"."tipo_riesgo"
ON CONFLICT DO NOTHING;

-- TIPO_SITU_HORA_TRAB -> rrhh.tipo_situ_hora_trab  (3 col)
INSERT INTO "rrhh"."tipo_situ_hora_trab" ("codi_tipo_situ_hora", "desc_situ_hora", "abre_situ_hora")
SELECT
       NULLIF(rtrim("codi_tipo_situ_hora"::text), '')::varchar(2) AS "codi_tipo_situ_hora",
       NULLIF(rtrim("desc_situ_hora"::text), '')::varchar(50) AS "desc_situ_hora",
       NULLIF(rtrim("abre_situ_hora"::text), '')::varchar(20) AS "abre_situ_hora"
FROM "legacy_raw"."tipo_situ_hora_trab"
ON CONFLICT DO NOTHING;

-- TIPO_SUSPENSION -> rrhh.tipo_suspension  (4 col)
INSERT INTO "rrhh"."tipo_suspension" ("codi_tipo_susp_labo", "codi_tipo_susp_labo_sunat", "desc_tipo_susp_labo", "tipo")
SELECT
       NULLIF(btrim("codi_tipo_susp_labo"::text), '')::smallint AS "codi_tipo_susp_labo",
       NULLIF(rtrim("codi_tipo_susp_labo_sunat"::text), '')::varchar(2) AS "codi_tipo_susp_labo_sunat",
       NULLIF(rtrim("desc_tipo_susp_labo"::text), '')::varchar(200) AS "desc_tipo_susp_labo",
       NULLIF(btrim("tipo"::text), '')::smallint AS "tipo"
FROM "legacy_raw"."tipo_suspension"
ON CONFLICT DO NOTHING;

-- TIPO_TRABAJADOR -> rrhh.tipo_trabajador  (2 col)
INSERT INTO "rrhh"."tipo_trabajador" ("codi_tipo_pers", "desc_tipo_pers")
SELECT
       NULLIF(rtrim("codi_tipo_pers"::text), '')::varchar(2) AS "codi_tipo_pers",
       NULLIF(rtrim("desc_tipo_pers"::text), '')::varchar(50) AS "desc_tipo_pers"
FROM "legacy_raw"."tipo_trabajador"
ON CONFLICT DO NOTHING;

-- TIPO_VACACIONES -> rrhh.tipo_vacaciones  (2 col)
INSERT INTO "rrhh"."tipo_vacaciones" ("codi_tipo_vaca", "desc_tipo_vaca")
SELECT
       NULLIF(rtrim("codi_tipo_vaca"::text), '')::varchar(2) AS "codi_tipo_vaca",
       NULLIF(rtrim("desc_tipo_vaca"::text), '')::varchar(50) AS "desc_tipo_vaca"
FROM "legacy_raw"."tipo_vacaciones"
ON CONFLICT DO NOTHING;

-- TIPOS_LICENCIAS -> rrhh.tipos_licencias  (3 col)
INSERT INTO "rrhh"."tipos_licencias" ("codi_tipo_lice", "desc_lice", "nro_dias_remu")
SELECT
       NULLIF(rtrim("codi_tipo_lice"::text), '')::varchar(3) AS "codi_tipo_lice",
       NULLIF(rtrim("desc_lice"::text), '')::varchar(100) AS "desc_lice",
       NULLIF(btrim("nro_dias_remu"::text), '')::integer AS "nro_dias_remu"
FROM "legacy_raw"."tipos_licencias"
ON CONFLICT DO NOTHING;

-- TIPOS_PLANILLAS -> rrhh.tipos_planillas  (2 col)
INSERT INTO "rrhh"."tipos_planillas" ("codi_tipo_plan", "desc_tipo_plan")
SELECT
       NULLIF(rtrim("codi_tipo_plan"::text), '')::varchar(2) AS "codi_tipo_plan",
       NULLIF(rtrim("desc_tipo_plan"::text), '')::varchar(50) AS "desc_tipo_plan"
FROM "legacy_raw"."tipos_planillas"
ON CONFLICT DO NOTHING;

-- TURNOS -> rrhh.turnos  (4 col)
INSERT INTO "rrhh"."turnos" ("codi_turn", "desc_turn", "hora_ini", "hora_ter")
SELECT
       NULLIF(rtrim("codi_turn"::text), '')::varchar(2) AS "codi_turn",
       NULLIF(rtrim("desc_turn"::text), '')::varchar(50) AS "desc_turn",
       NULLIF(btrim("hora_ini"::text), '')::timestamp(3) AS "hora_ini",
       NULLIF(btrim("hora_ter"::text), '')::timestamp(3) AS "hora_ter"
FROM "legacy_raw"."turnos"
ON CONFLICT DO NOTHING;

-- UTIL_PERS_ANUAL -> rrhh.util_pers_anual  (3 col)
INSERT INTO "rrhh"."util_pers_anual" ("codi_pers", "periodo", "importe")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("periodo"::text), '')::varchar(4) AS "periodo",
       NULLIF(btrim("importe"::text), '')::numeric(18,4) AS "importe"
FROM "legacy_raw"."util_pers_anual"
ON CONFLICT DO NOTHING;

-- VACACIONES -> rrhh.vacaciones  (11 col)
INSERT INTO "rrhh"."vacaciones" ("codi_pers", "fech_inic", "fech_term", "nro_dias", "anio", "mes", "esta_acti", "observaciones", "codi_tipo_vaca", "anio_ini", "anio_fin")
SELECT
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(btrim("fech_inic"::text), '')::timestamp(3) AS "fech_inic",
       NULLIF(btrim("fech_term"::text), '')::timestamp(3) AS "fech_term",
       NULLIF(btrim("nro_dias"::text), '')::smallint AS "nro_dias",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(btrim("esta_acti"::text), '')::boolean AS "esta_acti",
       NULLIF(rtrim("observaciones"::text), '')::varchar(200) AS "observaciones",
       NULLIF(rtrim("codi_tipo_vaca"::text), '')::varchar(2) AS "codi_tipo_vaca",
       NULLIF(rtrim("anio_ini"::text), '')::varchar(4) AS "anio_ini",
       NULLIF(rtrim("anio_fin"::text), '')::varchar(4) AS "anio_fin"
FROM "legacy_raw"."vacaciones"
ON CONFLICT DO NOTHING;

-- VALORES_SISTEMA_PENSIONES -> rrhh.valores_sistema_pensiones  (4 col)
INSERT INTO "rrhh"."valores_sistema_pensiones" ("codi_sist_pens", "codi_rubr", "anio_mes", "valor")
SELECT
       NULLIF(rtrim("codi_sist_pens"::text), '')::varchar(2) AS "codi_sist_pens",
       NULLIF(rtrim("codi_rubr"::text), '')::varchar(3) AS "codi_rubr",
       NULLIF(rtrim("anio_mes"::text), '')::varchar(6) AS "anio_mes",
       NULLIF(btrim("valor"::text), '')::numeric(10,2) AS "valor"
FROM "legacy_raw"."valores_sistema_pensiones"
ON CONFLICT DO NOTHING;

-- VINCULO_FAMILIAR -> rrhh.vinculo_familiar  (3 col)
INSERT INTO "rrhh"."vinculo_familiar" ("codi_vinc_fami", "codi_vinc_fami_sunat", "desc_vinc_fami")
SELECT
       NULLIF(btrim("codi_vinc_fami"::text), '')::smallint AS "codi_vinc_fami",
       NULLIF(btrim("codi_vinc_fami_sunat"::text), '')::smallint AS "codi_vinc_fami_sunat",
       NULLIF(rtrim("desc_vinc_fami"::text), '')::varchar(50) AS "desc_vinc_fami"
FROM "legacy_raw"."vinculo_familiar"
ON CONFLICT DO NOTHING;

-- reajuste de secuencias de identidad del legado
SELECT setval(pg_get_serial_sequence('"rrhh"."desplazan_personal"', 'codi_desplazan_pers'),
              (SELECT COALESCE(MAX("codi_desplazan_pers"), 1) FROM "rrhh"."desplazan_personal"),
              (SELECT COUNT(*) > 0 FROM "rrhh"."desplazan_personal"));
SELECT setval(pg_get_serial_sequence('"rrhh"."desplazo_personal"', 'codi_despla_pers'),
              (SELECT COALESCE(MAX("codi_despla_pers"), 1) FROM "rrhh"."desplazo_personal"),
              (SELECT COUNT(*) > 0 FROM "rrhh"."desplazo_personal"));

COMMIT;

-- =====================================================================
-- ESQUEMA seguridad  (21 tablas)
-- =====================================================================
BEGIN;
SET LOCAL session_replication_role = replica;

-- ACCESO -> seguridad.acceso  (6 col)
INSERT INTO "seguridad"."acceso" ("cod_acceso", "codi_usua", "fecha_acce", "hora", "tipo", "glosa")
SELECT
       NULLIF(btrim("cod_acceso"::text), '')::bigint AS "cod_acceso",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(btrim("fecha_acce"::text), '')::timestamp(3) AS "fecha_acce",
       NULLIF(btrim("hora"::text), '')::timestamp(3) AS "hora",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo",
       NULLIF(rtrim("glosa"::text), '')::varchar(150) AS "glosa"
FROM "legacy_raw"."acceso"
ON CONFLICT DO NOTHING;

-- ACEPTACION_X_USUARIO -> seguridad.aceptacion_x_usuario  (6 col)
INSERT INTO "seguridad"."aceptacion_x_usuario" ("codi_usua", "codi_tipo_acep", "crear", "modificar", "eliminar", "guardar")
SELECT
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(rtrim("codi_tipo_acep"::text), '')::varchar(2) AS "codi_tipo_acep",
       NULLIF(rtrim("crear"::text), '')::varchar(1) AS "crear",
       NULLIF(rtrim("modificar"::text), '')::varchar(1) AS "modificar",
       NULLIF(rtrim("eliminar"::text), '')::varchar(1) AS "eliminar",
       NULLIF(rtrim("guardar"::text), '')::varchar(1) AS "guardar"
FROM "legacy_raw"."aceptacion_x_usuario"
ON CONFLICT DO NOTHING;

-- AUDITORIA -> seguridad.auditoria  (10 col)
INSERT INTO "seguridad"."auditoria" ("anio", "mes", "fecha", "maquina", "aplicacion", "codi_usua", "accion", "objeto", "codigo", "observacion")
SELECT
       NULLIF(btrim("anio"::text), '')::smallint AS "anio",
       NULLIF(btrim("mes"::text), '')::smallint AS "mes",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("maquina"::text), '')::varchar(50) AS "maquina",
       NULLIF(rtrim("aplicacion"::text), '')::varchar(100) AS "aplicacion",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(rtrim("accion"::text), '')::varchar(1) AS "accion",
       NULLIF(rtrim("objeto"::text), '')::varchar(100) AS "objeto",
       NULLIF(rtrim("codigo"::text), '')::varchar(50) AS "codigo",
       NULLIF(rtrim("observacion"::text), '')::varchar(300) AS "observacion"
FROM "legacy_raw"."auditoria"
ON CONFLICT DO NOTHING;

-- CIERRE_MES -> seguridad.cierre_mes  (4 col)
INSERT INTO "seguridad"."cierre_mes" ("codi_cierre", "anio", "mes", "estado")
SELECT
       NULLIF(btrim("codi_cierre"::text), '')::bigint AS "codi_cierre",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado"
FROM "legacy_raw"."cierre_mes"
ON CONFLICT DO NOTHING;

-- CIERRE_MES_USER -> seguridad.cierre_mes_user  (4 col)
INSERT INTO "seguridad"."cierre_mes_user" ("codi_cierre", "codi_usua", "mes", "anio")
SELECT
       NULLIF(btrim("codi_cierre"::text), '')::bigint AS "codi_cierre",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio"
FROM "legacy_raw"."cierre_mes_user"
ON CONFLICT DO NOTHING;

-- Conexion -> seguridad.conexion  (8 col)
INSERT INTO "seguridad"."conexion" ("empresa", "dbms", "servername", "logpass", "logid", "autocommit", "database", "dbparm")
SELECT
       NULLIF(rtrim("empresa"::text), '')::varchar(50) AS "empresa",
       NULLIF(rtrim("_dbms"::text), '')::varchar(50) AS "dbms",
       NULLIF(rtrim("_servername"::text), '')::varchar(50) AS "servername",
       NULLIF(rtrim("_logpass"::text), '')::varchar(50) AS "logpass",
       NULLIF(rtrim("_logid"::text), '')::varchar(50) AS "logid",
       NULLIF(rtrim("_autocommit"::text), '')::varchar(50) AS "autocommit",
       NULLIF(rtrim("_database"::text), '')::varchar(50) AS "database",
       NULLIF(rtrim("_dbparm"::text), '')::varchar(50) AS "dbparm"
FROM "legacy_raw"."conexion"
ON CONFLICT DO NOTHING;

-- ConfigSys -> seguridad.configsys  (2 col)
INSERT INTO "seguridad"."configsys" ("id_conf", "valor")
SELECT
       NULLIF(btrim("id_conf"::text), '')::integer AS "id_conf",
       NULLIF(rtrim("valor"::text), '')::varchar(50) AS "valor"
FROM "legacy_raw"."configsys"
ON CONFLICT DO NOTHING;

-- Consistencias -> seguridad.consistencias  (2 col)
INSERT INTO "seguridad"."consistencias" ("cuenta", "cargo_abono")
SELECT
       NULLIF(rtrim("cuenta"::text), '')::varchar(3) AS "cuenta",
       NULLIF(rtrim("cargo_abono"::text), '')::varchar(1) AS "cargo_abono"
FROM "legacy_raw"."consistencias"
ON CONFLICT DO NOTHING;

-- Empresa -> seguridad.empresa  (42 col)
INSERT INTO "seguridad"."empresa" ("razon_social", "ruc", "representante", "docu_iden_repr", "cargo", "direccion", "telefono", "fax", "direccion_x", "telefono_x", "fax_x", "acti_econ_prin", "nro_regi", "fech_incr", "ubigeo", "obje_soci", "obje_soci_2", "tipo_empr", "ciiu", "cuen_con_inmu", "e_mail", "pagi_web", "departamento", "provincia", "distrito", "urbanizacion", "codi_caja", "inicial", "dnirepre", "nom_bole", "car_bole", "docu_bole", "dat_mostrar", "grupo", "sector", "repr_flota", "dni_repr_flot", "codi_tipo_empr", "iqf_reg_uso", "iqf_reg_ru", "ruta_archivo", "ubl_21")
SELECT
       NULLIF(rtrim("razon_social"::text), '')::varchar(50) AS "razon_social",
       NULLIF(rtrim("ruc"::text), '')::varchar(15) AS "ruc",
       NULLIF(rtrim("representante"::text), '')::varchar(100) AS "representante",
       NULLIF(rtrim("docu_iden_repr"::text), '')::varchar(12) AS "docu_iden_repr",
       NULLIF(rtrim("cargo"::text), '')::varchar(30) AS "cargo",
       NULLIF(rtrim("direccion"::text), '')::varchar(150) AS "direccion",
       NULLIF(rtrim("telefono"::text), '')::varchar(100) AS "telefono",
       NULLIF(rtrim("fax"::text), '')::varchar(50) AS "fax",
       NULLIF(rtrim("direccion_"::text), '')::varchar(150) AS "direccion_x",
       NULLIF(rtrim("telefono_"::text), '')::varchar(50) AS "telefono_x",
       NULLIF(rtrim("fax_"::text), '')::varchar(50) AS "fax_x",
       NULLIF(rtrim("acti_econ_prin"::text), '')::varchar(200) AS "acti_econ_prin",
       NULLIF(rtrim("nro_regi"::text), '')::varchar(20) AS "nro_regi",
       NULLIF(btrim("fech_incr"::text), '')::timestamp(3) AS "fech_incr",
       NULLIF(rtrim("ubigeo"::text), '')::varchar(20) AS "ubigeo",
       NULLIF(rtrim("obje_soci"::text), '')::varchar(255) AS "obje_soci",
       NULLIF(rtrim("obje_soci_2"::text), '')::varchar(255) AS "obje_soci_2",
       NULLIF(rtrim("tipo_empr"::text), '')::varchar(100) AS "tipo_empr",
       NULLIF(rtrim("ciiu"::text), '')::varchar(20) AS "ciiu",
       NULLIF(rtrim("cuen_con_inmu"::text), '')::varchar(300) AS "cuen_con_inmu",
       NULLIF(rtrim("e_mail"::text), '')::varchar(50) AS "e_mail",
       NULLIF(rtrim("pagi_web"::text), '')::varchar(100) AS "pagi_web",
       NULLIF(rtrim("departamento"::text), '')::varchar(50) AS "departamento",
       NULLIF(rtrim("provincia"::text), '')::varchar(50) AS "provincia",
       NULLIF(rtrim("distrito"::text), '')::varchar(50) AS "distrito",
       NULLIF(rtrim("urbanizacion"::text), '')::varchar(50) AS "urbanizacion",
       NULLIF(rtrim("codi_caja"::text), '')::varchar(10) AS "codi_caja",
       NULLIF(rtrim("inicial"::text), '')::varchar(10) AS "inicial",
       NULLIF(rtrim("dnirepre"::text), '')::varchar(8) AS "dnirepre",
       NULLIF(rtrim("nom_bole"::text), '')::varchar(150) AS "nom_bole",
       NULLIF(rtrim("car_bole"::text), '')::varchar(150) AS "car_bole",
       NULLIF(rtrim("docu_bole"::text), '')::varchar(20) AS "docu_bole",
       NULLIF(rtrim("dat_mostrar"::text), '')::varchar(30) AS "dat_mostrar",
       NULLIF(rtrim("grupo"::text), '')::varchar(10) AS "grupo",
       NULLIF(rtrim("sector"::text), '')::varchar(20) AS "sector",
       NULLIF(rtrim("repr_flota"::text), '')::varchar(100) AS "repr_flota",
       NULLIF(rtrim("dni_repr_flot"::text), '')::varchar(20) AS "dni_repr_flot",
       NULLIF(rtrim("codi_tipo_empr"::text), '')::varchar(2) AS "codi_tipo_empr",
       NULLIF(rtrim("iqf_reg_uso"::text), '')::varchar(5) AS "iqf_reg_uso",
       NULLIF(rtrim("iqf_reg_ru"::text), '')::varchar(6) AS "iqf_reg_ru",
       NULLIF(rtrim("ruta_archivo"::text), '')::varchar(255) AS "ruta_archivo",
       NULLIF(rtrim("ubl_21"::text), '')::varchar(1) AS "ubl_21"
FROM "legacy_raw"."empresa"
ON CONFLICT DO NOTHING;

-- EMPRESA_ESTABLEC_TASAS -> seguridad.empresa_establec_tasas  (4 col)
INSERT INTO "seguridad"."empresa_establec_tasas" ("codi_tasa", "codi_empre_estab", "tasa", "estado")
SELECT
       NULLIF(btrim("codi_tasa"::text), '')::integer AS "codi_tasa",
       NULLIF(btrim("codi_empre_estab"::text), '')::integer AS "codi_empre_estab",
       NULLIF(btrim("tasa"::text), '')::bigint AS "tasa",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado"
FROM "legacy_raw"."empresa_establec_tasas"
ON CONFLICT DO NOTHING;

-- EMPRESA_ESTABLECIMIENTO -> seguridad.empresa_establecimiento  (6 col)
INSERT INTO "seguridad"."empresa_establecimiento" ("codi_empre_estab", "codi_empre", "codigo_denomi", "denominacion", "codi_tipo_estab", "centro_riesgo")
SELECT
       NULLIF(btrim("codi_empre_estab"::text), '')::integer AS "codi_empre_estab",
       NULLIF(btrim("codi_empre"::text), '')::integer AS "codi_empre",
       NULLIF(rtrim("codigo_denomi"::text), '')::varchar(4) AS "codigo_denomi",
       NULLIF(rtrim("denominacion"::text), '')::varchar(50) AS "denominacion",
       NULLIF(btrim("codi_tipo_estab"::text), '')::smallint AS "codi_tipo_estab",
       NULLIF(rtrim("centro_riesgo"::text), '')::varchar(1) AS "centro_riesgo"
FROM "legacy_raw"."empresa_establecimiento"
ON CONFLICT DO NOTHING;

-- Firmas -> seguridad.firmas  (5 col)
INSERT INTO "seguridad"."firmas" ("f1", "f2", "f3", "f4", "f5")
SELECT
       NULLIF(rtrim("f1"::text), '')::varchar(30) AS "f1",
       NULLIF(rtrim("f2"::text), '')::varchar(30) AS "f2",
       NULLIF(rtrim("f3"::text), '')::varchar(30) AS "f3",
       NULLIF(rtrim("f4"::text), '')::varchar(30) AS "f4",
       NULLIF(rtrim("f5"::text), '')::varchar(30) AS "f5"
FROM "legacy_raw"."firmas"
ON CONFLICT DO NOTHING;

-- Grupos -> seguridad.grupos  (2 col)
INSERT INTO "seguridad"."grupos" ("codi_grup", "nomb_grup")
SELECT
       NULLIF(btrim("codi_grup"::text), '')::integer AS "codi_grup",
       NULLIF(rtrim("nomb_grup"::text), '')::varchar(15) AS "nomb_grup"
FROM "legacy_raw"."grupos"
ON CONFLICT DO NOTHING;

-- MenuGrupos -> seguridad.menugrupos  (6 col)
INSERT INTO "seguridad"."menugrupos" ("codi_menu", "nomb_menu", "codi_grup", "activo", "nivel", "clase")
SELECT
       NULLIF(btrim("codi_menu"::text), '')::integer AS "codi_menu",
       NULLIF(rtrim("nomb_menu"::text), '')::varchar(150) AS "nomb_menu",
       NULLIF(btrim("codi_grup"::text), '')::integer AS "codi_grup",
       NULLIF(btrim("activo"::text), '')::integer AS "activo",
       NULLIF(btrim("nivel"::text), '')::integer AS "nivel",
       NULLIF(rtrim("clase"::text), '')::varchar(50) AS "clase"
FROM "legacy_raw"."menugrupos"
ON CONFLICT DO NOTHING;

-- NOTAS_POSITS -> seguridad.notas_posits  (5 col)
INSERT INTO "seguridad"."notas_posits" ("idd_nota", "fecha", "descripcion", "codi_alma", "estado")
SELECT
       NULLIF(btrim("idd_nota"::text), '')::bigint AS "idd_nota",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("descripcion"::text), '')::varchar(250) AS "descripcion",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado"
FROM "legacy_raw"."notas_posits"
ON CONFLICT DO NOTHING;

-- Parametro -> seguridad.parametro  (11 col)
INSERT INTO "seguridad"."parametro" ("cod_param", "desc_param", "unid_medi", "nemo", "orden_repo", "limitemin", "limitemax", "optimo", "codi_prod", "tipo", "calculable")
SELECT
       NULLIF(btrim("cod_param"::text), '')::smallint AS "cod_param",
       NULLIF(rtrim("desc_param"::text), '')::varchar(75) AS "desc_param",
       NULLIF(rtrim("unid_medi"::text), '')::varchar(15) AS "unid_medi",
       NULLIF(rtrim("nemo"::text), '')::varchar(15) AS "nemo",
       NULLIF(btrim("orden_repo"::text), '')::smallint AS "orden_repo",
       NULLIF(btrim("limitemin"::text), '')::numeric(18,2) AS "limitemin",
       NULLIF(btrim("limitemax"::text), '')::numeric(18,2) AS "limitemax",
       NULLIF(btrim("optimo"::text), '')::smallint AS "optimo",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("tipo"::text), '')::smallint AS "tipo",
       NULLIF(btrim("calculable"::text), '')::smallint AS "calculable"
FROM "legacy_raw"."parametro"
ON CONFLICT DO NOTHING;

-- Parametros -> seguridad.parametros  (6 col)
INSERT INTO "seguridad"."parametros" ("id_parm", "desc_parm", "valor_parm", "valor1", "valor2", "codi_alma")
SELECT
       NULLIF(btrim("id_parm"::text), '')::integer AS "id_parm",
       NULLIF(rtrim("desc_parm"::text), '')::varchar(50) AS "desc_parm",
       NULLIF(rtrim("valor_parm"::text), '')::varchar(100) AS "valor_parm",
       NULLIF(btrim("valor1"::text), '')::bigint AS "valor1",
       NULLIF(btrim("valor2"::text), '')::bigint AS "valor2",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma"
FROM "legacy_raw"."parametros"
ON CONFLICT DO NOTHING;

-- USUARIOS -> seguridad.usuarios  (16 col)
INSERT INTO "seguridad"."usuarios" ("codi_usua", "apel_1", "apel_2", "nomb_1", "nomb_2", "codi_pers", "login", "clave", "fech_inic_vige", "esta_clav", "codi_carg", "codi_grup", "fech_camb", "recordar", "codi_alma", "multi_acceso")
SELECT
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(rtrim("apel_1"::text), '')::varchar(25) AS "apel_1",
       NULLIF(rtrim("apel_2"::text), '')::varchar(25) AS "apel_2",
       NULLIF(rtrim("nomb_1"::text), '')::varchar(25) AS "nomb_1",
       NULLIF(rtrim("nomb_2"::text), '')::varchar(25) AS "nomb_2",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("login"::text), '')::varchar(50) AS "login",
       NULLIF(rtrim("clave"::text), '')::varchar(50) AS "clave",
       NULLIF(btrim("fech_inic_vige"::text), '')::timestamp(3) AS "fech_inic_vige",
       NULLIF(btrim("esta_clav"::text), '')::boolean AS "esta_clav",
       NULLIF(rtrim("codi_carg"::text), '')::varchar(4) AS "codi_carg",
       NULLIF(btrim("codi_grup"::text), '')::integer AS "codi_grup",
       NULLIF(btrim("fech_camb"::text), '')::timestamp(3) AS "fech_camb",
       NULLIF(btrim("recordar"::text), '')::integer AS "recordar",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("multi_acceso"::text), '')::varchar(1) AS "multi_acceso"
FROM "legacy_raw"."usuarios"
ON CONFLICT DO NOTHING;

-- USUARIOS_GRUPOS -> seguridad.usuarios_grupos  (2 col)
INSERT INTO "seguridad"."usuarios_grupos" ("codi_usua", "codi_grup")
SELECT
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(btrim("codi_grup"::text), '')::integer AS "codi_grup"
FROM "legacy_raw"."usuarios_grupos"
ON CONFLICT DO NOTHING;

-- VISO_EVEN -> seguridad.viso_even  (4 col)
INSERT INTO "seguridad"."viso_even" ("fech_even", "codi_pers", "desc_even", "name_pc")
SELECT
       NULLIF(btrim("fech_even"::text), '')::timestamp(3) AS "fech_even",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("desc_even"::text), '')::varchar(200) AS "desc_even",
       NULLIF(rtrim("name_pc"::text), '')::varchar(30) AS "name_pc"
FROM "legacy_raw"."viso_even"
ON CONFLICT DO NOTHING;

-- VISOR_DE_EVENTOS -> seguridad.visor_de_eventos  (7 col)
INSERT INTO "seguridad"."visor_de_eventos" ("id", "opcion", "usuario", "accion", "informacion", "computer", "fecha")
SELECT
       NULLIF(btrim("id"::text), '')::bigint AS "id",
       NULLIF(rtrim("opcion"::text), '')::varchar(50) AS "opcion",
       NULLIF(rtrim("usuario"::text), '')::varchar(5) AS "usuario",
       NULLIF(rtrim("accion"::text), '')::varchar(1) AS "accion",
       NULLIF(rtrim("informacion"::text), '')::text AS "informacion",
       NULLIF(rtrim("computer"::text), '')::varchar(20) AS "computer",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha"
FROM "legacy_raw"."visor_de_eventos"
ON CONFLICT DO NOTHING;

-- reajuste de secuencias de identidad del legado
SELECT setval(pg_get_serial_sequence('"seguridad"."notas_posits"', 'idd_nota'),
              (SELECT COALESCE(MAX("idd_nota"), 1) FROM "seguridad"."notas_posits"),
              (SELECT COUNT(*) > 0 FROM "seguridad"."notas_posits"));
SELECT setval(pg_get_serial_sequence('"seguridad"."visor_de_eventos"', 'id'),
              (SELECT COALESCE(MAX("id"), 1) FROM "seguridad"."visor_de_eventos"),
              (SELECT COUNT(*) > 0 FROM "seguridad"."visor_de_eventos"));

COMMIT;

-- =====================================================================
-- ESQUEMA staging  (30 tablas)
-- =====================================================================
BEGIN;
SET LOCAL session_replication_role = replica;

-- Artificio_Tablas -> staging.artificio_tablas  (9 col)
INSERT INTO "staging"."artificio_tablas" ("codi_uso", "uso", "descripcion", "nom_dataobject", "condicion_de_uso", "uso_si_o_no", "filtro1_nombre", "filtro1_valor", "filtro1_valor_inter")
SELECT
       NULLIF(btrim("codi_uso"::text), '')::integer AS "codi_uso",
       NULLIF(rtrim("uso"::text), '')::varchar(20) AS "uso",
       NULLIF(rtrim("descripcion"::text), '')::varchar(200) AS "descripcion",
       NULLIF(rtrim("nom_dataobject"::text), '')::varchar(100) AS "nom_dataobject",
       NULLIF(rtrim("condicion_de_uso"::text), '')::varchar(50) AS "condicion_de_uso",
       NULLIF(btrim("uso_si_o_no"::text), '')::boolean AS "uso_si_o_no",
       NULLIF(rtrim("filtro1_nombre"::text), '')::varchar(50) AS "filtro1_nombre",
       NULLIF(rtrim("filtro1_valor"::text), '')::varchar(20) AS "filtro1_valor",
       NULLIF(rtrim("filtro1_valor_inter"::text), '')::varchar(20) AS "filtro1_valor_inter"
FROM "legacy_raw"."artificio_tablas"
ON CONFLICT DO NOTHING;

-- Artificio_Tablas_COPY -> staging.artificio_tablas_copy  (7 col)
INSERT INTO "staging"."artificio_tablas_copy" ("uso", "descripcion", "nom_dataobject", "condicion_de_uso", "uso_si_o_no", "filtro1_nombre", "filtro1_valor")
SELECT
       NULLIF(rtrim("uso"::text), '')::varchar(10) AS "uso",
       NULLIF(rtrim("descripcion"::text), '')::varchar(200) AS "descripcion",
       NULLIF(rtrim("nom_dataobject"::text), '')::varchar(100) AS "nom_dataobject",
       NULLIF(rtrim("condicion_de_uso"::text), '')::varchar(50) AS "condicion_de_uso",
       NULLIF(btrim("uso_si_o_no"::text), '')::boolean AS "uso_si_o_no",
       NULLIF(rtrim("filtro1_nombre"::text), '')::varchar(50) AS "filtro1_nombre",
       NULLIF(rtrim("filtro1_valor"::text), '')::varchar(20) AS "filtro1_valor"
FROM "legacy_raw"."artificio_tablas_copy"
ON CONFLICT DO NOTHING;

-- Artificio_USO_ObjetoPB -> staging.artificio_uso_objetopb  (3 col)
INSERT INTO "staging"."artificio_uso_objetopb" ("codi_uso", "uso", "objeto_pb")
SELECT
       NULLIF(btrim("codi_uso"::text), '')::integer AS "codi_uso",
       NULLIF(rtrim("uso"::text), '')::varchar(20) AS "uso",
       NULLIF(rtrim("objeto_pb"::text), '')::varchar(200) AS "objeto_pb"
FROM "legacy_raw"."artificio_uso_objetopb"
ON CONFLICT DO NOTHING;

-- cliente_proveedor_aux -> staging.cliente_proveedor_aux  (4 col)
INSERT INTO "staging"."cliente_proveedor_aux" ("id", "codigo", "ruc", "nuevo_ruc")
SELECT
       NULLIF(btrim("id"::text), '')::integer AS "id",
       NULLIF(rtrim("codigo"::text), '')::varchar(50) AS "codigo",
       NULLIF(rtrim("ruc"::text), '')::varchar(15) AS "ruc",
       NULLIF(rtrim("nuevo_ruc"::text), '')::varchar(50) AS "nuevo_ruc"
FROM "legacy_raw"."cliente_proveedor_aux"
ON CONFLICT DO NOTHING;

-- CLIENTE_PROVEEDOR_TEMPO -> staging.cliente_proveedor_tempo  (7 col)
INSERT INTO "staging"."cliente_proveedor_tempo" ("ide", "codi_clie_prov", "tipo_pers", "razo_soci", "ruc", "e_mail", "nuevo_ruc")
SELECT
       NULLIF(btrim("ide"::text), '')::integer AS "ide",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("tipo_pers"::text), '')::varchar(12) AS "tipo_pers",
       NULLIF(rtrim("razo_soci"::text), '')::varchar(100) AS "razo_soci",
       NULLIF(rtrim("ruc"::text), '')::varchar(15) AS "ruc",
       NULLIF(rtrim("e_mail"::text), '')::varchar(50) AS "e_mail",
       NULLIF(rtrim("nuevo_ruc"::text), '')::varchar(15) AS "nuevo_ruc"
FROM "legacy_raw"."cliente_proveedor_tempo"
ON CONFLICT DO NOTHING;

-- cp -> staging.cp  (3 col)
INSERT INTO "staging"."cp" ("a", "codi_cp", "razon")
SELECT
       NULLIF(btrim("a"::text), '')::integer AS "a",
       NULLIF(rtrim("codi_cp"::text), '')::varchar(5) AS "codi_cp",
       NULLIF(rtrim("razon"::text), '')::varchar(100) AS "razon"
FROM "legacy_raw"."cp"
ON CONFLICT DO NOTHING;

-- DETALLE_SALIDA_AUX -> staging.detalle_salida_aux  (27 col)
INSERT INTO "staging"."detalle_salida_aux" ("codi_deta_docu_sali", "codi_docu_sali", "nro_cuen", "codi_prod", "cantidad", "prec_costo", "prec_prom", "stoc_sali", "fech_ulti_sali", "cant_ulti_sali", "codi_orde_pedi", "codi_unid_oper", "codi_alma", "codi_alma_desti", "codi_deta_orde_pedi", "prec_kard", "concen_iqf", "prodserviqf", "canti_prodserviqf", "um_prodserviqf", "deseiqf", "canti_deseiqf", "um_deseiqf", "canti_rhpm_iqf", "um_rhpm_iqf", "moti_rhpm_iqf", "observaciones")
SELECT
       NULLIF(rtrim("codi_deta_docu_sali"::text), '')::varchar(12) AS "codi_deta_docu_sali",
       NULLIF(rtrim("codi_docu_sali"::text), '')::varchar(10) AS "codi_docu_sali",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(10,4) AS "cantidad",
       NULLIF(btrim("prec_costo"::text), '')::numeric(18,4) AS "prec_costo",
       NULLIF(btrim("prec_prom"::text), '')::numeric(12,4) AS "prec_prom",
       NULLIF(btrim("stoc_sali"::text), '')::numeric(12,4) AS "stoc_sali",
       NULLIF(btrim("fech_ulti_sali"::text), '')::timestamp(3) AS "fech_ulti_sali",
       NULLIF(btrim("cant_ulti_sali"::text), '')::numeric(12,4) AS "cant_ulti_sali",
       NULLIF(rtrim("codi_orde_pedi"::text), '')::varchar(10) AS "codi_orde_pedi",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_alma_desti"::text), '')::varchar(2) AS "codi_alma_desti",
       NULLIF(rtrim("codi_deta_orde_pedi"::text), '')::varchar(12) AS "codi_deta_orde_pedi",
       NULLIF(btrim("prec_kard"::text), '')::numeric(18,4) AS "prec_kard",
       NULLIF(btrim("concen_iqf"::text), '')::bigint AS "concen_iqf",
       NULLIF(rtrim("prodserviqf"::text), '')::varchar(50) AS "prodserviqf",
       NULLIF(btrim("canti_prodserviqf"::text), '')::bigint AS "canti_prodserviqf",
       NULLIF(rtrim("um_prodserviqf"::text), '')::varchar(2) AS "um_prodserviqf",
       NULLIF(rtrim("deseiqf"::text), '')::varchar(50) AS "deseiqf",
       NULLIF(btrim("canti_deseiqf"::text), '')::bigint AS "canti_deseiqf",
       NULLIF(rtrim("um_deseiqf"::text), '')::varchar(2) AS "um_deseiqf",
       NULLIF(btrim("canti_rhpm_iqf"::text), '')::bigint AS "canti_rhpm_iqf",
       NULLIF(rtrim("um_rhpm_iqf"::text), '')::varchar(2) AS "um_rhpm_iqf",
       NULLIF(rtrim("moti_rhpm_iqf"::text), '')::varchar(50) AS "moti_rhpm_iqf",
       NULLIF(rtrim("observaciones"::text), '')::varchar(50) AS "observaciones"
FROM "legacy_raw"."detalle_salida_aux"
ON CONFLICT DO NOTHING;

-- eliminar_corre -> staging.eliminar_corre  (5 col)
INSERT INTO "staging"."eliminar_corre" ("correlativo", "fecha", "codi_tipo_docu", "serie", "nro_docu")
SELECT
       NULLIF(btrim("correlativo"::text), '')::integer AS "correlativo",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("serie"::text), '')::varchar(4) AS "serie",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(10) AS "nro_docu"
FROM "legacy_raw"."eliminar_corre"
ON CONFLICT DO NOTHING;

-- Kadm -> staging.kadm  (10 col)
INSERT INTO "staging"."kadm" ("codigo", "desc_prod", "afecto", "sub_fami", "familia", "linea", "saldo", "laboratorio", "almacen", "stock_inv")
SELECT
       NULLIF(rtrim("codigo"::text), '')::varchar(8) AS "codigo",
       NULLIF(rtrim("desc_prod"::text), '')::varchar(160) AS "desc_prod",
       NULLIF(rtrim("afecto"::text), '')::varchar(1) AS "afecto",
       NULLIF(rtrim("sub_fami"::text), '')::varchar(100) AS "sub_fami",
       NULLIF(rtrim("familia"::text), '')::varchar(100) AS "familia",
       NULLIF(rtrim("linea"::text), '')::varchar(100) AS "linea",
       NULLIF(btrim("saldo"::text), '')::numeric(12,2) AS "saldo",
       NULLIF(rtrim("laboratorio"::text), '')::varchar(100) AS "laboratorio",
       NULLIF(rtrim("almacen"::text), '')::varchar(20) AS "almacen",
       NULLIF(btrim("stock_inv"::text), '')::numeric(12,2) AS "stock_inv"
FROM "legacy_raw"."kadm"
ON CONFLICT DO NOTHING;

-- Kadm2015 -> staging.kadm2015  (9 col)
INSERT INTO "staging"."kadm2015" ("codigo", "desc_prod", "afecto", "sub_fami", "familia", "linea", "saldo", "laboratorio", "almacen")
SELECT
       NULLIF(rtrim("codigo"::text), '')::varchar(8) AS "codigo",
       NULLIF(rtrim("desc_prod"::text), '')::varchar(160) AS "desc_prod",
       NULLIF(rtrim("afecto"::text), '')::varchar(1) AS "afecto",
       NULLIF(rtrim("sub_fami"::text), '')::varchar(100) AS "sub_fami",
       NULLIF(rtrim("familia"::text), '')::varchar(100) AS "familia",
       NULLIF(rtrim("linea"::text), '')::varchar(100) AS "linea",
       NULLIF(btrim("saldo"::text), '')::numeric(12,2) AS "saldo",
       NULLIF(rtrim("laboratorio"::text), '')::varchar(100) AS "laboratorio",
       NULLIF(rtrim("almacen"::text), '')::varchar(20) AS "almacen"
FROM "legacy_raw"."kadm2015"
ON CONFLICT DO NOTHING;

-- LE201707 -> staging.le201707  (36 col)
INSERT INTO "staging"."le201707" ("columna_0", "columna_1", "columna_2", "columna_3", "columna_4", "columna_5", "columna_6", "columna_7", "columna_8", "columna_9", "columna_10", "columna_11", "columna_12", "columna_13", "columna_14", "columna_15", "columna_16", "columna_17", "columna_18", "columna_19", "columna_20", "columna_21", "columna_22", "columna_23", "columna_24", "columna_25", "columna_26", "columna_27", "columna_28", "columna_29", "columna_30", "columna_31", "columna_32", "columna_33", "columna_34", "columna_35")
SELECT
       NULLIF(rtrim("columna 0"::text), '')::varchar(50) AS "columna_0",
       NULLIF(rtrim("columna 1"::text), '')::varchar(50) AS "columna_1",
       NULLIF(rtrim("columna 2"::text), '')::varchar(50) AS "columna_2",
       NULLIF(rtrim("columna 3"::text), '')::varchar(50) AS "columna_3",
       NULLIF(rtrim("columna 4"::text), '')::varchar(50) AS "columna_4",
       NULLIF(rtrim("columna 5"::text), '')::varchar(50) AS "columna_5",
       NULLIF(rtrim("columna 6"::text), '')::varchar(50) AS "columna_6",
       NULLIF(rtrim("columna 7"::text), '')::varchar(50) AS "columna_7",
       NULLIF(rtrim("columna 8"::text), '')::varchar(50) AS "columna_8",
       NULLIF(rtrim("columna 9"::text), '')::varchar(50) AS "columna_9",
       NULLIF(rtrim("columna 10"::text), '')::varchar(50) AS "columna_10",
       NULLIF(rtrim("columna 11"::text), '')::varchar(100) AS "columna_11",
       NULLIF(rtrim("columna 12"::text), '')::varchar(50) AS "columna_12",
       NULLIF(rtrim("columna 13"::text), '')::varchar(50) AS "columna_13",
       NULLIF(rtrim("columna 14"::text), '')::varchar(50) AS "columna_14",
       NULLIF(rtrim("columna 15"::text), '')::varchar(50) AS "columna_15",
       NULLIF(rtrim("columna 16"::text), '')::varchar(50) AS "columna_16",
       NULLIF(rtrim("columna 17"::text), '')::varchar(50) AS "columna_17",
       NULLIF(rtrim("columna 18"::text), '')::varchar(50) AS "columna_18",
       NULLIF(rtrim("columna 19"::text), '')::varchar(50) AS "columna_19",
       NULLIF(rtrim("columna 20"::text), '')::varchar(50) AS "columna_20",
       NULLIF(rtrim("columna 21"::text), '')::varchar(50) AS "columna_21",
       NULLIF(rtrim("columna 22"::text), '')::varchar(50) AS "columna_22",
       NULLIF(rtrim("columna 23"::text), '')::varchar(50) AS "columna_23",
       NULLIF(rtrim("columna 24"::text), '')::varchar(50) AS "columna_24",
       NULLIF(rtrim("columna 25"::text), '')::varchar(50) AS "columna_25",
       NULLIF(rtrim("columna 26"::text), '')::varchar(50) AS "columna_26",
       NULLIF(rtrim("columna 27"::text), '')::varchar(50) AS "columna_27",
       NULLIF(rtrim("columna 28"::text), '')::varchar(50) AS "columna_28",
       NULLIF(rtrim("columna 29"::text), '')::varchar(50) AS "columna_29",
       NULLIF(rtrim("columna 30"::text), '')::varchar(50) AS "columna_30",
       NULLIF(rtrim("columna 31"::text), '')::varchar(50) AS "columna_31",
       NULLIF(rtrim("columna 32"::text), '')::varchar(50) AS "columna_32",
       NULLIF(rtrim("columna 33"::text), '')::varchar(50) AS "columna_33",
       NULLIF(rtrim("columna 34"::text), '')::varchar(50) AS "columna_34",
       NULLIF(rtrim("columna 35"::text), '')::varchar(50) AS "columna_35"
FROM "legacy_raw"."le201707"
ON CONFLICT DO NOTHING;

-- Movi_Contables_AX -> staging.movi_contables_ax  (78 col)
INSERT INTO "staging"."movi_contables_ax" ("idd", "codi_contable", "anio", "mes", "subdia", "compr", "codi_mone", "fecha", "nro_cuen", "nro_sub_cuen", "codi_clie_prov", "serie", "nro_docu", "codi_tipo_docu", "importe", "igv", "otros", "total", "importe_d", "igv_d", "otros_d", "total_d", "registro", "codi_unid_oper", "glosa", "cargo_abono", "fecha_venc", "tipo_cambio", "situ_cheq", "tipo_cambio_2", "codi_vouc", "fecha_spot", "num_spot", "codi_pers", "codi_sema", "codi_nota_ingr", "nro_orde_comp", "nro_orde_pedi", "codi_pres", "nro_presu", "banco", "cartera", "hecho_por", "itf", "compensa", "detraccion", "fech_pago", "ref", "nro_fact", "codi_memo", "tipo_movi", "codi_desti", "codi_tasa_detr", "retencion", "codi_ingr", "codi_alma", "codi_tipo_intan", "codi_aduana", "anio_dua_dsi", "nro_detrac", "fecha_detrac", "fecha_nd_nc", "tipo_docu_nd_nc", "serie_nd_nc", "nro_docu_nd_nc", "tipo_venta", "codi_libro_regi", "codi_tipo_medio_pago", "banco_aux", "fecha_creacion", "estado_inic", "creacion", "id_flujo", "id_tipo_flujo", "codi_oper", "codi_bien_serv", "pdetr", "valor_refe")
SELECT
       NULLIF(btrim("idd"::text), '')::integer AS "idd",
       NULLIF(rtrim("codi_contable"::text), '')::varchar(10) AS "codi_contable",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("subdia"::text), '')::varchar(1) AS "subdia",
       NULLIF(rtrim("compr"::text), '')::varchar(10) AS "compr",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(rtrim("nro_sub_cuen"::text), '')::varchar(7) AS "nro_sub_cuen",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("serie"::text), '')::varchar(5) AS "serie",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(20) AS "nro_docu",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(btrim("importe"::text), '')::numeric(18,2) AS "importe",
       NULLIF(btrim("igv"::text), '')::numeric(18,2) AS "igv",
       NULLIF(btrim("otros"::text), '')::numeric(18,2) AS "otros",
       NULLIF(btrim("total"::text), '')::numeric(18,2) AS "total",
       NULLIF(btrim("importe_d"::text), '')::numeric(18,2) AS "importe_d",
       NULLIF(btrim("igv_d"::text), '')::numeric(18,2) AS "igv_d",
       NULLIF(btrim("otros_d"::text), '')::numeric(18,2) AS "otros_d",
       NULLIF(btrim("total_d"::text), '')::numeric(18,2) AS "total_d",
       NULLIF(rtrim("registro"::text), '')::varchar(10) AS "registro",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("glosa"::text), '')::varchar(200) AS "glosa",
       NULLIF(rtrim("cargo_abono"::text), '')::varchar(1) AS "cargo_abono",
       NULLIF(btrim("fecha_venc"::text), '')::timestamp(3) AS "fecha_venc",
       NULLIF(btrim("tipo_cambio"::text), '')::numeric(18,4) AS "tipo_cambio",
       NULLIF(rtrim("situ_cheq"::text), '')::varchar(2) AS "situ_cheq",
       NULLIF(btrim("tipo_cambio_2"::text), '')::numeric(18,4) AS "tipo_cambio_2",
       NULLIF(rtrim("codi_vouc"::text), '')::varchar(10) AS "codi_vouc",
       NULLIF(btrim("fecha_spot"::text), '')::timestamp(3) AS "fecha_spot",
       NULLIF(rtrim("num_spot"::text), '')::varchar(10) AS "num_spot",
       NULLIF(rtrim("codi_pers"::text), '')::varchar(5) AS "codi_pers",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(rtrim("codi_nota_ingr"::text), '')::varchar(10) AS "codi_nota_ingr",
       NULLIF(rtrim("nro_orde_comp"::text), '')::varchar(10) AS "nro_orde_comp",
       NULLIF(rtrim("nro_orde_pedi"::text), '')::varchar(10) AS "nro_orde_pedi",
       NULLIF(rtrim("codi_pres"::text), '')::varchar(4) AS "codi_pres",
       NULLIF(rtrim("nro_presu"::text), '')::varchar(5) AS "nro_presu",
       NULLIF(rtrim("banco"::text), '')::varchar(7) AS "banco",
       NULLIF(btrim("cartera"::text), '')::boolean AS "cartera",
       NULLIF(rtrim("hecho_por"::text), '')::varchar(5) AS "hecho_por",
       NULLIF(rtrim("itf"::text), '')::varchar(1) AS "itf",
       NULLIF(btrim("compensa"::text), '')::boolean AS "compensa",
       NULLIF(btrim("detraccion"::text), '')::boolean AS "detraccion",
       NULLIF(btrim("fech_pago"::text), '')::timestamp(3) AS "fech_pago",
       NULLIF(rtrim("ref"::text), '')::varchar(5) AS "ref",
       NULLIF(rtrim("nro_fact"::text), '')::varchar(20) AS "nro_fact",
       NULLIF(btrim("codi_memo"::text), '')::bigint AS "codi_memo",
       NULLIF(rtrim("tipo_movi"::text), '')::varchar(2) AS "tipo_movi",
       NULLIF(rtrim("codi_desti"::text), '')::varchar(1) AS "codi_desti",
       NULLIF(rtrim("codi_tasa_detr"::text), '')::varchar(5) AS "codi_tasa_detr",
       NULLIF(btrim("retencion"::text), '')::boolean AS "retencion",
       NULLIF(btrim("codi_ingr"::text), '')::bigint AS "codi_ingr",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_tipo_intan"::text), '')::varchar(2) AS "codi_tipo_intan",
       NULLIF(btrim("codi_aduana"::text), '')::smallint AS "codi_aduana",
       NULLIF(btrim("anio_dua_dsi"::text), '')::smallint AS "anio_dua_dsi",
       NULLIF(rtrim("nro_detrac"::text), '')::varchar(10) AS "nro_detrac",
       NULLIF(btrim("fecha_detrac"::text), '')::timestamp(0) AS "fecha_detrac",
       NULLIF(btrim("fecha_nd_nc"::text), '')::timestamp(0) AS "fecha_nd_nc",
       NULLIF(rtrim("tipo_docu_nd_nc"::text), '')::varchar(4) AS "tipo_docu_nd_nc",
       NULLIF(rtrim("serie_nd_nc"::text), '')::varchar(5) AS "serie_nd_nc",
       NULLIF(rtrim("nro_docu_nd_nc"::text), '')::varchar(10) AS "nro_docu_nd_nc",
       NULLIF(rtrim("tipo_venta"::text), '')::varchar(1) AS "tipo_venta",
       NULLIF(btrim("codi_libro_regi"::text), '')::smallint AS "codi_libro_regi",
       NULLIF(btrim("codi_tipo_medio_pago"::text), '')::smallint AS "codi_tipo_medio_pago",
       NULLIF(rtrim("banco_aux"::text), '')::varchar(2) AS "banco_aux",
       NULLIF(btrim("fecha_creacion"::text), '')::timestamp(3) AS "fecha_creacion",
       NULLIF(btrim("estado_inic"::text), '')::integer AS "estado_inic",
       NULLIF(btrim("creacion"::text), '')::timestamp(3) AS "creacion",
       NULLIF(btrim("id_flujo"::text), '')::integer AS "id_flujo",
       NULLIF(btrim("id_tipo_flujo"::text), '')::integer AS "id_tipo_flujo",
       NULLIF(rtrim("codi_oper"::text), '')::varchar(2) AS "codi_oper",
       NULLIF(rtrim("codi_bien_serv"::text), '')::varchar(5) AS "codi_bien_serv",
       NULLIF(btrim("pdetr"::text), '')::numeric(18,3) AS "pdetr",
       NULLIF(btrim("valor_refe"::text), '')::numeric(18,2) AS "valor_refe"
FROM "legacy_raw"."movi_contables_ax"
ON CONFLICT DO NOTHING;

-- ORDEN_PRODUC_DETA_MATERIAL_copy -> staging.orden_produc_deta_material_copy  (2 col)
INSERT INTO "staging"."orden_produc_deta_material_copy" ("codi_orde_produc", "codi_prod")
SELECT
       NULLIF(btrim("codi_orde_produc"::text), '')::integer AS "codi_orde_produc",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod"
FROM "legacy_raw"."orden_produc_deta_material_copy"
ON CONFLICT DO NOTHING;

-- Paper -> staging.paper  (2 col)
INSERT INTO "staging"."paper" ("codi", "descrip")
SELECT
       NULLIF(rtrim("codi"::text), '')::varchar(2) AS "codi",
       NULLIF(rtrim("descrip"::text), '')::varchar(70) AS "descrip"
FROM "legacy_raw"."paper"
ON CONFLICT DO NOTHING;

-- pbcatcol -> staging.pbcatcol  (20 col)
INSERT INTO "staging"."pbcatcol" ("pbc_tnam", "pbc_tid", "pbc_ownr", "pbc_cnam", "pbc_cid", "pbc_labl", "pbc_lpos", "pbc_hdr", "pbc_hpos", "pbc_jtfy", "pbc_mask", "pbc_case", "pbc_hght", "pbc_wdth", "pbc_ptrn", "pbc_bmap", "pbc_init", "pbc_cmnt", "pbc_edit", "pbc_tag")
SELECT
       NULLIF(rtrim("pbc_tnam"::text), '')::varchar(30) AS "pbc_tnam",
       NULLIF(btrim("pbc_tid"::text), '')::integer AS "pbc_tid",
       NULLIF(rtrim("pbc_ownr"::text), '')::varchar(30) AS "pbc_ownr",
       NULLIF(rtrim("pbc_cnam"::text), '')::varchar(30) AS "pbc_cnam",
       NULLIF(btrim("pbc_cid"::text), '')::smallint AS "pbc_cid",
       NULLIF(rtrim("pbc_labl"::text), '')::varchar(254) AS "pbc_labl",
       NULLIF(btrim("pbc_lpos"::text), '')::smallint AS "pbc_lpos",
       NULLIF(rtrim("pbc_hdr"::text), '')::varchar(254) AS "pbc_hdr",
       NULLIF(btrim("pbc_hpos"::text), '')::smallint AS "pbc_hpos",
       NULLIF(btrim("pbc_jtfy"::text), '')::smallint AS "pbc_jtfy",
       NULLIF(rtrim("pbc_mask"::text), '')::varchar(31) AS "pbc_mask",
       NULLIF(btrim("pbc_case"::text), '')::smallint AS "pbc_case",
       NULLIF(btrim("pbc_hght"::text), '')::smallint AS "pbc_hght",
       NULLIF(btrim("pbc_wdth"::text), '')::smallint AS "pbc_wdth",
       NULLIF(rtrim("pbc_ptrn"::text), '')::varchar(31) AS "pbc_ptrn",
       NULLIF(rtrim("pbc_bmap"::text), '')::varchar(1) AS "pbc_bmap",
       NULLIF(rtrim("pbc_init"::text), '')::varchar(254) AS "pbc_init",
       NULLIF(rtrim("pbc_cmnt"::text), '')::varchar(254) AS "pbc_cmnt",
       NULLIF(rtrim("pbc_edit"::text), '')::varchar(31) AS "pbc_edit",
       NULLIF(rtrim("pbc_tag"::text), '')::varchar(254) AS "pbc_tag"
FROM "legacy_raw"."pbcatcol"
ON CONFLICT DO NOTHING;

-- pbcatedt -> staging.pbcatedt  (7 col)
INSERT INTO "staging"."pbcatedt" ("pbe_name", "pbe_edit", "pbe_type", "pbe_cntr", "pbe_seqn", "pbe_flag", "pbe_work")
SELECT
       NULLIF(rtrim("pbe_name"::text), '')::varchar(30) AS "pbe_name",
       NULLIF(rtrim("pbe_edit"::text), '')::varchar(254) AS "pbe_edit",
       NULLIF(btrim("pbe_type"::text), '')::smallint AS "pbe_type",
       NULLIF(btrim("pbe_cntr"::text), '')::integer AS "pbe_cntr",
       NULLIF(btrim("pbe_seqn"::text), '')::smallint AS "pbe_seqn",
       NULLIF(btrim("pbe_flag"::text), '')::integer AS "pbe_flag",
       NULLIF(rtrim("pbe_work"::text), '')::varchar(32) AS "pbe_work"
FROM "legacy_raw"."pbcatedt"
ON CONFLICT DO NOTHING;

-- pbcatfmt -> staging.pbcatfmt  (4 col)
INSERT INTO "staging"."pbcatfmt" ("pbf_name", "pbf_frmt", "pbf_type", "pbf_cntr")
SELECT
       NULLIF(rtrim("pbf_name"::text), '')::varchar(30) AS "pbf_name",
       NULLIF(rtrim("pbf_frmt"::text), '')::varchar(254) AS "pbf_frmt",
       NULLIF(btrim("pbf_type"::text), '')::smallint AS "pbf_type",
       NULLIF(btrim("pbf_cntr"::text), '')::integer AS "pbf_cntr"
FROM "legacy_raw"."pbcatfmt"
ON CONFLICT DO NOTHING;

-- pbcattbl -> staging.pbcattbl  (25 col)
INSERT INTO "staging"."pbcattbl" ("pbt_tnam", "pbt_tid", "pbt_ownr", "pbd_fhgt", "pbd_fwgt", "pbd_fitl", "pbd_funl", "pbd_fchr", "pbd_fptc", "pbd_ffce", "pbh_fhgt", "pbh_fwgt", "pbh_fitl", "pbh_funl", "pbh_fchr", "pbh_fptc", "pbh_ffce", "pbl_fhgt", "pbl_fwgt", "pbl_fitl", "pbl_funl", "pbl_fchr", "pbl_fptc", "pbl_ffce", "pbt_cmnt")
SELECT
       NULLIF(rtrim("pbt_tnam"::text), '')::varchar(30) AS "pbt_tnam",
       NULLIF(btrim("pbt_tid"::text), '')::integer AS "pbt_tid",
       NULLIF(rtrim("pbt_ownr"::text), '')::varchar(30) AS "pbt_ownr",
       NULLIF(btrim("pbd_fhgt"::text), '')::smallint AS "pbd_fhgt",
       NULLIF(btrim("pbd_fwgt"::text), '')::smallint AS "pbd_fwgt",
       NULLIF(rtrim("pbd_fitl"::text), '')::varchar(1) AS "pbd_fitl",
       NULLIF(rtrim("pbd_funl"::text), '')::varchar(1) AS "pbd_funl",
       NULLIF(btrim("pbd_fchr"::text), '')::smallint AS "pbd_fchr",
       NULLIF(btrim("pbd_fptc"::text), '')::smallint AS "pbd_fptc",
       NULLIF(rtrim("pbd_ffce"::text), '')::varchar(32) AS "pbd_ffce",
       NULLIF(btrim("pbh_fhgt"::text), '')::smallint AS "pbh_fhgt",
       NULLIF(btrim("pbh_fwgt"::text), '')::smallint AS "pbh_fwgt",
       NULLIF(rtrim("pbh_fitl"::text), '')::varchar(1) AS "pbh_fitl",
       NULLIF(rtrim("pbh_funl"::text), '')::varchar(1) AS "pbh_funl",
       NULLIF(btrim("pbh_fchr"::text), '')::smallint AS "pbh_fchr",
       NULLIF(btrim("pbh_fptc"::text), '')::smallint AS "pbh_fptc",
       NULLIF(rtrim("pbh_ffce"::text), '')::varchar(32) AS "pbh_ffce",
       NULLIF(btrim("pbl_fhgt"::text), '')::smallint AS "pbl_fhgt",
       NULLIF(btrim("pbl_fwgt"::text), '')::smallint AS "pbl_fwgt",
       NULLIF(rtrim("pbl_fitl"::text), '')::varchar(1) AS "pbl_fitl",
       NULLIF(rtrim("pbl_funl"::text), '')::varchar(1) AS "pbl_funl",
       NULLIF(btrim("pbl_fchr"::text), '')::smallint AS "pbl_fchr",
       NULLIF(btrim("pbl_fptc"::text), '')::smallint AS "pbl_fptc",
       NULLIF(rtrim("pbl_ffce"::text), '')::varchar(32) AS "pbl_ffce",
       NULLIF(rtrim("pbt_cmnt"::text), '')::varchar(254) AS "pbt_cmnt"
FROM "legacy_raw"."pbcattbl"
ON CONFLICT DO NOTHING;

-- pbcatvld -> staging.pbcatvld  (5 col)
INSERT INTO "staging"."pbcatvld" ("pbv_name", "pbv_vald", "pbv_type", "pbv_cntr", "pbv_msg")
SELECT
       NULLIF(rtrim("pbv_name"::text), '')::varchar(30) AS "pbv_name",
       NULLIF(rtrim("pbv_vald"::text), '')::varchar(254) AS "pbv_vald",
       NULLIF(btrim("pbv_type"::text), '')::smallint AS "pbv_type",
       NULLIF(btrim("pbv_cntr"::text), '')::integer AS "pbv_cntr",
       NULLIF(rtrim("pbv_msg"::text), '')::varchar(254) AS "pbv_msg"
FROM "legacy_raw"."pbcatvld"
ON CONFLICT DO NOTHING;

-- PRODUCTOS_MATRIZ_X -> staging.productos_matriz_x  (4 col)
INSERT INTO "staging"."productos_matriz_x" ("id_mat", "codi_prod", "codi_rota", "fecha")
SELECT
       NULLIF(btrim("id_mat"::text), '')::bigint AS "id_mat",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("codi_rota"::text), '')::bigint AS "codi_rota",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha"
FROM "legacy_raw"."productos_matriz_x"
ON CONFLICT DO NOTHING;

-- PRODUCTOS_XX -> staging.productos_xx  (34 col)
INSERT INTO "staging"."productos_xx" ("codi_prod", "desc_prod", "codi_sub_fami_prod", "codi_unid_medi", "codi_mone", "prec_prom", "stock", "stoc_mini", "stoc_maxi", "punt_repe", "fech_venc", "esta_prod", "stoc_temp", "ubicacion", "nro_cuen", "iqf", "porc_detr", "poli_prec", "exonerado", "prec_list_1", "prec_list_2", "cost_prod", "analisis", "material", "codi_clie_prov", "cod_pres", "fec_registro", "prec_prov", "descto_compra", "descto_porcenta", "cod_impuesto", "tcambio", "nro_decim_precio", "costo_oper")
SELECT
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("desc_prod"::text), '')::varchar(150) AS "desc_prod",
       NULLIF(rtrim("codi_sub_fami_prod"::text), '')::varchar(4) AS "codi_sub_fami_prod",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("prec_prom"::text), '')::numeric(14,2) AS "prec_prom",
       NULLIF(btrim("stock"::text), '')::numeric(9,2) AS "stock",
       NULLIF(btrim("stoc_mini"::text), '')::numeric(9,2) AS "stoc_mini",
       NULLIF(btrim("stoc_maxi"::text), '')::numeric(9,2) AS "stoc_maxi",
       NULLIF(btrim("punt_repe"::text), '')::numeric(9,2) AS "punt_repe",
       NULLIF(btrim("fech_venc"::text), '')::timestamp(3) AS "fech_venc",
       NULLIF(rtrim("esta_prod"::text), '')::varchar(25) AS "esta_prod",
       NULLIF(btrim("stoc_temp"::text), '')::numeric(9,2) AS "stoc_temp",
       NULLIF(rtrim("ubicacion"::text), '')::varchar(50) AS "ubicacion",
       NULLIF(rtrim("nro_cuen"::text), '')::varchar(7) AS "nro_cuen",
       NULLIF(btrim("iqf"::text), '')::boolean AS "iqf",
       NULLIF(btrim("porc_detr"::text), '')::numeric(15,4) AS "porc_detr",
       NULLIF(btrim("poli_prec"::text), '')::numeric(18,4) AS "poli_prec",
       NULLIF(rtrim("exonerado"::text), '')::varchar(1) AS "exonerado",
       NULLIF(btrim("prec_list_1"::text), '')::numeric(15,4) AS "prec_list_1",
       NULLIF(btrim("prec_list_2"::text), '')::numeric(15,4) AS "prec_list_2",
       NULLIF(btrim("cost_prod"::text), '')::numeric(15,4) AS "cost_prod",
       NULLIF(btrim("analisis"::text), '')::smallint AS "analisis",
       NULLIF(btrim("material"::text), '')::smallint AS "material",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("cod_pres"::text), '')::integer AS "cod_pres",
       NULLIF(btrim("fec_registro"::text), '')::timestamp(3) AS "fec_registro",
       NULLIF(btrim("prec_prov"::text), '')::numeric(19,4) AS "prec_prov",
       NULLIF(btrim("descto_compra"::text), '')::numeric(19,4) AS "descto_compra",
       NULLIF(btrim("descto_porcenta"::text), '')::numeric(19,4) AS "descto_porcenta",
       NULLIF(btrim("cod_impuesto"::text), '')::integer AS "cod_impuesto",
       NULLIF(btrim("tcambio"::text), '')::numeric(9,3) AS "tcambio",
       NULLIF(btrim("nro_decim_precio"::text), '')::integer AS "nro_decim_precio",
       NULLIF(btrim("costo_oper"::text), '')::numeric(18,2) AS "costo_oper"
FROM "legacy_raw"."productos_xx"
ON CONFLICT DO NOTHING;

-- PX -> staging.px  (3 col)
INSERT INTO "staging"."px" ("codi_alma", "codi_prod", "modi")
SELECT
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("modi"::text), '')::integer AS "modi"
FROM "legacy_raw"."px"
ON CONFLICT DO NOTHING;

-- Registro_Axu -> staging.registro_axu  (2 col)
INSERT INTO "staging"."registro_axu" ("registro", "importe")
SELECT
       NULLIF(rtrim("registro"::text), '')::varchar(10) AS "registro",
       NULLIF(btrim("importe"::text), '')::numeric(18,2) AS "importe"
FROM "legacy_raw"."registro_axu"
ON CONFLICT DO NOTHING;

-- Sheet -> staging.sheet  (7 col)
INSERT INTO "staging"."sheet" ("producto", "mo", "presentac", "stock", "x_espec", "a_e", "codi_prod")
SELECT
       NULLIF(rtrim("producto"::text), '')::varchar(255) AS "producto",
       NULLIF(rtrim("mo"::text), '')::varchar(255) AS "mo",
       NULLIF(rtrim("presentac#"::text), '')::varchar(255) AS "presentac",
       NULLIF(btrim("stock"::text), '')::double precision AS "stock",
       NULLIF(btrim("x espec#"::text), '')::double precision AS "x_espec",
       NULLIF(rtrim("a/e"::text), '')::varchar(255) AS "a_e",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod"
FROM "legacy_raw"."sheet"
ON CONFLICT DO NOTHING;

-- tempo -> staging.tempo  (6 col)
INSERT INTO "staging"."tempo" ("nro_fila", "anio", "mes", "subdia", "compr", "compr_num")
SELECT
       NULLIF(btrim("nro_fila"::text), '')::integer AS "nro_fila",
       NULLIF(rtrim("anio"::text), '')::varchar(4) AS "anio",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("subdia"::text), '')::varchar(1) AS "subdia",
       NULLIF(rtrim("compr"::text), '')::varchar(10) AS "compr",
       NULLIF(btrim("compr_num"::text), '')::integer AS "compr_num"
FROM "legacy_raw"."tempo"
ON CONFLICT DO NOTHING;

-- Tx -> staging.tx  (4 col)
INSERT INTO "staging"."tx" ("idd", "codi_alma", "codi_prod", "modi")
SELECT
       NULLIF(btrim("idd"::text), '')::integer AS "idd",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("modi"::text), '')::integer AS "modi"
FROM "legacy_raw"."tx"
ON CONFLICT DO NOTHING;

-- Tx2 -> staging.tx2  (5 col)
INSERT INTO "staging"."tx2" ("idd", "codi_alma", "codi_prod", "modi", "origi")
SELECT
       NULLIF(btrim("idd"::text), '')::integer AS "idd",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("modi"::text), '')::integer AS "modi",
       NULLIF(btrim("origi"::text), '')::numeric(12,4) AS "origi"
FROM "legacy_raw"."tx2"
ON CONFLICT DO NOTHING;

-- Tx3 -> staging.tx3  (5 col)
INSERT INTO "staging"."tx3" ("idd", "codi_alma", "codi_prod", "modi", "origi")
SELECT
       NULLIF(btrim("idd"::text), '')::integer AS "idd",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("modi"::text), '')::integer AS "modi",
       NULLIF(btrim("origi"::text), '')::integer AS "origi"
FROM "legacy_raw"."tx3"
ON CONFLICT DO NOTHING;

-- TXProd -> staging.txprod  (1 col)
INSERT INTO "staging"."txprod" ("codigo")
SELECT
       NULLIF(btrim("codigo"::text), '')::integer AS "codigo"
FROM "legacy_raw"."txprod"
ON CONFLICT DO NOTHING;

-- V2017 -> staging.v2017  (20 col)
INSERT INTO "staging"."v2017" ("sucursal", "linea", "subfamilia", "familia", "proveedor", "producto", "pres", "cliente", "fecha", "pago", "documento", "serie", "numero", "cantidad", "precio_venta", "precio_lista", "dif", "codi_prod", "codi_clie_prov", "codi_tipo_docu")
SELECT
       NULLIF(rtrim("sucursal"::text), '')::varchar(100) AS "sucursal",
       NULLIF(rtrim("linea"::text), '')::varchar(50) AS "linea",
       NULLIF(rtrim("subfamilia"::text), '')::varchar(150) AS "subfamilia",
       NULLIF(rtrim("familia"::text), '')::varchar(150) AS "familia",
       NULLIF(rtrim("proveedor"::text), '')::varchar(150) AS "proveedor",
       NULLIF(rtrim("producto"::text), '')::varchar(200) AS "producto",
       NULLIF(rtrim("pres"::text), '')::varchar(100) AS "pres",
       NULLIF(rtrim("cliente"::text), '')::varchar(200) AS "cliente",
       NULLIF(rtrim("fecha"::text), '')::varchar(50) AS "fecha",
       NULLIF(rtrim("pago"::text), '')::varchar(50) AS "pago",
       NULLIF(rtrim("documento"::text), '')::varchar(50) AS "documento",
       NULLIF(rtrim("serie"::text), '')::varchar(50) AS "serie",
       NULLIF(rtrim("numero"::text), '')::varchar(50) AS "numero",
       NULLIF(rtrim("cantidad"::text), '')::varchar(50) AS "cantidad",
       NULLIF(rtrim("precio_venta"::text), '')::varchar(50) AS "precio_venta",
       NULLIF(rtrim("precio_lista"::text), '')::varchar(50) AS "precio_lista",
       NULLIF(rtrim("dif"::text), '')::varchar(50) AS "dif",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu"
FROM "legacy_raw"."v2017"
ON CONFLICT DO NOTHING;

-- reajuste de secuencias de identidad del legado
SELECT setval(pg_get_serial_sequence('"staging"."cliente_proveedor_aux"', 'id'),
              (SELECT COALESCE(MAX("id"), 1) FROM "staging"."cliente_proveedor_aux"),
              (SELECT COUNT(*) > 0 FROM "staging"."cliente_proveedor_aux"));
SELECT setval(pg_get_serial_sequence('"staging"."cliente_proveedor_tempo"', 'ide'),
              (SELECT COALESCE(MAX("ide"), 1) FROM "staging"."cliente_proveedor_tempo"),
              (SELECT COUNT(*) > 0 FROM "staging"."cliente_proveedor_tempo"));
SELECT setval(pg_get_serial_sequence('"staging"."cp"', 'a'),
              (SELECT COALESCE(MAX("a"), 1) FROM "staging"."cp"),
              (SELECT COUNT(*) > 0 FROM "staging"."cp"));
SELECT setval(pg_get_serial_sequence('"staging"."movi_contables_ax"', 'idd'),
              (SELECT COALESCE(MAX("idd"), 1) FROM "staging"."movi_contables_ax"),
              (SELECT COUNT(*) > 0 FROM "staging"."movi_contables_ax"));
SELECT setval(pg_get_serial_sequence('"staging"."productos_matriz_x"', 'id_mat'),
              (SELECT COALESCE(MAX("id_mat"), 1) FROM "staging"."productos_matriz_x"),
              (SELECT COUNT(*) > 0 FROM "staging"."productos_matriz_x"));
SELECT setval(pg_get_serial_sequence('"staging"."tempo"', 'nro_fila'),
              (SELECT COALESCE(MAX("nro_fila"), 1) FROM "staging"."tempo"),
              (SELECT COUNT(*) > 0 FROM "staging"."tempo"));
SELECT setval(pg_get_serial_sequence('"staging"."tx"', 'idd'),
              (SELECT COALESCE(MAX("idd"), 1) FROM "staging"."tx"),
              (SELECT COUNT(*) > 0 FROM "staging"."tx"));
SELECT setval(pg_get_serial_sequence('"staging"."tx2"', 'idd'),
              (SELECT COALESCE(MAX("idd"), 1) FROM "staging"."tx2"),
              (SELECT COUNT(*) > 0 FROM "staging"."tx2"));
SELECT setval(pg_get_serial_sequence('"staging"."tx3"', 'idd'),
              (SELECT COALESCE(MAX("idd"), 1) FROM "staging"."tx3"),
              (SELECT COUNT(*) > 0 FROM "staging"."tx3"));

COMMIT;

-- =====================================================================
-- ESQUEMA ventas  (72 tablas)
-- =====================================================================
BEGIN;
SET LOCAL session_replication_role = replica;

-- acta_entrega -> ventas.acta_entrega  (9 col)
INSERT INTO "ventas"."acta_entrega" ("codi_act", "fecha", "nro", "codi_alma", "codi_clie_prov", "estado", "persona_responsable", "dni", "domicilio")
SELECT
       NULLIF(btrim("codi_act"::text), '')::bigint AS "codi_act",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(btrim("nro"::text), '')::bigint AS "nro",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("persona_responsable"::text), '')::varchar(200) AS "persona_responsable",
       NULLIF(rtrim("dni"::text), '')::varchar(15) AS "dni",
       NULLIF(rtrim("domicilio"::text), '')::varchar(200) AS "domicilio"
FROM "legacy_raw"."acta_entrega"
ON CONFLICT DO NOTHING;

-- acta_entrega_detalle -> ventas.acta_entrega_detalle  (7 col)
INSERT INTO "ventas"."acta_entrega_detalle" ("codi_act", "codi_prod", "cantidad", "descripcion", "item", "codi_conv", "item_conv")
SELECT
       NULLIF(btrim("codi_act"::text), '')::bigint AS "codi_act",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(12,3) AS "cantidad",
       NULLIF(rtrim("descripcion"::text), '')::varchar(150) AS "descripcion",
       NULLIF(btrim("item"::text), '')::integer AS "item",
       NULLIF(btrim("codi_conv"::text), '')::bigint AS "codi_conv",
       NULLIF(btrim("item_conv"::text), '')::integer AS "item_conv"
FROM "legacy_raw"."acta_entrega_detalle"
ON CONFLICT DO NOTHING;

-- ALMACEN_DOCUMENTOS -> ventas.almacen_documentos  (8 col)
INSERT INTO "ventas"."almacen_documentos" ("codi_alma", "codi_tipo_docu", "serie_alma", "nro_docu_empieza", "nro_actual", "estado", "tipo_fact", "codi_cont_docu")
SELECT
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("serie_alma"::text), '')::varchar(5) AS "serie_alma",
       NULLIF(btrim("nro_docu_empieza"::text), '')::bigint AS "nro_docu_empieza",
       NULLIF(btrim("nro_actual"::text), '')::bigint AS "nro_actual",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("tipo_fact"::text), '')::varchar(1) AS "tipo_fact",
       NULLIF(btrim("codi_cont_docu"::text), '')::bigint AS "codi_cont_docu"
FROM "legacy_raw"."almacen_documentos"
ON CONFLICT DO NOTHING;

-- BAZAR -> ventas.bazar  (7 col)
INSERT INTO "ventas"."bazar" ("codi_baza", "nomb_baza", "mont_inte", "tipo_mont", "codi_clie_prov", "observacion", "codi_conc")
SELECT
       NULLIF(rtrim("codi_baza"::text), '')::varchar(2) AS "codi_baza",
       NULLIF(rtrim("nomb_baza"::text), '')::varchar(100) AS "nomb_baza",
       NULLIF(btrim("mont_inte"::text), '')::numeric(12,3) AS "mont_inte",
       NULLIF(btrim("tipo_mont"::text), '')::bigint AS "tipo_mont",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("observacion"::text), '')::varchar(200) AS "observacion",
       NULLIF(rtrim("codi_conc"::text), '')::varchar(6) AS "codi_conc"
FROM "legacy_raw"."bazar"
ON CONFLICT DO NOTHING;

-- BOLETAS -> ventas.boletas  (8 col)
INSERT INTO "ventas"."boletas" ("codi_bole", "serie", "numero", "codi_clie_prov", "fecha", "monto", "tipo", "codi_mone")
SELECT
       NULLIF(rtrim("codi_bole"::text), '')::varchar(10) AS "codi_bole",
       NULLIF(rtrim("serie"::text), '')::varchar(3) AS "serie",
       NULLIF(rtrim("numero"::text), '')::varchar(6) AS "numero",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(btrim("monto"::text), '')::numeric(12,2) AS "monto",
       NULLIF(rtrim("tipo"::text), '')::varchar(2) AS "tipo",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone"
FROM "legacy_raw"."boletas"
ON CONFLICT DO NOTHING;

-- BOLETAS_DETALLE -> ventas.boletas_detalle  (7 col)
INSERT INTO "ventas"."boletas_detalle" ("codi_bole", "codi_deta", "codi_item", "descripcion", "cant_item", "precio", "total")
SELECT
       NULLIF(rtrim("codi_bole"::text), '')::varchar(10) AS "codi_bole",
       NULLIF(rtrim("codi_deta"::text), '')::varchar(3) AS "codi_deta",
       NULLIF(rtrim("codi_item"::text), '')::varchar(10) AS "codi_item",
       NULLIF(rtrim("descripcion"::text), '')::text AS "descripcion",
       NULLIF(btrim("cant_item"::text), '')::numeric(12,2) AS "cant_item",
       NULLIF(btrim("precio"::text), '')::numeric(12,2) AS "precio",
       NULLIF(btrim("total"::text), '')::numeric(12,2) AS "total"
FROM "legacy_raw"."boletas_detalle"
ON CONFLICT DO NOTHING;

-- CAPTACION -> ventas.captacion  (21 col)
INSERT INTO "ventas"."captacion" ("codi_cap", "nro_doc", "cliente", "zona", "cultivo", "area", "etapa", "captado", "observaciones", "codi_usua", "fecha", "tipo_pers", "codi_tipo_docu_iden", "apel_1", "apel_2", "nomb_1", "nomb_2", "denominacion", "codi_clie_prov", "codi_alma", "frecuencia")
SELECT
       NULLIF(btrim("codi_cap"::text), '')::bigint AS "codi_cap",
       NULLIF(rtrim("nro_doc"::text), '')::varchar(15) AS "nro_doc",
       NULLIF(rtrim("cliente"::text), '')::varchar(150) AS "cliente",
       NULLIF(rtrim("zona"::text), '')::varchar(250) AS "zona",
       NULLIF(rtrim("cultivo"::text), '')::varchar(250) AS "cultivo",
       NULLIF(rtrim("area"::text), '')::varchar(250) AS "area",
       NULLIF(rtrim("etapa"::text), '')::varchar(50) AS "etapa",
       NULLIF(rtrim("captado"::text), '')::varchar(5) AS "captado",
       NULLIF(rtrim("observaciones"::text), '')::varchar(250) AS "observaciones",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("tipo_pers"::text), '')::varchar(12) AS "tipo_pers",
       NULLIF(btrim("codi_tipo_docu_iden"::text), '')::smallint AS "codi_tipo_docu_iden",
       NULLIF(rtrim("apel_1"::text), '')::varchar(30) AS "apel_1",
       NULLIF(rtrim("apel_2"::text), '')::varchar(30) AS "apel_2",
       NULLIF(rtrim("nomb_1"::text), '')::varchar(30) AS "nomb_1",
       NULLIF(rtrim("nomb_2"::text), '')::varchar(30) AS "nomb_2",
       NULLIF(rtrim("denominacion"::text), '')::varchar(100) AS "denominacion",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("frecuencia"::text), '')::varchar(2) AS "frecuencia"
FROM "legacy_raw"."captacion"
ON CONFLICT DO NOTHING;

-- CAPTACION_VISITA -> ventas.captacion_visita  (17 col)
INSERT INTO "ventas"."captacion_visita" ("codi_capta", "fecha", "agricultor", "zona", "cultivo", "area", "etapa", "codi_rec", "codi_usua", "tipo", "codi_alma", "telefono", "e_mail", "siembra", "area_nro", "codi_cap", "codi_clie_prov")
SELECT
       NULLIF(btrim("codi_capta"::text), '')::bigint AS "codi_capta",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("agricultor"::text), '')::varchar(150) AS "agricultor",
       NULLIF(rtrim("zona"::text), '')::varchar(250) AS "zona",
       NULLIF(rtrim("cultivo"::text), '')::varchar(250) AS "cultivo",
       NULLIF(rtrim("area"::text), '')::varchar(250) AS "area",
       NULLIF(rtrim("etapa"::text), '')::varchar(50) AS "etapa",
       NULLIF(btrim("codi_rec"::text), '')::bigint AS "codi_rec",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("telefono"::text), '')::varchar(15) AS "telefono",
       NULLIF(rtrim("e_mail"::text), '')::varchar(50) AS "e_mail",
       NULLIF(rtrim("siembra"::text), '')::varchar(50) AS "siembra",
       NULLIF(btrim("area_nro"::text), '')::numeric(18,2) AS "area_nro",
       NULLIF(btrim("codi_cap"::text), '')::bigint AS "codi_cap",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov"
FROM "legacy_raw"."captacion_visita"
ON CONFLICT DO NOTHING;

-- CLIENTE_CREDITO_HISTORIAL -> ventas.cliente_credito_historial  (4 col)
INSERT INTO "ventas"."cliente_credito_historial" ("codi_credito", "codi_deta", "fecha", "decripcion")
SELECT
       NULLIF(btrim("codi_credito"::text), '')::bigint AS "codi_credito",
       NULLIF(btrim("codi_deta"::text), '')::bigint AS "codi_deta",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("decripcion"::text), '')::varchar(255) AS "decripcion"
FROM "legacy_raw"."cliente_credito_historial"
ON CONFLICT DO NOTHING;

-- CLIENTE_CREDITOS -> ventas.cliente_creditos  (42 col)
INSERT INTO "ventas"."cliente_creditos" ("codi_credito", "codi_clie_prov", "fec_inic_cred", "codi_mone", "monto_cred", "fec_fin_cred", "observa_cred", "codi_usua_autoriza", "estado", "codi_usua_responsa", "tipo_cred", "codi_alma", "multi_credito", "tipo_pago", "doc_garantia", "fec_pago", "fec_icomp", "fconyuge", "faval", "cdnicliente", "cdniconyuge", "ccontrarrend", "crecserv", "ctitprop", "terrprop", "casa", "vehiculo", "negocio", "referencias", "fec_csf", "codigosf", "calificacion", "capital", "intereses", "total", "vae1", "vae2", "vae3", "vac1", "vac2", "vac3", "infocorp")
SELECT
       NULLIF(btrim("codi_credito"::text), '')::bigint AS "codi_credito",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("fec_inic_cred"::text), '')::timestamp(3) AS "fec_inic_cred",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("monto_cred"::text), '')::numeric(19,4) AS "monto_cred",
       NULLIF(btrim("fec_fin_cred"::text), '')::timestamp(3) AS "fec_fin_cred",
       NULLIF(rtrim("observa_cred"::text), '')::varchar(100) AS "observa_cred",
       NULLIF(rtrim("codi_usua_autoriza"::text), '')::varchar(5) AS "codi_usua_autoriza",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("codi_usua_responsa"::text), '')::varchar(5) AS "codi_usua_responsa",
       NULLIF(rtrim("tipo_cred"::text), '')::varchar(1) AS "tipo_cred",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("multi_credito"::text), '')::varchar(1) AS "multi_credito",
       NULLIF(rtrim("tipo_pago"::text), '')::varchar(1) AS "tipo_pago",
       NULLIF(rtrim("doc_garantia"::text), '')::varchar(2) AS "doc_garantia",
       NULLIF(btrim("fec_pago"::text), '')::timestamp(3) AS "fec_pago",
       NULLIF(btrim("fec_icomp"::text), '')::timestamp(3) AS "fec_icomp",
       NULLIF(btrim("fconyuge"::text), '')::boolean AS "fconyuge",
       NULLIF(btrim("faval"::text), '')::boolean AS "faval",
       NULLIF(btrim("cdnicliente"::text), '')::boolean AS "cdnicliente",
       NULLIF(btrim("cdniconyuge"::text), '')::boolean AS "cdniconyuge",
       NULLIF(btrim("ccontrarrend"::text), '')::boolean AS "ccontrarrend",
       NULLIF(rtrim("crecserv"::text), '')::varchar(100) AS "crecserv",
       NULLIF(rtrim("ctitprop"::text), '')::varchar(100) AS "ctitprop",
       NULLIF(rtrim("terrprop"::text), '')::varchar(255) AS "terrprop",
       NULLIF(rtrim("casa"::text), '')::varchar(255) AS "casa",
       NULLIF(rtrim("vehiculo"::text), '')::varchar(255) AS "vehiculo",
       NULLIF(rtrim("negocio"::text), '')::varchar(255) AS "negocio",
       NULLIF(rtrim("referencias"::text), '')::varchar(255) AS "referencias",
       NULLIF(btrim("fec_csf"::text), '')::timestamp(3) AS "fec_csf",
       NULLIF(rtrim("codigosf"::text), '')::varchar(20) AS "codigosf",
       NULLIF(rtrim("calificacion"::text), '')::varchar(50) AS "calificacion",
       NULLIF(btrim("capital"::text), '')::numeric(18,2) AS "capital",
       NULLIF(btrim("intereses"::text), '')::numeric(18,2) AS "intereses",
       NULLIF(btrim("total"::text), '')::numeric(18,2) AS "total",
       NULLIF(btrim("vae1"::text), '')::numeric(18,2) AS "vae1",
       NULLIF(btrim("vae2"::text), '')::numeric(18,2) AS "vae2",
       NULLIF(btrim("vae3"::text), '')::numeric(18,2) AS "vae3",
       NULLIF(btrim("vac1"::text), '')::numeric(18,2) AS "vac1",
       NULLIF(btrim("vac2"::text), '')::numeric(18,2) AS "vac2",
       NULLIF(btrim("vac3"::text), '')::numeric(18,2) AS "vac3",
       NULLIF(rtrim("infocorp"::text), '')::varchar(1) AS "infocorp"
FROM "legacy_raw"."cliente_creditos"
ON CONFLICT DO NOTHING;

-- CLIENTE_CREDITOS_GARANTIA -> ventas.cliente_creditos_garantia  (2 col)
INSERT INTO "ventas"."cliente_creditos_garantia" ("codi_credito", "doc_garantia")
SELECT
       NULLIF(btrim("codi_credito"::text), '')::bigint AS "codi_credito",
       NULLIF(rtrim("doc_garantia"::text), '')::varchar(2) AS "doc_garantia"
FROM "legacy_raw"."cliente_creditos_garantia"
ON CONFLICT DO NOTHING;

-- CLIENTE_VENDEDOR -> ventas.cliente_vendedor  (4 col)
INSERT INTO "ventas"."cliente_vendedor" ("id_clie_vende", "codi_usua", "codi_clie_prov", "estado")
SELECT
       NULLIF(btrim("id_clie_vende"::text), '')::bigint AS "id_clie_vende",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado"
FROM "legacy_raw"."cliente_vendedor"
ON CONFLICT DO NOTHING;

-- COMISIONES -> ventas.comisiones  (14 col)
INSERT INTO "ventas"."comisiones" ("id_comi", "mes", "anio", "codi_alma", "codi_prod", "desc_prod", "desc_pres", "cantidad", "valor", "comision", "valor_comision", "codi_depen", "desc_depen", "desc_prese_depen")
SELECT
       NULLIF(btrim("id_comi"::text), '')::bigint AS "id_comi",
       NULLIF(btrim("mes"::text), '')::integer AS "mes",
       NULLIF(btrim("anio"::text), '')::integer AS "anio",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("desc_prod"::text), '')::varchar(200) AS "desc_prod",
       NULLIF(rtrim("desc_pres"::text), '')::varchar(200) AS "desc_pres",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,2) AS "cantidad",
       NULLIF(btrim("valor"::text), '')::numeric(18,3) AS "valor",
       NULLIF(btrim("comision"::text), '')::numeric(18,3) AS "comision",
       NULLIF(btrim("valor_comision"::text), '')::numeric(18,3) AS "valor_comision",
       NULLIF(rtrim("codi_depen"::text), '')::varchar(8) AS "codi_depen",
       NULLIF(rtrim("desc_depen"::text), '')::varchar(200) AS "desc_depen",
       NULLIF(rtrim("desc_prese_depen"::text), '')::varchar(200) AS "desc_prese_depen"
FROM "legacy_raw"."comisiones"
ON CONFLICT DO NOTHING;

-- CONFIGURACION_VEHICULAR -> ventas.configuracion_vehicular  (3 col)
INSERT INTO "ventas"."configuracion_vehicular" ("id_conf", "desc_conf", "carga_util")
SELECT
       NULLIF(btrim("id_conf"::text), '')::integer AS "id_conf",
       NULLIF(rtrim("desc_conf"::text), '')::varchar(50) AS "desc_conf",
       NULLIF(btrim("carga_util"::text), '')::numeric(18,3) AS "carga_util"
FROM "legacy_raw"."configuracion_vehicular"
ON CONFLICT DO NOTHING;

-- CONOCIMIENTO -> ventas.conocimiento  (12 col)
INSERT INTO "ventas"."conocimiento" ("codi_con_mer", "fecha", "codi_alma", "cultivo", "variedad", "epoca", "periodo", "zona", "sector", "area", "rendimiento", "precio")
SELECT
       NULLIF(btrim("codi_con_mer"::text), '')::bigint AS "codi_con_mer",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("cultivo"::text), '')::varchar(150) AS "cultivo",
       NULLIF(rtrim("variedad"::text), '')::varchar(150) AS "variedad",
       NULLIF(rtrim("epoca"::text), '')::varchar(2) AS "epoca",
       NULLIF(btrim("periodo"::text), '')::numeric(18,2) AS "periodo",
       NULLIF(rtrim("zona"::text), '')::varchar(150) AS "zona",
       NULLIF(rtrim("sector"::text), '')::varchar(150) AS "sector",
       NULLIF(rtrim("area"::text), '')::varchar(150) AS "area",
       NULLIF(btrim("rendimiento"::text), '')::numeric(18,2) AS "rendimiento",
       NULLIF(btrim("precio"::text), '')::numeric(18,2) AS "precio"
FROM "legacy_raw"."conocimiento"
ON CONFLICT DO NOTHING;

-- convenio -> ventas.convenio  (8 col)
INSERT INTO "ventas"."convenio" ("codi_conv", "codi_fact", "fecha", "nro", "codi_alma", "codi_clie_prov", "codi_mone", "estado")
SELECT
       NULLIF(btrim("codi_conv"::text), '')::bigint AS "codi_conv",
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(btrim("nro"::text), '')::bigint AS "nro",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado"
FROM "legacy_raw"."convenio"
ON CONFLICT DO NOTHING;

-- convenio_detalle -> ventas.convenio_detalle  (8 col)
INSERT INTO "ventas"."convenio_detalle" ("codi_conv", "fecha", "codi_prod", "cantidad", "descripcion", "item", "estado", "saldo")
SELECT
       NULLIF(btrim("codi_conv"::text), '')::bigint AS "codi_conv",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(12,3) AS "cantidad",
       NULLIF(rtrim("descripcion"::text), '')::varchar(150) AS "descripcion",
       NULLIF(btrim("item"::text), '')::integer AS "item",
       NULLIF(btrim("estado"::text), '')::integer AS "estado",
       NULLIF(btrim("saldo"::text), '')::numeric(12,3) AS "saldo"
FROM "legacy_raw"."convenio_detalle"
ON CONFLICT DO NOTHING;

-- COTIZACION -> ventas.cotizacion  (11 col)
INSERT INTO "ventas"."cotizacion" ("codi_coti", "nro_cotiza", "fecha", "codi_alma", "codi_clie_prov", "lugar_ent", "tiempo_ent", "observaciones", "fecha_venc", "forma_pago", "fact_dias")
SELECT
       NULLIF(btrim("codi_coti"::text), '')::bigint AS "codi_coti",
       NULLIF(btrim("nro_cotiza"::text), '')::bigint AS "nro_cotiza",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("lugar_ent"::text), '')::varchar(250) AS "lugar_ent",
       NULLIF(rtrim("tiempo_ent"::text), '')::varchar(250) AS "tiempo_ent",
       NULLIF(rtrim("observaciones"::text), '')::varchar(250) AS "observaciones",
       NULLIF(btrim("fecha_venc"::text), '')::timestamp(3) AS "fecha_venc",
       NULLIF(rtrim("forma_pago"::text), '')::varchar(2) AS "forma_pago",
       NULLIF(btrim("fact_dias"::text), '')::integer AS "fact_dias"
FROM "legacy_raw"."cotizacion"
ON CONFLICT DO NOTHING;

-- CREDITOS -> ventas.creditos  (23 col)
INSERT INTO "ventas"."creditos" ("codi_credito", "codi_clie_prov", "fec_inic_cred", "codi_mone", "monto_cred", "fec_fin_cred", "observa_cred", "codi_usua_autoriza", "estado", "codi_usua_responsa", "tipo_cred", "codi_alma", "multi_credito", "tipo_pago", "doc_garantia", "interes", "igv", "gastos", "total", "codi_lin_cred", "codi_proy", "codi_clie_fav", "periodo")
SELECT
       NULLIF(btrim("codi_credito"::text), '')::bigint AS "codi_credito",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("fec_inic_cred"::text), '')::timestamp(3) AS "fec_inic_cred",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("monto_cred"::text), '')::numeric(19,4) AS "monto_cred",
       NULLIF(btrim("fec_fin_cred"::text), '')::timestamp(3) AS "fec_fin_cred",
       NULLIF(rtrim("observa_cred"::text), '')::varchar(100) AS "observa_cred",
       NULLIF(rtrim("codi_usua_autoriza"::text), '')::varchar(5) AS "codi_usua_autoriza",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("codi_usua_responsa"::text), '')::varchar(5) AS "codi_usua_responsa",
       NULLIF(rtrim("tipo_cred"::text), '')::varchar(1) AS "tipo_cred",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("multi_credito"::text), '')::varchar(1) AS "multi_credito",
       NULLIF(btrim("tipo_pago"::text), '')::bigint AS "tipo_pago",
       NULLIF(rtrim("doc_garantia"::text), '')::varchar(1) AS "doc_garantia",
       NULLIF(btrim("interes"::text), '')::numeric(18,2) AS "interes",
       NULLIF(btrim("igv"::text), '')::numeric(18,2) AS "igv",
       NULLIF(btrim("gastos"::text), '')::numeric(18,2) AS "gastos",
       NULLIF(btrim("total"::text), '')::numeric(18,2) AS "total",
       NULLIF(btrim("codi_lin_cred"::text), '')::bigint AS "codi_lin_cred",
       NULLIF(rtrim("codi_proy"::text), '')::varchar(10) AS "codi_proy",
       NULLIF(rtrim("codi_clie_fav"::text), '')::varchar(5) AS "codi_clie_fav",
       NULLIF(rtrim("periodo"::text), '')::varchar(2) AS "periodo"
FROM "legacy_raw"."creditos"
ON CONFLICT DO NOTHING;

-- CREDITOS_DETALLE -> ventas.creditos_detalle  (6 col)
INSERT INTO "ventas"."creditos_detalle" ("codi_credito", "codi_deta", "fecha", "codi_mone", "valor", "activo")
SELECT
       NULLIF(btrim("codi_credito"::text), '')::bigint AS "codi_credito",
       NULLIF(btrim("codi_deta"::text), '')::bigint AS "codi_deta",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("valor"::text), '')::numeric(18,2) AS "valor",
       NULLIF(rtrim("activo"::text), '')::varchar(1) AS "activo"
FROM "legacy_raw"."creditos_detalle"
ON CONFLICT DO NOTHING;

-- CREDITOS_LINEAS -> ventas.creditos_lineas  (2 col)
INSERT INTO "ventas"."creditos_lineas" ("codi_lin_cred", "descripcion")
SELECT
       NULLIF(btrim("codi_lin_cred"::text), '')::bigint AS "codi_lin_cred",
       NULLIF(rtrim("descripcion"::text), '')::varchar(150) AS "descripcion"
FROM "legacy_raw"."creditos_lineas"
ON CONFLICT DO NOTHING;

-- CREDITOS_TIPOS -> ventas.creditos_tipos  (2 col)
INSERT INTO "ventas"."creditos_tipos" ("codi_tipo_cred", "descripcion")
SELECT
       NULLIF(btrim("codi_tipo_cred"::text), '')::bigint AS "codi_tipo_cred",
       NULLIF(rtrim("descripcion"::text), '')::varchar(150) AS "descripcion"
FROM "legacy_raw"."creditos_tipos"
ON CONFLICT DO NOTHING;

-- CULTIVOS_PRINCIPAL -> ventas.cultivos_principal  (11 col)
INSERT INTO "ventas"."cultivos_principal" ("codi_culti", "cultivo", "periodo", "epoca", "zona", "rendimiento", "porc_parti", "codi_usua", "fecha", "nro_peri", "codi_alma")
SELECT
       NULLIF(btrim("codi_culti"::text), '')::bigint AS "codi_culti",
       NULLIF(rtrim("cultivo"::text), '')::varchar(150) AS "cultivo",
       NULLIF(rtrim("periodo"::text), '')::varchar(150) AS "periodo",
       NULLIF(rtrim("epoca"::text), '')::varchar(150) AS "epoca",
       NULLIF(rtrim("zona"::text), '')::varchar(250) AS "zona",
       NULLIF(btrim("rendimiento"::text), '')::numeric(18,3) AS "rendimiento",
       NULLIF(btrim("porc_parti"::text), '')::numeric(18,3) AS "porc_parti",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(btrim("nro_peri"::text), '')::numeric(18,3) AS "nro_peri",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma"
FROM "legacy_raw"."cultivos_principal"
ON CONFLICT DO NOTHING;

-- CUOTAS_SUCURSAL -> ventas.cuotas_sucursal  (5 col)
INSERT INTO "ventas"."cuotas_sucursal" ("anio", "mes", "codi_alma", "monto", "cod_lin_pro")
SELECT
       NULLIF(btrim("anio"::text), '')::integer AS "anio",
       NULLIF(btrim("mes"::text), '')::integer AS "mes",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("monto"::text), '')::numeric(18,2) AS "monto",
       NULLIF(rtrim("cod_lin_pro"::text), '')::varchar(2) AS "cod_lin_pro"
FROM "legacy_raw"."cuotas_sucursal"
ON CONFLICT DO NOTHING;

-- FACTURA -> ventas.factura  (61 col)
INSERT INTO "ventas"."factura" ("codi_fact", "codi_alma", "codi_clie_prov", "fech_fact", "codi_tipo_docu", "ser_fact", "nro_fact", "orde_fact", "tele_fact", "guia_fact", "venc_fact", "tipo_fact", "codi_mone", "tcambio", "codi_tipo_pago", "tipo_credito", "valo_fact", "dscto_fact", "subtota_fact", "tota_exonerado", "valor_igv", "igv_fact", "tota_fact", "codi_orde_grua", "estado", "codi_unid_oper", "codi_vouc", "contabilizado", "aplica_igv", "cod_imp", "cod_usua", "impreso", "cod_usua_vende", "cod_siembra", "fec_pago", "cod_cultivo", "cod_zona", "cod_usua_recetista", "prov_canc", "creacion", "hectarea", "hecho_por", "nro_dias", "codi_conv", "fecha_siembra", "detra", "codi_bien_serv", "printer_name", "dias_fact", "codi_oper", "cod_usua_modi", "total_gratuita", "fecha_elim", "motivo_elim", "codi_desc", "dscto_global", "factor_dscto", "nro_cuotas", "codi_guia_rem", "tipo_impr", "pdetr")
SELECT
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("fech_fact"::text), '')::timestamp(3) AS "fech_fact",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("ser_fact"::text), '')::varchar(5) AS "ser_fact",
       NULLIF(rtrim("nro_fact"::text), '')::varchar(10) AS "nro_fact",
       NULLIF(rtrim("orde_fact"::text), '')::varchar(30) AS "orde_fact",
       NULLIF(rtrim("tele_fact"::text), '')::varchar(50) AS "tele_fact",
       NULLIF(rtrim("guia_fact"::text), '')::varchar(250) AS "guia_fact",
       NULLIF(btrim("venc_fact"::text), '')::timestamp(3) AS "venc_fact",
       NULLIF(rtrim("tipo_fact"::text), '')::varchar(2) AS "tipo_fact",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("tcambio"::text), '')::numeric(19,4) AS "tcambio",
       NULLIF(btrim("codi_tipo_pago"::text), '')::integer AS "codi_tipo_pago",
       NULLIF(btrim("tipo_credito"::text), '')::smallint AS "tipo_credito",
       NULLIF(btrim("valo_fact"::text), '')::numeric(12,3) AS "valo_fact",
       NULLIF(btrim("dscto_fact"::text), '')::numeric(19,4) AS "dscto_fact",
       NULLIF(btrim("subtota_fact"::text), '')::numeric(19,4) AS "subtota_fact",
       NULLIF(btrim("tota_exonerado"::text), '')::numeric(19,4) AS "tota_exonerado",
       NULLIF(btrim("valor_igv"::text), '')::numeric(12,2) AS "valor_igv",
       NULLIF(btrim("igv_fact"::text), '')::numeric(12,3) AS "igv_fact",
       NULLIF(btrim("tota_fact"::text), '')::numeric(12,3) AS "tota_fact",
       NULLIF(rtrim("codi_orde_grua"::text), '')::varchar(10) AS "codi_orde_grua",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_vouc"::text), '')::varchar(10) AS "codi_vouc",
       NULLIF(rtrim("contabilizado"::text), '')::varchar(1) AS "contabilizado",
       NULLIF(rtrim("aplica_igv"::text), '')::varchar(1) AS "aplica_igv",
       NULLIF(btrim("cod_imp"::text), '')::integer AS "cod_imp",
       NULLIF(rtrim("cod_usua"::text), '')::varchar(5) AS "cod_usua",
       NULLIF(rtrim("impreso"::text), '')::varchar(1) AS "impreso",
       NULLIF(rtrim("cod_usua_vende"::text), '')::varchar(5) AS "cod_usua_vende",
       NULLIF(btrim("cod_siembra"::text), '')::bigint AS "cod_siembra",
       NULLIF(btrim("fec_pago"::text), '')::timestamp(3) AS "fec_pago",
       NULLIF(btrim("cod_cultivo"::text), '')::integer AS "cod_cultivo",
       NULLIF(btrim("cod_zona"::text), '')::bigint AS "cod_zona",
       NULLIF(rtrim("cod_usua_recetista"::text), '')::varchar(5) AS "cod_usua_recetista",
       NULLIF(rtrim("prov_canc"::text), '')::varchar(1) AS "prov_canc",
       NULLIF(btrim("creacion"::text), '')::timestamp(3) AS "creacion",
       NULLIF(btrim("hectarea"::text), '')::numeric(18,3) AS "hectarea",
       NULLIF(rtrim("hecho_por"::text), '')::varchar(5) AS "hecho_por",
       NULLIF(btrim("nro_dias"::text), '')::integer AS "nro_dias",
       NULLIF(btrim("codi_conv"::text), '')::bigint AS "codi_conv",
       NULLIF(btrim("fecha_siembra"::text), '')::timestamp(3) AS "fecha_siembra",
       NULLIF(rtrim("detra"::text), '')::varchar(1) AS "detra",
       NULLIF(rtrim("codi_bien_serv"::text), '')::varchar(5) AS "codi_bien_serv",
       NULLIF(rtrim("printer_name"::text), '')::varchar(250) AS "printer_name",
       NULLIF(btrim("dias_fact"::text), '')::bigint AS "dias_fact",
       NULLIF(rtrim("codi_oper"::text), '')::varchar(4) AS "codi_oper",
       NULLIF(rtrim("cod_usua_modi"::text), '')::varchar(5) AS "cod_usua_modi",
       NULLIF(btrim("total_gratuita"::text), '')::numeric(12,2) AS "total_gratuita",
       NULLIF(btrim("fecha_elim"::text), '')::timestamp(3) AS "fecha_elim",
       NULLIF(rtrim("motivo_elim"::text), '')::varchar(100) AS "motivo_elim",
       NULLIF(rtrim("codi_desc"::text), '')::varchar(2) AS "codi_desc",
       NULLIF(btrim("dscto_global"::text), '')::numeric(12,2) AS "dscto_global",
       NULLIF(btrim("factor_dscto"::text), '')::numeric(12,2) AS "factor_dscto",
       NULLIF(btrim("nro_cuotas"::text), '')::integer AS "nro_cuotas",
       NULLIF(btrim("codi_guia_rem"::text), '')::bigint AS "codi_guia_rem",
       NULLIF(rtrim("tipo_impr"::text), '')::varchar(1) AS "tipo_impr",
       NULLIF(btrim("pdetr"::text), '')::numeric(18,3) AS "pdetr"
FROM "legacy_raw"."factura"
ON CONFLICT DO NOTHING;

-- FACTURA_ANTICIPOS -> ventas.factura_anticipos  (13 col)
INSERT INTO "ventas"."factura_anticipos" ("codi_fact", "id_sec", "codi_tipo_docu", "serie", "numero", "fecha_pago_rece", "fecha_pago_efec", "monto_anti", "descripcion", "hora_pago", "precio", "codi_fact_anti", "codi_mone")
SELECT
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(btrim("id_sec"::text), '')::integer AS "id_sec",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("serie"::text), '')::varchar(10) AS "serie",
       NULLIF(rtrim("numero"::text), '')::varchar(20) AS "numero",
       NULLIF(btrim("fecha_pago_rece"::text), '')::timestamp(3) AS "fecha_pago_rece",
       NULLIF(btrim("fecha_pago_efec"::text), '')::timestamp(3) AS "fecha_pago_efec",
       NULLIF(btrim("monto_anti"::text), '')::numeric(18,2) AS "monto_anti",
       NULLIF(rtrim("descripcion"::text), '')::varchar(200) AS "descripcion",
       NULLIF(btrim("hora_pago"::text), '')::timestamp(3) AS "hora_pago",
       NULLIF(btrim("precio"::text), '')::numeric(12,2) AS "precio",
       NULLIF(rtrim("codi_fact_anti"::text), '')::varchar(10) AS "codi_fact_anti",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone"
FROM "legacy_raw"."factura_anticipos"
ON CONFLICT DO NOTHING;

-- FACTURA_CREDITO -> ventas.factura_credito  (3 col)
INSERT INTO "ventas"."factura_credito" ("codi_fact", "codi_credito", "monto")
SELECT
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(btrim("codi_credito"::text), '')::bigint AS "codi_credito",
       NULLIF(btrim("monto"::text), '')::numeric(19,4) AS "monto"
FROM "legacy_raw"."factura_credito"
ON CONFLICT DO NOTHING;

-- FACTURA_CUOTAS -> ventas.factura_cuotas  (6 col)
INSERT INTO "ventas"."factura_cuotas" ("codi_fact", "id_sec", "fecha", "monto", "fecha_nc", "monto_nc")
SELECT
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(btrim("id_sec"::text), '')::integer AS "id_sec",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(btrim("monto"::text), '')::numeric(18,2) AS "monto",
       NULLIF(btrim("fecha_nc"::text), '')::timestamp(3) AS "fecha_nc",
       NULLIF(btrim("monto_nc"::text), '')::numeric(18,2) AS "monto_nc"
FROM "legacy_raw"."factura_cuotas"
ON CONFLICT DO NOTHING;

-- FACTURA_DETALLE -> ventas.factura_detalle  (24 col)
INSERT INTO "ventas"."factura_detalle" ("codi_fact", "codi_deta", "codi_alma", "codi_item", "codi_prod", "desc_item", "codi_unid_medi", "cant_item", "prec_item", "prec_lista", "dscto_prec", "dscto_item", "impo_item", "igv", "codi_mate", "cant_saldo", "codi_imp", "prec_costo", "incl_igv", "saldo_conv", "prod_ofer", "codi_desc_deta", "codi_tipo_afec", "tipo_rot")
SELECT
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(rtrim("codi_deta"::text), '')::varchar(3) AS "codi_deta",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_item"::text), '')::varchar(10) AS "codi_item",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("desc_item"::text), '')::varchar(300) AS "desc_item",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(btrim("cant_item"::text), '')::numeric(12,3) AS "cant_item",
       NULLIF(btrim("prec_item"::text), '')::numeric(18,7) AS "prec_item",
       NULLIF(btrim("prec_lista"::text), '')::numeric(18,7) AS "prec_lista",
       NULLIF(btrim("dscto_prec"::text), '')::numeric(19,4) AS "dscto_prec",
       NULLIF(btrim("dscto_item"::text), '')::numeric(19,4) AS "dscto_item",
       NULLIF(btrim("impo_item"::text), '')::numeric(12,3) AS "impo_item",
       NULLIF(btrim("igv"::text), '')::numeric(18,3) AS "igv",
       NULLIF(rtrim("codi_mate"::text), '')::varchar(10) AS "codi_mate",
       NULLIF(btrim("cant_saldo"::text), '')::bigint AS "cant_saldo",
       NULLIF(btrim("codi_imp"::text), '')::integer AS "codi_imp",
       NULLIF(btrim("prec_costo"::text), '')::numeric(19,4) AS "prec_costo",
       NULLIF(rtrim("incl_igv"::text), '')::varchar(1) AS "incl_igv",
       NULLIF(btrim("saldo_conv"::text), '')::numeric(18,2) AS "saldo_conv",
       NULLIF(rtrim("prod_ofer"::text), '')::varchar(1) AS "prod_ofer",
       NULLIF(rtrim("codi_desc_deta"::text), '')::varchar(2) AS "codi_desc_deta",
       NULLIF(rtrim("codi_tipo_afec"::text), '')::varchar(2) AS "codi_tipo_afec",
       NULLIF(rtrim("tipo_rot"::text), '')::varchar(7) AS "tipo_rot"
FROM "legacy_raw"."factura_detalle"
ON CONFLICT DO NOTHING;

-- FACTURA_PESCA -> ventas.factura_pesca  (14 col)
INSERT INTO "ventas"."factura_pesca" ("codi_fact_pesc", "codi_clie_prov", "fech_emis", "valo_vent", "igv", "valo_tota", "codi_mone", "ser_fact", "nro_fact", "tipo_fact", "codi_unid_oper", "detr_tota", "codi_sema", "porc_detr")
SELECT
       NULLIF(rtrim("codi_fact_pesc"::text), '')::varchar(10) AS "codi_fact_pesc",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("fech_emis"::text), '')::timestamp(3) AS "fech_emis",
       NULLIF(btrim("valo_vent"::text), '')::numeric(12,3) AS "valo_vent",
       NULLIF(btrim("igv"::text), '')::numeric(12,3) AS "igv",
       NULLIF(btrim("valo_tota"::text), '')::numeric(12,3) AS "valo_tota",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("ser_fact"::text), '')::varchar(3) AS "ser_fact",
       NULLIF(rtrim("nro_fact"::text), '')::varchar(10) AS "nro_fact",
       NULLIF(rtrim("tipo_fact"::text), '')::varchar(2) AS "tipo_fact",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(btrim("detr_tota"::text), '')::numeric(12,3) AS "detr_tota",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(btrim("porc_detr"::text), '')::numeric(12,3) AS "porc_detr"
FROM "legacy_raw"."factura_pesca"
ON CONFLICT DO NOTHING;

-- FACTURA_SUNAT -> ventas.factura_sunat  (2 col)
INSERT INTO "ventas"."factura_sunat" ("codi_fact", "estado")
SELECT
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(btrim("estado"::text), '')::integer AS "estado"
FROM "legacy_raw"."factura_sunat"
ON CONFLICT DO NOTHING;

-- FACTURAS -> ventas.facturas  (29 col)
INSERT INTO "ventas"."facturas" ("codi_fact", "serie_fact", "nro_fact", "fecha_fact", "tipo_pers", "codi_clie", "id_clie_natu_f", "valorventa", "igv", "total", "estado", "codi_usua", "observaciones", "exonerado", "codi_mone", "codi_tipo_docu", "tipo_cambio", "entrega", "tipo", "nro_oc_clie", "impreso", "cliente", "direccion", "nro_docu", "serv_prod", "cancelada", "provisionada", "codi_vouc", "fechareg")
SELECT
       NULLIF(btrim("codi_fact"::text), '')::integer AS "codi_fact",
       NULLIF(btrim("serie_fact"::text), '')::smallint AS "serie_fact",
       NULLIF(btrim("nro_fact"::text), '')::integer AS "nro_fact",
       NULLIF(btrim("fecha_fact"::text), '')::timestamp(0) AS "fecha_fact",
       NULLIF(rtrim("tipo_pers"::text), '')::varchar(1) AS "tipo_pers",
       NULLIF(rtrim("codi_clie"::text), '')::varchar(5) AS "codi_clie",
       NULLIF(btrim("id_clie_natu_f"::text), '')::integer AS "id_clie_natu_f",
       NULLIF(btrim("valorventa"::text), '')::numeric(18,2) AS "valorventa",
       NULLIF(btrim("igv"::text), '')::numeric(18,2) AS "igv",
       NULLIF(btrim("total"::text), '')::numeric(18,2) AS "total",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(rtrim("observaciones"::text), '')::varchar(200) AS "observaciones",
       NULLIF(btrim("exonerado"::text), '')::smallint AS "exonerado",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(btrim("tipo_cambio"::text), '')::numeric(18,4) AS "tipo_cambio",
       NULLIF(btrim("entrega"::text), '')::smallint AS "entrega",
       NULLIF(btrim("tipo"::text), '')::smallint AS "tipo",
       NULLIF(rtrim("nro_oc_clie"::text), '')::varchar(25) AS "nro_oc_clie",
       NULLIF(btrim("impreso"::text), '')::smallint AS "impreso",
       NULLIF(rtrim("cliente"::text), '')::varchar(75) AS "cliente",
       NULLIF(rtrim("direccion"::text), '')::varchar(75) AS "direccion",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(20) AS "nro_docu",
       NULLIF(rtrim("serv_prod"::text), '')::varchar(1) AS "serv_prod",
       NULLIF(btrim("cancelada"::text), '')::smallint AS "cancelada",
       NULLIF(btrim("provisionada"::text), '')::smallint AS "provisionada",
       NULLIF(rtrim("codi_vouc"::text), '')::varchar(10) AS "codi_vouc",
       NULLIF(btrim("fechareg"::text), '')::timestamp(3) AS "fechareg"
FROM "legacy_raw"."facturas"
ON CONFLICT DO NOTHING;

-- FACTURAS_DETALLE -> ventas.facturas_detalle  (20 col)
INSERT INTO "ventas"."facturas_detalle" ("codi_fact", "item_fact", "codi_prod_serv", "descripcion", "cantidad", "codi_unid_medi", "prec_inc_igv", "prec_unit", "subtotal", "origen", "estado", "codi_orde_produc", "codi_guia", "item_guia", "detalle", "detalle2", "detalle3", "detalle4", "detadescrip", "descripcion_item")
SELECT
       NULLIF(btrim("codi_fact"::text), '')::integer AS "codi_fact",
       NULLIF(btrim("item_fact"::text), '')::smallint AS "item_fact",
       NULLIF(rtrim("codi_prod_serv"::text), '')::varchar(8) AS "codi_prod_serv",
       NULLIF(rtrim("descripcion"::text), '')::varchar(150) AS "descripcion",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,2) AS "cantidad",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(btrim("prec_inc_igv"::text), '')::numeric(18,8) AS "prec_inc_igv",
       NULLIF(btrim("prec_unit"::text), '')::numeric(18,8) AS "prec_unit",
       NULLIF(btrim("subtotal"::text), '')::numeric(18,4) AS "subtotal",
       NULLIF(btrim("origen"::text), '')::smallint AS "origen",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(btrim("codi_orde_produc"::text), '')::integer AS "codi_orde_produc",
       NULLIF(btrim("codi_guia"::text), '')::integer AS "codi_guia",
       NULLIF(btrim("item_guia"::text), '')::smallint AS "item_guia",
       NULLIF(rtrim("detalle"::text), '')::varchar(1000) AS "detalle",
       NULLIF(rtrim("detalle2"::text), '')::varchar(250) AS "detalle2",
       NULLIF(rtrim("detalle3"::text), '')::varchar(250) AS "detalle3",
       NULLIF(rtrim("detalle4"::text), '')::varchar(250) AS "detalle4",
       NULLIF(rtrim("detadescrip"::text), '')::varchar(1000) AS "detadescrip",
       NULLIF(rtrim("descripcion_item"::text), '')::varchar(1000) AS "descripcion_item"
FROM "legacy_raw"."facturas_detalle"
ON CONFLICT DO NOTHING;

-- GUIA -> ventas.guia  (43 col)
INSERT INTO "ventas"."guia" ("codi_guia", "ser_guia", "nro_guia", "fech_tras", "punto_partida", "e_p", "orde_compr", "codi_clie_dest", "punto_llegada", "codi_trans", "placa_vehi", "codi_moti_tras", "otros_obs", "codi_fact", "marca_placa", "nro_licencia", "peso_total", "codi_mone", "sub_total", "igv_venta", "total_venta", "codi_docu_sali", "codi_alma", "codi_alma_desti", "estado", "codi_unid_vehi", "codi_chof", "ruc_dni", "codi_orden_pedi", "fecha", "nom_terc", "const_ins", "observaciones", "apro_por", "creacion", "envio", "tipo_gene", "dist_part", "dist_dest", "codi_unid_medi_peso", "tipo_traslado", "codi_clie_comp", "codi_nota_ingre")
SELECT
       NULLIF(btrim("codi_guia"::text), '')::bigint AS "codi_guia",
       NULLIF(rtrim("ser_guia"::text), '')::varchar(4) AS "ser_guia",
       NULLIF(btrim("nro_guia"::text), '')::integer AS "nro_guia",
       NULLIF(btrim("fech_tras"::text), '')::timestamp(3) AS "fech_tras",
       NULLIF(rtrim("punto_partida"::text), '')::varchar(150) AS "punto_partida",
       NULLIF(rtrim("e_p"::text), '')::varchar(250) AS "e_p",
       NULLIF(rtrim("orde_compr"::text), '')::varchar(50) AS "orde_compr",
       NULLIF(rtrim("codi_clie_dest"::text), '')::varchar(5) AS "codi_clie_dest",
       NULLIF(rtrim("punto_llegada"::text), '')::varchar(150) AS "punto_llegada",
       NULLIF(rtrim("codi_trans"::text), '')::varchar(5) AS "codi_trans",
       NULLIF(rtrim("placa_vehi"::text), '')::varchar(50) AS "placa_vehi",
       NULLIF(rtrim("codi_moti_tras"::text), '')::varchar(2) AS "codi_moti_tras",
       NULLIF(rtrim("otros_obs"::text), '')::varchar(150) AS "otros_obs",
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(rtrim("marca_placa"::text), '')::varchar(50) AS "marca_placa",
       NULLIF(rtrim("nro_licencia"::text), '')::varchar(50) AS "nro_licencia",
       NULLIF(btrim("peso_total"::text), '')::numeric(18,3) AS "peso_total",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("sub_total"::text), '')::numeric(18,2) AS "sub_total",
       NULLIF(btrim("igv_venta"::text), '')::numeric(18,2) AS "igv_venta",
       NULLIF(btrim("total_venta"::text), '')::numeric(18,2) AS "total_venta",
       NULLIF(rtrim("codi_docu_sali"::text), '')::varchar(10) AS "codi_docu_sali",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_alma_desti"::text), '')::varchar(2) AS "codi_alma_desti",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("codi_unid_vehi"::text), '')::varchar(5) AS "codi_unid_vehi",
       NULLIF(rtrim("codi_chof"::text), '')::varchar(4) AS "codi_chof",
       NULLIF(rtrim("ruc_dni"::text), '')::varchar(15) AS "ruc_dni",
       NULLIF(btrim("codi_orden_pedi"::text), '')::bigint AS "codi_orden_pedi",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("nom_terc"::text), '')::varchar(100) AS "nom_terc",
       NULLIF(rtrim("const_ins"::text), '')::varchar(50) AS "const_ins",
       NULLIF(rtrim("observaciones"::text), '')::varchar(255) AS "observaciones",
       NULLIF(rtrim("apro_por"::text), '')::varchar(5) AS "apro_por",
       NULLIF(btrim("creacion"::text), '')::timestamp(3) AS "creacion",
       NULLIF(rtrim("envio"::text), '')::varchar(1) AS "envio",
       NULLIF(rtrim("tipo_gene"::text), '')::varchar(1) AS "tipo_gene",
       NULLIF(btrim("dist_part"::text), '')::integer AS "dist_part",
       NULLIF(btrim("dist_dest"::text), '')::integer AS "dist_dest",
       NULLIF(rtrim("codi_unid_medi_peso"::text), '')::varchar(2) AS "codi_unid_medi_peso",
       NULLIF(rtrim("tipo_traslado"::text), '')::varchar(2) AS "tipo_traslado",
       NULLIF(rtrim("codi_clie_comp"::text), '')::varchar(5) AS "codi_clie_comp",
       NULLIF(rtrim("codi_nota_ingre"::text), '')::varchar(10) AS "codi_nota_ingre"
FROM "legacy_raw"."guia"
ON CONFLICT DO NOTHING;

-- GUIA_DETALLE -> ventas.guia_detalle  (18 col)
INSERT INTO "ventas"."guia_detalle" ("codi_guia", "item_guia", "codi_prod", "cantidad", "codi_unid_medi", "descripcion", "prec_unit", "valor_venta", "descuento", "prec_venta", "peso_total", "observaciones", "doc", "ser", "nro", "prec_compra", "codi_deta_orde_pedi", "prec_venta_real")
SELECT
       NULLIF(btrim("codi_guia"::text), '')::bigint AS "codi_guia",
       NULLIF(btrim("item_guia"::text), '')::integer AS "item_guia",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,4) AS "cantidad",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(rtrim("descripcion"::text), '')::varchar(100) AS "descripcion",
       NULLIF(btrim("prec_unit"::text), '')::numeric(18,4) AS "prec_unit",
       NULLIF(btrim("valor_venta"::text), '')::numeric(18,4) AS "valor_venta",
       NULLIF(btrim("descuento"::text), '')::numeric(12,2) AS "descuento",
       NULLIF(btrim("prec_venta"::text), '')::numeric(12,4) AS "prec_venta",
       NULLIF(btrim("peso_total"::text), '')::numeric(12,2) AS "peso_total",
       NULLIF(rtrim("observaciones"::text), '')::varchar(150) AS "observaciones",
       NULLIF(rtrim("doc"::text), '')::varchar(5) AS "doc",
       NULLIF(rtrim("ser"::text), '')::varchar(5) AS "ser",
       NULLIF(rtrim("nro"::text), '')::varchar(10) AS "nro",
       NULLIF(btrim("prec_compra"::text), '')::numeric(18,4) AS "prec_compra",
       NULLIF(rtrim("codi_deta_orde_pedi"::text), '')::varchar(12) AS "codi_deta_orde_pedi",
       NULLIF(btrim("prec_venta_real"::text), '')::numeric(12,4) AS "prec_venta_real"
FROM "legacy_raw"."guia_detalle"
ON CONFLICT DO NOTHING;

-- GUIA_TRANSPORTISTA -> ventas.guia_transportista  (36 col)
INSERT INTO "ventas"."guia_transportista" ("id_guia", "serie", "numero", "fecha", "fecha_inic_tras", "via_tipo_part", "via_nomb_part", "nro_part", "interior_part", "zona_part", "dist_part", "prov_part", "depa_part", "via_tipo_dest", "via_nomb_dest", "nro_dest", "interior_dest", "zona_dest", "dist_dest", "prov_dest", "depa_dest", "codi_clie_remi", "codi_clie_dest", "codi_clie_subc", "marca_vehi", "codi_unid_vehi", "codi_unid_carr", "codi_trans", "observaciones", "orden_despa", "orden_venta", "guia_remitente", "codi_fact", "estado", "codi_orden_soli", "codi_deta")
SELECT
       NULLIF(btrim("id_guia"::text), '')::bigint AS "id_guia",
       NULLIF(rtrim("serie"::text), '')::varchar(5) AS "serie",
       NULLIF(btrim("numero"::text), '')::bigint AS "numero",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(btrim("fecha_inic_tras"::text), '')::timestamp(3) AS "fecha_inic_tras",
       NULLIF(rtrim("via_tipo_part"::text), '')::varchar(50) AS "via_tipo_part",
       NULLIF(rtrim("via_nomb_part"::text), '')::varchar(150) AS "via_nomb_part",
       NULLIF(rtrim("nro_part"::text), '')::varchar(50) AS "nro_part",
       NULLIF(rtrim("interior_part"::text), '')::varchar(50) AS "interior_part",
       NULLIF(rtrim("zona_part"::text), '')::varchar(150) AS "zona_part",
       NULLIF(btrim("dist_part"::text), '')::smallint AS "dist_part",
       NULLIF(btrim("prov_part"::text), '')::smallint AS "prov_part",
       NULLIF(btrim("depa_part"::text), '')::smallint AS "depa_part",
       NULLIF(rtrim("via_tipo_dest"::text), '')::varchar(50) AS "via_tipo_dest",
       NULLIF(rtrim("via_nomb_dest"::text), '')::varchar(150) AS "via_nomb_dest",
       NULLIF(rtrim("nro_dest"::text), '')::varchar(50) AS "nro_dest",
       NULLIF(rtrim("interior_dest"::text), '')::varchar(50) AS "interior_dest",
       NULLIF(rtrim("zona_dest"::text), '')::varchar(150) AS "zona_dest",
       NULLIF(btrim("dist_dest"::text), '')::smallint AS "dist_dest",
       NULLIF(btrim("prov_dest"::text), '')::smallint AS "prov_dest",
       NULLIF(btrim("depa_dest"::text), '')::smallint AS "depa_dest",
       NULLIF(rtrim("codi_clie_remi"::text), '')::varchar(5) AS "codi_clie_remi",
       NULLIF(rtrim("codi_clie_dest"::text), '')::varchar(5) AS "codi_clie_dest",
       NULLIF(rtrim("codi_clie_subc"::text), '')::varchar(5) AS "codi_clie_subc",
       NULLIF(rtrim("marca_vehi"::text), '')::varchar(50) AS "marca_vehi",
       NULLIF(rtrim("codi_unid_vehi"::text), '')::varchar(5) AS "codi_unid_vehi",
       NULLIF(rtrim("codi_unid_carr"::text), '')::varchar(10) AS "codi_unid_carr",
       NULLIF(rtrim("codi_trans"::text), '')::varchar(4) AS "codi_trans",
       NULLIF(rtrim("observaciones"::text), '')::varchar(250) AS "observaciones",
       NULLIF(rtrim("orden_despa"::text), '')::varchar(50) AS "orden_despa",
       NULLIF(rtrim("orden_venta"::text), '')::varchar(50) AS "orden_venta",
       NULLIF(rtrim("guia_remitente"::text), '')::varchar(50) AS "guia_remitente",
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(btrim("codi_orden_soli"::text), '')::bigint AS "codi_orden_soli",
       NULLIF(btrim("codi_deta"::text), '')::bigint AS "codi_deta"
FROM "legacy_raw"."guia_transportista"
ON CONFLICT DO NOTHING;

-- GUIA_TRANSPORTISTA_DETALLE -> ventas.guia_transportista_detalle  (11 col)
INSERT INTO "ventas"."guia_transportista_detalle" ("id_guia", "item", "codi_prod", "descripcion", "cantidad", "peso", "codi_unid_medi", "costo_minimo", "precio", "total", "codi_deta_oss")
SELECT
       NULLIF(btrim("id_guia"::text), '')::bigint AS "id_guia",
       NULLIF(btrim("item"::text), '')::integer AS "item",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("descripcion"::text), '')::varchar(200) AS "descripcion",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,3) AS "cantidad",
       NULLIF(btrim("peso"::text), '')::numeric(18,3) AS "peso",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(btrim("costo_minimo"::text), '')::numeric(18,4) AS "costo_minimo",
       NULLIF(btrim("precio"::text), '')::numeric(18,3) AS "precio",
       NULLIF(btrim("total"::text), '')::numeric(18,3) AS "total",
       NULLIF(btrim("codi_deta_oss"::text), '')::bigint AS "codi_deta_oss"
FROM "legacy_raw"."guia_transportista_detalle"
ON CONFLICT DO NOTHING;

-- HOJA_VIDA -> ventas.hoja_vida  (46 col)
INSERT INTO "ventas"."hoja_vida" ("codi_hoja", "grupo", "razon", "ruc", "email_emp", "email_logi", "email_ventas", "email_tecni", "direccion", "localidad", "provincia", "departamento", "telef", "celular", "cobertura", "ape_1", "ape_2", "nombres", "codigo", "cargo", "propietario", "arrendatario", "jefe_campo", "logistica", "zona_pers", "prov_pers", "dist_pers", "depa_pers", "email", "fech_nac", "dni", "telef_pers", "estado_civ", "celular_pers", "grado", "familia", "especie", "variedad", "siembra", "surco", "golpe", "surco_2", "area", "semilla", "nro_semilla", "densidad")
SELECT
       NULLIF(btrim("codi_hoja"::text), '')::bigint AS "codi_hoja",
       NULLIF(rtrim("grupo"::text), '')::varchar(250) AS "grupo",
       NULLIF(rtrim("razon"::text), '')::varchar(250) AS "razon",
       NULLIF(rtrim("ruc"::text), '')::varchar(11) AS "ruc",
       NULLIF(rtrim("email_emp"::text), '')::varchar(100) AS "email_emp",
       NULLIF(rtrim("email_logi"::text), '')::varchar(100) AS "email_logi",
       NULLIF(rtrim("email_ventas"::text), '')::varchar(100) AS "email_ventas",
       NULLIF(rtrim("email_tecni"::text), '')::varchar(100) AS "email_tecni",
       NULLIF(rtrim("direccion"::text), '')::varchar(100) AS "direccion",
       NULLIF(rtrim("localidad"::text), '')::varchar(100) AS "localidad",
       NULLIF(rtrim("provincia"::text), '')::varchar(100) AS "provincia",
       NULLIF(rtrim("departamento"::text), '')::varchar(100) AS "departamento",
       NULLIF(rtrim("telef"::text), '')::varchar(15) AS "telef",
       NULLIF(rtrim("celular"::text), '')::varchar(15) AS "celular",
       NULLIF(rtrim("cobertura"::text), '')::varchar(150) AS "cobertura",
       NULLIF(rtrim("ape_1"::text), '')::varchar(100) AS "ape_1",
       NULLIF(rtrim("ape_2"::text), '')::varchar(100) AS "ape_2",
       NULLIF(rtrim("nombres"::text), '')::varchar(150) AS "nombres",
       NULLIF(rtrim("codigo"::text), '')::varchar(20) AS "codigo",
       NULLIF(rtrim("cargo"::text), '')::varchar(100) AS "cargo",
       NULLIF(rtrim("propietario"::text), '')::varchar(100) AS "propietario",
       NULLIF(rtrim("arrendatario"::text), '')::varchar(100) AS "arrendatario",
       NULLIF(rtrim("jefe_campo"::text), '')::varchar(100) AS "jefe_campo",
       NULLIF(rtrim("logistica"::text), '')::varchar(100) AS "logistica",
       NULLIF(rtrim("zona_pers"::text), '')::varchar(100) AS "zona_pers",
       NULLIF(rtrim("prov_pers"::text), '')::varchar(100) AS "prov_pers",
       NULLIF(rtrim("dist_pers"::text), '')::varchar(100) AS "dist_pers",
       NULLIF(rtrim("depa_pers"::text), '')::varchar(100) AS "depa_pers",
       NULLIF(rtrim("email"::text), '')::varchar(100) AS "email",
       NULLIF(btrim("fech_nac"::text), '')::timestamp(3) AS "fech_nac",
       NULLIF(rtrim("dni"::text), '')::varchar(8) AS "dni",
       NULLIF(rtrim("telef_pers"::text), '')::varchar(15) AS "telef_pers",
       NULLIF(rtrim("estado_civ"::text), '')::varchar(20) AS "estado_civ",
       NULLIF(rtrim("celular_pers"::text), '')::varchar(15) AS "celular_pers",
       NULLIF(rtrim("grado"::text), '')::varchar(100) AS "grado",
       NULLIF(rtrim("familia"::text), '')::varchar(100) AS "familia",
       NULLIF(rtrim("especie"::text), '')::varchar(100) AS "especie",
       NULLIF(rtrim("variedad"::text), '')::varchar(100) AS "variedad",
       NULLIF(rtrim("siembra"::text), '')::varchar(100) AS "siembra",
       NULLIF(btrim("surco"::text), '')::numeric(18,3) AS "surco",
       NULLIF(btrim("golpe"::text), '')::numeric(18,3) AS "golpe",
       NULLIF(btrim("surco_2"::text), '')::numeric(18,3) AS "surco_2",
       NULLIF(btrim("area"::text), '')::numeric(18,3) AS "area",
       NULLIF(rtrim("semilla"::text), '')::varchar(50) AS "semilla",
       NULLIF(btrim("nro_semilla"::text), '')::numeric(18,3) AS "nro_semilla",
       NULLIF(btrim("densidad"::text), '')::numeric(18,3) AS "densidad"
FROM "legacy_raw"."hoja_vida"
ON CONFLICT DO NOTHING;

-- HOJA_VIDA_DETA -> ventas.hoja_vida_deta  (11 col)
INSERT INTO "ventas"."hoja_vida_deta" ("codi_hoja", "codi_deta", "diagnostico", "recomendacion", "dosis", "gasto", "gasto_agro", "gasto_total", "etapa", "fecha_prog", "fecha_vis")
SELECT
       NULLIF(btrim("codi_hoja"::text), '')::bigint AS "codi_hoja",
       NULLIF(btrim("codi_deta"::text), '')::integer AS "codi_deta",
       NULLIF(rtrim("diagnostico"::text), '')::varchar(150) AS "diagnostico",
       NULLIF(rtrim("recomendacion"::text), '')::varchar(150) AS "recomendacion",
       NULLIF(btrim("dosis"::text), '')::numeric(18,3) AS "dosis",
       NULLIF(btrim("gasto"::text), '')::numeric(18,3) AS "gasto",
       NULLIF(btrim("gasto_agro"::text), '')::numeric(18,3) AS "gasto_agro",
       NULLIF(btrim("gasto_total"::text), '')::numeric(18,3) AS "gasto_total",
       NULLIF(rtrim("etapa"::text), '')::varchar(50) AS "etapa",
       NULLIF(btrim("fecha_prog"::text), '')::timestamp(3) AS "fecha_prog",
       NULLIF(btrim("fecha_vis"::text), '')::timestamp(3) AS "fecha_vis"
FROM "legacy_raw"."hoja_vida_deta"
ON CONFLICT DO NOTHING;

-- LIQUIDACION -> ventas.liquidacion  (21 col)
INSERT INTO "ventas"."liquidacion" ("codi_liqu", "serie", "nro", "codi_trans", "gastos", "flete", "zona_part", "zona_dest", "mercaderia", "placa_tracto", "placa_carreta", "fecha_sal", "fecha_lleg", "codi_clie_prov", "nro_recibo", "total", "rendir", "combustible", "costo_comb", "saldo", "codi_orden_soli")
SELECT
       NULLIF(btrim("codi_liqu"::text), '')::bigint AS "codi_liqu",
       NULLIF(rtrim("serie"::text), '')::varchar(5) AS "serie",
       NULLIF(rtrim("nro"::text), '')::varchar(10) AS "nro",
       NULLIF(rtrim("codi_trans"::text), '')::varchar(5) AS "codi_trans",
       NULLIF(btrim("gastos"::text), '')::numeric(12,3) AS "gastos",
       NULLIF(btrim("flete"::text), '')::numeric(12,3) AS "flete",
       NULLIF(rtrim("zona_part"::text), '')::varchar(150) AS "zona_part",
       NULLIF(rtrim("zona_dest"::text), '')::varchar(150) AS "zona_dest",
       NULLIF(rtrim("mercaderia"::text), '')::varchar(150) AS "mercaderia",
       NULLIF(rtrim("placa_tracto"::text), '')::varchar(5) AS "placa_tracto",
       NULLIF(rtrim("placa_carreta"::text), '')::varchar(5) AS "placa_carreta",
       NULLIF(btrim("fecha_sal"::text), '')::timestamp(3) AS "fecha_sal",
       NULLIF(btrim("fecha_lleg"::text), '')::timestamp(3) AS "fecha_lleg",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("nro_recibo"::text), '')::varchar(10) AS "nro_recibo",
       NULLIF(btrim("total"::text), '')::numeric(12,3) AS "total",
       NULLIF(rtrim("rendir"::text), '')::varchar(1) AS "rendir",
       NULLIF(btrim("combustible"::text), '')::numeric(12,3) AS "combustible",
       NULLIF(btrim("costo_comb"::text), '')::numeric(12,3) AS "costo_comb",
       NULLIF(btrim("saldo"::text), '')::numeric(12,3) AS "saldo",
       NULLIF(btrim("codi_orden_soli"::text), '')::bigint AS "codi_orden_soli"
FROM "legacy_raw"."liquidacion"
ON CONFLICT DO NOTHING;

-- LIQUIDACION_DETA -> ventas.liquidacion_deta  (14 col)
INSERT INTO "ventas"."liquidacion_deta" ("codi_liqu", "codi_deta", "fecha", "detalle", "f", "importe", "codi_tipo_docu", "serie", "nro_docu", "tipo_contab", "codi_clie_prov", "estado", "nro_recibo", "codi_ruta")
SELECT
       NULLIF(btrim("codi_liqu"::text), '')::bigint AS "codi_liqu",
       NULLIF(btrim("codi_deta"::text), '')::integer AS "codi_deta",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("detalle"::text), '')::varchar(150) AS "detalle",
       NULLIF(rtrim("f"::text), '')::varchar(1) AS "f",
       NULLIF(btrim("importe"::text), '')::numeric(12,3) AS "importe",
       NULLIF(rtrim("codi_tipo_docu"::text), '')::varchar(4) AS "codi_tipo_docu",
       NULLIF(rtrim("serie"::text), '')::varchar(10) AS "serie",
       NULLIF(rtrim("nro_docu"::text), '')::varchar(20) AS "nro_docu",
       NULLIF(rtrim("tipo_contab"::text), '')::varchar(3) AS "tipo_contab",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("nro_recibo"::text), '')::varchar(10) AS "nro_recibo",
       NULLIF(rtrim("codi_ruta"::text), '')::varchar(5) AS "codi_ruta"
FROM "legacy_raw"."liquidacion_deta"
ON CONFLICT DO NOTHING;

-- LIQUIDACION_RUTA -> ventas.liquidacion_ruta  (11 col)
INSERT INTO "ventas"."liquidacion_ruta" ("codi_liqu", "codi_deta", "zona_part", "zona_lleg", "flete", "fecha_ini", "fecha_fin", "codi_clie_prov", "codi_orden_soli", "placa_tracto", "placa_carreta")
SELECT
       NULLIF(btrim("codi_liqu"::text), '')::bigint AS "codi_liqu",
       NULLIF(btrim("codi_deta"::text), '')::integer AS "codi_deta",
       NULLIF(rtrim("zona_part"::text), '')::varchar(255) AS "zona_part",
       NULLIF(rtrim("zona_lleg"::text), '')::varchar(255) AS "zona_lleg",
       NULLIF(btrim("flete"::text), '')::numeric(18,2) AS "flete",
       NULLIF(btrim("fecha_ini"::text), '')::timestamp(3) AS "fecha_ini",
       NULLIF(btrim("fecha_fin"::text), '')::timestamp(3) AS "fecha_fin",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("codi_orden_soli"::text), '')::bigint AS "codi_orden_soli",
       NULLIF(rtrim("placa_tracto"::text), '')::varchar(5) AS "placa_tracto",
       NULLIF(rtrim("placa_carreta"::text), '')::varchar(5) AS "placa_carreta"
FROM "legacy_raw"."liquidacion_ruta"
ON CONFLICT DO NOTHING;

-- METAS_LINEA_ROTA -> ventas.metas_linea_rota  (5 col)
INSERT INTO "ventas"."metas_linea_rota" ("cod_lin_pro", "codi_rota", "meta1", "meta2", "meta3")
SELECT
       NULLIF(rtrim("cod_lin_pro"::text), '')::varchar(2) AS "cod_lin_pro",
       NULLIF(btrim("codi_rota"::text), '')::integer AS "codi_rota",
       NULLIF(btrim("meta1"::text), '')::numeric(18,2) AS "meta1",
       NULLIF(btrim("meta2"::text), '')::numeric(18,2) AS "meta2",
       NULLIF(btrim("meta3"::text), '')::numeric(18,2) AS "meta3"
FROM "legacy_raw"."metas_linea_rota"
ON CONFLICT DO NOTHING;

-- MOTIVO_NOTA_CRED -> ventas.motivo_nota_cred  (3 col)
INSERT INTO "ventas"."motivo_nota_cred" ("id_moti", "desc_moti", "codi_sunat")
SELECT
       NULLIF(btrim("id_moti"::text), '')::integer AS "id_moti",
       NULLIF(rtrim("desc_moti"::text), '')::varchar(50) AS "desc_moti",
       NULLIF(rtrim("codi_sunat"::text), '')::varchar(2) AS "codi_sunat"
FROM "legacy_raw"."motivo_nota_cred"
ON CONFLICT DO NOTHING;

-- MOTIVO_TRASLADO -> ventas.motivo_traslado  (5 col)
INSERT INTO "ventas"."motivo_traslado" ("codi_moti_tras", "desc_moti_tras", "nemo_moti_tras", "codi_tipo_is", "codi_sunat_elec")
SELECT
       NULLIF(rtrim("codi_moti_tras"::text), '')::varchar(2) AS "codi_moti_tras",
       NULLIF(rtrim("desc_moti_tras"::text), '')::varchar(200) AS "desc_moti_tras",
       NULLIF(rtrim("nemo_moti_tras"::text), '')::varchar(30) AS "nemo_moti_tras",
       NULLIF(rtrim("codi_tipo_is"::text), '')::varchar(2) AS "codi_tipo_is",
       NULLIF(rtrim("codi_sunat_elec"::text), '')::varchar(2) AS "codi_sunat_elec"
FROM "legacy_raw"."motivo_traslado"
ON CONFLICT DO NOTHING;

-- NOTA_CREDITO -> ventas.nota_credito  (32 col)
INSERT INTO "ventas"."nota_credito" ("codi_nota_cred", "ser_nota_cred", "nro_nota_cred", "codi_clie_prov", "fech_nota_cred", "valo_vent", "igv", "prec_vent", "codi_mone", "observacion", "codi_unid_oper", "codi_sema", "codi_deta_zarp", "estado", "cuenta1", "cuenta2", "cuenta3", "contabilizado", "codi_tipo", "razon_social", "direccion", "ruc", "codi_vouc", "exonerado", "codi_fact", "codi_alma", "id_moti", "moti_otro", "tipo_oper", "fecha_elim", "motivo_elim", "tipo_impr")
SELECT
       NULLIF(rtrim("codi_nota_cred"::text), '')::varchar(10) AS "codi_nota_cred",
       NULLIF(rtrim("ser_nota_cred"::text), '')::varchar(5) AS "ser_nota_cred",
       NULLIF(rtrim("nro_nota_cred"::text), '')::varchar(10) AS "nro_nota_cred",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("fech_nota_cred"::text), '')::timestamp(3) AS "fech_nota_cred",
       NULLIF(btrim("valo_vent"::text), '')::numeric(12,3) AS "valo_vent",
       NULLIF(btrim("igv"::text), '')::numeric(12,3) AS "igv",
       NULLIF(btrim("prec_vent"::text), '')::numeric(12,3) AS "prec_vent",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("observacion"::text), '')::varchar(250) AS "observacion",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(rtrim("codi_deta_zarp"::text), '')::varchar(15) AS "codi_deta_zarp",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("cuenta1"::text), '')::varchar(7) AS "cuenta1",
       NULLIF(rtrim("cuenta2"::text), '')::varchar(7) AS "cuenta2",
       NULLIF(rtrim("cuenta3"::text), '')::varchar(7) AS "cuenta3",
       NULLIF(rtrim("contabilizado"::text), '')::varchar(1) AS "contabilizado",
       NULLIF(rtrim("codi_tipo"::text), '')::varchar(2) AS "codi_tipo",
       NULLIF(rtrim("razon_social"::text), '')::varchar(150) AS "razon_social",
       NULLIF(rtrim("direccion"::text), '')::varchar(150) AS "direccion",
       NULLIF(rtrim("ruc"::text), '')::varchar(12) AS "ruc",
       NULLIF(rtrim("codi_vouc"::text), '')::varchar(10) AS "codi_vouc",
       NULLIF(rtrim("exonerado"::text), '')::varchar(1) AS "exonerado",
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("id_moti"::text), '')::integer AS "id_moti",
       NULLIF(rtrim("moti_otro"::text), '')::varchar(50) AS "moti_otro",
       NULLIF(rtrim("tipo_oper"::text), '')::varchar(4) AS "tipo_oper",
       NULLIF(btrim("fecha_elim"::text), '')::timestamp(3) AS "fecha_elim",
       NULLIF(rtrim("motivo_elim"::text), '')::varchar(100) AS "motivo_elim",
       NULLIF(rtrim("tipo_impr"::text), '')::varchar(1) AS "tipo_impr"
FROM "legacy_raw"."nota_credito"
ON CONFLICT DO NOTHING;

-- NOTA_CREDITO_DETA -> ventas.nota_credito_deta  (10 col)
INSERT INTO "ventas"."nota_credito_deta" ("codi_nota_cred", "codi_deta", "desc_item", "codi_unid_medi", "cant_item", "prec_item", "impo_item", "codi_item", "igv", "codi_deta_fact")
SELECT
       NULLIF(rtrim("codi_nota_cred"::text), '')::varchar(10) AS "codi_nota_cred",
       NULLIF(rtrim("codi_deta"::text), '')::varchar(3) AS "codi_deta",
       NULLIF(rtrim("desc_item"::text), '')::text AS "desc_item",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(btrim("cant_item"::text), '')::numeric(12,3) AS "cant_item",
       NULLIF(btrim("prec_item"::text), '')::numeric(12,3) AS "prec_item",
       NULLIF(btrim("impo_item"::text), '')::numeric(12,3) AS "impo_item",
       NULLIF(rtrim("codi_item"::text), '')::varchar(10) AS "codi_item",
       NULLIF(btrim("igv"::text), '')::numeric(18,2) AS "igv",
       NULLIF(rtrim("codi_deta_fact"::text), '')::varchar(3) AS "codi_deta_fact"
FROM "legacy_raw"."nota_credito_deta"
ON CONFLICT DO NOTHING;

-- NOTA_DEBITO -> ventas.nota_debito  (30 col)
INSERT INTO "ventas"."nota_debito" ("codi_nota_debi", "ser_nota_debi", "nro_nota_debi", "codi_clie_prov", "fech_nota_debi", "valo_vent", "igv", "prec_vent", "codi_mone", "observacion1", "observacion2", "codi_unid_oper", "codi_sema", "codi_deta_zarp", "estado", "cuenta1", "cuenta2", "cuenta3", "contabilizado", "codi_tipo", "razon_social", "direccion", "ruc", "codi_vouc", "exonerado", "codi_alma", "codi_fact", "tipo_oper", "fecha_elim", "motivo_elim")
SELECT
       NULLIF(rtrim("codi_nota_debi"::text), '')::varchar(10) AS "codi_nota_debi",
       NULLIF(rtrim("ser_nota_debi"::text), '')::varchar(5) AS "ser_nota_debi",
       NULLIF(rtrim("nro_nota_debi"::text), '')::varchar(10) AS "nro_nota_debi",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("fech_nota_debi"::text), '')::timestamp(3) AS "fech_nota_debi",
       NULLIF(btrim("valo_vent"::text), '')::numeric(12,3) AS "valo_vent",
       NULLIF(btrim("igv"::text), '')::numeric(12,3) AS "igv",
       NULLIF(btrim("prec_vent"::text), '')::numeric(12,3) AS "prec_vent",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("observacion1"::text), '')::varchar(200) AS "observacion1",
       NULLIF(rtrim("observacion2"::text), '')::varchar(200) AS "observacion2",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(rtrim("codi_sema"::text), '')::varchar(8) AS "codi_sema",
       NULLIF(rtrim("codi_deta_zarp"::text), '')::varchar(15) AS "codi_deta_zarp",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("cuenta1"::text), '')::varchar(7) AS "cuenta1",
       NULLIF(rtrim("cuenta2"::text), '')::varchar(7) AS "cuenta2",
       NULLIF(rtrim("cuenta3"::text), '')::varchar(7) AS "cuenta3",
       NULLIF(rtrim("contabilizado"::text), '')::varchar(1) AS "contabilizado",
       NULLIF(rtrim("codi_tipo"::text), '')::varchar(2) AS "codi_tipo",
       NULLIF(rtrim("razon_social"::text), '')::varchar(150) AS "razon_social",
       NULLIF(rtrim("direccion"::text), '')::varchar(150) AS "direccion",
       NULLIF(rtrim("ruc"::text), '')::varchar(12) AS "ruc",
       NULLIF(rtrim("codi_vouc"::text), '')::varchar(10) AS "codi_vouc",
       NULLIF(rtrim("exonerado"::text), '')::varchar(1) AS "exonerado",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(rtrim("tipo_oper"::text), '')::varchar(4) AS "tipo_oper",
       NULLIF(btrim("fecha_elim"::text), '')::timestamp(3) AS "fecha_elim",
       NULLIF(rtrim("motivo_elim"::text), '')::varchar(100) AS "motivo_elim"
FROM "legacy_raw"."nota_debito"
ON CONFLICT DO NOTHING;

-- NOTA_DEBITO_DETA -> ventas.nota_debito_deta  (10 col)
INSERT INTO "ventas"."nota_debito_deta" ("codi_nota_debi", "codi_deta", "desc_item", "cant_item", "prec_item", "impo_item", "codi_unid_medi", "codi_item", "igv", "codi_deta_fact")
SELECT
       NULLIF(rtrim("codi_nota_debi"::text), '')::varchar(10) AS "codi_nota_debi",
       NULLIF(rtrim("codi_deta"::text), '')::varchar(3) AS "codi_deta",
       NULLIF(rtrim("desc_item"::text), '')::text AS "desc_item",
       NULLIF(btrim("cant_item"::text), '')::numeric(12,3) AS "cant_item",
       NULLIF(btrim("prec_item"::text), '')::numeric(12,3) AS "prec_item",
       NULLIF(btrim("impo_item"::text), '')::numeric(12,3) AS "impo_item",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(rtrim("codi_item"::text), '')::varchar(10) AS "codi_item",
       NULLIF(btrim("igv"::text), '')::numeric(18,2) AS "igv",
       NULLIF(rtrim("codi_deta_fact"::text), '')::varchar(3) AS "codi_deta_fact"
FROM "legacy_raw"."nota_debito_deta"
ON CONFLICT DO NOTHING;

-- NOTA_VENTA -> ventas.nota_venta  (28 col)
INSERT INTO "ventas"."nota_venta" ("codi_nota_venta", "codi_alma", "nro_nota_venta", "codi_clie_prov", "fecha", "codi_mone", "tcambio", "creacion", "codi_tipo_pago", "tipo_credito", "codi_usua", "cod_imp", "cod_siembra", "cod_cultivo", "cod_zona", "cod_usua_recetista", "hectarea", "nro_dias", "fec_pago", "venc_fact", "codi_fact", "valor_igv", "valo_fact", "subtota_fact", "igv_fact", "tota_exonerado", "tota_fact", "estado")
SELECT
       NULLIF(btrim("codi_nota_venta"::text), '')::bigint AS "codi_nota_venta",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("nro_nota_venta"::text), '')::bigint AS "nro_nota_venta",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("tcambio"::text), '')::numeric(19,4) AS "tcambio",
       NULLIF(btrim("creacion"::text), '')::timestamp(3) AS "creacion",
       NULLIF(btrim("codi_tipo_pago"::text), '')::integer AS "codi_tipo_pago",
       NULLIF(btrim("tipo_credito"::text), '')::smallint AS "tipo_credito",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(btrim("cod_imp"::text), '')::integer AS "cod_imp",
       NULLIF(btrim("cod_siembra"::text), '')::bigint AS "cod_siembra",
       NULLIF(btrim("cod_cultivo"::text), '')::integer AS "cod_cultivo",
       NULLIF(btrim("cod_zona"::text), '')::bigint AS "cod_zona",
       NULLIF(rtrim("cod_usua_recetista"::text), '')::varchar(5) AS "cod_usua_recetista",
       NULLIF(btrim("hectarea"::text), '')::numeric(18,3) AS "hectarea",
       NULLIF(btrim("nro_dias"::text), '')::integer AS "nro_dias",
       NULLIF(btrim("fec_pago"::text), '')::timestamp(3) AS "fec_pago",
       NULLIF(btrim("venc_fact"::text), '')::timestamp(3) AS "venc_fact",
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(btrim("valor_igv"::text), '')::numeric(12,2) AS "valor_igv",
       NULLIF(btrim("valo_fact"::text), '')::numeric(12,3) AS "valo_fact",
       NULLIF(btrim("subtota_fact"::text), '')::numeric(19,4) AS "subtota_fact",
       NULLIF(btrim("igv_fact"::text), '')::numeric(12,3) AS "igv_fact",
       NULLIF(btrim("tota_exonerado"::text), '')::numeric(19,4) AS "tota_exonerado",
       NULLIF(btrim("tota_fact"::text), '')::numeric(12,3) AS "tota_fact",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado"
FROM "legacy_raw"."nota_venta"
ON CONFLICT DO NOTHING;

-- NOTA_VENTA_DETALLE -> ventas.nota_venta_detalle  (14 col)
INSERT INTO "ventas"."nota_venta_detalle" ("codi_nota_venta", "id_sec", "codi_prod", "cantidad", "prec_item", "prec_lista", "dscto_prec", "dscto_item", "impo_item", "igv", "codi_alma", "codi_imp", "desc_item", "prec_costo")
SELECT
       NULLIF(btrim("codi_nota_venta"::text), '')::bigint AS "codi_nota_venta",
       NULLIF(btrim("id_sec"::text), '')::bigint AS "id_sec",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,4) AS "cantidad",
       NULLIF(btrim("prec_item"::text), '')::numeric(12,4) AS "prec_item",
       NULLIF(btrim("prec_lista"::text), '')::numeric(19,4) AS "prec_lista",
       NULLIF(btrim("dscto_prec"::text), '')::numeric(19,4) AS "dscto_prec",
       NULLIF(btrim("dscto_item"::text), '')::numeric(19,4) AS "dscto_item",
       NULLIF(btrim("impo_item"::text), '')::numeric(12,3) AS "impo_item",
       NULLIF(btrim("igv"::text), '')::numeric(18,3) AS "igv",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("codi_imp"::text), '')::integer AS "codi_imp",
       NULLIF(rtrim("desc_item"::text), '')::varchar(150) AS "desc_item",
       NULLIF(btrim("prec_costo"::text), '')::numeric(19,4) AS "prec_costo"
FROM "legacy_raw"."nota_venta_detalle"
ON CONFLICT DO NOTHING;

-- ORDEN_SOLICITUD_SERVICIO -> ventas.orden_solicitud_servicio  (15 col)
INSERT INTO "ventas"."orden_solicitud_servicio" ("codi_orden_soli", "nro_orden_soli", "codi_clie_prov", "codi_ruta", "contacto", "telefono", "fecha", "condicion", "codi_aux", "facturado", "responsable", "flete", "igv", "codi_mone", "tipo")
SELECT
       NULLIF(btrim("codi_orden_soli"::text), '')::bigint AS "codi_orden_soli",
       NULLIF(btrim("nro_orden_soli"::text), '')::bigint AS "nro_orden_soli",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(rtrim("codi_ruta"::text), '')::varchar(5) AS "codi_ruta",
       NULLIF(rtrim("contacto"::text), '')::varchar(150) AS "contacto",
       NULLIF(rtrim("telefono"::text), '')::varchar(20) AS "telefono",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("condicion"::text), '')::varchar(1) AS "condicion",
       NULLIF(btrim("codi_aux"::text), '')::bigint AS "codi_aux",
       NULLIF(rtrim("facturado"::text), '')::varchar(1) AS "facturado",
       NULLIF(rtrim("responsable"::text), '')::varchar(5) AS "responsable",
       NULLIF(btrim("flete"::text), '')::numeric(18,2) AS "flete",
       NULLIF(btrim("igv"::text), '')::numeric(18,2) AS "igv",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo"
FROM "legacy_raw"."orden_solicitud_servicio"
ON CONFLICT DO NOTHING;

-- ORDEN_SOLICITUD_SERVICIO_DETA -> ventas.orden_solicitud_servicio_deta  (13 col)
INSERT INTO "ventas"."orden_solicitud_servicio_deta" ("codi_orden_soli", "codi_deta", "codi_tracto", "codi_carreta", "codi_trans", "codi_carga", "cantidad", "codi_unid_medi", "precio", "estado", "observacion", "importe", "id_guia")
SELECT
       NULLIF(btrim("codi_orden_soli"::text), '')::bigint AS "codi_orden_soli",
       NULLIF(btrim("codi_deta"::text), '')::bigint AS "codi_deta",
       NULLIF(rtrim("codi_tracto"::text), '')::varchar(5) AS "codi_tracto",
       NULLIF(rtrim("codi_carreta"::text), '')::varchar(5) AS "codi_carreta",
       NULLIF(rtrim("codi_trans"::text), '')::varchar(4) AS "codi_trans",
       NULLIF(rtrim("codi_carga"::text), '')::varchar(4) AS "codi_carga",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,2) AS "cantidad",
       NULLIF(rtrim("codi_unid_medi"::text), '')::varchar(2) AS "codi_unid_medi",
       NULLIF(btrim("precio"::text), '')::numeric(18,2) AS "precio",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("observacion"::text), '')::varchar(150) AS "observacion",
       NULLIF(btrim("importe"::text), '')::numeric(18,2) AS "importe",
       NULLIF(btrim("id_guia"::text), '')::bigint AS "id_guia"
FROM "legacy_raw"."orden_solicitud_servicio_deta"
ON CONFLICT DO NOTHING;

-- PLAN_MARKETING -> ventas.plan_marketing  (10 col)
INSERT INTO "ventas"."plan_marketing" ("codi_plan", "codi_alma", "mes", "sem1", "sem2", "sem3", "sem4", "codi_usua", "registro", "fecha")
SELECT
       NULLIF(btrim("codi_plan"::text), '')::bigint AS "codi_plan",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("mes"::text), '')::varchar(2) AS "mes",
       NULLIF(rtrim("sem1"::text), '')::varchar(8) AS "sem1",
       NULLIF(rtrim("sem2"::text), '')::varchar(8) AS "sem2",
       NULLIF(rtrim("sem3"::text), '')::varchar(8) AS "sem3",
       NULLIF(rtrim("sem4"::text), '')::varchar(8) AS "sem4",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(rtrim("registro"::text), '')::varchar(150) AS "registro",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha"
FROM "legacy_raw"."plan_marketing"
ON CONFLICT DO NOTHING;

-- Producto_Comision -> ventas.producto_comision  (7 col)
INSERT INTO "ventas"."producto_comision" ("id_comi_prod", "codi_prod", "desc_prod", "comision", "inicio", "fin", "codi_depen")
SELECT
       NULLIF(btrim("id_comi_prod"::text), '')::bigint AS "id_comi_prod",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("desc_prod"::text), '')::varchar(200) AS "desc_prod",
       NULLIF(btrim("comision"::text), '')::numeric(18,2) AS "comision",
       NULLIF(btrim("inicio"::text), '')::numeric(18,2) AS "inicio",
       NULLIF(btrim("fin"::text), '')::numeric(18,2) AS "fin",
       NULLIF(rtrim("codi_depen"::text), '')::varchar(8) AS "codi_depen"
FROM "legacy_raw"."producto_comision"
ON CONFLICT DO NOTHING;

-- PRODUCTOS_OFERTAS -> ventas.productos_ofertas  (11 col)
INSERT INTO "ventas"."productos_ofertas" ("item", "codi_prod", "cantidad", "precio", "fecha_ini", "fecha_fin", "estado", "codi_alma", "codi_mone", "usado", "precio_costo")
SELECT
       NULLIF(btrim("item"::text), '')::bigint AS "item",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,2) AS "cantidad",
       NULLIF(btrim("precio"::text), '')::numeric(18,4) AS "precio",
       NULLIF(btrim("fecha_ini"::text), '')::timestamp(3) AS "fecha_ini",
       NULLIF(btrim("fecha_fin"::text), '')::timestamp(3) AS "fecha_fin",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("usado"::text), '')::numeric(12,4) AS "usado",
       NULLIF(btrim("precio_costo"::text), '')::numeric(12,4) AS "precio_costo"
FROM "legacy_raw"."productos_ofertas"
ON CONFLICT DO NOTHING;

-- RECOMENDACION -> ventas.recomendacion  (4 col)
INSERT INTO "ventas"."recomendacion" ("codi_rec", "diagnostico", "recomendacion", "nro_rec")
SELECT
       NULLIF(btrim("codi_rec"::text), '')::bigint AS "codi_rec",
       NULLIF(rtrim("diagnostico"::text), '')::varchar(250) AS "diagnostico",
       NULLIF(rtrim("recomendacion"::text), '')::varchar(250) AS "recomendacion",
       NULLIF(btrim("nro_rec"::text), '')::bigint AS "nro_rec"
FROM "legacy_raw"."recomendacion"
ON CONFLICT DO NOTHING;

-- RECOMENDACION_DETA -> ventas.recomendacion_deta  (9 col)
INSERT INTO "ventas"."recomendacion_deta" ("codi_rec", "codi_deta", "codi_prod", "dosis", "descripcion", "dosis_cant", "prec_espe", "cant_unidad", "total_val")
SELECT
       NULLIF(btrim("codi_rec"::text), '')::bigint AS "codi_rec",
       NULLIF(btrim("codi_deta"::text), '')::bigint AS "codi_deta",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(rtrim("dosis"::text), '')::varchar(100) AS "dosis",
       NULLIF(rtrim("descripcion"::text), '')::varchar(100) AS "descripcion",
       NULLIF(btrim("dosis_cant"::text), '')::numeric(18,2) AS "dosis_cant",
       NULLIF(btrim("prec_espe"::text), '')::numeric(18,2) AS "prec_espe",
       NULLIF(btrim("cant_unidad"::text), '')::numeric(12,3) AS "cant_unidad",
       NULLIF(btrim("total_val"::text), '')::numeric(12,2) AS "total_val"
FROM "legacy_raw"."recomendacion_deta"
ON CONFLICT DO NOTHING;

-- REGISTRO_VALE -> ventas.registro_vale  (28 col)
INSERT INTO "ventas"."registro_vale" ("codi_vale", "codi_alma", "nro_vale", "codi_clie_prov", "fecha", "codi_mone", "tcambio", "creacion", "codi_tipo_pago", "tipo_credito", "codi_usua", "cod_imp", "cod_siembra", "cod_cultivo", "cod_zona", "cod_usua_recetista", "hectarea", "nro_dias", "fec_pago", "venc_fact", "codi_fact", "valor_igv", "valo_fact", "subtota_fact", "igv_fact", "tota_exonerado", "tota_fact", "estado")
SELECT
       NULLIF(btrim("codi_vale"::text), '')::bigint AS "codi_vale",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("nro_vale"::text), '')::bigint AS "nro_vale",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone",
       NULLIF(btrim("tcambio"::text), '')::numeric(19,4) AS "tcambio",
       NULLIF(btrim("creacion"::text), '')::timestamp(3) AS "creacion",
       NULLIF(btrim("codi_tipo_pago"::text), '')::integer AS "codi_tipo_pago",
       NULLIF(btrim("tipo_credito"::text), '')::smallint AS "tipo_credito",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(btrim("cod_imp"::text), '')::integer AS "cod_imp",
       NULLIF(btrim("cod_siembra"::text), '')::bigint AS "cod_siembra",
       NULLIF(btrim("cod_cultivo"::text), '')::integer AS "cod_cultivo",
       NULLIF(btrim("cod_zona"::text), '')::bigint AS "cod_zona",
       NULLIF(rtrim("cod_usua_recetista"::text), '')::varchar(5) AS "cod_usua_recetista",
       NULLIF(btrim("hectarea"::text), '')::numeric(18,3) AS "hectarea",
       NULLIF(btrim("nro_dias"::text), '')::integer AS "nro_dias",
       NULLIF(btrim("fec_pago"::text), '')::timestamp(3) AS "fec_pago",
       NULLIF(btrim("venc_fact"::text), '')::timestamp(3) AS "venc_fact",
       NULLIF(rtrim("codi_fact"::text), '')::varchar(10) AS "codi_fact",
       NULLIF(btrim("valor_igv"::text), '')::numeric(12,2) AS "valor_igv",
       NULLIF(btrim("valo_fact"::text), '')::numeric(12,3) AS "valo_fact",
       NULLIF(btrim("subtota_fact"::text), '')::numeric(19,4) AS "subtota_fact",
       NULLIF(btrim("igv_fact"::text), '')::numeric(12,3) AS "igv_fact",
       NULLIF(btrim("tota_exonerado"::text), '')::numeric(19,4) AS "tota_exonerado",
       NULLIF(btrim("tota_fact"::text), '')::numeric(12,3) AS "tota_fact",
       NULLIF(rtrim("estado"::text), '')::varchar(1) AS "estado"
FROM "legacy_raw"."registro_vale"
ON CONFLICT DO NOTHING;

-- REGISTRO_VALE_DETALLE -> ventas.registro_vale_detalle  (14 col)
INSERT INTO "ventas"."registro_vale_detalle" ("codi_vale", "id_sec", "codi_prod", "cantidad", "prec_item", "prec_lista", "dscto_prec", "dscto_item", "impo_item", "igv", "codi_alma", "codi_imp", "desc_item", "prec_costo")
SELECT
       NULLIF(btrim("codi_vale"::text), '')::bigint AS "codi_vale",
       NULLIF(btrim("id_sec"::text), '')::bigint AS "id_sec",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(18,4) AS "cantidad",
       NULLIF(btrim("prec_item"::text), '')::numeric(12,4) AS "prec_item",
       NULLIF(btrim("prec_lista"::text), '')::numeric(19,4) AS "prec_lista",
       NULLIF(btrim("dscto_prec"::text), '')::numeric(19,4) AS "dscto_prec",
       NULLIF(btrim("dscto_item"::text), '')::numeric(19,4) AS "dscto_item",
       NULLIF(btrim("impo_item"::text), '')::numeric(12,3) AS "impo_item",
       NULLIF(btrim("igv"::text), '')::numeric(18,3) AS "igv",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("codi_imp"::text), '')::integer AS "codi_imp",
       NULLIF(rtrim("desc_item"::text), '')::varchar(150) AS "desc_item",
       NULLIF(btrim("prec_costo"::text), '')::numeric(19,4) AS "prec_costo"
FROM "legacy_raw"."registro_vale_detalle"
ON CONFLICT DO NOTHING;

-- ROTACION -> ventas.rotacion  (9 col)
INSERT INTO "ventas"."rotacion" ("codi_rota", "codi_prod", "cantidad", "lote", "fecha", "tipo", "codi_alma", "fecha_venc", "observaciones")
SELECT
       NULLIF(btrim("codi_rota"::text), '')::bigint AS "codi_rota",
       NULLIF(rtrim("codi_prod"::text), '')::varchar(8) AS "codi_prod",
       NULLIF(btrim("cantidad"::text), '')::numeric(12,2) AS "cantidad",
       NULLIF(rtrim("lote"::text), '')::varchar(150) AS "lote",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(btrim("fecha_venc"::text), '')::timestamp(3) AS "fecha_venc",
       NULLIF(rtrim("observaciones"::text), '')::varchar(255) AS "observaciones"
FROM "legacy_raw"."rotacion"
ON CONFLICT DO NOTHING;

-- RUTA -> ventas.ruta  (12 col)
INSERT INTO "ventas"."ruta" ("codi_ruta", "zona", "dia_l", "dia_m", "dia_mc", "dia_j", "dia_v", "dia_sa", "codi_usua", "fecha", "fecha_sal", "codi_alma")
SELECT
       NULLIF(btrim("codi_ruta"::text), '')::bigint AS "codi_ruta",
       NULLIF(rtrim("zona"::text), '')::varchar(150) AS "zona",
       NULLIF(rtrim("dia_l"::text), '')::varchar(150) AS "dia_l",
       NULLIF(rtrim("dia_m"::text), '')::varchar(150) AS "dia_m",
       NULLIF(rtrim("dia_mc"::text), '')::varchar(150) AS "dia_mc",
       NULLIF(rtrim("dia_j"::text), '')::varchar(150) AS "dia_j",
       NULLIF(rtrim("dia_v"::text), '')::varchar(150) AS "dia_v",
       NULLIF(rtrim("dia_sa"::text), '')::varchar(150) AS "dia_sa",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(btrim("fecha_sal"::text), '')::timestamp(3) AS "fecha_sal",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma"
FROM "legacy_raw"."ruta"
ON CONFLICT DO NOTHING;

-- RUTA_ORDEN -> ventas.ruta_orden  (8 col)
INSERT INTO "ventas"."ruta_orden" ("codi_ruta", "descripcion", "destino", "distancia", "origen", "codi_ori", "codi_des", "valor")
SELECT
       NULLIF(rtrim("codi_ruta"::text), '')::varchar(5) AS "codi_ruta",
       NULLIF(rtrim("descripcion"::text), '')::varchar(150) AS "descripcion",
       NULLIF(rtrim("destino"::text), '')::varchar(150) AS "destino",
       NULLIF(btrim("distancia"::text), '')::numeric(18,2) AS "distancia",
       NULLIF(rtrim("origen"::text), '')::varchar(150) AS "origen",
       NULLIF(btrim("codi_ori"::text), '')::integer AS "codi_ori",
       NULLIF(btrim("codi_des"::text), '')::integer AS "codi_des",
       NULLIF(btrim("valor"::text), '')::numeric(18,2) AS "valor"
FROM "legacy_raw"."ruta_orden"
ON CONFLICT DO NOTHING;

-- RUTA_SEMANAL -> ventas.ruta_semanal  (11 col)
INSERT INTO "ventas"."ruta_semanal" ("codi_ruta", "zona", "cliente", "cultivo", "area", "etapa", "observacion", "codi_usua", "fecha", "codi_alma", "zona_aux")
SELECT
       NULLIF(btrim("codi_ruta"::text), '')::bigint AS "codi_ruta",
       NULLIF(rtrim("zona"::text), '')::varchar(150) AS "zona",
       NULLIF(rtrim("cliente"::text), '')::varchar(150) AS "cliente",
       NULLIF(rtrim("cultivo"::text), '')::varchar(150) AS "cultivo",
       NULLIF(rtrim("area"::text), '')::varchar(150) AS "area",
       NULLIF(rtrim("etapa"::text), '')::varchar(150) AS "etapa",
       NULLIF(rtrim("observacion"::text), '')::varchar(150) AS "observacion",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("zona_aux"::text), '')::varchar(150) AS "zona_aux"
FROM "legacy_raw"."ruta_semanal"
ON CONFLICT DO NOTHING;

-- SIEMBRAS -> ventas.siembras  (26 col)
INSERT INTO "ventas"."siembras" ("codi_siembra", "codi_clie_prov", "fec_siembra", "fec_estima_termi", "fec_termino", "nro_hecta", "cod_cultivo", "cod_zona", "ubicacion", "observa", "terreno", "textsuelo", "triego", "cvecinos", "credsoc", "expcult", "asestecn", "edadcult", "relacomerc", "prodhect", "preccult", "utilbruta", "utilneta", "gastos", "comprador", "codi_mone")
SELECT
       NULLIF(btrim("codi_siembra"::text), '')::bigint AS "codi_siembra",
       NULLIF(rtrim("codi_clie_prov"::text), '')::varchar(5) AS "codi_clie_prov",
       NULLIF(btrim("fec_siembra"::text), '')::timestamp(3) AS "fec_siembra",
       NULLIF(btrim("fec_estima_termi"::text), '')::timestamp(3) AS "fec_estima_termi",
       NULLIF(btrim("fec_termino"::text), '')::timestamp(3) AS "fec_termino",
       NULLIF(btrim("nro_hecta"::text), '')::numeric(18,2) AS "nro_hecta",
       NULLIF(btrim("cod_cultivo"::text), '')::integer AS "cod_cultivo",
       NULLIF(btrim("cod_zona"::text), '')::bigint AS "cod_zona",
       NULLIF(rtrim("ubicación"::text), '')::varchar(100) AS "ubicacion",
       NULLIF(rtrim("observa"::text), '')::varchar(100) AS "observa",
       NULLIF(rtrim("terreno"::text), '')::varchar(50) AS "terreno",
       NULLIF(rtrim("textsuelo"::text), '')::varchar(100) AS "textsuelo",
       NULLIF(rtrim("triego"::text), '')::varchar(50) AS "triego",
       NULLIF(rtrim("cvecinos"::text), '')::varchar(255) AS "cvecinos",
       NULLIF(btrim("credsoc"::text), '')::boolean AS "credsoc",
       NULLIF(btrim("expcult"::text), '')::numeric(18,2) AS "expcult",
       NULLIF(rtrim("asestecn"::text), '')::varchar(50) AS "asestecn",
       NULLIF(btrim("edadcult"::text), '')::numeric(18,2) AS "edadcult",
       NULLIF(rtrim("relacomerc"::text), '')::varchar(150) AS "relacomerc",
       NULLIF(btrim("prodhect"::text), '')::numeric(18,2) AS "prodhect",
       NULLIF(btrim("preccult"::text), '')::numeric(18,4) AS "preccult",
       NULLIF(btrim("utilbruta"::text), '')::numeric(18,2) AS "utilbruta",
       NULLIF(btrim("utilneta"::text), '')::numeric(18,2) AS "utilneta",
       NULLIF(btrim("gastos"::text), '')::numeric(18,2) AS "gastos",
       NULLIF(rtrim("comprador"::text), '')::varchar(150) AS "comprador",
       NULLIF(rtrim("codi_mone"::text), '')::varchar(2) AS "codi_mone"
FROM "legacy_raw"."siembras"
ON CONFLICT DO NOTHING;

-- TIPO_CARGA -> ventas.tipo_carga  (2 col)
INSERT INTO "ventas"."tipo_carga" ("codi_carga", "descripcion")
SELECT
       NULLIF(rtrim("codi_carga"::text), '')::varchar(4) AS "codi_carga",
       NULLIF(rtrim("descripcion"::text), '')::varchar(150) AS "descripcion"
FROM "legacy_raw"."tipo_carga"
ON CONFLICT DO NOTHING;

-- TIPO_COMISION -> ventas.tipo_comision  (3 col)
INSERT INTO "ventas"."tipo_comision" ("id_tipocomi", "desc_tipocomi", "porcentaje")
SELECT
       NULLIF(btrim("id_tipocomi"::text), '')::integer AS "id_tipocomi",
       NULLIF(rtrim("desc_tipocomi"::text), '')::varchar(50) AS "desc_tipocomi",
       NULLIF(btrim("porcentaje"::text), '')::numeric(18,2) AS "porcentaje"
FROM "legacy_raw"."tipo_comision"
ON CONFLICT DO NOTHING;

-- Tipo_Factura -> ventas.tipo_factura  (3 col)
INSERT INTO "ventas"."tipo_factura" ("codi_tipo", "descrip", "tipo")
SELECT
       NULLIF(rtrim("codi_tipo"::text), '')::varchar(2) AS "codi_tipo",
       NULLIF(rtrim("descrip"::text), '')::varchar(30) AS "descrip",
       NULLIF(rtrim("tipo"::text), '')::varchar(1) AS "tipo"
FROM "legacy_raw"."tipo_factura"
ON CONFLICT DO NOTHING;

-- TIPO_NOTAS -> ventas.tipo_notas  (2 col)
INSERT INTO "ventas"."tipo_notas" ("codi_tipo", "descrip")
SELECT
       NULLIF(rtrim("codi_tipo"::text), '')::varchar(2) AS "codi_tipo",
       NULLIF(rtrim("descrip"::text), '')::varchar(50) AS "descrip"
FROM "legacy_raw"."tipo_notas"
ON CONFLICT DO NOTHING;

-- UBICACION -> ventas.ubicacion  (7 col)
INSERT INTO "ventas"."ubicacion" ("codi_ubi", "codi_alma", "zona", "sector", "subsector", "fecha", "codi_usua")
SELECT
       NULLIF(btrim("codi_ubi"::text), '')::bigint AS "codi_ubi",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma",
       NULLIF(rtrim("zona"::text), '')::varchar(150) AS "zona",
       NULLIF(rtrim("sector"::text), '')::varchar(250) AS "sector",
       NULLIF(rtrim("subsector"::text), '')::varchar(250) AS "subsector",
       NULLIF(btrim("fecha"::text), '')::timestamp(3) AS "fecha",
       NULLIF(rtrim("codi_usua"::text), '')::varchar(5) AS "codi_usua"
FROM "legacy_raw"."ubicacion"
ON CONFLICT DO NOTHING;

-- Unidad_transporte -> ventas.unidad_transporte  (31 col)
INSERT INTO "ventas"."unidad_transporte" ("codi_unid_tran", "desc_unid_tran", "marc_unid_tran", "plac_unid_tran", "cert_unid_tran", "colo_unid_tran", "lice_unid_trans", "mot_unid_tran", "anio_unid_tran", "cod_tran_unid_tran", "codi_tipo", "nro_plac_remo", "apel_1_chof", "apel_2_chof", "nomb_1_chof", "nomb_2_chof", "lice_cond_chof", "dni_chof", "inte_exte", "codi_unid_oper", "capacidad", "id_conf", "codi_carreta", "codi_trans", "codi_tracto", "tipo_unidad", "permiso", "soat_ini", "soat_fin", "codi_prop", "codi_alma")
SELECT
       NULLIF(rtrim("codi_unid_tran"::text), '')::varchar(4) AS "codi_unid_tran",
       NULLIF(rtrim("desc_unid_tran"::text), '')::varchar(100) AS "desc_unid_tran",
       NULLIF(rtrim("marc_unid_tran"::text), '')::varchar(20) AS "marc_unid_tran",
       NULLIF(rtrim("plac_unid_tran"::text), '')::varchar(10) AS "plac_unid_tran",
       NULLIF(rtrim("cert_unid_tran"::text), '')::varchar(12) AS "cert_unid_tran",
       NULLIF(rtrim("colo_unid_tran"::text), '')::varchar(10) AS "colo_unid_tran",
       NULLIF(rtrim("lice_unid_trans"::text), '')::varchar(20) AS "lice_unid_trans",
       NULLIF(rtrim("mot_unid_tran"::text), '')::varchar(20) AS "mot_unid_tran",
       NULLIF(rtrim("anio_unid_tran"::text), '')::varchar(4) AS "anio_unid_tran",
       NULLIF(rtrim("cod_tran_unid_tran"::text), '')::varchar(10) AS "cod_tran_unid_tran",
       NULLIF(rtrim("codi_tipo"::text), '')::varchar(1) AS "codi_tipo",
       NULLIF(rtrim("nro_plac_remo"::text), '')::varchar(20) AS "nro_plac_remo",
       NULLIF(rtrim("apel_1_chof"::text), '')::varchar(30) AS "apel_1_chof",
       NULLIF(rtrim("apel_2_chof"::text), '')::varchar(30) AS "apel_2_chof",
       NULLIF(rtrim("nomb_1_chof"::text), '')::varchar(30) AS "nomb_1_chof",
       NULLIF(rtrim("nomb_2_chof"::text), '')::varchar(30) AS "nomb_2_chof",
       NULLIF(rtrim("lice_cond_chof"::text), '')::varchar(20) AS "lice_cond_chof",
       NULLIF(rtrim("dni_chof"::text), '')::varchar(20) AS "dni_chof",
       NULLIF(rtrim("inte_exte"::text), '')::varchar(1) AS "inte_exte",
       NULLIF(rtrim("codi_unid_oper"::text), '')::varchar(5) AS "codi_unid_oper",
       NULLIF(btrim("capacidad"::text), '')::numeric(18,2) AS "capacidad",
       NULLIF(btrim("id_conf"::text), '')::integer AS "id_conf",
       NULLIF(rtrim("codi_carreta"::text), '')::varchar(5) AS "codi_carreta",
       NULLIF(rtrim("codi_trans"::text), '')::varchar(4) AS "codi_trans",
       NULLIF(rtrim("codi_tracto"::text), '')::varchar(5) AS "codi_tracto",
       NULLIF(rtrim("tipo_unidad"::text), '')::varchar(50) AS "tipo_unidad",
       NULLIF(rtrim("permiso"::text), '')::varchar(1) AS "permiso",
       NULLIF(btrim("soat_ini"::text), '')::timestamp(3) AS "soat_ini",
       NULLIF(btrim("soat_fin"::text), '')::timestamp(3) AS "soat_fin",
       NULLIF(rtrim("codi_prop"::text), '')::varchar(5) AS "codi_prop",
       NULLIF(rtrim("codi_alma"::text), '')::varchar(2) AS "codi_alma"
FROM "legacy_raw"."unidad_transporte"
ON CONFLICT DO NOTHING;

-- vale_CREDITO -> ventas.vale_credito  (3 col)
INSERT INTO "ventas"."vale_credito" ("codi_vale", "codi_credito", "monto")
SELECT
       NULLIF(btrim("codi_vale"::text), '')::bigint AS "codi_vale",
       NULLIF(btrim("codi_credito"::text), '')::bigint AS "codi_credito",
       NULLIF(btrim("monto"::text), '')::numeric(19,4) AS "monto"
FROM "legacy_raw"."vale_credito"
ON CONFLICT DO NOTHING;

-- reajuste de secuencias de identidad del legado
SELECT setval(pg_get_serial_sequence('"ventas"."cliente_vendedor"', 'id_clie_vende'),
              (SELECT COALESCE(MAX("id_clie_vende"), 1) FROM "ventas"."cliente_vendedor"),
              (SELECT COUNT(*) > 0 FROM "ventas"."cliente_vendedor"));
SELECT setval(pg_get_serial_sequence('"ventas"."comisiones"', 'id_comi'),
              (SELECT COALESCE(MAX("id_comi"), 1) FROM "ventas"."comisiones"),
              (SELECT COUNT(*) > 0 FROM "ventas"."comisiones"));
SELECT setval(pg_get_serial_sequence('"ventas"."creditos_detalle"', 'codi_deta'),
              (SELECT COALESCE(MAX("codi_deta"), 1) FROM "ventas"."creditos_detalle"),
              (SELECT COUNT(*) > 0 FROM "ventas"."creditos_detalle"));
SELECT setval(pg_get_serial_sequence('"ventas"."producto_comision"', 'id_comi_prod'),
              (SELECT COALESCE(MAX("id_comi_prod"), 1) FROM "ventas"."producto_comision"),
              (SELECT COUNT(*) > 0 FROM "ventas"."producto_comision"));

COMMIT;
