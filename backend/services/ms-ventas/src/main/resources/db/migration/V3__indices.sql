-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
CREATE INDEX ix_factura_alma_docu_ser_nro ON factura (codi_alma, codi_tipo_docu, ser_fact, nro_fact);
CREATE INDEX ix_factura_alma_pago_fecha ON factura (codi_alma, codi_tipo_pago, fech_fact);
CREATE INDEX ix_factura_cliente ON factura (codi_clie_prov);
CREATE INDEX ix_factura_cod_fec_esta ON factura (codi_alma) INCLUDE (codi_fact, fech_fact, estado);
CREATE INDEX ix_factura_codifact_fechfact ON factura (codi_alma, codi_tipo_pago) INCLUDE (codi_fact, fech_fact);
CREATE INDEX ix_factura_doc_ser_nro ON factura (codi_tipo_docu, ser_fact, nro_fact);
CREATE INDEX ix_factura_fac_fec ON factura (fech_fact) INCLUDE (codi_fact, codi_alma, codi_clie_prov, codi_tipo_docu, ser_fact, nro_fact, codi_mone, tcambio, codi_tipo_pago, estado);
CREATE INDEX ix_factura_fecha ON factura (fech_fact) INCLUDE (codi_fact, codi_tipo_docu, ser_fact, nro_fact, estado);
CREATE INDEX ix_factura_fk_tipo_fact ON factura (tipo_fact); -- indice de FK (mejora)
CREATE INDEX ix_factura_detalle_fact_prod_impo ON factura_detalle (codi_prod) INCLUDE (codi_fact, impo_item);
CREATE INDEX ix_cliente_creditos_alma ON cliente_creditos (codi_alma) INCLUDE (codi_credito);
CREATE INDEX ix_factura_credito_credi ON factura_credito (codi_credito) INCLUDE (monto);
CREATE INDEX ix_registro_vale_fact_vale_esta ON registro_vale (codi_fact) INCLUDE (codi_vale, estado);
CREATE INDEX ix_vale_credito_fk_codi_credito ON vale_credito (codi_credito); -- indice de FK (mejora)
CREATE INDEX ix_guia_aprob ON guia (apro_por) INCLUDE (codi_guia, ser_guia, nro_guia, fech_tras, punto_partida, codi_clie_dest, creacion, envio);
CREATE INDEX ix_registro_vale_detalle_cod_prod_cant ON registro_vale_detalle (codi_alma) INCLUDE (codi_vale, codi_prod, cantidad);
CREATE INDEX ix_registro_vale_detalle_prod_alma ON registro_vale_detalle (codi_prod, codi_alma);
