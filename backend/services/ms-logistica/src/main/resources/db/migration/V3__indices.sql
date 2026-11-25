-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
CREATE INDEX ix_nota_ingreso_clie_ser_nro_cont ON nota_ingreso (codi_clie_prov, nro_docu_cont, codi_tipo_docu_cont) INCLUDE (codi_nota_ingr, nro_seri_docu_cont);
CREATE INDEX ix_nota_ingreso_fec_tipo ON nota_ingreso (fech_nota_ingr, tipo_nota_ingr);
CREATE INDEX ix_nota_ingreso_tipo_alma ON nota_ingreso (tipo_nota_ingr, codi_alma) INCLUDE (codi_nota_ingr, fech_nota_ingr);
CREATE INDEX ix_nota_ingreso_tipo_nota ON nota_ingreso (tipo_nota_ingr) INCLUDE (codi_nota_ingr);
CREATE INDEX ix_nota_ingreso_tiponota_fecha ON nota_ingreso (tipo_nota_ingr, fech_nota_ingr) INCLUDE (codi_nota_ingr);
CREATE INDEX ix_nota_ingreso_fk_codi_alma ON nota_ingreso (codi_alma); -- indice de FK (mejora)
CREATE INDEX ix_sub_familia_producto_fk_codi_fami_prod ON sub_familia_producto (codi_fami_prod); -- indice de FK (mejora)
CREATE INDEX ix_productos_prod ON productos (codi_prod) INCLUDE (desc_prod, codi_sub_fami_prod, codi_mone, cod_pres, tcambio, nro_decim_precio, costo_oper);
CREATE INDEX ix_productos_fk_codi_sub_fami_prod ON productos (codi_sub_fami_prod); -- indice de FK (mejora)
CREATE INDEX ix_almacen_producto_fk_codi_prod ON almacen_producto (codi_prod); -- indice de FK (mejora)
CREATE INDEX ix_kardex_2 ON kardex (periodo, codi_alma, codi_prod, fech_tran);
CREATE INDEX ix_kardex_codi_per_item ON kardex (codi_docu_i_o, periodo, item);
CREATE INDEX ix_kardex_codiprod_fechtran_cantingr_cantsali ON kardex (codi_alma) INCLUDE (codi_prod, fech_tran, cant_ingr, cant_sali);
CREATE INDEX ix_kardex_kar_fec_prom_io_docu_item ON kardex (periodo) INCLUDE (fech_tran, prec_prom, i_o, codi_docu_i_o, item);
CREATE INDEX ix_kardex_per ON kardex (periodo) INCLUDE (codi_prod, cant_ingr, cant_sali, codi_alma);
CREATE INDEX ix_kardex_per_io_cod_ite ON kardex (periodo) INCLUDE (i_o, codi_docu_i_o, item);
CREATE INDEX ix_kardex_periodo ON kardex (periodo) INCLUDE (codi_prod, fech_tran, cant_sali, i_o, codi_docu_i_o, codi_alma);
CREATE INDEX ix_kardex_pro_fec_per ON kardex (codi_prod, fech_tran, periodo);
CREATE INDEX ix_kardex_prod_alma_docu ON kardex (codi_prod, codi_alma, codi_tipo_docu) INCLUDE (fech_tran, i_o);
CREATE INDEX ix_kardex_prod_fec_cant_io_docu_alma ON kardex (periodo) INCLUDE (codi_prod, fech_tran, cant_ingr, i_o, codi_docu_i_o, codi_alma);
CREATE INDEX ix_kardex_prod_per ON kardex (codi_prod, periodo) INCLUDE (codi_kard, fech_tran, i_o, codi_docu_i_o, item);
CREATE INDEX ix_kardex_usp_reporte_productos_venta_sinrota_1 ON kardex (codi_alma, periodo) INCLUDE (codi_prod, fech_tran, concepto);
CREATE INDEX ix_kardex_usp_stock_pendiente_all_x_sucur_1 ON kardex (periodo, fech_tran) INCLUDE (codi_prod);
CREATE INDEX ix_kardex_usp_stock_pendiente_all_x_sucur_2 ON kardex (periodo, fech_tran) INCLUDE (codi_prod);
CREATE INDEX ix_lista_de_requerimientos_fk_codi_alma ON lista_de_requerimientos (codi_alma); -- indice de FK (mejora)
CREATE INDEX ix_orden_de_pedido_fk_codi_alma ON orden_de_pedido (codi_alma); -- indice de FK (mejora)
CREATE INDEX ix_orden_de_pedido_fk_codi_list_requ ON orden_de_pedido (codi_list_requ); -- indice de FK (mejora)
CREATE INDEX ix_docu_sali_mate_codi_cond_alma ON docu_sali_mate (codi_alma_desti, condicion, codi_alma) INCLUDE (codi_docu_sali, codi_tipo_docu_sali, fech_emis, nro_seri_docu_sali, nro_docu_sali, nro_sali);
CREATE INDEX ix_docu_sali_mate_fech_emis ON docu_sali_mate (fech_emis) INCLUDE (codi_docu_sali, codi_fact);
CREATE INDEX ix_docu_sali_mate_tipo_docu_serie_alma ON docu_sali_mate (codi_tipo_docu_sali, nro_seri_docu_sali, codi_alma) INCLUDE (nro_docu_sali);
CREATE INDEX ix_docu_sali_mate_tipo_sali ON docu_sali_mate (tipo_sali) INCLUDE (codi_docu_sali);
CREATE INDEX ix_docu_sali_mate_tipo_sali_alma ON docu_sali_mate (tipo_sali, codi_alma) INCLUDE (codi_docu_sali, fech_emis, codi_alma_desti);
CREATE INDEX ix_docu_sali_mate_tipo_sali_incl ON docu_sali_mate (tipo_sali) INCLUDE (codi_docu_sali, codi_unid_oper_rece, fech_emis, nro_seri_docu_sali, nro_docu_sali, nro_sali, codi_alma);
CREATE INDEX ix_docu_sali_mate_indi_nro_sali_sali_mate ON docu_sali_mate (nro_sali);
CREATE INDEX ix_docu_sali_mate_fk_codi_alma ON docu_sali_mate (codi_alma); -- indice de FK (mejora)
CREATE INDEX ix_docu_sali_mate_fk_codi_orde_pedi ON docu_sali_mate (codi_orde_pedi); -- indice de FK (mejora)
CREATE INDEX ix_detalle_docu_sali_2 ON detalle_docu_sali (codi_deta_docu_sali, codi_docu_sali);
CREATE INDEX ix_detalle_docu_sali_ind_deta_docu_sali_prod_pedi ON detalle_docu_sali (codi_prod, codi_deta_orde_pedi);
CREATE INDEX ix_detalle_docu_sali_indi_docu_sali_mate_dds ON detalle_docu_sali (codi_docu_sali);
CREATE INDEX ix_detalle_docu_sali_fk_codi_alma ON detalle_docu_sali (codi_alma); -- indice de FK (mejora)
CREATE INDEX ix_detalle_docu_sali_fk_codi_prod ON detalle_docu_sali (codi_prod); -- indice de FK (mejora)
CREATE INDEX ix_detalle_nota_ingreso_codi_pro ON detalle_nota_ingreso (codi_nota_ingr, nro_item_nota_ingr, codi_prod);
CREATE INDEX ix_detalle_nota_ingreso_prod ON detalle_nota_ingreso (codi_prod) INCLUDE (codi_nota_ingr);
CREATE INDEX ix_detalle_nota_ingreso_fk_codi_alma ON detalle_nota_ingreso (codi_alma); -- indice de FK (mejora)
CREATE INDEX ix_productos_lotes_vale_cred_lotes ON productos_lotes_vale_cred (codi_prod_alma_lote);
CREATE INDEX ix_orden_de_compra_apro_oc ON orden_de_compra (apro_por) INCLUDE (codi_orde_comp, codi_clie_prov, fecha, fech_entr, nro_orde_comp);
CREATE INDEX ix_orden_de_compra_pedi_fecha ON orden_de_compra (pedi_trab, fecha);
CREATE INDEX ix_orden_de_compra_fk_codi_alma ON orden_de_compra (codi_alma); -- indice de FK (mejora)
CREATE INDEX ix_nota_ingr_por_orde_comp_fk_codi_nota_ingr ON nota_ingr_por_orde_comp (codi_nota_ingr); -- indice de FK (mejora)
CREATE INDEX ix_producto_almacen_lote_alma_stock ON producto_almacen_lote (codi_alma, stock) INCLUDE (codi_prod);
CREATE INDEX ix_sali_mate_x_proy_fk_codi_proy ON sali_mate_x_proy (codi_proy); -- indice de FK (mejora)
CREATE INDEX ix_detalle_salida_materiales_fk_codi_docu_sali ON detalle_salida_materiales (codi_docu_sali); -- indice de FK (mejora)
CREATE INDEX ix_detalle_orden_compra_fk_codi_alma ON detalle_orden_compra (codi_alma); -- indice de FK (mejora)
CREATE INDEX ix_detalle_orden_compra_fk_codi_orde_comp ON detalle_orden_compra (codi_orde_comp); -- indice de FK (mejora)
CREATE INDEX ix_detalle_orden_compra_fk_codi_prod ON detalle_orden_compra (codi_prod); -- indice de FK (mejora)
CREATE INDEX ix_detalle_orden_de_pedido_fk_codi_alma ON detalle_orden_de_pedido (codi_alma); -- indice de FK (mejora)
CREATE INDEX ix_detalle_orden_de_pedido_fk_codi_prod ON detalle_orden_de_pedido (codi_prod); -- indice de FK (mejora)
CREATE INDEX ix_detalle_cotizacion_pedido_fk_codi_coti ON detalle_cotizacion_pedido (codi_coti); -- indice de FK (mejora)
CREATE INDEX ix_detalle_cotizacion_pedido_fk_codi_prod ON detalle_cotizacion_pedido (codi_prod); -- indice de FK (mejora)
CREATE INDEX ix_detalle_listarequerimientos_fk_codi_alma ON detalle_listarequerimientos (codi_alma); -- indice de FK (mejora)
CREATE INDEX ix_detalle_listarequerimientos_fk_codi_prod ON detalle_listarequerimientos (codi_prod); -- indice de FK (mejora)
CREATE INDEX ix_kit_deta_fk_codi_prod ON kit_deta (codi_prod); -- indice de FK (mejora)
