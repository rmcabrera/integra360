-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
-- Las FK se crean NOT VALID porque en SQL Server estaban WITH NOCHECK.
-- Tras depurar datos: ALTER TABLE <t> VALIDATE CONSTRAINT <fk>;

ALTER TABLE nota_ingreso ADD CONSTRAINT fk_nota_ingreso_almacen FOREIGN KEY (codi_alma) REFERENCES almacen (codi_alma) NOT VALID;
ALTER TABLE sub_familia_producto ADD CONSTRAINT fk_sub_familia_producto_familia_producto FOREIGN KEY (codi_fami_prod) REFERENCES familia_producto (codi_fami_prod) NOT VALID;
ALTER TABLE productos ADD CONSTRAINT fk_productos_sub_familia_producto FOREIGN KEY (codi_sub_fami_prod) REFERENCES sub_familia_producto (codi_sub_fami_prod) NOT VALID;
ALTER TABLE almacen_producto ADD CONSTRAINT fk_almacen_producto_almacen FOREIGN KEY (codi_alma) REFERENCES almacen (codi_alma) ON DELETE CASCADE NOT VALID;
ALTER TABLE almacen_producto ADD CONSTRAINT fk_almacen_producto_productos FOREIGN KEY (codi_prod) REFERENCES productos (codi_prod) ON DELETE CASCADE NOT VALID;
ALTER TABLE kardex ADD CONSTRAINT fk_kardex_almacen FOREIGN KEY (codi_alma) REFERENCES almacen (codi_alma) NOT VALID;
ALTER TABLE lista_de_requerimientos ADD CONSTRAINT fk_lista_de_requerimientos_almacen FOREIGN KEY (codi_alma) REFERENCES almacen (codi_alma) NOT VALID;
ALTER TABLE orden_de_pedido ADD CONSTRAINT fk_orden_de_pedido_almacen FOREIGN KEY (codi_alma) REFERENCES almacen (codi_alma) NOT VALID;
ALTER TABLE orden_de_pedido ADD CONSTRAINT fk_orden_de_pedido_lista_de_requerimientos FOREIGN KEY (codi_list_requ) REFERENCES lista_de_requerimientos (codi_list_requ) ON UPDATE CASCADE NOT VALID;
ALTER TABLE docu_sali_mate ADD CONSTRAINT fk_docu_sali_mate_almacen FOREIGN KEY (codi_alma) REFERENCES almacen (codi_alma) NOT VALID;
ALTER TABLE docu_sali_mate ADD CONSTRAINT fk_docu_sali_mate_orden_de_pedido FOREIGN KEY (codi_orde_pedi) REFERENCES orden_de_pedido (codi_orde_pedi) NOT VALID;
ALTER TABLE detalle_docu_sali ADD CONSTRAINT fk_detalle_docu_sali_almacen FOREIGN KEY (codi_alma) REFERENCES almacen (codi_alma) NOT VALID;
ALTER TABLE detalle_docu_sali ADD CONSTRAINT fk_detalle_docu_sali_docu_sali_mate FOREIGN KEY (codi_docu_sali) REFERENCES docu_sali_mate (codi_docu_sali) NOT VALID;
ALTER TABLE detalle_docu_sali ADD CONSTRAINT fk_detalle_docu_sali_productos FOREIGN KEY (codi_prod) REFERENCES productos (codi_prod) NOT VALID;
ALTER TABLE detalle_nota_ingreso ADD CONSTRAINT fk_detalle_nota_ingreso_almacen FOREIGN KEY (codi_alma) REFERENCES almacen (codi_alma) NOT VALID;
ALTER TABLE detalle_nota_ingreso ADD CONSTRAINT fk_detalle_nota_ingreso_nota_ingreso FOREIGN KEY (codi_nota_ingr) REFERENCES nota_ingreso (codi_nota_ingr) NOT VALID;
ALTER TABLE detalle_nota_ingreso ADD CONSTRAINT fk_detalle_nota_ingreso_productos FOREIGN KEY (codi_prod) REFERENCES productos (codi_prod) NOT VALID;
ALTER TABLE orden_de_compra ADD CONSTRAINT fk_orden_de_compra_almacen FOREIGN KEY (codi_alma) REFERENCES almacen (codi_alma) NOT VALID;
ALTER TABLE nota_ingr_por_orde_comp ADD CONSTRAINT fk_nota_ingr_por_orde_comp_nota_ingreso FOREIGN KEY (codi_nota_ingr) REFERENCES nota_ingreso (codi_nota_ingr) NOT VALID;
ALTER TABLE nota_ingr_por_orde_comp ADD CONSTRAINT fk_nota_ingr_por_orde_comp_orden_de_compra FOREIGN KEY (codi_orde_comp) REFERENCES orden_de_compra (codi_orde_comp) NOT VALID;
ALTER TABLE almacen_usuario ADD CONSTRAINT fk_almacen_usuario_almacen FOREIGN KEY (codi_alma) REFERENCES almacen (codi_alma) ON DELETE CASCADE NOT VALID;
ALTER TABLE sali_mate_x_proy ADD CONSTRAINT fk_sali_mate_x_proy_proyecto FOREIGN KEY (codi_proy) REFERENCES proyecto (codi_proy) NOT VALID;
ALTER TABLE sali_mate_x_docu_sali ADD CONSTRAINT fk_sali_mate_x_docu_sali_salida_material FOREIGN KEY (codi_docu_sali_mate) REFERENCES salida_material (codi_docu_sali) ON DELETE CASCADE ON UPDATE CASCADE NOT VALID;
ALTER TABLE sali_mate_x_docu_sali ADD CONSTRAINT fk_sali_mate_x_docu_sali_salida_material_2 FOREIGN KEY (codi_docu_sali_mate) REFERENCES salida_material (codi_docu_sali) NOT VALID;
ALTER TABLE detalle_salida_materiales ADD CONSTRAINT fk_detalle_salida_materiales_salida_material FOREIGN KEY (codi_docu_sali) REFERENCES salida_material (codi_docu_sali) NOT VALID;
ALTER TABLE detalle_salida_materiales ADD CONSTRAINT fk_detalle_salida_materiales_salida_material_2 FOREIGN KEY (codi_docu_sali) REFERENCES salida_material (codi_docu_sali) ON DELETE CASCADE ON UPDATE CASCADE NOT VALID;
ALTER TABLE orden_compra_pedido_cotiza ADD CONSTRAINT fk_orden_compra_pedido_cotiza_orden_de_compra FOREIGN KEY (codi_orde_comp) REFERENCES orden_de_compra (codi_orde_comp) ON UPDATE CASCADE NOT VALID;
ALTER TABLE detalle_orden_compra ADD CONSTRAINT fk_detalle_orden_compra_almacen FOREIGN KEY (codi_alma) REFERENCES almacen (codi_alma) NOT VALID;
ALTER TABLE detalle_orden_compra ADD CONSTRAINT fk_detalle_orden_compra_orden_de_compra FOREIGN KEY (codi_orde_comp) REFERENCES orden_de_compra (codi_orde_comp) ON UPDATE CASCADE NOT VALID;
ALTER TABLE detalle_orden_compra ADD CONSTRAINT fk_detalle_orden_compra_productos FOREIGN KEY (codi_prod) REFERENCES productos (codi_prod) NOT VALID;
ALTER TABLE detalle_orden_de_pedido ADD CONSTRAINT fk_detalle_orden_de_pedido_almacen FOREIGN KEY (codi_alma) REFERENCES almacen (codi_alma) NOT VALID;
ALTER TABLE detalle_orden_de_pedido ADD CONSTRAINT fk_detalle_orden_de_pedido_productos FOREIGN KEY (codi_prod) REFERENCES productos (codi_prod) NOT VALID;
ALTER TABLE detalle_cotizacion_pedido ADD CONSTRAINT fk_detalle_cotizacion_pedido_cotizacion_de_pedidos FOREIGN KEY (codi_coti) REFERENCES cotizacion_de_pedidos (codi_coti) NOT VALID;
ALTER TABLE detalle_cotizacion_pedido ADD CONSTRAINT fk_detalle_cotizacion_pedido_productos FOREIGN KEY (codi_prod) REFERENCES productos (codi_prod) NOT VALID;
ALTER TABLE detalle_listarequerimientos ADD CONSTRAINT fk_detalle_listarequerimientos_almacen FOREIGN KEY (codi_alma) REFERENCES almacen (codi_alma) NOT VALID;
ALTER TABLE detalle_listarequerimientos ADD CONSTRAINT fk_detalle_listarequerimientos_productos FOREIGN KEY (codi_prod) REFERENCES productos (codi_prod) NOT VALID;
ALTER TABLE kit_deta ADD CONSTRAINT fk_kit_deta_productos FOREIGN KEY (codi_prod) REFERENCES productos (codi_prod) NOT VALID;
ALTER TABLE aceptacion_lista_reque ADD CONSTRAINT fk_aceptacion_lista_reque_detalle_listarequerimientos FOREIGN KEY (codi_deta_list_requ) REFERENCES detalle_listarequerimientos (codi_deta_list_requ) ON UPDATE CASCADE NOT VALID;
