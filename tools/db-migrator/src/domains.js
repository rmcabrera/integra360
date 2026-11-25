'use strict';
/**
 * Asignacion de tablas legado -> bounded context (microservicio).
 * Basado en el arbol de menus de m_siep_main (PowerBuilder) y en el uso de las tablas
 * en los procedimientos almacenados. Las reglas se evaluan en orden: gana la primera.
 * Para mover una tabla de servicio basta con agregarla en OVERRIDES.
 */
const SERVICES = {
  seguridad:    { port: 8081, pkg: 'seguridad',    title: 'Seguridad y Configuracion' },
  maestros:     { port: 8082, pkg: 'maestros',     title: 'Maestros generales' },
  logistica:    { port: 8083, pkg: 'logistica',    title: 'Logistica, Almacen y Compras' },
  ventas:       { port: 8084, pkg: 'ventas',       title: 'Facturacion, Ventas y Operaciones comerciales' },
  contabilidad: { port: 8085, pkg: 'contabilidad', title: 'Contabilidad, Activos y Libros SUNAT' },
  finanzas:     { port: 8086, pkg: 'finanzas',     title: 'Finanzas: Caja, Bancos y Letras' },
  rrhh:         { port: 8087, pkg: 'rrhh',         title: 'Personal, Planillas y Legal' },
  produccion:   { port: 8088, pkg: 'produccion',   title: 'Pesca, Flota y Produccion' },
  staging:      { port: null, pkg: null,           title: 'Tablas auxiliares/temporales del legado (sin servicio)' }
};

const OVERRIDES = {
  // seguridad / plataforma
  usuarios: 'seguridad', usuarios_grupos: 'seguridad', acceso: 'seguridad', configsys: 'seguridad', conexion: 'seguridad',
  auditoria: 'seguridad', visor_de_eventos: 'seguridad', viso_even: 'seguridad', cierre_mes: 'seguridad', cierre_mes_user: 'seguridad',
  empresa: 'seguridad', parametros: 'seguridad', aceptacion_x_usuario: 'seguridad', firmas: 'seguridad', notas_posits: 'seguridad',
  consistencias: 'seguridad', menugrupos: 'seguridad', establecimiento: 'maestros',
  // staging (tablas temporales / copias / pruebas del sistema anterior)
  tx: 'staging', tx2: 'staging', tx3: 'staging', txprod: 'staging', px: 'staging', tempo: 'staging', sheet: 'staging',
  v2017: 'staging', kadm: 'staging', kadm2015: 'staging', registro_axu: 'staging', cliente_proveedor_tempo: 'staging',
  cliente_proveedor_aux: 'staging', productos_xx: 'staging', productos_matriz_x: 'staging', orden_produc_deta_material_copy: 'staging',
  artificio_tablas_copy: 'staging', artificio_tablas: 'staging', artificio_uso_objetopb: 'staging', eliminar_corre: 'staging', cp: 'staging',
  movi_contables_ax: 'staging', detalle_salida_aux: 'staging', paper: 'staging', pbcatcol: 'staging', pbcatedt: 'staging',
  pbcatfmt: 'staging', pbcattbl: 'staging', pbcatvld: 'staging', le201707: 'staging',
  // casos ambiguos resueltos a mano
  productos_ofertas: 'ventas', letras_productos: 'finanzas', registro_pagos: 'finanzas', factura_anticipos: 'ventas',
  pagos_adelantos: 'rrhh', cotizacion: 'ventas', cotizacion_deta: 'logistica', cotizacion_de_pedidos: 'logistica',
  liquidacion: 'ventas', liquidacion_deta: 'ventas', liquidacion_ruta: 'ventas', compromisos_pactados: 'logistica',
  compromisos_pactados_deta: 'logistica', orden_despacho_combustible: 'logistica', orden_despacho_combustible_deta: 'logistica',
  tipo_pago: 'maestros', bancos: 'finanzas', centro_costo: 'contabilidad', unid_oper: 'maestros', unidad_negocio: 'maestros',
  tipo_unid_oper: 'maestros', tanques: 'produccion', tanq_auxiliar: 'produccion', cultivos: 'maestros', proyecto: 'logistica',
  orde_serv_x_proy: 'logistica', recibo_egreso: 'finanzas', retencion: 'contabilidad', bien_servicio: 'contabilidad',
  detalle_detraccion: 'contabilidad', cabecera_detraccion: 'contabilidad', tipo_comision: 'ventas', comisiones: 'ventas',
  producto_comision: 'ventas', lugar_origen: 'produccion', tipo_carga: 'ventas', transportistas: 'maestros', domicilio: 'maestros',
  feriados: 'maestros', semana: 'maestros', convenio_evita_doble_tributacion: 'rrhh', nivel: 'rrhh', ocupacion: 'rrhh',
  estados: 'maestros', motivos: 'maestros', documentos: 'maestros', referencias: 'maestros', terceros: 'maestros',
  propias_terceros: 'produccion', gasto_operativo: 'contabilidad', costo: 'contabilidad', ratios: 'contabilidad',
  punto_equilibrio: 'contabilidad', documento_garantia: 'finanzas', polizas: 'finanzas', bazar: 'ventas', puerto: 'produccion',
  material: 'logistica', marca: 'logistica', acabado: 'logistica', color: 'logistica', kits: 'logistica', zonas: 'maestros', zona: 'maestros',
  via: 'maestros', tipo_documento: 'maestros', tipo_docu_iden: 'maestros', tipo_comprobante: 'contabilidad', operaciones: 'contabilidad',
  sub_factura: 'ventas', control: 'seguridad', util_pers_anual: 'rrhh', precio: 'ventas', prec_prom_inve: 'logistica',
  hoja_vida: 'ventas', hoja_vida_deta: 'ventas', conocimiento: 'ventas', rotacion: 'ventas', metas_linea_rota: 'ventas',
  plan_marketing: 'ventas', ubicacion: 'ventas', agrupaciones: 'contabilidad', glosas: 'contabilidad', subdiario: 'contabilidad',
  clase: 'contabilidad', tipo_gasto: 'contabilidad', elemento_costo: 'contabilidad', catalmae: 'contabilidad', aduana: 'maestros',
  monedas: 'maestros', actividad: 'rrhh', acti_econ_prin: 'maestros', tipo_empresa: 'maestros', entidad_salud: 'rrhh',
  documento_vinculo: 'rrhh', cuentas_activos_prov: 'contabilidad', activos_centros: 'contabilidad', talleres: 'produccion',
  sistemas_embarcaciones: 'produccion', informe_acidez: 'produccion', analisis_aceite: 'produccion', registro_vale: 'ventas',
  vale_credito: 'ventas', vale_salida: 'logistica', acta_entrega: 'ventas', registro_producto: 'logistica', registro_producto_deta: 'logistica',
  registro_orden_pedido: 'logistica', registro_orden_pedido_deta: 'logistica', lote_situacion: 'logistica', saldo_moneda: 'finanzas',
  tipo_destino: 'produccion', destinos_pesca: 'produccion', tipo_envases: 'logistica', tipo_existencia: 'logistica', tipo_intangible: 'contabilidad',
  tipo_medida: 'maestros', tipo_costo: 'contabilidad', tipo_cost_gene: 'contabilidad', tipo_riesgo: 'rrhh', tipo_ries_tasa: 'rrhh',
  tipo_comida: 'rrhh', tipo_cert_emba: 'produccion', tipo_titu_pesc: 'produccion', tipo_plan_nemo: 'rrhh', tipos_planillas: 'rrhh',
  tipo_ingr_sali: 'logistica', tipo_aceptacion: 'logistica', tipos_orden_produccion: 'produccion', principio_activo: 'logistica',
  siembras: 'ventas', captacion: 'ventas', captacion_visita: 'ventas', recomendacion: 'ventas', recomendacion_deta: 'ventas',
  depositos: 'finanzas', cuotas_sucursal: 'ventas', cultivos_principal: 'ventas', grupos: 'seguridad',
  estados_financieros: 'contabilidad', estados_financieros_detalle: 'contabilidad', reporte_eeff: 'contabilidad',
  reporte_eeff_grupo: 'contabilidad', libro_registro: 'contabilidad', libro_diario_s: 'contabilidad', sub_clas_cuen: 'contabilidad',
  detalle_calc_af: 'contabilidad', tipo_form_most_eeff: 'contabilidad', tipo_form_prov_plan: 'contabilidad',
  control_problemas: 'logistica', control_problemas_detalle: 'logistica', calc_util_tota: 'rrhh', calc_util_pers: 'rrhh',
  calc_util_deta: 'rrhh', registro_vale_detalle: 'ventas', parte_cargo: 'produccion', taller_diario: 'produccion',
  proveedor_productos: 'logistica', orden_compra_detalle: 'logistica', orden_compra_pedido_cotiza: 'logistica',
  detalle_cotizacion_pedido: 'logistica', detalle_listarequerimientos: 'logistica', kit_deta: 'logistica',
  aceptacion_lista_reque: 'logistica', detalle_salida_materiales: 'logistica', principio_x_producto: 'logistica',
  ratio_produccion: 'produccion', saldo_poza: 'produccion', saldo_tanques: 'produccion', precio_snp: 'produccion',
  precio_pactado: 'produccion', consumo_combustible: 'produccion', detalle_zarpe: 'produccion', detalle_factura_pesca: 'produccion',
  acta_entrega_detalle: 'ventas', cheques: 'finanzas', seguros: 'finanzas', presupuesto: 'finanzas',
  empresa_establecimiento: 'seguridad', empresa_establec_tasas: 'seguridad', plan_conc_desc: 'rrhh', plan_conc_incr: 'rrhh',
  auto_trab_cent_oper: 'rrhh', auto_trab_cent_oper_deta: 'rrhh', valores_sistema_pensiones: 'rrhh', incrementos_personal: 'rrhh',
  derecho_habiente: 'rrhh', datos_cts: 'rrhh', unidad_transporte: 'ventas', analisis_parametro: 'produccion', parametro: 'seguridad',
  unidad_medida: 'maestros', almacen_documentos: 'ventas', unidad_medida_sunat: 'maestros', unidad_medida_inter: 'maestros',
  sunat: 'contabilidad', sunat_f318: 'contabilidad', periodicidad: 'rrhh', pension: 'rrhh', lugar_trabajo: 'rrhh', especies: 'produccion'
};

const RULES = [
  ['rrhh',        /^(personal|pers_|planilla|asistencia|hora|horario|turnos|cargos|areas?$|area_grup|sub_area_grup|conceptos|tipo_conceptos|contratos|tipo_contrato|vacaciones|tipo_vacaciones|licencias|tipos_licencias|sindicatos|sistema_pensiones|rubros_sistema_pensiones|situ_trab_pens|regimen_laboral|categoria_|tipo_trabajador|tipo_personal|tipo_cargo|modalidad_formativa|vinculo_familiar|moti_baja_dh|moti_fin_periodo|tipo_suspension|soli_pres|tipo_prestamo|pagos_prestamos|prestamos|adelanto|ingresos_quinta|parametros_quinta|subsidios|grat|extr|dias_trab|abogados|jueces|juzgados|especialistas|demandas|constancia_juicios|juicios|desplaz|deta_ingr_grat|tipo_situ_hora_trab)/],
  ['produccion',  /^(embar|emba_|situ_emba|nrotrip|zarp|derechopesca|pozas|nota_ingreso_aceite|orden_compra_aceite|orden_produc|tipos_orden_produccion)/],
  ['contabilidad',/^(movi_contables|cuentas_|cuen_|m_|clases_cuentas|sub_clase|linea_clase_c|contabilizacion|saldos_cuentas|sald_tota|eeff|tipo_eeff|concepto_balance|gerencial_repo|activos|operac_sunat|concepto_sunat|sub_concepto_sunat|plecompras|tipo_afecta_igv|tipo_impuestos|coef_liqu|dif_camb|declara|decl_)/],
  ['finanzas',    /^(caja_|bancos|banco|conci_banco|tipo_situ_conc_banc|tipo_situ_cheq|sald_conc_banc|saldo_bancos|letra|pres_pago|pres_grup|rubros_caja|warrant|tipos_pago_warrant|tipo_cta|tipo_medio_pago|tipo_form_pago|escribalo|cta_cte|tipo_reembolso|anticipo|pagos_)/],
  ['ventas',      /^(factura|facturas|nota_venta|nota_credito|nota_debito|tipo_factura|tipo_notas|convenio|cliente_credito|creditos|cliente_vendedor|captacion|ruta|guia|configuracion_vehicular|motivo_traslado|motivo_nota_cred|orden_solicitud_servicio|boletas)/],
  ['logistica',   /^(productos|producto_|almacen|kardex|familia_|sub_familia|linea_familia|presentacion|nota_ingreso|nota_ingr_|detalle_nota_ingreso|docu_sali|detalle_docu_sali|salida_material|sali_|lista_de_requerimientos|orden_de_pedido|orden_de_compra|detalle_orden|ccnu_|unidad_medida|unid_)/],
  ['maestros',    /^(cliente|clie_|ubigeo|pais|nacion|tipo_|moti|codigos_|estados)/]
];

function classify(tableName) {
  const n = tableName.toLowerCase();
  if (OVERRIDES[n]) return OVERRIDES[n];
  for (const [svc, re] of RULES) if (re.test(n)) return svc;
  return 'maestros';
}

module.exports = { SERVICES, classify };
