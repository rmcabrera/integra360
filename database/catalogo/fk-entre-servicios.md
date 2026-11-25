# Relaciones entre servicios

Estas FK existian en SQL Server pero cruzan limites de microservicio. No se crean como constraint:
la integridad se mantiene por API (validacion sincronica) o por eventos Kafka (replica local de lectura).

| Origen | Destino | FK legado |
|---|---|---|
| logistica.nota_ingreso(codi_tipo_docu) | maestros.tipo_documento(codi_tipo_docu) | FK_NOTA_INGRESO_TIPO_DOCUMENTO |
| ventas.factura(codi_clie_prov) | maestros.cliente_proveedor(codi_clie_prov) | PK_CLIENTE_PROVE_FACTURA |
| contabilidad.movi_contables(codi_mone) | maestros.monedas(codi_mone) | FK_Movi_Contables_MONEDAS |
| contabilidad.movi_contables(codi_tipo_docu) | maestros.tipo_documento(codi_tipo_docu) | FK_Movi_Contables_TIPO_DOCUMENTO |
| logistica.productos(codi_mone) | maestros.monedas(codi_mone) | FK_PRODUCTOS_MONEDAS |
| logistica.productos(codi_unid_medi) | maestros.unidad_medida(codi_unid_medi) | FK_PRODUCTOS_UNIDAD_MEDIDA |
| maestros.unid_oper(codi_lcc) | contabilidad.linea_clase_c(codi_lcc) | FK_UNID_OPER_LINEA_CLASE_C |
| logistica.lista_de_requerimientos(codi_pers_resp) | seguridad.usuarios(codi_usua) | FK_LISTA_DE_REQUERIMIENTOS_USUARIOS |
| logistica.docu_sali_mate(codi_tipo_docu_sali) | maestros.tipo_documento(codi_tipo_docu) | FK_DOCU_SALI_MATE_TIPO_DOCUMENTO |
| logistica.docu_sali_mate(codi_unid_nego) | maestros.unidad_negocio(codi_unid_nego) | PK_DOCU_SALI_UNID_NEGO |
| logistica.docu_sali_mate(codi_turn) | rrhh.turnos(codi_turn) | PK_TURN_SALIDA |
| logistica.docu_sali_mate(codi_turn) | rrhh.turnos(codi_turn) | PK_TURN_VALE_SALIDA |
| produccion.analisis_aceite(codi_ingr,codi_alma,item,codi_prod,i_o) | logistica.kardex_almacenes(codi_transa,codi_alma,item,codi_prod,i_o) | FK_Analisis_Aceite_KARDEX_ALMACENES |
| logistica.orden_de_compra(codi_clie_prov) | maestros.cliente_proveedor(codi_clie_prov) | FK_ORDEN_DE_COMPRA_CLIENTE_PROVEEDOR |
| contabilidad.decl_diar_zarp_deta(codi_carg) | rrhh.cargos(codi_carg) | FK_DECL_DIAR_ZARP_DETA_CARGOS |
| produccion.parte_cargo(codi_carg) | rrhh.cargos(codi_carg) | FK_PARTE_CARGO_CARGOS |
| rrhh.juicios_empresa(codi_clie_prov) | maestros.cliente_proveedor(codi_clie_prov) | FK_JUICIOS_EMPRESA_CLIENTE_PROVEEDOR |
| finanzas.anticipos(codi_clie_prov) | maestros.cliente_proveedor(codi_clie_prov) | FK_ANTICIPOS_CLIENTE_PROVEEDOR |
| finanzas.anticipos(codi_tipo_docu_pago) | maestros.tipo_documento(codi_tipo_docu) | FK_ANTICIPOS_TIPO_DOCUMENTO |
| finanzas.anticipos(codi_tipo_docu_soli) | maestros.tipo_documento(codi_tipo_docu) | FK_ANTICIPOS_TIPO_DOCUMENTO1 |
| logistica.almacen_usuario(codi_usua) | seguridad.usuarios(codi_usua) | FK_Almacen_Usuario_USUARIOS |
| ventas.boletas(codi_clie_prov) | maestros.cliente_proveedor(codi_clie_prov) | PK_BOLETAS_CLIENTE |
| logistica.proveedor_productos(codi_clie_prov) | maestros.cliente_proveedor(codi_clie_prov) | FK_PROVEEDOR_PRODUCTOS_CLIENTE_PROVEEDOR |
| produccion.ratio_produccion(codi_rati) | contabilidad.ratios(codi_rati) | PK_RATIO_PROD |
| logistica.orden_compra_detalle(codi_orde) | produccion.orden_compra_aceite(codi_orde) | FK_ORDEN_COMPRA_DETALLE_ORDEN_COMPRA_ACEITE |
| rrhh.adelanto_ep_terceros(codi_unid_oper) | produccion.embarcaciones(codi_unid_oper) | FK_ADELANTOS_TERCEROS |
| produccion.zarpes(codi_clie_prov) | maestros.cliente_proveedor(codi_clie_prov) | FK_ZARPES_CLIENTE_PROVEEDOR |
| produccion.zarpes(codi_prov_petr) | maestros.cliente_proveedor(codi_clie_prov) | PK_PROVEEDOR_PETRO |
| finanzas.cheques(codi_clie_prov) | maestros.cliente_proveedor(codi_clie_prov) | FK_CHEQUES_CLIENTE_PROVEEDOR |
| seguridad.empresa_establecimiento(codi_tipo_estab) | maestros.establecimiento(codi_esta) | FK_EMPRESA_ESTABLECIMIENTO_ESTABLECIMIENTO |
| rrhh.personal(codi_mone_basi) | maestros.monedas(codi_mone) | FK_PERSONAL_MONEDAS |
| rrhh.personal(codi_mone) | maestros.monedas(codi_mone) | FK_PERSONAL_MONEDAS1 |
| produccion.precio_snp(codi_sema) | maestros.semana(codi_sema) | PK_SEMAN_SNP |
| ventas.factura_pesca(codi_clie_prov) | maestros.cliente_proveedor(codi_clie_prov) | PK_CLIENTE_FACTURA |
| ventas.factura_pesca(codi_mone) | maestros.monedas(codi_mone) | PK_MONEDA_FACTURA |
| rrhh.auto_trab_cent_oper(codi_puer_oper) | produccion.puerto(codi_puer) | FK_AUTO_TRAB_CENT_OPER_Puerto |
| rrhh.asistencia_tripulantes_pesca(codi_sema) | maestros.semana(codi_sema) | PK_ASIS_SEMANA_TRIPU |
| rrhh.asistencia_tripulantes_pesca(codi_unid_oper) | produccion.embarcaciones(codi_unid_oper) | PK_EMBAR_ASIS |
| ventas.facturas(codi_clie) | maestros.cliente_proveedor(codi_clie_prov) | FK_FACTURAS_CLIENTE_PROVEEDOR |
| ventas.facturas(codi_mone) | maestros.monedas(codi_mone) | FK_FACTURAS_MONEDAS |
| produccion.consumo_combustible(codi_unid_tran) | ventas.unidad_transporte(codi_unid_tran) | FK_CONS_COMB_Unid_trans |
| produccion.precio_pactado(codi_clie_prov) | maestros.cliente_proveedor(codi_clie_prov) | FK_PRECIO_PACTADO_CLIENTE_PROVEEDOR |
| produccion.precio_pactado(codi_sema) | maestros.semana(codi_sema) | FK_PRECIO_PACTADO_SEMANA |
| finanzas.seguros(codi_clie_prov) | maestros.cliente_proveedor(codi_clie_prov) | FK_SEGUROS_CLIENTE_PROVEEDOR |
| ventas.siembras(cod_cultivo) | maestros.cultivos(cod_cultivo) | FK_SIEMBRAS_CULTIVOS |
| rrhh.planilla_de_tripulantes(codi_sema) | maestros.semana(codi_sema) | FK_PLANILLA_DE_TRIPULANTES_SEMANA_PESCA |
| rrhh.incrementos_personal(codi_mone) | maestros.monedas(codi_mone) | FK_INCREMENTOS_PERSONAL_MONEDAS |
| rrhh.personal_seguros(codi_mone) | maestros.monedas(codi_mone) | FK_PERSONAL_SEGUROS_MONEDAS |
| rrhh.personal_seguros(codi_segu) | finanzas.seguros(codi_segu) | FK_PERSONAL_SEGUROS_SEGUROS |
| finanzas.cta_cte_personal(codi_pers) | rrhh.personal(codi_pers) | FK_CTA_CTE_PERSONAL_PERSONAL |
| produccion.detalle_zarpe(codi_unid_medi_cant) | maestros.unidad_medida(codi_unid_medi) | FK_DETALLE_ZARPE_UNIDAD_MEDIDA |
| produccion.detalle_zarpe(codi_unid_medi_tama) | maestros.unidad_medida(codi_unid_medi) | FK_DETALLE_ZARPE_UNIDAD_MEDIDA1 |
| produccion.detalle_zarpe(codi_clie_prov) | maestros.cliente_proveedor(codi_clie_prov) | PK_CLIENTE_ZARPE |
| contabilidad.activos(codi_mone) | maestros.monedas(codi_mone) | FK_activo_MONEDAS |
| logistica.orden_compra_pedido_cotiza(codi_tipo_docu) | maestros.tipo_documento(codi_tipo_docu) | FK_ORDEN_COMPRA_PEDIDO_COTIZA_TIPO_DOCUMENTO |
| ventas.facturas_detalle(codi_orde_produc) | produccion.orden_produccion(codi_orde_produc) | FK_FACTURAS_DETALLE_ORDEN_PRODUCCION |
| finanzas.anticipos_documento_compra(codi_tipo_docu) | maestros.tipo_documento(codi_tipo_docu) | FK_ANTICIPOS_DOCUMENTO_COMPRA_TIPO_DOCUMENTO |
| maestros.telefono(codi_pers) | rrhh.personal(codi_pers) | FK_TELEFONO_PERSONAL |
| rrhh.derecho_habiente(codi_tipo_docu) | maestros.tipo_documento(codi_tipo_docu) | FK_DERECHO_HABIENTE_TIPO_DOCUMENTO |
| produccion.orden_produccion_factura(codi_fact) | ventas.facturas(codi_fact) | FK_ORDEN_PRODUCCION_FACTURA_FACTURAS |
| contabilidad.decl_diar_arri(codi_puer_arri) | produccion.puerto(codi_puer) | FK_DECL_DIAR_ARRI_Puerto |
| rrhh.planilla_pesca_tripulantes(codi_sema) | maestros.semana(codi_sema) | PK_SEMA_PLANILALA |
| rrhh.planilla_pesca_tripulantes(codi_unid_oper) | produccion.embarcaciones(codi_unid_oper) | PK_UNID_OPER_PLANILLA |
| contabilidad.decl_zarp_trim_deta(codi_carg) | rrhh.cargos(codi_carg) | FK_DECL_ZARP_TRIM_DETA_CARGOS |
| contabilidad.decl_zarp_trim_deta(codi_titu) | produccion.tipo_titu_pesc(codi_tipo_titu_pesc) | FK_DECL_ZARP_TRIM_DETA_TIPO_TITU_PESC |
| seguridad.parametro(codi_prod) | logistica.productos(codi_prod) | FK_Parametro_PRODUCTOS |
| produccion.analisis_parametro(cod_param) | seguridad.parametro(cod_param) | FK_Analisis_Parametro_Parametro |
| finanzas.pagos_juicios(codi_juic) | rrhh.juicios(codi_juic) | FK_PAGOS_JUICIOS_JUICIOS |
