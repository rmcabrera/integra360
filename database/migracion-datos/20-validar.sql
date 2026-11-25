-- Generado por tools/db-migrator/src/gen-data-migration.js a partir de
-- database/catalogo/mapeo-columnas.json. No editar a mano: regenerar con el script.
-- =====================================================================
-- 1) Comparacion de conteo de filas legacy_raw vs destino.
--    'diferencia' = destino - legacy. 0 = carga completa (si no hay duplicados
--    descartados por ON CONFLICT). Un valor negativo indica filas no migradas.
-- =====================================================================
SELECT 'contabilidad.activos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."activos") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."activos") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."activos") - (SELECT count(*) FROM "legacy_raw"."activos") AS diferencia
UNION ALL
SELECT 'contabilidad.activos_centros' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."activos_centros") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."activos_centros") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."activos_centros") - (SELECT count(*) FROM "legacy_raw"."activos_centros") AS diferencia
UNION ALL
SELECT 'contabilidad.agrupaciones' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."agrupaciones") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."agrupaciones") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."agrupaciones") - (SELECT count(*) FROM "legacy_raw"."agrupaciones") AS diferencia
UNION ALL
SELECT 'contabilidad.bien_servicio' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."bien_servicio") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."bien_servicio") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."bien_servicio") - (SELECT count(*) FROM "legacy_raw"."bien_servicio") AS diferencia
UNION ALL
SELECT 'contabilidad.cabecera_detraccion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cabecera_detraccion") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."cabecera_detraccion") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."cabecera_detraccion") - (SELECT count(*) FROM "legacy_raw"."cabecera_detraccion") AS diferencia
UNION ALL
SELECT 'contabilidad.catalmae' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."catalmae") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."catalmae") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."catalmae") - (SELECT count(*) FROM "legacy_raw"."catalmae") AS diferencia
UNION ALL
SELECT 'contabilidad.centro_costo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."centro_costo") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."centro_costo") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."centro_costo") - (SELECT count(*) FROM "legacy_raw"."centro_costo") AS diferencia
UNION ALL
SELECT 'contabilidad.clase' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."clase") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."clase") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."clase") - (SELECT count(*) FROM "legacy_raw"."clase") AS diferencia
UNION ALL
SELECT 'contabilidad.clases_cuentas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."clases_cuentas") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."clases_cuentas") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."clases_cuentas") - (SELECT count(*) FROM "legacy_raw"."clases_cuentas") AS diferencia
UNION ALL
SELECT 'contabilidad.coef_liqu_imp' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."coef_liqu_imp") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."coef_liqu_imp") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."coef_liqu_imp") - (SELECT count(*) FROM "legacy_raw"."coef_liqu_imp") AS diferencia
UNION ALL
SELECT 'contabilidad.concepto_balance' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."concepto_balance") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."concepto_balance") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."concepto_balance") - (SELECT count(*) FROM "legacy_raw"."concepto_balance") AS diferencia
UNION ALL
SELECT 'contabilidad.concepto_sunat' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."concepto_sunat") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."concepto_sunat") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."concepto_sunat") - (SELECT count(*) FROM "legacy_raw"."concepto_sunat") AS diferencia
UNION ALL
SELECT 'contabilidad.contabilizacion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."contabilizacion") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."contabilizacion") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."contabilizacion") - (SELECT count(*) FROM "legacy_raw"."contabilizacion") AS diferencia
UNION ALL
SELECT 'contabilidad.costo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."costo") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."costo") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."costo") - (SELECT count(*) FROM "legacy_raw"."costo") AS diferencia
UNION ALL
SELECT 'contabilidad.cuen_x_tipo_cost' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cuen_x_tipo_cost") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."cuen_x_tipo_cost") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."cuen_x_tipo_cost") - (SELECT count(*) FROM "legacy_raw"."cuen_x_tipo_cost") AS diferencia
UNION ALL
SELECT 'contabilidad.cuentas_activos_prov' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cuentas_activos_prov") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."cuentas_activos_prov") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."cuentas_activos_prov") - (SELECT count(*) FROM "legacy_raw"."cuentas_activos_prov") AS diferencia
UNION ALL
SELECT 'contabilidad.cuentas_contable' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cuentas_contable") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."cuentas_contable") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."cuentas_contable") - (SELECT count(*) FROM "legacy_raw"."cuentas_contable") AS diferencia
UNION ALL
SELECT 'contabilidad.cuentas_costo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cuentas_costo") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."cuentas_costo") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."cuentas_costo") - (SELECT count(*) FROM "legacy_raw"."cuentas_costo") AS diferencia
UNION ALL
SELECT 'contabilidad.cuentas_gerencial' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cuentas_gerencial") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."cuentas_gerencial") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."cuentas_gerencial") - (SELECT count(*) FROM "legacy_raw"."cuentas_gerencial") AS diferencia
UNION ALL
SELECT 'contabilidad.cuentas_partida' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cuentas_partida") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."cuentas_partida") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."cuentas_partida") - (SELECT count(*) FROM "legacy_raw"."cuentas_partida") AS diferencia
UNION ALL
SELECT 'contabilidad.cuentas_partida_reporte' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cuentas_partida_reporte") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."cuentas_partida_reporte") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."cuentas_partida_reporte") - (SELECT count(*) FROM "legacy_raw"."cuentas_partida_reporte") AS diferencia
UNION ALL
SELECT 'contabilidad.cuentas_plan_prov' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cuentas_plan_prov") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."cuentas_plan_prov") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."cuentas_plan_prov") - (SELECT count(*) FROM "legacy_raw"."cuentas_plan_prov") AS diferencia
UNION ALL
SELECT 'contabilidad.cuentas_plan_prov_concep' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cuentas_plan_prov_concep") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."cuentas_plan_prov_concep") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."cuentas_plan_prov_concep") - (SELECT count(*) FROM "legacy_raw"."cuentas_plan_prov_concep") AS diferencia
UNION ALL
SELECT 'contabilidad.cuentas_provision' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cuentas_provision") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."cuentas_provision") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."cuentas_provision") - (SELECT count(*) FROM "legacy_raw"."cuentas_provision") AS diferencia
UNION ALL
SELECT 'contabilidad.cuentas_reporte' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cuentas_reporte") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."cuentas_reporte") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."cuentas_reporte") - (SELECT count(*) FROM "legacy_raw"."cuentas_reporte") AS diferencia
UNION ALL
SELECT 'contabilidad.decl_diar_arri' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."decl_diar_arri") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."decl_diar_arri") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."decl_diar_arri") - (SELECT count(*) FROM "legacy_raw"."decl_diar_arri") AS diferencia
UNION ALL
SELECT 'contabilidad.decl_diar_zarp' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."decl_diar_zarp") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."decl_diar_zarp") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."decl_diar_zarp") - (SELECT count(*) FROM "legacy_raw"."decl_diar_zarp") AS diferencia
UNION ALL
SELECT 'contabilidad.decl_diar_zarp_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."decl_diar_zarp_deta") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."decl_diar_zarp_deta") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."decl_diar_zarp_deta") - (SELECT count(*) FROM "legacy_raw"."decl_diar_zarp_deta") AS diferencia
UNION ALL
SELECT 'contabilidad.decl_zarp_trim' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."decl_zarp_trim") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."decl_zarp_trim") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."decl_zarp_trim") - (SELECT count(*) FROM "legacy_raw"."decl_zarp_trim") AS diferencia
UNION ALL
SELECT 'contabilidad.decl_zarp_trim_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."decl_zarp_trim_deta") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."decl_zarp_trim_deta") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."decl_zarp_trim_deta") - (SELECT count(*) FROM "legacy_raw"."decl_zarp_trim_deta") AS diferencia
UNION ALL
SELECT 'contabilidad.declara_jurada' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."declara_jurada") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."declara_jurada") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."declara_jurada") - (SELECT count(*) FROM "legacy_raw"."declara_jurada") AS diferencia
UNION ALL
SELECT 'contabilidad.declara_jurada_caja' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."declara_jurada_caja") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."declara_jurada_caja") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."declara_jurada_caja") - (SELECT count(*) FROM "legacy_raw"."declara_jurada_caja") AS diferencia
UNION ALL
SELECT 'contabilidad.declara_jurada_merca' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."declara_jurada_merca") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."declara_jurada_merca") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."declara_jurada_merca") - (SELECT count(*) FROM "legacy_raw"."declara_jurada_merca") AS diferencia
UNION ALL
SELECT 'contabilidad.detalle_calc_af' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."detalle_calc_af") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."detalle_calc_af") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."detalle_calc_af") - (SELECT count(*) FROM "legacy_raw"."detalle_calc_af") AS diferencia
UNION ALL
SELECT 'contabilidad.detalle_detraccion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."detalle_detraccion") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."detalle_detraccion") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."detalle_detraccion") - (SELECT count(*) FROM "legacy_raw"."detalle_detraccion") AS diferencia
UNION ALL
SELECT 'contabilidad.dif_camb' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."dif_camb") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."dif_camb") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."dif_camb") - (SELECT count(*) FROM "legacy_raw"."dif_camb") AS diferencia
UNION ALL
SELECT 'contabilidad.eeff' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."eeff") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."eeff") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."eeff") - (SELECT count(*) FROM "legacy_raw"."eeff") AS diferencia
UNION ALL
SELECT 'contabilidad.elemento_costo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."elemento_costo") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."elemento_costo") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."elemento_costo") - (SELECT count(*) FROM "legacy_raw"."elemento_costo") AS diferencia
UNION ALL
SELECT 'contabilidad.estados_financieros' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."estados_financieros") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."estados_financieros") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."estados_financieros") - (SELECT count(*) FROM "legacy_raw"."estados_financieros") AS diferencia
UNION ALL
SELECT 'contabilidad.estados_financieros_detalle' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."estados_financieros_detalle") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."estados_financieros_detalle") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."estados_financieros_detalle") - (SELECT count(*) FROM "legacy_raw"."estados_financieros_detalle") AS diferencia
UNION ALL
SELECT 'contabilidad.gasto_operativo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."gasto_operativo") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."gasto_operativo") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."gasto_operativo") - (SELECT count(*) FROM "legacy_raw"."gasto_operativo") AS diferencia
UNION ALL
SELECT 'contabilidad.gerencial_repo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."gerencial_repo") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."gerencial_repo") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."gerencial_repo") - (SELECT count(*) FROM "legacy_raw"."gerencial_repo") AS diferencia
UNION ALL
SELECT 'contabilidad.gerencial_repo_tipo_cuen' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."gerencial_repo_tipo_cuen") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."gerencial_repo_tipo_cuen") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."gerencial_repo_tipo_cuen") - (SELECT count(*) FROM "legacy_raw"."gerencial_repo_tipo_cuen") AS diferencia
UNION ALL
SELECT 'contabilidad.gerencial_repo_tipos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."gerencial_repo_tipos") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."gerencial_repo_tipos") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."gerencial_repo_tipos") - (SELECT count(*) FROM "legacy_raw"."gerencial_repo_tipos") AS diferencia
UNION ALL
SELECT 'contabilidad.glosas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."glosas") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."glosas") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."glosas") - (SELECT count(*) FROM "legacy_raw"."glosas") AS diferencia
UNION ALL
SELECT 'contabilidad.libro_diario_s' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."libro_diario_s") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."libro_diario_s") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."libro_diario_s") - (SELECT count(*) FROM "legacy_raw"."libro_diario_s") AS diferencia
UNION ALL
SELECT 'contabilidad.libro_registro' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."libro_registro") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."libro_registro") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."libro_registro") - (SELECT count(*) FROM "legacy_raw"."libro_registro") AS diferencia
UNION ALL
SELECT 'contabilidad.linea_clase_c' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."linea_clase_c") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."linea_clase_c") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."linea_clase_c") - (SELECT count(*) FROM "legacy_raw"."linea_clase_c") AS diferencia
UNION ALL
SELECT 'contabilidad.m_cuentas_contable' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."m_cuentas_contable") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."m_cuentas_contable") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."m_cuentas_contable") - (SELECT count(*) FROM "legacy_raw"."m_cuentas_contable") AS diferencia
UNION ALL
SELECT 'contabilidad.m_linea_clase_c' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."m_linea_clase_c") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."m_linea_clase_c") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."m_linea_clase_c") - (SELECT count(*) FROM "legacy_raw"."m_linea_clase_c") AS diferencia
UNION ALL
SELECT 'contabilidad.m_sub_clas_cuen' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."m_sub_clas_cuen") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."m_sub_clas_cuen") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."m_sub_clas_cuen") - (SELECT count(*) FROM "legacy_raw"."m_sub_clas_cuen") AS diferencia
UNION ALL
SELECT 'contabilidad.movi_contables' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."movi_contables") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."movi_contables") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."movi_contables") - (SELECT count(*) FROM "legacy_raw"."movi_contables") AS diferencia
UNION ALL
SELECT 'contabilidad.operac_sunat_ple' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."operac_sunat_ple") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."operac_sunat_ple") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."operac_sunat_ple") - (SELECT count(*) FROM "legacy_raw"."operac_sunat_ple") AS diferencia
UNION ALL
SELECT 'contabilidad.operaciones' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."operaciones") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."operaciones") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."operaciones") - (SELECT count(*) FROM "legacy_raw"."operaciones") AS diferencia
UNION ALL
SELECT 'contabilidad.plecompras' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."plecompras") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."plecompras") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."plecompras") - (SELECT count(*) FROM "legacy_raw"."plecompras") AS diferencia
UNION ALL
SELECT 'contabilidad.punto_equilibrio' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."punto_equilibrio") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."punto_equilibrio") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."punto_equilibrio") - (SELECT count(*) FROM "legacy_raw"."punto_equilibrio") AS diferencia
UNION ALL
SELECT 'contabilidad.ratios' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ratios") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."ratios") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."ratios") - (SELECT count(*) FROM "legacy_raw"."ratios") AS diferencia
UNION ALL
SELECT 'contabilidad.reporte_eeff' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."reporte_eeff") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."reporte_eeff") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."reporte_eeff") - (SELECT count(*) FROM "legacy_raw"."reporte_eeff") AS diferencia
UNION ALL
SELECT 'contabilidad.reporte_eeff_grupo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."reporte_eeff_grupo") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."reporte_eeff_grupo") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."reporte_eeff_grupo") - (SELECT count(*) FROM "legacy_raw"."reporte_eeff_grupo") AS diferencia
UNION ALL
SELECT 'contabilidad.retencion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."retencion") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."retencion") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."retencion") - (SELECT count(*) FROM "legacy_raw"."retencion") AS diferencia
UNION ALL
SELECT 'contabilidad.sald_tota_c' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sald_tota_c") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."sald_tota_c") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."sald_tota_c") - (SELECT count(*) FROM "legacy_raw"."sald_tota_c") AS diferencia
UNION ALL
SELECT 'contabilidad.sald_tota_c_p' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sald_tota_c_p") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."sald_tota_c_p") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."sald_tota_c_p") - (SELECT count(*) FROM "legacy_raw"."sald_tota_c_p") AS diferencia
UNION ALL
SELECT 'contabilidad.sald_tota_c_uo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sald_tota_c_uo") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."sald_tota_c_uo") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."sald_tota_c_uo") - (SELECT count(*) FROM "legacy_raw"."sald_tota_c_uo") AS diferencia
UNION ALL
SELECT 'contabilidad.sald_tota_c_uo_p' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sald_tota_c_uo_p") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."sald_tota_c_uo_p") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."sald_tota_c_uo_p") - (SELECT count(*) FROM "legacy_raw"."sald_tota_c_uo_p") AS diferencia
UNION ALL
SELECT 'contabilidad.saldos_cuentas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."saldos_cuentas") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."saldos_cuentas") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."saldos_cuentas") - (SELECT count(*) FROM "legacy_raw"."saldos_cuentas") AS diferencia
UNION ALL
SELECT 'contabilidad.sub_clas_cuen' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sub_clas_cuen") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."sub_clas_cuen") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."sub_clas_cuen") - (SELECT count(*) FROM "legacy_raw"."sub_clas_cuen") AS diferencia
UNION ALL
SELECT 'contabilidad.sub_clase' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sub_clase") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."sub_clase") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."sub_clase") - (SELECT count(*) FROM "legacy_raw"."sub_clase") AS diferencia
UNION ALL
SELECT 'contabilidad.sub_clase_cont_4' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sub_clase_cont_4") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."sub_clase_cont_4") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."sub_clase_cont_4") - (SELECT count(*) FROM "legacy_raw"."sub_clase_cont_4") AS diferencia
UNION ALL
SELECT 'contabilidad.sub_concepto_sunat' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sub_concepto_sunat") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."sub_concepto_sunat") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."sub_concepto_sunat") - (SELECT count(*) FROM "legacy_raw"."sub_concepto_sunat") AS diferencia
UNION ALL
SELECT 'contabilidad.subdiario' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."subdiario") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."subdiario") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."subdiario") - (SELECT count(*) FROM "legacy_raw"."subdiario") AS diferencia
UNION ALL
SELECT 'contabilidad.sunat' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sunat") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."sunat") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."sunat") - (SELECT count(*) FROM "legacy_raw"."sunat") AS diferencia
UNION ALL
SELECT 'contabilidad.sunat_f318' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sunat_f318") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."sunat_f318") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."sunat_f318") - (SELECT count(*) FROM "legacy_raw"."sunat_f318") AS diferencia
UNION ALL
SELECT 'contabilidad.tipo_afecta_igv' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_afecta_igv") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."tipo_afecta_igv") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."tipo_afecta_igv") - (SELECT count(*) FROM "legacy_raw"."tipo_afecta_igv") AS diferencia
UNION ALL
SELECT 'contabilidad.tipo_comprobante' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_comprobante") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."tipo_comprobante") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."tipo_comprobante") - (SELECT count(*) FROM "legacy_raw"."tipo_comprobante") AS diferencia
UNION ALL
SELECT 'contabilidad.tipo_cost_gene' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_cost_gene") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."tipo_cost_gene") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."tipo_cost_gene") - (SELECT count(*) FROM "legacy_raw"."tipo_cost_gene") AS diferencia
UNION ALL
SELECT 'contabilidad.tipo_costo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_costo") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."tipo_costo") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."tipo_costo") - (SELECT count(*) FROM "legacy_raw"."tipo_costo") AS diferencia
UNION ALL
SELECT 'contabilidad.tipo_eeff' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_eeff") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."tipo_eeff") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."tipo_eeff") - (SELECT count(*) FROM "legacy_raw"."tipo_eeff") AS diferencia
UNION ALL
SELECT 'contabilidad.tipo_form_most_eeff' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_form_most_eeff") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."tipo_form_most_eeff") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."tipo_form_most_eeff") - (SELECT count(*) FROM "legacy_raw"."tipo_form_most_eeff") AS diferencia
UNION ALL
SELECT 'contabilidad.tipo_form_prov_plan' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_form_prov_plan") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."tipo_form_prov_plan") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."tipo_form_prov_plan") - (SELECT count(*) FROM "legacy_raw"."tipo_form_prov_plan") AS diferencia
UNION ALL
SELECT 'contabilidad.tipo_gasto' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_gasto") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."tipo_gasto") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."tipo_gasto") - (SELECT count(*) FROM "legacy_raw"."tipo_gasto") AS diferencia
UNION ALL
SELECT 'contabilidad.tipo_impuestos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_impuestos") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."tipo_impuestos") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."tipo_impuestos") - (SELECT count(*) FROM "legacy_raw"."tipo_impuestos") AS diferencia
UNION ALL
SELECT 'contabilidad.tipo_intangible' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_intangible") AS filas_legacy,
       (SELECT count(*) FROM "contabilidad"."tipo_intangible") AS filas_destino,
       (SELECT count(*) FROM "contabilidad"."tipo_intangible") - (SELECT count(*) FROM "legacy_raw"."tipo_intangible") AS diferencia
UNION ALL
SELECT 'finanzas.anticipos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."anticipos") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."anticipos") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."anticipos") - (SELECT count(*) FROM "legacy_raw"."anticipos") AS diferencia
UNION ALL
SELECT 'finanzas.anticipos_documento_compra' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."anticipos_documento_compra") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."anticipos_documento_compra") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."anticipos_documento_compra") - (SELECT count(*) FROM "legacy_raw"."anticipos_documento_compra") AS diferencia
UNION ALL
SELECT 'finanzas.bancos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."bancos") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."bancos") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."bancos") - (SELECT count(*) FROM "legacy_raw"."bancos") AS diferencia
UNION ALL
SELECT 'finanzas.bancos_cheques' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."bancos_cheques") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."bancos_cheques") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."bancos_cheques") - (SELECT count(*) FROM "legacy_raw"."bancos_cheques") AS diferencia
UNION ALL
SELECT 'finanzas.bancos_disponible' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."bancos_disponible") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."bancos_disponible") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."bancos_disponible") - (SELECT count(*) FROM "legacy_raw"."bancos_disponible") AS diferencia
UNION ALL
SELECT 'finanzas.bancos_disponible_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."bancos_disponible_deta") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."bancos_disponible_deta") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."bancos_disponible_deta") - (SELECT count(*) FROM "legacy_raw"."bancos_disponible_deta") AS diferencia
UNION ALL
SELECT 'finanzas.bancos_saldos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."bancos_saldos") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."bancos_saldos") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."bancos_saldos") - (SELECT count(*) FROM "legacy_raw"."bancos_saldos") AS diferencia
UNION ALL
SELECT 'finanzas.caja_chica' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."caja_chica") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."caja_chica") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."caja_chica") - (SELECT count(*) FROM "legacy_raw"."caja_chica") AS diferencia
UNION ALL
SELECT 'finanzas.caja_chica_depo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."caja_chica_depo") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."caja_chica_depo") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."caja_chica_depo") - (SELECT count(*) FROM "legacy_raw"."caja_chica_depo") AS diferencia
UNION ALL
SELECT 'finanzas.caja_cierre' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."caja_cierre") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."caja_cierre") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."caja_cierre") - (SELECT count(*) FROM "legacy_raw"."caja_cierre") AS diferencia
UNION ALL
SELECT 'finanzas.cheques' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cheques") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."cheques") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."cheques") - (SELECT count(*) FROM "legacy_raw"."cheques") AS diferencia
UNION ALL
SELECT 'finanzas.conci_banco' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."conci_banco") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."conci_banco") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."conci_banco") - (SELECT count(*) FROM "legacy_raw"."conci_banco") AS diferencia
UNION ALL
SELECT 'finanzas.cta_cte_personal' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cta_cte_personal") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."cta_cte_personal") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."cta_cte_personal") - (SELECT count(*) FROM "legacy_raw"."cta_cte_personal") AS diferencia
UNION ALL
SELECT 'finanzas.cta_cte_prov' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cta_cte_prov") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."cta_cte_prov") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."cta_cte_prov") - (SELECT count(*) FROM "legacy_raw"."cta_cte_prov") AS diferencia
UNION ALL
SELECT 'finanzas.depositos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."depositos") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."depositos") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."depositos") - (SELECT count(*) FROM "legacy_raw"."depositos") AS diferencia
UNION ALL
SELECT 'finanzas.documento_garantia' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."documento_garantia") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."documento_garantia") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."documento_garantia") - (SELECT count(*) FROM "legacy_raw"."documento_garantia") AS diferencia
UNION ALL
SELECT 'finanzas.escribalo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."escribalo") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."escribalo") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."escribalo") - (SELECT count(*) FROM "legacy_raw"."escribalo") AS diferencia
UNION ALL
SELECT 'finanzas.escribalo_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."escribalo_deta") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."escribalo_deta") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."escribalo_deta") - (SELECT count(*) FROM "legacy_raw"."escribalo_deta") AS diferencia
UNION ALL
SELECT 'finanzas.letra_calculo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."letra_calculo") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."letra_calculo") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."letra_calculo") - (SELECT count(*) FROM "legacy_raw"."letra_calculo") AS diferencia
UNION ALL
SELECT 'finanzas.letras_productos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."letras_productos") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."letras_productos") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."letras_productos") - (SELECT count(*) FROM "legacy_raw"."letras_productos") AS diferencia
UNION ALL
SELECT 'finanzas.pagos_juicios' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pagos_juicios") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."pagos_juicios") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."pagos_juicios") - (SELECT count(*) FROM "legacy_raw"."pagos_juicios") AS diferencia
UNION ALL
SELECT 'finanzas.polizas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."polizas") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."polizas") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."polizas") - (SELECT count(*) FROM "legacy_raw"."polizas") AS diferencia
UNION ALL
SELECT 'finanzas.pres_grup' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pres_grup") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."pres_grup") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."pres_grup") - (SELECT count(*) FROM "legacy_raw"."pres_grup") AS diferencia
UNION ALL
SELECT 'finanzas.pres_pago' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pres_pago") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."pres_pago") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."pres_pago") - (SELECT count(*) FROM "legacy_raw"."pres_pago") AS diferencia
UNION ALL
SELECT 'finanzas.presupuesto' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."presupuesto") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."presupuesto") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."presupuesto") - (SELECT count(*) FROM "legacy_raw"."presupuesto") AS diferencia
UNION ALL
SELECT 'finanzas.recibo_egreso' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."recibo_egreso") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."recibo_egreso") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."recibo_egreso") - (SELECT count(*) FROM "legacy_raw"."recibo_egreso") AS diferencia
UNION ALL
SELECT 'finanzas.registro_pagos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."registro_pagos") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."registro_pagos") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."registro_pagos") - (SELECT count(*) FROM "legacy_raw"."registro_pagos") AS diferencia
UNION ALL
SELECT 'finanzas.rubros_caja' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."rubros_caja") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."rubros_caja") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."rubros_caja") - (SELECT count(*) FROM "legacy_raw"."rubros_caja") AS diferencia
UNION ALL
SELECT 'finanzas.rubros_caja_detalle' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."rubros_caja_detalle") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."rubros_caja_detalle") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."rubros_caja_detalle") - (SELECT count(*) FROM "legacy_raw"."rubros_caja_detalle") AS diferencia
UNION ALL
SELECT 'finanzas.sald_conc_banc' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sald_conc_banc") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."sald_conc_banc") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."sald_conc_banc") - (SELECT count(*) FROM "legacy_raw"."sald_conc_banc") AS diferencia
UNION ALL
SELECT 'finanzas.saldo_bancos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."saldo_bancos") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."saldo_bancos") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."saldo_bancos") - (SELECT count(*) FROM "legacy_raw"."saldo_bancos") AS diferencia
UNION ALL
SELECT 'finanzas.saldo_moneda' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."saldo_moneda") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."saldo_moneda") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."saldo_moneda") - (SELECT count(*) FROM "legacy_raw"."saldo_moneda") AS diferencia
UNION ALL
SELECT 'finanzas.seguros' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."seguros") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."seguros") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."seguros") - (SELECT count(*) FROM "legacy_raw"."seguros") AS diferencia
UNION ALL
SELECT 'finanzas.tipo_cta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_cta") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."tipo_cta") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."tipo_cta") - (SELECT count(*) FROM "legacy_raw"."tipo_cta") AS diferencia
UNION ALL
SELECT 'finanzas.tipo_cta_banc' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_cta_banc") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."tipo_cta_banc") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."tipo_cta_banc") - (SELECT count(*) FROM "legacy_raw"."tipo_cta_banc") AS diferencia
UNION ALL
SELECT 'finanzas.tipo_cta_cte' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_cta_cte") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."tipo_cta_cte") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."tipo_cta_cte") - (SELECT count(*) FROM "legacy_raw"."tipo_cta_cte") AS diferencia
UNION ALL
SELECT 'finanzas.tipo_form_pago' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_form_pago") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."tipo_form_pago") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."tipo_form_pago") - (SELECT count(*) FROM "legacy_raw"."tipo_form_pago") AS diferencia
UNION ALL
SELECT 'finanzas.tipo_medio_pago' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_medio_pago") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."tipo_medio_pago") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."tipo_medio_pago") - (SELECT count(*) FROM "legacy_raw"."tipo_medio_pago") AS diferencia
UNION ALL
SELECT 'finanzas.tipo_reembolso' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_reembolso") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."tipo_reembolso") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."tipo_reembolso") - (SELECT count(*) FROM "legacy_raw"."tipo_reembolso") AS diferencia
UNION ALL
SELECT 'finanzas.tipo_reembolso_almacen' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_reembolso_almacen") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."tipo_reembolso_almacen") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."tipo_reembolso_almacen") - (SELECT count(*) FROM "legacy_raw"."tipo_reembolso_almacen") AS diferencia
UNION ALL
SELECT 'finanzas.tipo_situ_cheq' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_situ_cheq") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."tipo_situ_cheq") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."tipo_situ_cheq") - (SELECT count(*) FROM "legacy_raw"."tipo_situ_cheq") AS diferencia
UNION ALL
SELECT 'finanzas.tipo_situ_conc_banc' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_situ_conc_banc") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."tipo_situ_conc_banc") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."tipo_situ_conc_banc") - (SELECT count(*) FROM "legacy_raw"."tipo_situ_conc_banc") AS diferencia
UNION ALL
SELECT 'finanzas.tipos_pago_warrant' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipos_pago_warrant") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."tipos_pago_warrant") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."tipos_pago_warrant") - (SELECT count(*) FROM "legacy_raw"."tipos_pago_warrant") AS diferencia
UNION ALL
SELECT 'finanzas.warrant_control' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."warrant_control") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."warrant_control") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."warrant_control") - (SELECT count(*) FROM "legacy_raw"."warrant_control") AS diferencia
UNION ALL
SELECT 'finanzas.warrant_pagos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."warrant_pagos") AS filas_legacy,
       (SELECT count(*) FROM "finanzas"."warrant_pagos") AS filas_destino,
       (SELECT count(*) FROM "finanzas"."warrant_pagos") - (SELECT count(*) FROM "legacy_raw"."warrant_pagos") AS diferencia
UNION ALL
SELECT 'logistica.acabado' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."acabado") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."acabado") AS filas_destino,
       (SELECT count(*) FROM "logistica"."acabado") - (SELECT count(*) FROM "legacy_raw"."acabado") AS diferencia
UNION ALL
SELECT 'logistica.aceptacion_lista_reque' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."aceptacion_lista_reque") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."aceptacion_lista_reque") AS filas_destino,
       (SELECT count(*) FROM "logistica"."aceptacion_lista_reque") - (SELECT count(*) FROM "legacy_raw"."aceptacion_lista_reque") AS diferencia
UNION ALL
SELECT 'logistica.almacen' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."almacen") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."almacen") AS filas_destino,
       (SELECT count(*) FROM "logistica"."almacen") - (SELECT count(*) FROM "legacy_raw"."almacen") AS diferencia
UNION ALL
SELECT 'logistica.almacen_doc_regularizar' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."almacen_doc_regularizar") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."almacen_doc_regularizar") AS filas_destino,
       (SELECT count(*) FROM "logistica"."almacen_doc_regularizar") - (SELECT count(*) FROM "legacy_raw"."almacen_doc_regularizar") AS diferencia
UNION ALL
SELECT 'logistica.almacen_producto' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."almacen_producto") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."almacen_producto") AS filas_destino,
       (SELECT count(*) FROM "logistica"."almacen_producto") - (SELECT count(*) FROM "legacy_raw"."almacen_producto") AS diferencia
UNION ALL
SELECT 'logistica.almacen_usuario' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."almacen_usuario") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."almacen_usuario") AS filas_destino,
       (SELECT count(*) FROM "logistica"."almacen_usuario") - (SELECT count(*) FROM "legacy_raw"."almacen_usuario") AS diferencia
UNION ALL
SELECT 'logistica.almacenes' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."almacenes") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."almacenes") AS filas_destino,
       (SELECT count(*) FROM "logistica"."almacenes") - (SELECT count(*) FROM "legacy_raw"."almacenes") AS diferencia
UNION ALL
SELECT 'logistica.ccnu_clases' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ccnu_clases") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."ccnu_clases") AS filas_destino,
       (SELECT count(*) FROM "logistica"."ccnu_clases") - (SELECT count(*) FROM "legacy_raw"."ccnu_clases") AS diferencia
UNION ALL
SELECT 'logistica.ccnu_familias' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ccnu_familias") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."ccnu_familias") AS filas_destino,
       (SELECT count(*) FROM "logistica"."ccnu_familias") - (SELECT count(*) FROM "legacy_raw"."ccnu_familias") AS diferencia
UNION ALL
SELECT 'logistica.ccnu_productos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ccnu_productos") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."ccnu_productos") AS filas_destino,
       (SELECT count(*) FROM "logistica"."ccnu_productos") - (SELECT count(*) FROM "legacy_raw"."ccnu_productos") AS diferencia
UNION ALL
SELECT 'logistica.ccnu_segmentos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ccnu_segmentos") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."ccnu_segmentos") AS filas_destino,
       (SELECT count(*) FROM "logistica"."ccnu_segmentos") - (SELECT count(*) FROM "legacy_raw"."ccnu_segmentos") AS diferencia
UNION ALL
SELECT 'logistica.color' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."color") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."color") AS filas_destino,
       (SELECT count(*) FROM "logistica"."color") - (SELECT count(*) FROM "legacy_raw"."color") AS diferencia
UNION ALL
SELECT 'logistica.compromisos_pactados' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."compromisos_pactados") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."compromisos_pactados") AS filas_destino,
       (SELECT count(*) FROM "logistica"."compromisos_pactados") - (SELECT count(*) FROM "legacy_raw"."compromisos_pactados") AS diferencia
UNION ALL
SELECT 'logistica.compromisos_pactados_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."compromisos_pactados_deta") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."compromisos_pactados_deta") AS filas_destino,
       (SELECT count(*) FROM "logistica"."compromisos_pactados_deta") - (SELECT count(*) FROM "legacy_raw"."compromisos_pactados_deta") AS diferencia
UNION ALL
SELECT 'logistica.control_problemas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."control_problemas") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."control_problemas") AS filas_destino,
       (SELECT count(*) FROM "logistica"."control_problemas") - (SELECT count(*) FROM "legacy_raw"."control_problemas") AS diferencia
UNION ALL
SELECT 'logistica.control_problemas_detalle' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."control_problemas_detalle") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."control_problemas_detalle") AS filas_destino,
       (SELECT count(*) FROM "logistica"."control_problemas_detalle") - (SELECT count(*) FROM "legacy_raw"."control_problemas_detalle") AS diferencia
UNION ALL
SELECT 'logistica.cotizacion_de_pedidos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cotizacion_de_pedidos") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."cotizacion_de_pedidos") AS filas_destino,
       (SELECT count(*) FROM "logistica"."cotizacion_de_pedidos") - (SELECT count(*) FROM "legacy_raw"."cotizacion_de_pedidos") AS diferencia
UNION ALL
SELECT 'logistica.cotizacion_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cotizacion_deta") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."cotizacion_deta") AS filas_destino,
       (SELECT count(*) FROM "logistica"."cotizacion_deta") - (SELECT count(*) FROM "legacy_raw"."cotizacion_deta") AS diferencia
UNION ALL
SELECT 'logistica.detalle_cotizacion_pedido' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."detalle_cotizacion_pedido") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."detalle_cotizacion_pedido") AS filas_destino,
       (SELECT count(*) FROM "logistica"."detalle_cotizacion_pedido") - (SELECT count(*) FROM "legacy_raw"."detalle_cotizacion_pedido") AS diferencia
UNION ALL
SELECT 'logistica.detalle_docu_sali' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."detalle_docu_sali") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."detalle_docu_sali") AS filas_destino,
       (SELECT count(*) FROM "logistica"."detalle_docu_sali") - (SELECT count(*) FROM "legacy_raw"."detalle_docu_sali") AS diferencia
UNION ALL
SELECT 'logistica.detalle_listarequerimientos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."detalle_listarequerimientos") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."detalle_listarequerimientos") AS filas_destino,
       (SELECT count(*) FROM "logistica"."detalle_listarequerimientos") - (SELECT count(*) FROM "legacy_raw"."detalle_listarequerimientos") AS diferencia
UNION ALL
SELECT 'logistica.detalle_nota_ingreso' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."detalle_nota_ingreso") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."detalle_nota_ingreso") AS filas_destino,
       (SELECT count(*) FROM "logistica"."detalle_nota_ingreso") - (SELECT count(*) FROM "legacy_raw"."detalle_nota_ingreso") AS diferencia
UNION ALL
SELECT 'logistica.detalle_orden_compra' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."detalle_orden_compra") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."detalle_orden_compra") AS filas_destino,
       (SELECT count(*) FROM "logistica"."detalle_orden_compra") - (SELECT count(*) FROM "legacy_raw"."detalle_orden_compra") AS diferencia
UNION ALL
SELECT 'logistica.detalle_orden_compra_distribucion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."detalle_orden_compra_distribucion") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."detalle_orden_compra_distribucion") AS filas_destino,
       (SELECT count(*) FROM "logistica"."detalle_orden_compra_distribucion") - (SELECT count(*) FROM "legacy_raw"."detalle_orden_compra_distribucion") AS diferencia
UNION ALL
SELECT 'logistica.detalle_orden_de_pedido' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."detalle_orden_de_pedido") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."detalle_orden_de_pedido") AS filas_destino,
       (SELECT count(*) FROM "logistica"."detalle_orden_de_pedido") - (SELECT count(*) FROM "legacy_raw"."detalle_orden_de_pedido") AS diferencia
UNION ALL
SELECT 'logistica.detalle_orden_servicio' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."detalle_orden_servicio") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."detalle_orden_servicio") AS filas_destino,
       (SELECT count(*) FROM "logistica"."detalle_orden_servicio") - (SELECT count(*) FROM "legacy_raw"."detalle_orden_servicio") AS diferencia
UNION ALL
SELECT 'logistica.detalle_salida_materiales' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."detalle_salida_materiales") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."detalle_salida_materiales") AS filas_destino,
       (SELECT count(*) FROM "logistica"."detalle_salida_materiales") - (SELECT count(*) FROM "legacy_raw"."detalle_salida_materiales") AS diferencia
UNION ALL
SELECT 'logistica.docu_sali_mate' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."docu_sali_mate") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."docu_sali_mate") AS filas_destino,
       (SELECT count(*) FROM "logistica"."docu_sali_mate") - (SELECT count(*) FROM "legacy_raw"."docu_sali_mate") AS diferencia
UNION ALL
SELECT 'logistica.docu_sali_x_orde_pedi' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."docu_sali_x_orde_pedi") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."docu_sali_x_orde_pedi") AS filas_destino,
       (SELECT count(*) FROM "logistica"."docu_sali_x_orde_pedi") - (SELECT count(*) FROM "legacy_raw"."docu_sali_x_orde_pedi") AS diferencia
UNION ALL
SELECT 'logistica.familia_producto' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."familia_producto") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."familia_producto") AS filas_destino,
       (SELECT count(*) FROM "logistica"."familia_producto") - (SELECT count(*) FROM "legacy_raw"."familia_producto") AS diferencia
UNION ALL
SELECT 'logistica.kardex' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."kardex") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."kardex") AS filas_destino,
       (SELECT count(*) FROM "logistica"."kardex") - (SELECT count(*) FROM "legacy_raw"."kardex") AS diferencia
UNION ALL
SELECT 'logistica.kardex_almacenes' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."kardex_almacenes") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."kardex_almacenes") AS filas_destino,
       (SELECT count(*) FROM "logistica"."kardex_almacenes") - (SELECT count(*) FROM "legacy_raw"."kardex_almacenes") AS diferencia
UNION ALL
SELECT 'logistica.kit_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."kit_deta") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."kit_deta") AS filas_destino,
       (SELECT count(*) FROM "logistica"."kit_deta") - (SELECT count(*) FROM "legacy_raw"."kit_deta") AS diferencia
UNION ALL
SELECT 'logistica.kits' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."kits") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."kits") AS filas_destino,
       (SELECT count(*) FROM "logistica"."kits") - (SELECT count(*) FROM "legacy_raw"."kits") AS diferencia
UNION ALL
SELECT 'logistica.linea_familia_pro' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."linea_familia_pro") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."linea_familia_pro") AS filas_destino,
       (SELECT count(*) FROM "logistica"."linea_familia_pro") - (SELECT count(*) FROM "legacy_raw"."linea_familia_pro") AS diferencia
UNION ALL
SELECT 'logistica.lista_de_requerimientos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."lista_de_requerimientos") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."lista_de_requerimientos") AS filas_destino,
       (SELECT count(*) FROM "logistica"."lista_de_requerimientos") - (SELECT count(*) FROM "legacy_raw"."lista_de_requerimientos") AS diferencia
UNION ALL
SELECT 'logistica.lote_situacion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."lote_situacion") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."lote_situacion") AS filas_destino,
       (SELECT count(*) FROM "logistica"."lote_situacion") - (SELECT count(*) FROM "legacy_raw"."lote_situacion") AS diferencia
UNION ALL
SELECT 'logistica.marca' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."marca") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."marca") AS filas_destino,
       (SELECT count(*) FROM "logistica"."marca") - (SELECT count(*) FROM "legacy_raw"."marca") AS diferencia
UNION ALL
SELECT 'logistica.material' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."material") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."material") AS filas_destino,
       (SELECT count(*) FROM "logistica"."material") - (SELECT count(*) FROM "legacy_raw"."material") AS diferencia
UNION ALL
SELECT 'logistica.nota_ingr_por_orde_comp' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."nota_ingr_por_orde_comp") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."nota_ingr_por_orde_comp") AS filas_destino,
       (SELECT count(*) FROM "logistica"."nota_ingr_por_orde_comp") - (SELECT count(*) FROM "legacy_raw"."nota_ingr_por_orde_comp") AS diferencia
UNION ALL
SELECT 'logistica.nota_ingreso' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."nota_ingreso") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."nota_ingreso") AS filas_destino,
       (SELECT count(*) FROM "logistica"."nota_ingreso") - (SELECT count(*) FROM "legacy_raw"."nota_ingreso") AS diferencia
UNION ALL
SELECT 'logistica.orde_serv_x_proy' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."orde_serv_x_proy") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."orde_serv_x_proy") AS filas_destino,
       (SELECT count(*) FROM "logistica"."orde_serv_x_proy") - (SELECT count(*) FROM "legacy_raw"."orde_serv_x_proy") AS diferencia
UNION ALL
SELECT 'logistica.orden_compra_detalle' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."orden_compra_detalle") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."orden_compra_detalle") AS filas_destino,
       (SELECT count(*) FROM "logistica"."orden_compra_detalle") - (SELECT count(*) FROM "legacy_raw"."orden_compra_detalle") AS diferencia
UNION ALL
SELECT 'logistica.orden_compra_pedido_cotiza' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."orden_compra_pedido_cotiza") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."orden_compra_pedido_cotiza") AS filas_destino,
       (SELECT count(*) FROM "logistica"."orden_compra_pedido_cotiza") - (SELECT count(*) FROM "legacy_raw"."orden_compra_pedido_cotiza") AS diferencia
UNION ALL
SELECT 'logistica.orden_de_compra' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."orden_de_compra") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."orden_de_compra") AS filas_destino,
       (SELECT count(*) FROM "logistica"."orden_de_compra") - (SELECT count(*) FROM "legacy_raw"."orden_de_compra") AS diferencia
UNION ALL
SELECT 'logistica.orden_de_pedido' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."orden_de_pedido") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."orden_de_pedido") AS filas_destino,
       (SELECT count(*) FROM "logistica"."orden_de_pedido") - (SELECT count(*) FROM "legacy_raw"."orden_de_pedido") AS diferencia
UNION ALL
SELECT 'logistica.orden_despacho_combustible' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."orden_despacho_combustible") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."orden_despacho_combustible") AS filas_destino,
       (SELECT count(*) FROM "logistica"."orden_despacho_combustible") - (SELECT count(*) FROM "legacy_raw"."orden_despacho_combustible") AS diferencia
UNION ALL
SELECT 'logistica.orden_despacho_combustible_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."orden_despacho_combustible_deta") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."orden_despacho_combustible_deta") AS filas_destino,
       (SELECT count(*) FROM "logistica"."orden_despacho_combustible_deta") - (SELECT count(*) FROM "legacy_raw"."orden_despacho_combustible_deta") AS diferencia
UNION ALL
SELECT 'logistica.prec_prom_inve' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."prec_prom_inve") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."prec_prom_inve") AS filas_destino,
       (SELECT count(*) FROM "logistica"."prec_prom_inve") - (SELECT count(*) FROM "legacy_raw"."prec_prom_inve") AS diferencia
UNION ALL
SELECT 'logistica.presentacion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."presentacion") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."presentacion") AS filas_destino,
       (SELECT count(*) FROM "logistica"."presentacion") - (SELECT count(*) FROM "legacy_raw"."presentacion") AS diferencia
UNION ALL
SELECT 'logistica.principio_activo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."principio_activo") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."principio_activo") AS filas_destino,
       (SELECT count(*) FROM "logistica"."principio_activo") - (SELECT count(*) FROM "legacy_raw"."principio_activo") AS diferencia
UNION ALL
SELECT 'logistica.principio_x_producto' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."principio_x_producto") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."principio_x_producto") AS filas_destino,
       (SELECT count(*) FROM "logistica"."principio_x_producto") - (SELECT count(*) FROM "legacy_raw"."principio_x_producto") AS diferencia
UNION ALL
SELECT 'logistica.producto_almacen_lote' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."producto_almacen_lote") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."producto_almacen_lote") AS filas_destino,
       (SELECT count(*) FROM "logistica"."producto_almacen_lote") - (SELECT count(*) FROM "legacy_raw"."producto_almacen_lote") AS diferencia
UNION ALL
SELECT 'logistica.producto_almacen_lote_pedido' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."producto_almacen_lote_pedido") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."producto_almacen_lote_pedido") AS filas_destino,
       (SELECT count(*) FROM "logistica"."producto_almacen_lote_pedido") - (SELECT count(*) FROM "legacy_raw"."producto_almacen_lote_pedido") AS diferencia
UNION ALL
SELECT 'logistica.productos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."productos") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."productos") AS filas_destino,
       (SELECT count(*) FROM "logistica"."productos") - (SELECT count(*) FROM "legacy_raw"."productos") AS diferencia
UNION ALL
SELECT 'logistica.productos_baja' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."productos_baja") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."productos_baja") AS filas_destino,
       (SELECT count(*) FROM "logistica"."productos_baja") - (SELECT count(*) FROM "legacy_raw"."productos_baja") AS diferencia
UNION ALL
SELECT 'logistica.productos_baja_rotacion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."productos_baja_rotacion") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."productos_baja_rotacion") AS filas_destino,
       (SELECT count(*) FROM "logistica"."productos_baja_rotacion") - (SELECT count(*) FROM "legacy_raw"."productos_baja_rotacion") AS diferencia
UNION ALL
SELECT 'logistica.productos_eventos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."productos_eventos") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."productos_eventos") AS filas_destino,
       (SELECT count(*) FROM "logistica"."productos_eventos") - (SELECT count(*) FROM "legacy_raw"."productos_eventos") AS diferencia
UNION ALL
SELECT 'logistica.productos_lotes_ingre_sali' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."productos_lotes_ingre_sali") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."productos_lotes_ingre_sali") AS filas_destino,
       (SELECT count(*) FROM "logistica"."productos_lotes_ingre_sali") - (SELECT count(*) FROM "legacy_raw"."productos_lotes_ingre_sali") AS diferencia
UNION ALL
SELECT 'logistica.productos_lotes_nota_venta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."productos_lotes_nota_venta") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."productos_lotes_nota_venta") AS filas_destino,
       (SELECT count(*) FROM "logistica"."productos_lotes_nota_venta") - (SELECT count(*) FROM "legacy_raw"."productos_lotes_nota_venta") AS diferencia
UNION ALL
SELECT 'logistica.productos_lotes_vale_cred' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."productos_lotes_vale_cred") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."productos_lotes_vale_cred") AS filas_destino,
       (SELECT count(*) FROM "logistica"."productos_lotes_vale_cred") - (SELECT count(*) FROM "legacy_raw"."productos_lotes_vale_cred") AS diferencia
UNION ALL
SELECT 'logistica.productos_matriz' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."productos_matriz") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."productos_matriz") AS filas_destino,
       (SELECT count(*) FROM "logistica"."productos_matriz") - (SELECT count(*) FROM "legacy_raw"."productos_matriz") AS diferencia
UNION ALL
SELECT 'logistica.productos_precio' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."productos_precio") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."productos_precio") AS filas_destino,
       (SELECT count(*) FROM "logistica"."productos_precio") - (SELECT count(*) FROM "legacy_raw"."productos_precio") AS diferencia
UNION ALL
SELECT 'logistica.productos_sin_venta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."productos_sin_venta") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."productos_sin_venta") AS filas_destino,
       (SELECT count(*) FROM "logistica"."productos_sin_venta") - (SELECT count(*) FROM "legacy_raw"."productos_sin_venta") AS diferencia
UNION ALL
SELECT 'logistica.proveedor_productos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."proveedor_productos") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."proveedor_productos") AS filas_destino,
       (SELECT count(*) FROM "logistica"."proveedor_productos") - (SELECT count(*) FROM "legacy_raw"."proveedor_productos") AS diferencia
UNION ALL
SELECT 'logistica.proyecto' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."proyecto") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."proyecto") AS filas_destino,
       (SELECT count(*) FROM "logistica"."proyecto") - (SELECT count(*) FROM "legacy_raw"."proyecto") AS diferencia
UNION ALL
SELECT 'logistica.registro_orden_pedido' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."registro_orden_pedido") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."registro_orden_pedido") AS filas_destino,
       (SELECT count(*) FROM "logistica"."registro_orden_pedido") - (SELECT count(*) FROM "legacy_raw"."registro_orden_pedido") AS diferencia
UNION ALL
SELECT 'logistica.registro_orden_pedido_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."registro_orden_pedido_deta") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."registro_orden_pedido_deta") AS filas_destino,
       (SELECT count(*) FROM "logistica"."registro_orden_pedido_deta") - (SELECT count(*) FROM "legacy_raw"."registro_orden_pedido_deta") AS diferencia
UNION ALL
SELECT 'logistica.registro_producto' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."registro_producto") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."registro_producto") AS filas_destino,
       (SELECT count(*) FROM "logistica"."registro_producto") - (SELECT count(*) FROM "legacy_raw"."registro_producto") AS diferencia
UNION ALL
SELECT 'logistica.registro_producto_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."registro_producto_deta") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."registro_producto_deta") AS filas_destino,
       (SELECT count(*) FROM "logistica"."registro_producto_deta") - (SELECT count(*) FROM "legacy_raw"."registro_producto_deta") AS diferencia
UNION ALL
SELECT 'logistica.sali_mate_x_docu_sali' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sali_mate_x_docu_sali") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."sali_mate_x_docu_sali") AS filas_destino,
       (SELECT count(*) FROM "logistica"."sali_mate_x_docu_sali") - (SELECT count(*) FROM "legacy_raw"."sali_mate_x_docu_sali") AS diferencia
UNION ALL
SELECT 'logistica.sali_mate_x_proy' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sali_mate_x_proy") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."sali_mate_x_proy") AS filas_destino,
       (SELECT count(*) FROM "logistica"."sali_mate_x_proy") - (SELECT count(*) FROM "legacy_raw"."sali_mate_x_proy") AS diferencia
UNION ALL
SELECT 'logistica.salida_material' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."salida_material") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."salida_material") AS filas_destino,
       (SELECT count(*) FROM "logistica"."salida_material") - (SELECT count(*) FROM "legacy_raw"."salida_material") AS diferencia
UNION ALL
SELECT 'logistica.sub_familia_producto' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sub_familia_producto") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."sub_familia_producto") AS filas_destino,
       (SELECT count(*) FROM "logistica"."sub_familia_producto") - (SELECT count(*) FROM "legacy_raw"."sub_familia_producto") AS diferencia
UNION ALL
SELECT 'logistica.tipo_aceptacion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_aceptacion") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."tipo_aceptacion") AS filas_destino,
       (SELECT count(*) FROM "logistica"."tipo_aceptacion") - (SELECT count(*) FROM "legacy_raw"."tipo_aceptacion") AS diferencia
UNION ALL
SELECT 'logistica.tipo_envases' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_envases") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."tipo_envases") AS filas_destino,
       (SELECT count(*) FROM "logistica"."tipo_envases") - (SELECT count(*) FROM "legacy_raw"."tipo_envases") AS diferencia
UNION ALL
SELECT 'logistica.tipo_existencia' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_existencia") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."tipo_existencia") AS filas_destino,
       (SELECT count(*) FROM "logistica"."tipo_existencia") - (SELECT count(*) FROM "legacy_raw"."tipo_existencia") AS diferencia
UNION ALL
SELECT 'logistica.tipo_ingr_sali' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_ingr_sali") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."tipo_ingr_sali") AS filas_destino,
       (SELECT count(*) FROM "logistica"."tipo_ingr_sali") - (SELECT count(*) FROM "legacy_raw"."tipo_ingr_sali") AS diferencia
UNION ALL
SELECT 'logistica.unid_oper_divi' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."unid_oper_divi") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."unid_oper_divi") AS filas_destino,
       (SELECT count(*) FROM "logistica"."unid_oper_divi") - (SELECT count(*) FROM "legacy_raw"."unid_oper_divi") AS diferencia
UNION ALL
SELECT 'logistica.vale_salida' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."vale_salida") AS filas_legacy,
       (SELECT count(*) FROM "logistica"."vale_salida") AS filas_destino,
       (SELECT count(*) FROM "logistica"."vale_salida") - (SELECT count(*) FROM "legacy_raw"."vale_salida") AS diferencia
UNION ALL
SELECT 'maestros.acti_econ_prin' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."acti_econ_prin") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."acti_econ_prin") AS filas_destino,
       (SELECT count(*) FROM "maestros"."acti_econ_prin") - (SELECT count(*) FROM "legacy_raw"."acti_econ_prin") AS diferencia
UNION ALL
SELECT 'maestros.aduana' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."aduana") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."aduana") AS filas_destino,
       (SELECT count(*) FROM "maestros"."aduana") - (SELECT count(*) FROM "legacy_raw"."aduana") AS diferencia
UNION ALL
SELECT 'maestros.clie_prov_suspen_cta_categ' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."clie_prov_suspen_cta_categ") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."clie_prov_suspen_cta_categ") AS filas_destino,
       (SELECT count(*) FROM "maestros"."clie_prov_suspen_cta_categ") - (SELECT count(*) FROM "legacy_raw"."clie_prov_suspen_cta_categ") AS diferencia
UNION ALL
SELECT 'maestros.cliente_natural' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cliente_natural") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."cliente_natural") AS filas_destino,
       (SELECT count(*) FROM "maestros"."cliente_natural") - (SELECT count(*) FROM "legacy_raw"."cliente_natural") AS diferencia
UNION ALL
SELECT 'maestros.cliente_proveedor' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cliente_proveedor") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."cliente_proveedor") AS filas_destino,
       (SELECT count(*) FROM "maestros"."cliente_proveedor") - (SELECT count(*) FROM "legacy_raw"."cliente_proveedor") AS diferencia
UNION ALL
SELECT 'maestros.codigos_ldistancia' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."codigos_ldistancia") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."codigos_ldistancia") AS filas_destino,
       (SELECT count(*) FROM "maestros"."codigos_ldistancia") - (SELECT count(*) FROM "legacy_raw"."codigos_ldistancia") AS diferencia
UNION ALL
SELECT 'maestros.cultivos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cultivos") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."cultivos") AS filas_destino,
       (SELECT count(*) FROM "maestros"."cultivos") - (SELECT count(*) FROM "legacy_raw"."cultivos") AS diferencia
UNION ALL
SELECT 'maestros.documentos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."documentos") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."documentos") AS filas_destino,
       (SELECT count(*) FROM "maestros"."documentos") - (SELECT count(*) FROM "legacy_raw"."documentos") AS diferencia
UNION ALL
SELECT 'maestros.domicilio' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."domicilio") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."domicilio") AS filas_destino,
       (SELECT count(*) FROM "maestros"."domicilio") - (SELECT count(*) FROM "legacy_raw"."domicilio") AS diferencia
UNION ALL
SELECT 'maestros.establecimiento' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."establecimiento") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."establecimiento") AS filas_destino,
       (SELECT count(*) FROM "maestros"."establecimiento") - (SELECT count(*) FROM "legacy_raw"."establecimiento") AS diferencia
UNION ALL
SELECT 'maestros.estados' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."estados") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."estados") AS filas_destino,
       (SELECT count(*) FROM "maestros"."estados") - (SELECT count(*) FROM "legacy_raw"."estados") AS diferencia
UNION ALL
SELECT 'maestros.etapa_fenologica' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."etapa_fenologica") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."etapa_fenologica") AS filas_destino,
       (SELECT count(*) FROM "maestros"."etapa_fenologica") - (SELECT count(*) FROM "legacy_raw"."etapa_fenologica") AS diferencia
UNION ALL
SELECT 'maestros.evento' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."evento") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."evento") AS filas_destino,
       (SELECT count(*) FROM "maestros"."evento") - (SELECT count(*) FROM "legacy_raw"."evento") AS diferencia
UNION ALL
SELECT 'maestros.feriados' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."feriados") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."feriados") AS filas_destino,
       (SELECT count(*) FROM "maestros"."feriados") - (SELECT count(*) FROM "legacy_raw"."feriados") AS diferencia
UNION ALL
SELECT 'maestros.monedas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."monedas") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."monedas") AS filas_destino,
       (SELECT count(*) FROM "maestros"."monedas") - (SELECT count(*) FROM "legacy_raw"."monedas") AS diferencia
UNION ALL
SELECT 'maestros.motivos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."motivos") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."motivos") AS filas_destino,
       (SELECT count(*) FROM "maestros"."motivos") - (SELECT count(*) FROM "legacy_raw"."motivos") AS diferencia
UNION ALL
SELECT 'maestros.nacion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."nacion") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."nacion") AS filas_destino,
       (SELECT count(*) FROM "maestros"."nacion") - (SELECT count(*) FROM "legacy_raw"."nacion") AS diferencia
UNION ALL
SELECT 'maestros.pais_emisor' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pais_emisor") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."pais_emisor") AS filas_destino,
       (SELECT count(*) FROM "maestros"."pais_emisor") - (SELECT count(*) FROM "legacy_raw"."pais_emisor") AS diferencia
UNION ALL
SELECT 'maestros.referencias' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."referencias") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."referencias") AS filas_destino,
       (SELECT count(*) FROM "maestros"."referencias") - (SELECT count(*) FROM "legacy_raw"."referencias") AS diferencia
UNION ALL
SELECT 'maestros.semana' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."semana") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."semana") AS filas_destino,
       (SELECT count(*) FROM "maestros"."semana") - (SELECT count(*) FROM "legacy_raw"."semana") AS diferencia
UNION ALL
SELECT 'maestros.telefono' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."telefono") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."telefono") AS filas_destino,
       (SELECT count(*) FROM "maestros"."telefono") - (SELECT count(*) FROM "legacy_raw"."telefono") AS diferencia
UNION ALL
SELECT 'maestros.terceros' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."terceros") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."terceros") AS filas_destino,
       (SELECT count(*) FROM "maestros"."terceros") - (SELECT count(*) FROM "legacy_raw"."terceros") AS diferencia
UNION ALL
SELECT 'maestros.tipo_cambio_a_dolar' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_cambio_a_dolar") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."tipo_cambio_a_dolar") AS filas_destino,
       (SELECT count(*) FROM "maestros"."tipo_cambio_a_dolar") - (SELECT count(*) FROM "legacy_raw"."tipo_cambio_a_dolar") AS diferencia
UNION ALL
SELECT 'maestros.tipo_docu_iden' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_docu_iden") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."tipo_docu_iden") AS filas_destino,
       (SELECT count(*) FROM "maestros"."tipo_docu_iden") - (SELECT count(*) FROM "legacy_raw"."tipo_docu_iden") AS diferencia
UNION ALL
SELECT 'maestros.tipo_documento' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_documento") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."tipo_documento") AS filas_destino,
       (SELECT count(*) FROM "maestros"."tipo_documento") - (SELECT count(*) FROM "legacy_raw"."tipo_documento") AS diferencia
UNION ALL
SELECT 'maestros.tipo_empresa' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_empresa") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."tipo_empresa") AS filas_destino,
       (SELECT count(*) FROM "maestros"."tipo_empresa") - (SELECT count(*) FROM "legacy_raw"."tipo_empresa") AS diferencia
UNION ALL
SELECT 'maestros.tipo_medida' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_medida") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."tipo_medida") AS filas_destino,
       (SELECT count(*) FROM "maestros"."tipo_medida") - (SELECT count(*) FROM "legacy_raw"."tipo_medida") AS diferencia
UNION ALL
SELECT 'maestros.tipo_pago' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_pago") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."tipo_pago") AS filas_destino,
       (SELECT count(*) FROM "maestros"."tipo_pago") - (SELECT count(*) FROM "legacy_raw"."tipo_pago") AS diferencia
UNION ALL
SELECT 'maestros.tipo_unid_oper' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_unid_oper") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."tipo_unid_oper") AS filas_destino,
       (SELECT count(*) FROM "maestros"."tipo_unid_oper") - (SELECT count(*) FROM "legacy_raw"."tipo_unid_oper") AS diferencia
UNION ALL
SELECT 'maestros.transacciones' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."transacciones") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."transacciones") AS filas_destino,
       (SELECT count(*) FROM "maestros"."transacciones") - (SELECT count(*) FROM "legacy_raw"."transacciones") AS diferencia
UNION ALL
SELECT 'maestros.transportistas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."transportistas") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."transportistas") AS filas_destino,
       (SELECT count(*) FROM "maestros"."transportistas") - (SELECT count(*) FROM "legacy_raw"."transportistas") AS diferencia
UNION ALL
SELECT 'maestros.ubigeo_distrito' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ubigeo_distrito") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."ubigeo_distrito") AS filas_destino,
       (SELECT count(*) FROM "maestros"."ubigeo_distrito") - (SELECT count(*) FROM "legacy_raw"."ubigeo_distrito") AS diferencia
UNION ALL
SELECT 'maestros.ubigeo_provincia' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ubigeo_provincia") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."ubigeo_provincia") AS filas_destino,
       (SELECT count(*) FROM "maestros"."ubigeo_provincia") - (SELECT count(*) FROM "legacy_raw"."ubigeo_provincia") AS diferencia
UNION ALL
SELECT 'maestros.ubigeo_region' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ubigeo_region") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."ubigeo_region") AS filas_destino,
       (SELECT count(*) FROM "maestros"."ubigeo_region") - (SELECT count(*) FROM "legacy_raw"."ubigeo_region") AS diferencia
UNION ALL
SELECT 'maestros.unid_oper' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."unid_oper") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."unid_oper") AS filas_destino,
       (SELECT count(*) FROM "maestros"."unid_oper") - (SELECT count(*) FROM "legacy_raw"."unid_oper") AS diferencia
UNION ALL
SELECT 'maestros.unidad_medida' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."unidad_medida") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."unidad_medida") AS filas_destino,
       (SELECT count(*) FROM "maestros"."unidad_medida") - (SELECT count(*) FROM "legacy_raw"."unidad_medida") AS diferencia
UNION ALL
SELECT 'maestros.unidad_medida_inter' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."unidad_medida_inter") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."unidad_medida_inter") AS filas_destino,
       (SELECT count(*) FROM "maestros"."unidad_medida_inter") - (SELECT count(*) FROM "legacy_raw"."unidad_medida_inter") AS diferencia
UNION ALL
SELECT 'maestros.unidad_medida_sunat' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."unidad_medida_sunat") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."unidad_medida_sunat") AS filas_destino,
       (SELECT count(*) FROM "maestros"."unidad_medida_sunat") - (SELECT count(*) FROM "legacy_raw"."unidad_medida_sunat") AS diferencia
UNION ALL
SELECT 'maestros.unidad_negocio' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."unidad_negocio") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."unidad_negocio") AS filas_destino,
       (SELECT count(*) FROM "maestros"."unidad_negocio") - (SELECT count(*) FROM "legacy_raw"."unidad_negocio") AS diferencia
UNION ALL
SELECT 'maestros.valores_unitarios' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."valores_unitarios") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."valores_unitarios") AS filas_destino,
       (SELECT count(*) FROM "maestros"."valores_unitarios") - (SELECT count(*) FROM "legacy_raw"."valores_unitarios") AS diferencia
UNION ALL
SELECT 'maestros.valores_unitarios_anuales' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."valores_unitarios_anuales") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."valores_unitarios_anuales") AS filas_destino,
       (SELECT count(*) FROM "maestros"."valores_unitarios_anuales") - (SELECT count(*) FROM "legacy_raw"."valores_unitarios_anuales") AS diferencia
UNION ALL
SELECT 'maestros.via' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."via") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."via") AS filas_destino,
       (SELECT count(*) FROM "maestros"."via") - (SELECT count(*) FROM "legacy_raw"."via") AS diferencia
UNION ALL
SELECT 'maestros.zona' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."zona") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."zona") AS filas_destino,
       (SELECT count(*) FROM "maestros"."zona") - (SELECT count(*) FROM "legacy_raw"."zona") AS diferencia
UNION ALL
SELECT 'maestros.zonas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."zonas") AS filas_legacy,
       (SELECT count(*) FROM "maestros"."zonas") AS filas_destino,
       (SELECT count(*) FROM "maestros"."zonas") - (SELECT count(*) FROM "legacy_raw"."zonas") AS diferencia
UNION ALL
SELECT 'produccion.analisis_aceite' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."analisis_aceite") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."analisis_aceite") AS filas_destino,
       (SELECT count(*) FROM "produccion"."analisis_aceite") - (SELECT count(*) FROM "legacy_raw"."analisis_aceite") AS diferencia
UNION ALL
SELECT 'produccion.analisis_parametro' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."analisis_parametro") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."analisis_parametro") AS filas_destino,
       (SELECT count(*) FROM "produccion"."analisis_parametro") - (SELECT count(*) FROM "legacy_raw"."analisis_parametro") AS diferencia
UNION ALL
SELECT 'produccion.consumo_combustible' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."consumo_combustible") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."consumo_combustible") AS filas_destino,
       (SELECT count(*) FROM "produccion"."consumo_combustible") - (SELECT count(*) FROM "legacy_raw"."consumo_combustible") AS diferencia
UNION ALL
SELECT 'produccion.derechopesca' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."derechopesca") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."derechopesca") AS filas_destino,
       (SELECT count(*) FROM "produccion"."derechopesca") - (SELECT count(*) FROM "legacy_raw"."derechopesca") AS diferencia
UNION ALL
SELECT 'produccion.destinos_pesca' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."destinos_pesca") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."destinos_pesca") AS filas_destino,
       (SELECT count(*) FROM "produccion"."destinos_pesca") - (SELECT count(*) FROM "legacy_raw"."destinos_pesca") AS diferencia
UNION ALL
SELECT 'produccion.detalle_factura_pesca' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."detalle_factura_pesca") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."detalle_factura_pesca") AS filas_destino,
       (SELECT count(*) FROM "produccion"."detalle_factura_pesca") - (SELECT count(*) FROM "legacy_raw"."detalle_factura_pesca") AS diferencia
UNION ALL
SELECT 'produccion.detalle_zarpe' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."detalle_zarpe") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."detalle_zarpe") AS filas_destino,
       (SELECT count(*) FROM "produccion"."detalle_zarpe") - (SELECT count(*) FROM "legacy_raw"."detalle_zarpe") AS diferencia
UNION ALL
SELECT 'produccion.emba_venc_cert' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."emba_venc_cert") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."emba_venc_cert") AS filas_destino,
       (SELECT count(*) FROM "produccion"."emba_venc_cert") - (SELECT count(*) FROM "legacy_raw"."emba_venc_cert") AS diferencia
UNION ALL
SELECT 'produccion.embar_carac' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."embar_carac") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."embar_carac") AS filas_destino,
       (SELECT count(*) FROM "produccion"."embar_carac") - (SELECT count(*) FROM "legacy_raw"."embar_carac") AS diferencia
UNION ALL
SELECT 'produccion.embarcaciones' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."embarcaciones") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."embarcaciones") AS filas_destino,
       (SELECT count(*) FROM "produccion"."embarcaciones") - (SELECT count(*) FROM "legacy_raw"."embarcaciones") AS diferencia
UNION ALL
SELECT 'produccion.especies' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."especies") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."especies") AS filas_destino,
       (SELECT count(*) FROM "produccion"."especies") - (SELECT count(*) FROM "legacy_raw"."especies") AS diferencia
UNION ALL
SELECT 'produccion.informe_acidez' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."informe_acidez") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."informe_acidez") AS filas_destino,
       (SELECT count(*) FROM "produccion"."informe_acidez") - (SELECT count(*) FROM "legacy_raw"."informe_acidez") AS diferencia
UNION ALL
SELECT 'produccion.lugar_origen' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."lugar_origen") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."lugar_origen") AS filas_destino,
       (SELECT count(*) FROM "produccion"."lugar_origen") - (SELECT count(*) FROM "legacy_raw"."lugar_origen") AS diferencia
UNION ALL
SELECT 'produccion.nota_ingreso_aceite' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."nota_ingreso_aceite") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."nota_ingreso_aceite") AS filas_destino,
       (SELECT count(*) FROM "produccion"."nota_ingreso_aceite") - (SELECT count(*) FROM "legacy_raw"."nota_ingreso_aceite") AS diferencia
UNION ALL
SELECT 'produccion.nrotrip_embar' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."nrotrip_embar") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."nrotrip_embar") AS filas_destino,
       (SELECT count(*) FROM "produccion"."nrotrip_embar") - (SELECT count(*) FROM "legacy_raw"."nrotrip_embar") AS diferencia
UNION ALL
SELECT 'produccion.orden_compra_aceite' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."orden_compra_aceite") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."orden_compra_aceite") AS filas_destino,
       (SELECT count(*) FROM "produccion"."orden_compra_aceite") - (SELECT count(*) FROM "legacy_raw"."orden_compra_aceite") AS diferencia
UNION ALL
SELECT 'produccion.orden_produccion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."orden_produccion") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."orden_produccion") AS filas_destino,
       (SELECT count(*) FROM "produccion"."orden_produccion") - (SELECT count(*) FROM "legacy_raw"."orden_produccion") AS diferencia
UNION ALL
SELECT 'produccion.orden_produccion_factura' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."orden_produccion_factura") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."orden_produccion_factura") AS filas_destino,
       (SELECT count(*) FROM "produccion"."orden_produccion_factura") - (SELECT count(*) FROM "legacy_raw"."orden_produccion_factura") AS diferencia
UNION ALL
SELECT 'produccion.parte_cargo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."parte_cargo") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."parte_cargo") AS filas_destino,
       (SELECT count(*) FROM "produccion"."parte_cargo") - (SELECT count(*) FROM "legacy_raw"."parte_cargo") AS diferencia
UNION ALL
SELECT 'produccion.pozas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pozas") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."pozas") AS filas_destino,
       (SELECT count(*) FROM "produccion"."pozas") - (SELECT count(*) FROM "legacy_raw"."pozas") AS diferencia
UNION ALL
SELECT 'produccion.precio_pactado' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."precio_pactado") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."precio_pactado") AS filas_destino,
       (SELECT count(*) FROM "produccion"."precio_pactado") - (SELECT count(*) FROM "legacy_raw"."precio_pactado") AS diferencia
UNION ALL
SELECT 'produccion.precio_snp' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."precio_snp") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."precio_snp") AS filas_destino,
       (SELECT count(*) FROM "produccion"."precio_snp") - (SELECT count(*) FROM "legacy_raw"."precio_snp") AS diferencia
UNION ALL
SELECT 'produccion.propias_terceros' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."propias_terceros") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."propias_terceros") AS filas_destino,
       (SELECT count(*) FROM "produccion"."propias_terceros") - (SELECT count(*) FROM "legacy_raw"."propias_terceros") AS diferencia
UNION ALL
SELECT 'produccion.puerto' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."puerto") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."puerto") AS filas_destino,
       (SELECT count(*) FROM "produccion"."puerto") - (SELECT count(*) FROM "legacy_raw"."puerto") AS diferencia
UNION ALL
SELECT 'produccion.ratio_produccion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ratio_produccion") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."ratio_produccion") AS filas_destino,
       (SELECT count(*) FROM "produccion"."ratio_produccion") - (SELECT count(*) FROM "legacy_raw"."ratio_produccion") AS diferencia
UNION ALL
SELECT 'produccion.saldo_poza' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."saldo_poza") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."saldo_poza") AS filas_destino,
       (SELECT count(*) FROM "produccion"."saldo_poza") - (SELECT count(*) FROM "legacy_raw"."saldo_poza") AS diferencia
UNION ALL
SELECT 'produccion.saldo_tanques' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."saldo_tanques") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."saldo_tanques") AS filas_destino,
       (SELECT count(*) FROM "produccion"."saldo_tanques") - (SELECT count(*) FROM "legacy_raw"."saldo_tanques") AS diferencia
UNION ALL
SELECT 'produccion.sistemas_embarcaciones' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sistemas_embarcaciones") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."sistemas_embarcaciones") AS filas_destino,
       (SELECT count(*) FROM "produccion"."sistemas_embarcaciones") - (SELECT count(*) FROM "legacy_raw"."sistemas_embarcaciones") AS diferencia
UNION ALL
SELECT 'produccion.situ_emba' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."situ_emba") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."situ_emba") AS filas_destino,
       (SELECT count(*) FROM "produccion"."situ_emba") - (SELECT count(*) FROM "legacy_raw"."situ_emba") AS diferencia
UNION ALL
SELECT 'produccion.taller_diario' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."taller_diario") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."taller_diario") AS filas_destino,
       (SELECT count(*) FROM "produccion"."taller_diario") - (SELECT count(*) FROM "legacy_raw"."taller_diario") AS diferencia
UNION ALL
SELECT 'produccion.talleres' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."talleres") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."talleres") AS filas_destino,
       (SELECT count(*) FROM "produccion"."talleres") - (SELECT count(*) FROM "legacy_raw"."talleres") AS diferencia
UNION ALL
SELECT 'produccion.tanq_auxiliar' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tanq_auxiliar") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."tanq_auxiliar") AS filas_destino,
       (SELECT count(*) FROM "produccion"."tanq_auxiliar") - (SELECT count(*) FROM "legacy_raw"."tanq_auxiliar") AS diferencia
UNION ALL
SELECT 'produccion.tanques' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tanques") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."tanques") AS filas_destino,
       (SELECT count(*) FROM "produccion"."tanques") - (SELECT count(*) FROM "legacy_raw"."tanques") AS diferencia
UNION ALL
SELECT 'produccion.tipo_cert_emba' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_cert_emba") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."tipo_cert_emba") AS filas_destino,
       (SELECT count(*) FROM "produccion"."tipo_cert_emba") - (SELECT count(*) FROM "legacy_raw"."tipo_cert_emba") AS diferencia
UNION ALL
SELECT 'produccion.tipo_destino' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_destino") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."tipo_destino") AS filas_destino,
       (SELECT count(*) FROM "produccion"."tipo_destino") - (SELECT count(*) FROM "legacy_raw"."tipo_destino") AS diferencia
UNION ALL
SELECT 'produccion.tipo_titu_pesc' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_titu_pesc") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."tipo_titu_pesc") AS filas_destino,
       (SELECT count(*) FROM "produccion"."tipo_titu_pesc") - (SELECT count(*) FROM "legacy_raw"."tipo_titu_pesc") AS diferencia
UNION ALL
SELECT 'produccion.tipos_orden_produccion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipos_orden_produccion") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."tipos_orden_produccion") AS filas_destino,
       (SELECT count(*) FROM "produccion"."tipos_orden_produccion") - (SELECT count(*) FROM "legacy_raw"."tipos_orden_produccion") AS diferencia
UNION ALL
SELECT 'produccion.zarp_obse' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."zarp_obse") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."zarp_obse") AS filas_destino,
       (SELECT count(*) FROM "produccion"."zarp_obse") - (SELECT count(*) FROM "legacy_raw"."zarp_obse") AS diferencia
UNION ALL
SELECT 'produccion.zarpe_combustible' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."zarpe_combustible") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."zarpe_combustible") AS filas_destino,
       (SELECT count(*) FROM "produccion"."zarpe_combustible") - (SELECT count(*) FROM "legacy_raw"."zarpe_combustible") AS diferencia
UNION ALL
SELECT 'produccion.zarpes' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."zarpes") AS filas_legacy,
       (SELECT count(*) FROM "produccion"."zarpes") AS filas_destino,
       (SELECT count(*) FROM "produccion"."zarpes") - (SELECT count(*) FROM "legacy_raw"."zarpes") AS diferencia
UNION ALL
SELECT 'rrhh.abogados' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."abogados") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."abogados") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."abogados") - (SELECT count(*) FROM "legacy_raw"."abogados") AS diferencia
UNION ALL
SELECT 'rrhh.actividad' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."actividad") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."actividad") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."actividad") - (SELECT count(*) FROM "legacy_raw"."actividad") AS diferencia
UNION ALL
SELECT 'rrhh.adelanto_ep_terceros' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."adelanto_ep_terceros") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."adelanto_ep_terceros") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."adelanto_ep_terceros") - (SELECT count(*) FROM "legacy_raw"."adelanto_ep_terceros") AS diferencia
UNION ALL
SELECT 'rrhh.adelantos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."adelantos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."adelantos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."adelantos") - (SELECT count(*) FROM "legacy_raw"."adelantos") AS diferencia
UNION ALL
SELECT 'rrhh.area_grup' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."area_grup") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."area_grup") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."area_grup") - (SELECT count(*) FROM "legacy_raw"."area_grup") AS diferencia
UNION ALL
SELECT 'rrhh.areas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."areas") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."areas") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."areas") - (SELECT count(*) FROM "legacy_raw"."areas") AS diferencia
UNION ALL
SELECT 'rrhh.asistencia_maqui_motor' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."asistencia_maqui_motor") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."asistencia_maqui_motor") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."asistencia_maqui_motor") - (SELECT count(*) FROM "legacy_raw"."asistencia_maqui_motor") AS diferencia
UNION ALL
SELECT 'rrhh.asistencia_motorista' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."asistencia_motorista") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."asistencia_motorista") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."asistencia_motorista") - (SELECT count(*) FROM "legacy_raw"."asistencia_motorista") AS diferencia
UNION ALL
SELECT 'rrhh.asistencia_personal' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."asistencia_personal") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."asistencia_personal") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."asistencia_personal") - (SELECT count(*) FROM "legacy_raw"."asistencia_personal") AS diferencia
UNION ALL
SELECT 'rrhh.asistencia_tripulantes_pesca' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."asistencia_tripulantes_pesca") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."asistencia_tripulantes_pesca") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."asistencia_tripulantes_pesca") - (SELECT count(*) FROM "legacy_raw"."asistencia_tripulantes_pesca") AS diferencia
UNION ALL
SELECT 'rrhh.auto_trab_cent_oper' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."auto_trab_cent_oper") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."auto_trab_cent_oper") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."auto_trab_cent_oper") - (SELECT count(*) FROM "legacy_raw"."auto_trab_cent_oper") AS diferencia
UNION ALL
SELECT 'rrhh.auto_trab_cent_oper_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."auto_trab_cent_oper_deta") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."auto_trab_cent_oper_deta") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."auto_trab_cent_oper_deta") - (SELECT count(*) FROM "legacy_raw"."auto_trab_cent_oper_deta") AS diferencia
UNION ALL
SELECT 'rrhh.calc_util_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."calc_util_deta") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."calc_util_deta") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."calc_util_deta") - (SELECT count(*) FROM "legacy_raw"."calc_util_deta") AS diferencia
UNION ALL
SELECT 'rrhh.calc_util_pers' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."calc_util_pers") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."calc_util_pers") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."calc_util_pers") - (SELECT count(*) FROM "legacy_raw"."calc_util_pers") AS diferencia
UNION ALL
SELECT 'rrhh.calc_util_tota' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."calc_util_tota") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."calc_util_tota") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."calc_util_tota") - (SELECT count(*) FROM "legacy_raw"."calc_util_tota") AS diferencia
UNION ALL
SELECT 'rrhh.cargos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cargos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."cargos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."cargos") - (SELECT count(*) FROM "legacy_raw"."cargos") AS diferencia
UNION ALL
SELECT 'rrhh.categoria_ocupacional' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."categoria_ocupacional") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."categoria_ocupacional") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."categoria_ocupacional") - (SELECT count(*) FROM "legacy_raw"."categoria_ocupacional") AS diferencia
UNION ALL
SELECT 'rrhh.categoria_trabajador' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."categoria_trabajador") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."categoria_trabajador") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."categoria_trabajador") - (SELECT count(*) FROM "legacy_raw"."categoria_trabajador") AS diferencia
UNION ALL
SELECT 'rrhh.conceptos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."conceptos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."conceptos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."conceptos") - (SELECT count(*) FROM "legacy_raw"."conceptos") AS diferencia
UNION ALL
SELECT 'rrhh.conceptos_afectos_planillas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."conceptos_afectos_planillas") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."conceptos_afectos_planillas") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."conceptos_afectos_planillas") - (SELECT count(*) FROM "legacy_raw"."conceptos_afectos_planillas") AS diferencia
UNION ALL
SELECT 'rrhh.conceptos_contables' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."conceptos_contables") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."conceptos_contables") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."conceptos_contables") - (SELECT count(*) FROM "legacy_raw"."conceptos_contables") AS diferencia
UNION ALL
SELECT 'rrhh.constancia_juicios' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."constancia_juicios") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."constancia_juicios") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."constancia_juicios") - (SELECT count(*) FROM "legacy_raw"."constancia_juicios") AS diferencia
UNION ALL
SELECT 'rrhh.contratos_personal' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."contratos_personal") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."contratos_personal") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."contratos_personal") - (SELECT count(*) FROM "legacy_raw"."contratos_personal") AS diferencia
UNION ALL
SELECT 'rrhh.convenio_evita_doble_tributacion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."convenio_evita_doble_tributacion") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."convenio_evita_doble_tributacion") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."convenio_evita_doble_tributacion") - (SELECT count(*) FROM "legacy_raw"."convenio_evita_doble_tributacion") AS diferencia
UNION ALL
SELECT 'rrhh.datos_cts' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."datos_cts") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."datos_cts") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."datos_cts") - (SELECT count(*) FROM "legacy_raw"."datos_cts") AS diferencia
UNION ALL
SELECT 'rrhh.demandas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."demandas") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."demandas") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."demandas") - (SELECT count(*) FROM "legacy_raw"."demandas") AS diferencia
UNION ALL
SELECT 'rrhh.derecho_habiente' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."derecho_habiente") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."derecho_habiente") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."derecho_habiente") - (SELECT count(*) FROM "legacy_raw"."derecho_habiente") AS diferencia
UNION ALL
SELECT 'rrhh.desplazan_personal' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."desplazan_personal") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."desplazan_personal") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."desplazan_personal") - (SELECT count(*) FROM "legacy_raw"."desplazan_personal") AS diferencia
UNION ALL
SELECT 'rrhh.desplazo_personal' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."desplazo_personal") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."desplazo_personal") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."desplazo_personal") - (SELECT count(*) FROM "legacy_raw"."desplazo_personal") AS diferencia
UNION ALL
SELECT 'rrhh.deta_ingr_grat_trip' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."deta_ingr_grat_trip") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."deta_ingr_grat_trip") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."deta_ingr_grat_trip") - (SELECT count(*) FROM "legacy_raw"."deta_ingr_grat_trip") AS diferencia
UNION ALL
SELECT 'rrhh.dias_trab' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."dias_trab") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."dias_trab") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."dias_trab") - (SELECT count(*) FROM "legacy_raw"."dias_trab") AS diferencia
UNION ALL
SELECT 'rrhh.documento_vinculo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."documento_vinculo") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."documento_vinculo") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."documento_vinculo") - (SELECT count(*) FROM "legacy_raw"."documento_vinculo") AS diferencia
UNION ALL
SELECT 'rrhh.entidad_salud' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."entidad_salud") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."entidad_salud") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."entidad_salud") - (SELECT count(*) FROM "legacy_raw"."entidad_salud") AS diferencia
UNION ALL
SELECT 'rrhh.especialistas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."especialistas") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."especialistas") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."especialistas") - (SELECT count(*) FROM "legacy_raw"."especialistas") AS diferencia
UNION ALL
SELECT 'rrhh.extr_cont_liqu_pesc' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."extr_cont_liqu_pesc") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."extr_cont_liqu_pesc") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."extr_cont_liqu_pesc") - (SELECT count(*) FROM "legacy_raw"."extr_cont_liqu_pesc") AS diferencia
UNION ALL
SELECT 'rrhh.extra_conta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."extra_conta") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."extra_conta") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."extra_conta") - (SELECT count(*) FROM "legacy_raw"."extra_conta") AS diferencia
UNION ALL
SELECT 'rrhh.grat_trip_deta_conc' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."grat_trip_deta_conc") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."grat_trip_deta_conc") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."grat_trip_deta_conc") - (SELECT count(*) FROM "legacy_raw"."grat_trip_deta_conc") AS diferencia
UNION ALL
SELECT 'rrhh.hora_labo_sema' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."hora_labo_sema") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."hora_labo_sema") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."hora_labo_sema") - (SELECT count(*) FROM "legacy_raw"."hora_labo_sema") AS diferencia
UNION ALL
SELECT 'rrhh.hora_pers_fech' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."hora_pers_fech") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."hora_pers_fech") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."hora_pers_fech") - (SELECT count(*) FROM "legacy_raw"."hora_pers_fech") AS diferencia
UNION ALL
SELECT 'rrhh.hora_plan_vaca_grat' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."hora_plan_vaca_grat") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."hora_plan_vaca_grat") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."hora_plan_vaca_grat") - (SELECT count(*) FROM "legacy_raw"."hora_plan_vaca_grat") AS diferencia
UNION ALL
SELECT 'rrhh.horario' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."horario") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."horario") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."horario") - (SELECT count(*) FROM "legacy_raw"."horario") AS diferencia
UNION ALL
SELECT 'rrhh.horas_laboradas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."horas_laboradas") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."horas_laboradas") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."horas_laboradas") - (SELECT count(*) FROM "legacy_raw"."horas_laboradas") AS diferencia
UNION ALL
SELECT 'rrhh.incrementos_personal' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."incrementos_personal") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."incrementos_personal") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."incrementos_personal") - (SELECT count(*) FROM "legacy_raw"."incrementos_personal") AS diferencia
UNION ALL
SELECT 'rrhh.ingresos_quinta_categ' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ingresos_quinta_categ") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."ingresos_quinta_categ") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."ingresos_quinta_categ") - (SELECT count(*) FROM "legacy_raw"."ingresos_quinta_categ") AS diferencia
UNION ALL
SELECT 'rrhh.jueces' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."jueces") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."jueces") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."jueces") - (SELECT count(*) FROM "legacy_raw"."jueces") AS diferencia
UNION ALL
SELECT 'rrhh.juicios' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."juicios") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."juicios") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."juicios") - (SELECT count(*) FROM "legacy_raw"."juicios") AS diferencia
UNION ALL
SELECT 'rrhh.juicios_empresa' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."juicios_empresa") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."juicios_empresa") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."juicios_empresa") - (SELECT count(*) FROM "legacy_raw"."juicios_empresa") AS diferencia
UNION ALL
SELECT 'rrhh.juzgados' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."juzgados") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."juzgados") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."juzgados") - (SELECT count(*) FROM "legacy_raw"."juzgados") AS diferencia
UNION ALL
SELECT 'rrhh.licencias_por_personal' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."licencias_por_personal") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."licencias_por_personal") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."licencias_por_personal") - (SELECT count(*) FROM "legacy_raw"."licencias_por_personal") AS diferencia
UNION ALL
SELECT 'rrhh.lugar_trabajo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."lugar_trabajo") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."lugar_trabajo") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."lugar_trabajo") - (SELECT count(*) FROM "legacy_raw"."lugar_trabajo") AS diferencia
UNION ALL
SELECT 'rrhh.modalidad_formativa' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."modalidad_formativa") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."modalidad_formativa") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."modalidad_formativa") - (SELECT count(*) FROM "legacy_raw"."modalidad_formativa") AS diferencia
UNION ALL
SELECT 'rrhh.moti_baja_dh' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."moti_baja_dh") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."moti_baja_dh") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."moti_baja_dh") - (SELECT count(*) FROM "legacy_raw"."moti_baja_dh") AS diferencia
UNION ALL
SELECT 'rrhh.moti_fin_periodo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."moti_fin_periodo") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."moti_fin_periodo") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."moti_fin_periodo") - (SELECT count(*) FROM "legacy_raw"."moti_fin_periodo") AS diferencia
UNION ALL
SELECT 'rrhh.nivel' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."nivel") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."nivel") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."nivel") - (SELECT count(*) FROM "legacy_raw"."nivel") AS diferencia
UNION ALL
SELECT 'rrhh.ocupacion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ocupacion") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."ocupacion") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."ocupacion") - (SELECT count(*) FROM "legacy_raw"."ocupacion") AS diferencia
UNION ALL
SELECT 'rrhh.pagos_adelantos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pagos_adelantos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."pagos_adelantos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."pagos_adelantos") - (SELECT count(*) FROM "legacy_raw"."pagos_adelantos") AS diferencia
UNION ALL
SELECT 'rrhh.pagos_prestamos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pagos_prestamos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."pagos_prestamos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."pagos_prestamos") - (SELECT count(*) FROM "legacy_raw"."pagos_prestamos") AS diferencia
UNION ALL
SELECT 'rrhh.parametros_quinta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."parametros_quinta") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."parametros_quinta") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."parametros_quinta") - (SELECT count(*) FROM "legacy_raw"."parametros_quinta") AS diferencia
UNION ALL
SELECT 'rrhh.pension' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pension") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."pension") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."pension") - (SELECT count(*) FROM "legacy_raw"."pension") AS diferencia
UNION ALL
SELECT 'rrhh.periodicidad' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."periodicidad") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."periodicidad") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."periodicidad") - (SELECT count(*) FROM "legacy_raw"."periodicidad") AS diferencia
UNION ALL
SELECT 'rrhh.pers_dato_adic' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pers_dato_adic") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."pers_dato_adic") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."pers_dato_adic") - (SELECT count(*) FROM "legacy_raw"."pers_dato_adic") AS diferencia
UNION ALL
SELECT 'rrhh.pers_refe_labo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pers_refe_labo") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."pers_refe_labo") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."pers_refe_labo") - (SELECT count(*) FROM "legacy_raw"."pers_refe_labo") AS diferencia
UNION ALL
SELECT 'rrhh.pers_soli' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pers_soli") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."pers_soli") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."pers_soli") - (SELECT count(*) FROM "legacy_raw"."pers_soli") AS diferencia
UNION ALL
SELECT 'rrhh.pers_trip_vige_cert' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pers_trip_vige_cert") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."pers_trip_vige_cert") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."pers_trip_vige_cert") - (SELECT count(*) FROM "legacy_raw"."pers_trip_vige_cert") AS diferencia
UNION ALL
SELECT 'rrhh.personal' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."personal") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."personal") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."personal") - (SELECT count(*) FROM "legacy_raw"."personal") AS diferencia
UNION ALL
SELECT 'rrhh.personal_categoria' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."personal_categoria") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."personal_categoria") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."personal_categoria") - (SELECT count(*) FROM "legacy_raw"."personal_categoria") AS diferencia
UNION ALL
SELECT 'rrhh.personal_otros_emple_qta_cat' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."personal_otros_emple_qta_cat") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."personal_otros_emple_qta_cat") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."personal_otros_emple_qta_cat") - (SELECT count(*) FROM "legacy_raw"."personal_otros_emple_qta_cat") AS diferencia
UNION ALL
SELECT 'rrhh.personal_periodo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."personal_periodo") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."personal_periodo") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."personal_periodo") - (SELECT count(*) FROM "legacy_raw"."personal_periodo") AS diferencia
UNION ALL
SELECT 'rrhh.personal_por_tipo_trabajador' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."personal_por_tipo_trabajador") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."personal_por_tipo_trabajador") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."personal_por_tipo_trabajador") - (SELECT count(*) FROM "legacy_raw"."personal_por_tipo_trabajador") AS diferencia
UNION ALL
SELECT 'rrhh.personal_saludos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."personal_saludos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."personal_saludos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."personal_saludos") - (SELECT count(*) FROM "legacy_raw"."personal_saludos") AS diferencia
UNION ALL
SELECT 'rrhh.personal_seguros' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."personal_seguros") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."personal_seguros") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."personal_seguros") - (SELECT count(*) FROM "legacy_raw"."personal_seguros") AS diferencia
UNION ALL
SELECT 'rrhh.personal_turno' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."personal_turno") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."personal_turno") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."personal_turno") - (SELECT count(*) FROM "legacy_raw"."personal_turno") AS diferencia
UNION ALL
SELECT 'rrhh.personal_valores_defecto' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."personal_valores_defecto") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."personal_valores_defecto") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."personal_valores_defecto") - (SELECT count(*) FROM "legacy_raw"."personal_valores_defecto") AS diferencia
UNION ALL
SELECT 'rrhh.plan_conc_desc' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."plan_conc_desc") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."plan_conc_desc") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."plan_conc_desc") - (SELECT count(*) FROM "legacy_raw"."plan_conc_desc") AS diferencia
UNION ALL
SELECT 'rrhh.plan_conc_incr' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."plan_conc_incr") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."plan_conc_incr") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."plan_conc_incr") - (SELECT count(*) FROM "legacy_raw"."plan_conc_incr") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_boni_concepto' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_boni_concepto") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_boni_concepto") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_boni_concepto") - (SELECT count(*) FROM "legacy_raw"."planilla_boni_concepto") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_boni_moto' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_boni_moto") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_boni_moto") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_boni_moto") - (SELECT count(*) FROM "legacy_raw"."planilla_boni_moto") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_boni_tripu' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_boni_tripu") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_boni_tripu") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_boni_tripu") - (SELECT count(*) FROM "legacy_raw"."planilla_boni_tripu") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_bonitri_conceptos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_bonitri_conceptos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_bonitri_conceptos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_bonitri_conceptos") - (SELECT count(*) FROM "legacy_raw"."planilla_bonitri_conceptos") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_cts_conceptos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_cts_conceptos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_cts_conceptos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_cts_conceptos") - (SELECT count(*) FROM "legacy_raw"."planilla_cts_conceptos") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_de_empleados' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_de_empleados") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_de_empleados") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_de_empleados") - (SELECT count(*) FROM "legacy_raw"."planilla_de_empleados") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_de_obreros' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_de_obreros") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_de_obreros") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_de_obreros") - (SELECT count(*) FROM "legacy_raw"."planilla_de_obreros") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_de_tripulantes' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_de_tripulantes") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_de_tripulantes") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_de_tripulantes") - (SELECT count(*) FROM "legacy_raw"."planilla_de_tripulantes") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_empleado_conceptos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_empleado_conceptos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_empleado_conceptos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_empleado_conceptos") - (SELECT count(*) FROM "legacy_raw"."planilla_empleado_conceptos") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_grati_vaca' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_grati_vaca") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_grati_vaca") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_grati_vaca") - (SELECT count(*) FROM "legacy_raw"."planilla_grati_vaca") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_grati_vaca_concep' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_grati_vaca_concep") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_grati_vaca_concep") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_grati_vaca_concep") - (SELECT count(*) FROM "legacy_raw"."planilla_grati_vaca_concep") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_obrero_conceptos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_obrero_conceptos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_obrero_conceptos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_obrero_conceptos") - (SELECT count(*) FROM "legacy_raw"."planilla_obrero_conceptos") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_pesca_tripulantes' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_pesca_tripulantes") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_pesca_tripulantes") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_pesca_tripulantes") - (SELECT count(*) FROM "legacy_raw"."planilla_pesca_tripulantes") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_subs_concepto' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_subs_concepto") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_subs_concepto") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_subs_concepto") - (SELECT count(*) FROM "legacy_raw"."planilla_subs_concepto") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_subsidio' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_subsidio") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_subsidio") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_subsidio") - (SELECT count(*) FROM "legacy_raw"."planilla_subsidio") AS diferencia
UNION ALL
SELECT 'rrhh.planilla_tripulante_conceptos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."planilla_tripulante_conceptos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."planilla_tripulante_conceptos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."planilla_tripulante_conceptos") - (SELECT count(*) FROM "legacy_raw"."planilla_tripulante_conceptos") AS diferencia
UNION ALL
SELECT 'rrhh.prestamos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."prestamos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."prestamos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."prestamos") - (SELECT count(*) FROM "legacy_raw"."prestamos") AS diferencia
UNION ALL
SELECT 'rrhh.regimen_laboral' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."regimen_laboral") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."regimen_laboral") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."regimen_laboral") - (SELECT count(*) FROM "legacy_raw"."regimen_laboral") AS diferencia
UNION ALL
SELECT 'rrhh.rubros_sistema_pensiones' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."rubros_sistema_pensiones") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."rubros_sistema_pensiones") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."rubros_sistema_pensiones") - (SELECT count(*) FROM "legacy_raw"."rubros_sistema_pensiones") AS diferencia
UNION ALL
SELECT 'rrhh.sindicatos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sindicatos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."sindicatos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."sindicatos") - (SELECT count(*) FROM "legacy_raw"."sindicatos") AS diferencia
UNION ALL
SELECT 'rrhh.sindicatos_personal' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sindicatos_personal") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."sindicatos_personal") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."sindicatos_personal") - (SELECT count(*) FROM "legacy_raw"."sindicatos_personal") AS diferencia
UNION ALL
SELECT 'rrhh.sistema_pensiones' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sistema_pensiones") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."sistema_pensiones") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."sistema_pensiones") - (SELECT count(*) FROM "legacy_raw"."sistema_pensiones") AS diferencia
UNION ALL
SELECT 'rrhh.situ_trab_pens' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."situ_trab_pens") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."situ_trab_pens") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."situ_trab_pens") - (SELECT count(*) FROM "legacy_raw"."situ_trab_pens") AS diferencia
UNION ALL
SELECT 'rrhh.soli_pres' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."soli_pres") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."soli_pres") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."soli_pres") - (SELECT count(*) FROM "legacy_raw"."soli_pres") AS diferencia
UNION ALL
SELECT 'rrhh.soli_pres_cron_devo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."soli_pres_cron_devo") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."soli_pres_cron_devo") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."soli_pres_cron_devo") - (SELECT count(*) FROM "legacy_raw"."soli_pres_cron_devo") AS diferencia
UNION ALL
SELECT 'rrhh.soli_pres_ingr_desc' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."soli_pres_ingr_desc") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."soli_pres_ingr_desc") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."soli_pres_ingr_desc") - (SELECT count(*) FROM "legacy_raw"."soli_pres_ingr_desc") AS diferencia
UNION ALL
SELECT 'rrhh.sub_area_grup' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sub_area_grup") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."sub_area_grup") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."sub_area_grup") - (SELECT count(*) FROM "legacy_raw"."sub_area_grup") AS diferencia
UNION ALL
SELECT 'rrhh.subsidios' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."subsidios") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."subsidios") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."subsidios") - (SELECT count(*) FROM "legacy_raw"."subsidios") AS diferencia
UNION ALL
SELECT 'rrhh.tipo_cargo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_cargo") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipo_cargo") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipo_cargo") - (SELECT count(*) FROM "legacy_raw"."tipo_cargo") AS diferencia
UNION ALL
SELECT 'rrhh.tipo_comida' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_comida") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipo_comida") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipo_comida") - (SELECT count(*) FROM "legacy_raw"."tipo_comida") AS diferencia
UNION ALL
SELECT 'rrhh.tipo_conceptos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_conceptos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipo_conceptos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipo_conceptos") - (SELECT count(*) FROM "legacy_raw"."tipo_conceptos") AS diferencia
UNION ALL
SELECT 'rrhh.tipo_contrato' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_contrato") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipo_contrato") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipo_contrato") - (SELECT count(*) FROM "legacy_raw"."tipo_contrato") AS diferencia
UNION ALL
SELECT 'rrhh.tipo_personal' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_personal") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipo_personal") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipo_personal") - (SELECT count(*) FROM "legacy_raw"."tipo_personal") AS diferencia
UNION ALL
SELECT 'rrhh.tipo_plan_nemo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_plan_nemo") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipo_plan_nemo") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipo_plan_nemo") - (SELECT count(*) FROM "legacy_raw"."tipo_plan_nemo") AS diferencia
UNION ALL
SELECT 'rrhh.tipo_prestamo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_prestamo") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipo_prestamo") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipo_prestamo") - (SELECT count(*) FROM "legacy_raw"."tipo_prestamo") AS diferencia
UNION ALL
SELECT 'rrhh.tipo_ries_tasa' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_ries_tasa") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipo_ries_tasa") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipo_ries_tasa") - (SELECT count(*) FROM "legacy_raw"."tipo_ries_tasa") AS diferencia
UNION ALL
SELECT 'rrhh.tipo_riesgo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_riesgo") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipo_riesgo") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipo_riesgo") - (SELECT count(*) FROM "legacy_raw"."tipo_riesgo") AS diferencia
UNION ALL
SELECT 'rrhh.tipo_situ_hora_trab' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_situ_hora_trab") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipo_situ_hora_trab") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipo_situ_hora_trab") - (SELECT count(*) FROM "legacy_raw"."tipo_situ_hora_trab") AS diferencia
UNION ALL
SELECT 'rrhh.tipo_suspension' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_suspension") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipo_suspension") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipo_suspension") - (SELECT count(*) FROM "legacy_raw"."tipo_suspension") AS diferencia
UNION ALL
SELECT 'rrhh.tipo_trabajador' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_trabajador") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipo_trabajador") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipo_trabajador") - (SELECT count(*) FROM "legacy_raw"."tipo_trabajador") AS diferencia
UNION ALL
SELECT 'rrhh.tipo_vacaciones' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_vacaciones") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipo_vacaciones") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipo_vacaciones") - (SELECT count(*) FROM "legacy_raw"."tipo_vacaciones") AS diferencia
UNION ALL
SELECT 'rrhh.tipos_licencias' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipos_licencias") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipos_licencias") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipos_licencias") - (SELECT count(*) FROM "legacy_raw"."tipos_licencias") AS diferencia
UNION ALL
SELECT 'rrhh.tipos_planillas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipos_planillas") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."tipos_planillas") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."tipos_planillas") - (SELECT count(*) FROM "legacy_raw"."tipos_planillas") AS diferencia
UNION ALL
SELECT 'rrhh.turnos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."turnos") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."turnos") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."turnos") - (SELECT count(*) FROM "legacy_raw"."turnos") AS diferencia
UNION ALL
SELECT 'rrhh.util_pers_anual' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."util_pers_anual") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."util_pers_anual") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."util_pers_anual") - (SELECT count(*) FROM "legacy_raw"."util_pers_anual") AS diferencia
UNION ALL
SELECT 'rrhh.vacaciones' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."vacaciones") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."vacaciones") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."vacaciones") - (SELECT count(*) FROM "legacy_raw"."vacaciones") AS diferencia
UNION ALL
SELECT 'rrhh.valores_sistema_pensiones' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."valores_sistema_pensiones") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."valores_sistema_pensiones") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."valores_sistema_pensiones") - (SELECT count(*) FROM "legacy_raw"."valores_sistema_pensiones") AS diferencia
UNION ALL
SELECT 'rrhh.vinculo_familiar' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."vinculo_familiar") AS filas_legacy,
       (SELECT count(*) FROM "rrhh"."vinculo_familiar") AS filas_destino,
       (SELECT count(*) FROM "rrhh"."vinculo_familiar") - (SELECT count(*) FROM "legacy_raw"."vinculo_familiar") AS diferencia
UNION ALL
SELECT 'seguridad.acceso' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."acceso") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."acceso") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."acceso") - (SELECT count(*) FROM "legacy_raw"."acceso") AS diferencia
UNION ALL
SELECT 'seguridad.aceptacion_x_usuario' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."aceptacion_x_usuario") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."aceptacion_x_usuario") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."aceptacion_x_usuario") - (SELECT count(*) FROM "legacy_raw"."aceptacion_x_usuario") AS diferencia
UNION ALL
SELECT 'seguridad.auditoria' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."auditoria") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."auditoria") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."auditoria") - (SELECT count(*) FROM "legacy_raw"."auditoria") AS diferencia
UNION ALL
SELECT 'seguridad.cierre_mes' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cierre_mes") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."cierre_mes") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."cierre_mes") - (SELECT count(*) FROM "legacy_raw"."cierre_mes") AS diferencia
UNION ALL
SELECT 'seguridad.cierre_mes_user' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cierre_mes_user") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."cierre_mes_user") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."cierre_mes_user") - (SELECT count(*) FROM "legacy_raw"."cierre_mes_user") AS diferencia
UNION ALL
SELECT 'seguridad.conexion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."conexion") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."conexion") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."conexion") - (SELECT count(*) FROM "legacy_raw"."conexion") AS diferencia
UNION ALL
SELECT 'seguridad.configsys' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."configsys") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."configsys") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."configsys") - (SELECT count(*) FROM "legacy_raw"."configsys") AS diferencia
UNION ALL
SELECT 'seguridad.consistencias' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."consistencias") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."consistencias") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."consistencias") - (SELECT count(*) FROM "legacy_raw"."consistencias") AS diferencia
UNION ALL
SELECT 'seguridad.empresa' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."empresa") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."empresa") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."empresa") - (SELECT count(*) FROM "legacy_raw"."empresa") AS diferencia
UNION ALL
SELECT 'seguridad.empresa_establec_tasas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."empresa_establec_tasas") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."empresa_establec_tasas") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."empresa_establec_tasas") - (SELECT count(*) FROM "legacy_raw"."empresa_establec_tasas") AS diferencia
UNION ALL
SELECT 'seguridad.empresa_establecimiento' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."empresa_establecimiento") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."empresa_establecimiento") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."empresa_establecimiento") - (SELECT count(*) FROM "legacy_raw"."empresa_establecimiento") AS diferencia
UNION ALL
SELECT 'seguridad.firmas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."firmas") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."firmas") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."firmas") - (SELECT count(*) FROM "legacy_raw"."firmas") AS diferencia
UNION ALL
SELECT 'seguridad.grupos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."grupos") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."grupos") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."grupos") - (SELECT count(*) FROM "legacy_raw"."grupos") AS diferencia
UNION ALL
SELECT 'seguridad.menugrupos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."menugrupos") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."menugrupos") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."menugrupos") - (SELECT count(*) FROM "legacy_raw"."menugrupos") AS diferencia
UNION ALL
SELECT 'seguridad.notas_posits' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."notas_posits") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."notas_posits") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."notas_posits") - (SELECT count(*) FROM "legacy_raw"."notas_posits") AS diferencia
UNION ALL
SELECT 'seguridad.parametro' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."parametro") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."parametro") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."parametro") - (SELECT count(*) FROM "legacy_raw"."parametro") AS diferencia
UNION ALL
SELECT 'seguridad.parametros' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."parametros") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."parametros") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."parametros") - (SELECT count(*) FROM "legacy_raw"."parametros") AS diferencia
UNION ALL
SELECT 'seguridad.usuarios' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."usuarios") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."usuarios") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."usuarios") - (SELECT count(*) FROM "legacy_raw"."usuarios") AS diferencia
UNION ALL
SELECT 'seguridad.usuarios_grupos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."usuarios_grupos") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."usuarios_grupos") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."usuarios_grupos") - (SELECT count(*) FROM "legacy_raw"."usuarios_grupos") AS diferencia
UNION ALL
SELECT 'seguridad.viso_even' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."viso_even") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."viso_even") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."viso_even") - (SELECT count(*) FROM "legacy_raw"."viso_even") AS diferencia
UNION ALL
SELECT 'seguridad.visor_de_eventos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."visor_de_eventos") AS filas_legacy,
       (SELECT count(*) FROM "seguridad"."visor_de_eventos") AS filas_destino,
       (SELECT count(*) FROM "seguridad"."visor_de_eventos") - (SELECT count(*) FROM "legacy_raw"."visor_de_eventos") AS diferencia
UNION ALL
SELECT 'staging.artificio_tablas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."artificio_tablas") AS filas_legacy,
       (SELECT count(*) FROM "staging"."artificio_tablas") AS filas_destino,
       (SELECT count(*) FROM "staging"."artificio_tablas") - (SELECT count(*) FROM "legacy_raw"."artificio_tablas") AS diferencia
UNION ALL
SELECT 'staging.artificio_tablas_copy' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."artificio_tablas_copy") AS filas_legacy,
       (SELECT count(*) FROM "staging"."artificio_tablas_copy") AS filas_destino,
       (SELECT count(*) FROM "staging"."artificio_tablas_copy") - (SELECT count(*) FROM "legacy_raw"."artificio_tablas_copy") AS diferencia
UNION ALL
SELECT 'staging.artificio_uso_objetopb' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."artificio_uso_objetopb") AS filas_legacy,
       (SELECT count(*) FROM "staging"."artificio_uso_objetopb") AS filas_destino,
       (SELECT count(*) FROM "staging"."artificio_uso_objetopb") - (SELECT count(*) FROM "legacy_raw"."artificio_uso_objetopb") AS diferencia
UNION ALL
SELECT 'staging.cliente_proveedor_aux' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cliente_proveedor_aux") AS filas_legacy,
       (SELECT count(*) FROM "staging"."cliente_proveedor_aux") AS filas_destino,
       (SELECT count(*) FROM "staging"."cliente_proveedor_aux") - (SELECT count(*) FROM "legacy_raw"."cliente_proveedor_aux") AS diferencia
UNION ALL
SELECT 'staging.cliente_proveedor_tempo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cliente_proveedor_tempo") AS filas_legacy,
       (SELECT count(*) FROM "staging"."cliente_proveedor_tempo") AS filas_destino,
       (SELECT count(*) FROM "staging"."cliente_proveedor_tempo") - (SELECT count(*) FROM "legacy_raw"."cliente_proveedor_tempo") AS diferencia
UNION ALL
SELECT 'staging.cp' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cp") AS filas_legacy,
       (SELECT count(*) FROM "staging"."cp") AS filas_destino,
       (SELECT count(*) FROM "staging"."cp") - (SELECT count(*) FROM "legacy_raw"."cp") AS diferencia
UNION ALL
SELECT 'staging.detalle_salida_aux' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."detalle_salida_aux") AS filas_legacy,
       (SELECT count(*) FROM "staging"."detalle_salida_aux") AS filas_destino,
       (SELECT count(*) FROM "staging"."detalle_salida_aux") - (SELECT count(*) FROM "legacy_raw"."detalle_salida_aux") AS diferencia
UNION ALL
SELECT 'staging.eliminar_corre' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."eliminar_corre") AS filas_legacy,
       (SELECT count(*) FROM "staging"."eliminar_corre") AS filas_destino,
       (SELECT count(*) FROM "staging"."eliminar_corre") - (SELECT count(*) FROM "legacy_raw"."eliminar_corre") AS diferencia
UNION ALL
SELECT 'staging.kadm' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."kadm") AS filas_legacy,
       (SELECT count(*) FROM "staging"."kadm") AS filas_destino,
       (SELECT count(*) FROM "staging"."kadm") - (SELECT count(*) FROM "legacy_raw"."kadm") AS diferencia
UNION ALL
SELECT 'staging.kadm2015' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."kadm2015") AS filas_legacy,
       (SELECT count(*) FROM "staging"."kadm2015") AS filas_destino,
       (SELECT count(*) FROM "staging"."kadm2015") - (SELECT count(*) FROM "legacy_raw"."kadm2015") AS diferencia
UNION ALL
SELECT 'staging.le201707' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."le201707") AS filas_legacy,
       (SELECT count(*) FROM "staging"."le201707") AS filas_destino,
       (SELECT count(*) FROM "staging"."le201707") - (SELECT count(*) FROM "legacy_raw"."le201707") AS diferencia
UNION ALL
SELECT 'staging.movi_contables_ax' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."movi_contables_ax") AS filas_legacy,
       (SELECT count(*) FROM "staging"."movi_contables_ax") AS filas_destino,
       (SELECT count(*) FROM "staging"."movi_contables_ax") - (SELECT count(*) FROM "legacy_raw"."movi_contables_ax") AS diferencia
UNION ALL
SELECT 'staging.orden_produc_deta_material_copy' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."orden_produc_deta_material_copy") AS filas_legacy,
       (SELECT count(*) FROM "staging"."orden_produc_deta_material_copy") AS filas_destino,
       (SELECT count(*) FROM "staging"."orden_produc_deta_material_copy") - (SELECT count(*) FROM "legacy_raw"."orden_produc_deta_material_copy") AS diferencia
UNION ALL
SELECT 'staging.paper' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."paper") AS filas_legacy,
       (SELECT count(*) FROM "staging"."paper") AS filas_destino,
       (SELECT count(*) FROM "staging"."paper") - (SELECT count(*) FROM "legacy_raw"."paper") AS diferencia
UNION ALL
SELECT 'staging.pbcatcol' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pbcatcol") AS filas_legacy,
       (SELECT count(*) FROM "staging"."pbcatcol") AS filas_destino,
       (SELECT count(*) FROM "staging"."pbcatcol") - (SELECT count(*) FROM "legacy_raw"."pbcatcol") AS diferencia
UNION ALL
SELECT 'staging.pbcatedt' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pbcatedt") AS filas_legacy,
       (SELECT count(*) FROM "staging"."pbcatedt") AS filas_destino,
       (SELECT count(*) FROM "staging"."pbcatedt") - (SELECT count(*) FROM "legacy_raw"."pbcatedt") AS diferencia
UNION ALL
SELECT 'staging.pbcatfmt' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pbcatfmt") AS filas_legacy,
       (SELECT count(*) FROM "staging"."pbcatfmt") AS filas_destino,
       (SELECT count(*) FROM "staging"."pbcatfmt") - (SELECT count(*) FROM "legacy_raw"."pbcatfmt") AS diferencia
UNION ALL
SELECT 'staging.pbcattbl' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pbcattbl") AS filas_legacy,
       (SELECT count(*) FROM "staging"."pbcattbl") AS filas_destino,
       (SELECT count(*) FROM "staging"."pbcattbl") - (SELECT count(*) FROM "legacy_raw"."pbcattbl") AS diferencia
UNION ALL
SELECT 'staging.pbcatvld' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."pbcatvld") AS filas_legacy,
       (SELECT count(*) FROM "staging"."pbcatvld") AS filas_destino,
       (SELECT count(*) FROM "staging"."pbcatvld") - (SELECT count(*) FROM "legacy_raw"."pbcatvld") AS diferencia
UNION ALL
SELECT 'staging.productos_matriz_x' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."productos_matriz_x") AS filas_legacy,
       (SELECT count(*) FROM "staging"."productos_matriz_x") AS filas_destino,
       (SELECT count(*) FROM "staging"."productos_matriz_x") - (SELECT count(*) FROM "legacy_raw"."productos_matriz_x") AS diferencia
UNION ALL
SELECT 'staging.productos_xx' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."productos_xx") AS filas_legacy,
       (SELECT count(*) FROM "staging"."productos_xx") AS filas_destino,
       (SELECT count(*) FROM "staging"."productos_xx") - (SELECT count(*) FROM "legacy_raw"."productos_xx") AS diferencia
UNION ALL
SELECT 'staging.px' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."px") AS filas_legacy,
       (SELECT count(*) FROM "staging"."px") AS filas_destino,
       (SELECT count(*) FROM "staging"."px") - (SELECT count(*) FROM "legacy_raw"."px") AS diferencia
UNION ALL
SELECT 'staging.registro_axu' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."registro_axu") AS filas_legacy,
       (SELECT count(*) FROM "staging"."registro_axu") AS filas_destino,
       (SELECT count(*) FROM "staging"."registro_axu") - (SELECT count(*) FROM "legacy_raw"."registro_axu") AS diferencia
UNION ALL
SELECT 'staging.sheet' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."sheet") AS filas_legacy,
       (SELECT count(*) FROM "staging"."sheet") AS filas_destino,
       (SELECT count(*) FROM "staging"."sheet") - (SELECT count(*) FROM "legacy_raw"."sheet") AS diferencia
UNION ALL
SELECT 'staging.tempo' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tempo") AS filas_legacy,
       (SELECT count(*) FROM "staging"."tempo") AS filas_destino,
       (SELECT count(*) FROM "staging"."tempo") - (SELECT count(*) FROM "legacy_raw"."tempo") AS diferencia
UNION ALL
SELECT 'staging.tx' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tx") AS filas_legacy,
       (SELECT count(*) FROM "staging"."tx") AS filas_destino,
       (SELECT count(*) FROM "staging"."tx") - (SELECT count(*) FROM "legacy_raw"."tx") AS diferencia
UNION ALL
SELECT 'staging.tx2' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tx2") AS filas_legacy,
       (SELECT count(*) FROM "staging"."tx2") AS filas_destino,
       (SELECT count(*) FROM "staging"."tx2") - (SELECT count(*) FROM "legacy_raw"."tx2") AS diferencia
UNION ALL
SELECT 'staging.tx3' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tx3") AS filas_legacy,
       (SELECT count(*) FROM "staging"."tx3") AS filas_destino,
       (SELECT count(*) FROM "staging"."tx3") - (SELECT count(*) FROM "legacy_raw"."tx3") AS diferencia
UNION ALL
SELECT 'staging.txprod' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."txprod") AS filas_legacy,
       (SELECT count(*) FROM "staging"."txprod") AS filas_destino,
       (SELECT count(*) FROM "staging"."txprod") - (SELECT count(*) FROM "legacy_raw"."txprod") AS diferencia
UNION ALL
SELECT 'staging.v2017' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."v2017") AS filas_legacy,
       (SELECT count(*) FROM "staging"."v2017") AS filas_destino,
       (SELECT count(*) FROM "staging"."v2017") - (SELECT count(*) FROM "legacy_raw"."v2017") AS diferencia
UNION ALL
SELECT 'ventas.acta_entrega' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."acta_entrega") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."acta_entrega") AS filas_destino,
       (SELECT count(*) FROM "ventas"."acta_entrega") - (SELECT count(*) FROM "legacy_raw"."acta_entrega") AS diferencia
UNION ALL
SELECT 'ventas.acta_entrega_detalle' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."acta_entrega_detalle") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."acta_entrega_detalle") AS filas_destino,
       (SELECT count(*) FROM "ventas"."acta_entrega_detalle") - (SELECT count(*) FROM "legacy_raw"."acta_entrega_detalle") AS diferencia
UNION ALL
SELECT 'ventas.almacen_documentos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."almacen_documentos") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."almacen_documentos") AS filas_destino,
       (SELECT count(*) FROM "ventas"."almacen_documentos") - (SELECT count(*) FROM "legacy_raw"."almacen_documentos") AS diferencia
UNION ALL
SELECT 'ventas.bazar' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."bazar") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."bazar") AS filas_destino,
       (SELECT count(*) FROM "ventas"."bazar") - (SELECT count(*) FROM "legacy_raw"."bazar") AS diferencia
UNION ALL
SELECT 'ventas.boletas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."boletas") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."boletas") AS filas_destino,
       (SELECT count(*) FROM "ventas"."boletas") - (SELECT count(*) FROM "legacy_raw"."boletas") AS diferencia
UNION ALL
SELECT 'ventas.boletas_detalle' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."boletas_detalle") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."boletas_detalle") AS filas_destino,
       (SELECT count(*) FROM "ventas"."boletas_detalle") - (SELECT count(*) FROM "legacy_raw"."boletas_detalle") AS diferencia
UNION ALL
SELECT 'ventas.captacion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."captacion") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."captacion") AS filas_destino,
       (SELECT count(*) FROM "ventas"."captacion") - (SELECT count(*) FROM "legacy_raw"."captacion") AS diferencia
UNION ALL
SELECT 'ventas.captacion_visita' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."captacion_visita") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."captacion_visita") AS filas_destino,
       (SELECT count(*) FROM "ventas"."captacion_visita") - (SELECT count(*) FROM "legacy_raw"."captacion_visita") AS diferencia
UNION ALL
SELECT 'ventas.cliente_credito_historial' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cliente_credito_historial") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."cliente_credito_historial") AS filas_destino,
       (SELECT count(*) FROM "ventas"."cliente_credito_historial") - (SELECT count(*) FROM "legacy_raw"."cliente_credito_historial") AS diferencia
UNION ALL
SELECT 'ventas.cliente_creditos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cliente_creditos") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."cliente_creditos") AS filas_destino,
       (SELECT count(*) FROM "ventas"."cliente_creditos") - (SELECT count(*) FROM "legacy_raw"."cliente_creditos") AS diferencia
UNION ALL
SELECT 'ventas.cliente_creditos_garantia' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cliente_creditos_garantia") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."cliente_creditos_garantia") AS filas_destino,
       (SELECT count(*) FROM "ventas"."cliente_creditos_garantia") - (SELECT count(*) FROM "legacy_raw"."cliente_creditos_garantia") AS diferencia
UNION ALL
SELECT 'ventas.cliente_vendedor' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cliente_vendedor") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."cliente_vendedor") AS filas_destino,
       (SELECT count(*) FROM "ventas"."cliente_vendedor") - (SELECT count(*) FROM "legacy_raw"."cliente_vendedor") AS diferencia
UNION ALL
SELECT 'ventas.comisiones' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."comisiones") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."comisiones") AS filas_destino,
       (SELECT count(*) FROM "ventas"."comisiones") - (SELECT count(*) FROM "legacy_raw"."comisiones") AS diferencia
UNION ALL
SELECT 'ventas.configuracion_vehicular' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."configuracion_vehicular") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."configuracion_vehicular") AS filas_destino,
       (SELECT count(*) FROM "ventas"."configuracion_vehicular") - (SELECT count(*) FROM "legacy_raw"."configuracion_vehicular") AS diferencia
UNION ALL
SELECT 'ventas.conocimiento' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."conocimiento") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."conocimiento") AS filas_destino,
       (SELECT count(*) FROM "ventas"."conocimiento") - (SELECT count(*) FROM "legacy_raw"."conocimiento") AS diferencia
UNION ALL
SELECT 'ventas.convenio' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."convenio") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."convenio") AS filas_destino,
       (SELECT count(*) FROM "ventas"."convenio") - (SELECT count(*) FROM "legacy_raw"."convenio") AS diferencia
UNION ALL
SELECT 'ventas.convenio_detalle' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."convenio_detalle") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."convenio_detalle") AS filas_destino,
       (SELECT count(*) FROM "ventas"."convenio_detalle") - (SELECT count(*) FROM "legacy_raw"."convenio_detalle") AS diferencia
UNION ALL
SELECT 'ventas.cotizacion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cotizacion") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."cotizacion") AS filas_destino,
       (SELECT count(*) FROM "ventas"."cotizacion") - (SELECT count(*) FROM "legacy_raw"."cotizacion") AS diferencia
UNION ALL
SELECT 'ventas.creditos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."creditos") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."creditos") AS filas_destino,
       (SELECT count(*) FROM "ventas"."creditos") - (SELECT count(*) FROM "legacy_raw"."creditos") AS diferencia
UNION ALL
SELECT 'ventas.creditos_detalle' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."creditos_detalle") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."creditos_detalle") AS filas_destino,
       (SELECT count(*) FROM "ventas"."creditos_detalle") - (SELECT count(*) FROM "legacy_raw"."creditos_detalle") AS diferencia
UNION ALL
SELECT 'ventas.creditos_lineas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."creditos_lineas") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."creditos_lineas") AS filas_destino,
       (SELECT count(*) FROM "ventas"."creditos_lineas") - (SELECT count(*) FROM "legacy_raw"."creditos_lineas") AS diferencia
UNION ALL
SELECT 'ventas.creditos_tipos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."creditos_tipos") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."creditos_tipos") AS filas_destino,
       (SELECT count(*) FROM "ventas"."creditos_tipos") - (SELECT count(*) FROM "legacy_raw"."creditos_tipos") AS diferencia
UNION ALL
SELECT 'ventas.cultivos_principal' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cultivos_principal") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."cultivos_principal") AS filas_destino,
       (SELECT count(*) FROM "ventas"."cultivos_principal") - (SELECT count(*) FROM "legacy_raw"."cultivos_principal") AS diferencia
UNION ALL
SELECT 'ventas.cuotas_sucursal' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."cuotas_sucursal") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."cuotas_sucursal") AS filas_destino,
       (SELECT count(*) FROM "ventas"."cuotas_sucursal") - (SELECT count(*) FROM "legacy_raw"."cuotas_sucursal") AS diferencia
UNION ALL
SELECT 'ventas.factura' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."factura") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."factura") AS filas_destino,
       (SELECT count(*) FROM "ventas"."factura") - (SELECT count(*) FROM "legacy_raw"."factura") AS diferencia
UNION ALL
SELECT 'ventas.factura_anticipos' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."factura_anticipos") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."factura_anticipos") AS filas_destino,
       (SELECT count(*) FROM "ventas"."factura_anticipos") - (SELECT count(*) FROM "legacy_raw"."factura_anticipos") AS diferencia
UNION ALL
SELECT 'ventas.factura_credito' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."factura_credito") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."factura_credito") AS filas_destino,
       (SELECT count(*) FROM "ventas"."factura_credito") - (SELECT count(*) FROM "legacy_raw"."factura_credito") AS diferencia
UNION ALL
SELECT 'ventas.factura_cuotas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."factura_cuotas") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."factura_cuotas") AS filas_destino,
       (SELECT count(*) FROM "ventas"."factura_cuotas") - (SELECT count(*) FROM "legacy_raw"."factura_cuotas") AS diferencia
UNION ALL
SELECT 'ventas.factura_detalle' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."factura_detalle") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."factura_detalle") AS filas_destino,
       (SELECT count(*) FROM "ventas"."factura_detalle") - (SELECT count(*) FROM "legacy_raw"."factura_detalle") AS diferencia
UNION ALL
SELECT 'ventas.factura_pesca' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."factura_pesca") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."factura_pesca") AS filas_destino,
       (SELECT count(*) FROM "ventas"."factura_pesca") - (SELECT count(*) FROM "legacy_raw"."factura_pesca") AS diferencia
UNION ALL
SELECT 'ventas.factura_sunat' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."factura_sunat") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."factura_sunat") AS filas_destino,
       (SELECT count(*) FROM "ventas"."factura_sunat") - (SELECT count(*) FROM "legacy_raw"."factura_sunat") AS diferencia
UNION ALL
SELECT 'ventas.facturas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."facturas") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."facturas") AS filas_destino,
       (SELECT count(*) FROM "ventas"."facturas") - (SELECT count(*) FROM "legacy_raw"."facturas") AS diferencia
UNION ALL
SELECT 'ventas.facturas_detalle' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."facturas_detalle") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."facturas_detalle") AS filas_destino,
       (SELECT count(*) FROM "ventas"."facturas_detalle") - (SELECT count(*) FROM "legacy_raw"."facturas_detalle") AS diferencia
UNION ALL
SELECT 'ventas.guia' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."guia") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."guia") AS filas_destino,
       (SELECT count(*) FROM "ventas"."guia") - (SELECT count(*) FROM "legacy_raw"."guia") AS diferencia
UNION ALL
SELECT 'ventas.guia_detalle' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."guia_detalle") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."guia_detalle") AS filas_destino,
       (SELECT count(*) FROM "ventas"."guia_detalle") - (SELECT count(*) FROM "legacy_raw"."guia_detalle") AS diferencia
UNION ALL
SELECT 'ventas.guia_transportista' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."guia_transportista") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."guia_transportista") AS filas_destino,
       (SELECT count(*) FROM "ventas"."guia_transportista") - (SELECT count(*) FROM "legacy_raw"."guia_transportista") AS diferencia
UNION ALL
SELECT 'ventas.guia_transportista_detalle' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."guia_transportista_detalle") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."guia_transportista_detalle") AS filas_destino,
       (SELECT count(*) FROM "ventas"."guia_transportista_detalle") - (SELECT count(*) FROM "legacy_raw"."guia_transportista_detalle") AS diferencia
UNION ALL
SELECT 'ventas.hoja_vida' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."hoja_vida") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."hoja_vida") AS filas_destino,
       (SELECT count(*) FROM "ventas"."hoja_vida") - (SELECT count(*) FROM "legacy_raw"."hoja_vida") AS diferencia
UNION ALL
SELECT 'ventas.hoja_vida_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."hoja_vida_deta") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."hoja_vida_deta") AS filas_destino,
       (SELECT count(*) FROM "ventas"."hoja_vida_deta") - (SELECT count(*) FROM "legacy_raw"."hoja_vida_deta") AS diferencia
UNION ALL
SELECT 'ventas.liquidacion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."liquidacion") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."liquidacion") AS filas_destino,
       (SELECT count(*) FROM "ventas"."liquidacion") - (SELECT count(*) FROM "legacy_raw"."liquidacion") AS diferencia
UNION ALL
SELECT 'ventas.liquidacion_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."liquidacion_deta") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."liquidacion_deta") AS filas_destino,
       (SELECT count(*) FROM "ventas"."liquidacion_deta") - (SELECT count(*) FROM "legacy_raw"."liquidacion_deta") AS diferencia
UNION ALL
SELECT 'ventas.liquidacion_ruta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."liquidacion_ruta") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."liquidacion_ruta") AS filas_destino,
       (SELECT count(*) FROM "ventas"."liquidacion_ruta") - (SELECT count(*) FROM "legacy_raw"."liquidacion_ruta") AS diferencia
UNION ALL
SELECT 'ventas.metas_linea_rota' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."metas_linea_rota") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."metas_linea_rota") AS filas_destino,
       (SELECT count(*) FROM "ventas"."metas_linea_rota") - (SELECT count(*) FROM "legacy_raw"."metas_linea_rota") AS diferencia
UNION ALL
SELECT 'ventas.motivo_nota_cred' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."motivo_nota_cred") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."motivo_nota_cred") AS filas_destino,
       (SELECT count(*) FROM "ventas"."motivo_nota_cred") - (SELECT count(*) FROM "legacy_raw"."motivo_nota_cred") AS diferencia
UNION ALL
SELECT 'ventas.motivo_traslado' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."motivo_traslado") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."motivo_traslado") AS filas_destino,
       (SELECT count(*) FROM "ventas"."motivo_traslado") - (SELECT count(*) FROM "legacy_raw"."motivo_traslado") AS diferencia
UNION ALL
SELECT 'ventas.nota_credito' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."nota_credito") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."nota_credito") AS filas_destino,
       (SELECT count(*) FROM "ventas"."nota_credito") - (SELECT count(*) FROM "legacy_raw"."nota_credito") AS diferencia
UNION ALL
SELECT 'ventas.nota_credito_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."nota_credito_deta") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."nota_credito_deta") AS filas_destino,
       (SELECT count(*) FROM "ventas"."nota_credito_deta") - (SELECT count(*) FROM "legacy_raw"."nota_credito_deta") AS diferencia
UNION ALL
SELECT 'ventas.nota_debito' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."nota_debito") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."nota_debito") AS filas_destino,
       (SELECT count(*) FROM "ventas"."nota_debito") - (SELECT count(*) FROM "legacy_raw"."nota_debito") AS diferencia
UNION ALL
SELECT 'ventas.nota_debito_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."nota_debito_deta") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."nota_debito_deta") AS filas_destino,
       (SELECT count(*) FROM "ventas"."nota_debito_deta") - (SELECT count(*) FROM "legacy_raw"."nota_debito_deta") AS diferencia
UNION ALL
SELECT 'ventas.nota_venta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."nota_venta") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."nota_venta") AS filas_destino,
       (SELECT count(*) FROM "ventas"."nota_venta") - (SELECT count(*) FROM "legacy_raw"."nota_venta") AS diferencia
UNION ALL
SELECT 'ventas.nota_venta_detalle' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."nota_venta_detalle") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."nota_venta_detalle") AS filas_destino,
       (SELECT count(*) FROM "ventas"."nota_venta_detalle") - (SELECT count(*) FROM "legacy_raw"."nota_venta_detalle") AS diferencia
UNION ALL
SELECT 'ventas.orden_solicitud_servicio' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."orden_solicitud_servicio") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."orden_solicitud_servicio") AS filas_destino,
       (SELECT count(*) FROM "ventas"."orden_solicitud_servicio") - (SELECT count(*) FROM "legacy_raw"."orden_solicitud_servicio") AS diferencia
UNION ALL
SELECT 'ventas.orden_solicitud_servicio_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."orden_solicitud_servicio_deta") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."orden_solicitud_servicio_deta") AS filas_destino,
       (SELECT count(*) FROM "ventas"."orden_solicitud_servicio_deta") - (SELECT count(*) FROM "legacy_raw"."orden_solicitud_servicio_deta") AS diferencia
UNION ALL
SELECT 'ventas.plan_marketing' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."plan_marketing") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."plan_marketing") AS filas_destino,
       (SELECT count(*) FROM "ventas"."plan_marketing") - (SELECT count(*) FROM "legacy_raw"."plan_marketing") AS diferencia
UNION ALL
SELECT 'ventas.producto_comision' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."producto_comision") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."producto_comision") AS filas_destino,
       (SELECT count(*) FROM "ventas"."producto_comision") - (SELECT count(*) FROM "legacy_raw"."producto_comision") AS diferencia
UNION ALL
SELECT 'ventas.productos_ofertas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."productos_ofertas") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."productos_ofertas") AS filas_destino,
       (SELECT count(*) FROM "ventas"."productos_ofertas") - (SELECT count(*) FROM "legacy_raw"."productos_ofertas") AS diferencia
UNION ALL
SELECT 'ventas.recomendacion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."recomendacion") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."recomendacion") AS filas_destino,
       (SELECT count(*) FROM "ventas"."recomendacion") - (SELECT count(*) FROM "legacy_raw"."recomendacion") AS diferencia
UNION ALL
SELECT 'ventas.recomendacion_deta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."recomendacion_deta") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."recomendacion_deta") AS filas_destino,
       (SELECT count(*) FROM "ventas"."recomendacion_deta") - (SELECT count(*) FROM "legacy_raw"."recomendacion_deta") AS diferencia
UNION ALL
SELECT 'ventas.registro_vale' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."registro_vale") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."registro_vale") AS filas_destino,
       (SELECT count(*) FROM "ventas"."registro_vale") - (SELECT count(*) FROM "legacy_raw"."registro_vale") AS diferencia
UNION ALL
SELECT 'ventas.registro_vale_detalle' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."registro_vale_detalle") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."registro_vale_detalle") AS filas_destino,
       (SELECT count(*) FROM "ventas"."registro_vale_detalle") - (SELECT count(*) FROM "legacy_raw"."registro_vale_detalle") AS diferencia
UNION ALL
SELECT 'ventas.rotacion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."rotacion") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."rotacion") AS filas_destino,
       (SELECT count(*) FROM "ventas"."rotacion") - (SELECT count(*) FROM "legacy_raw"."rotacion") AS diferencia
UNION ALL
SELECT 'ventas.ruta' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ruta") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."ruta") AS filas_destino,
       (SELECT count(*) FROM "ventas"."ruta") - (SELECT count(*) FROM "legacy_raw"."ruta") AS diferencia
UNION ALL
SELECT 'ventas.ruta_orden' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ruta_orden") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."ruta_orden") AS filas_destino,
       (SELECT count(*) FROM "ventas"."ruta_orden") - (SELECT count(*) FROM "legacy_raw"."ruta_orden") AS diferencia
UNION ALL
SELECT 'ventas.ruta_semanal' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ruta_semanal") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."ruta_semanal") AS filas_destino,
       (SELECT count(*) FROM "ventas"."ruta_semanal") - (SELECT count(*) FROM "legacy_raw"."ruta_semanal") AS diferencia
UNION ALL
SELECT 'ventas.siembras' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."siembras") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."siembras") AS filas_destino,
       (SELECT count(*) FROM "ventas"."siembras") - (SELECT count(*) FROM "legacy_raw"."siembras") AS diferencia
UNION ALL
SELECT 'ventas.tipo_carga' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_carga") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."tipo_carga") AS filas_destino,
       (SELECT count(*) FROM "ventas"."tipo_carga") - (SELECT count(*) FROM "legacy_raw"."tipo_carga") AS diferencia
UNION ALL
SELECT 'ventas.tipo_comision' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_comision") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."tipo_comision") AS filas_destino,
       (SELECT count(*) FROM "ventas"."tipo_comision") - (SELECT count(*) FROM "legacy_raw"."tipo_comision") AS diferencia
UNION ALL
SELECT 'ventas.tipo_factura' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_factura") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."tipo_factura") AS filas_destino,
       (SELECT count(*) FROM "ventas"."tipo_factura") - (SELECT count(*) FROM "legacy_raw"."tipo_factura") AS diferencia
UNION ALL
SELECT 'ventas.tipo_notas' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."tipo_notas") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."tipo_notas") AS filas_destino,
       (SELECT count(*) FROM "ventas"."tipo_notas") - (SELECT count(*) FROM "legacy_raw"."tipo_notas") AS diferencia
UNION ALL
SELECT 'ventas.ubicacion' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."ubicacion") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."ubicacion") AS filas_destino,
       (SELECT count(*) FROM "ventas"."ubicacion") - (SELECT count(*) FROM "legacy_raw"."ubicacion") AS diferencia
UNION ALL
SELECT 'ventas.unidad_transporte' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."unidad_transporte") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."unidad_transporte") AS filas_destino,
       (SELECT count(*) FROM "ventas"."unidad_transporte") - (SELECT count(*) FROM "legacy_raw"."unidad_transporte") AS diferencia
UNION ALL
SELECT 'ventas.vale_credito' AS tabla,
       (SELECT count(*) FROM "legacy_raw"."vale_credito") AS filas_legacy,
       (SELECT count(*) FROM "ventas"."vale_credito") AS filas_destino,
       (SELECT count(*) FROM "ventas"."vale_credito") - (SELECT count(*) FROM "legacy_raw"."vale_credito") AS diferencia
ORDER BY diferencia, tabla;

-- =====================================================================
-- 2) Claves foraneas NOT VALID pendientes de validar.
--    En SQL Server estaban WITH NOCHECK; en PG se crearon NOT VALID. Tras
--    depurar los datos huerfanos, valide cada una.
-- =====================================================================
SELECT n.nspname AS esquema, rel.relname AS tabla, c.conname AS constraint
FROM pg_constraint c
JOIN pg_class rel     ON rel.oid = c.conrelid
JOIN pg_namespace n   ON n.oid  = rel.relnamespace
WHERE c.contype = 'f'
  AND NOT c.convalidated
ORDER BY n.nspname, rel.relname, c.conname;

-- Genera las sentencias ALTER ... VALIDATE CONSTRAINT (ejecute la salida):
SELECT format('ALTER TABLE %I.%I VALIDATE CONSTRAINT %I;', n.nspname, rel.relname, c.conname) AS ddl
FROM pg_constraint c
JOIN pg_class rel     ON rel.oid = c.conrelid
JOIN pg_namespace n   ON n.oid  = rel.relnamespace
WHERE c.contype = 'f'
  AND NOT c.convalidated
ORDER BY n.nspname, rel.relname, c.conname;
