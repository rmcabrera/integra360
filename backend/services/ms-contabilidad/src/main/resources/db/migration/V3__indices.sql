-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
CREATE INDEX ix_movi_contables_ani_mes_fec ON movi_contables (anio, mes, fecha) INCLUDE (nro_cuen, codi_clie_prov, importe, importe_d, registro, cargo_abono, fecha_venc);
CREATE INDEX ix_movi_contables_ani_mes_subdia ON movi_contables (anio, mes, subdia);
CREATE INDEX ix_movi_contables_anio_clie ON movi_contables (anio, codi_clie_prov);
CREATE INDEX ix_movi_contables_anio_cuen_fec_regis ON movi_contables (anio, nro_cuen, fecha, registro) INCLUDE (codi_clie_prov, importe, importe_d, cargo_abono, fecha_venc);
CREATE INDEX ix_movi_contables_anio_mes_cuen ON movi_contables (anio, mes, nro_cuen);
CREATE INDEX ix_movi_contables_anio_mes_sub_compr ON movi_contables (anio, mes, subdia, compr);
CREATE INDEX ix_movi_contables_anio_mes_sub_prov ON movi_contables (anio, mes, subdia, codi_clie_prov);
CREATE INDEX ix_movi_contables_anio_nota_ingr ON movi_contables (anio, codi_nota_ingr);
CREATE INDEX ix_movi_contables_clie_seri_nro_nota ON movi_contables (codi_clie_prov, serie, subdia, codi_nota_ingr);
CREATE INDEX ix_movi_contables_cuen_regis ON movi_contables (nro_cuen, registro) INCLUDE (codi_contable, codi_clie_prov);
CREATE INDEX ix_movi_contables_cuenta ON movi_contables (nro_cuen) INCLUDE (anio, codi_mone, fecha, codi_clie_prov, importe, importe_d, cargo_abono);
CREATE INDEX ix_movi_contables_fec_cuen_impo ON movi_contables (codi_unid_oper) INCLUDE (fecha, nro_cuen, importe, cargo_abono);
CREATE INDEX ix_movi_contables_fec_regis ON movi_contables (fecha, registro) INCLUDE (codi_contable, nro_cuen, codi_clie_prov);
CREATE INDEX ix_movi_contables_mes_subd ON movi_contables (mes, subdia) INCLUDE (anio, nro_cuen, importe, cargo_abono);
CREATE INDEX ix_movi_contables_movi_anio_cuen_subdia ON movi_contables (anio, nro_cuen, subdia) INCLUDE (codi_contable, mes, compr, fecha, codi_clie_prov, codi_tipo_docu, importe, importe_d, glosa, cargo_abono, situ_cheq, itf);
CREATE INDEX ix_movi_contables_reg ON movi_contables (registro);
CREATE INDEX ix_movi_contables_sd_tpd ON movi_contables (subdia, codi_tipo_docu) INCLUDE (fecha, nro_cuen, serie, importe);
CREATE INDEX ix_movi_contables_sub_fec_cuen ON movi_contables (subdia, fecha, nro_cuen);
CREATE INDEX ix_movi_contables_subdia_voucher ON movi_contables (subdia) INCLUDE (codi_vouc);
CREATE INDEX ix_movi_contables_voucher ON movi_contables (codi_vouc, subdia, cargo_abono);
CREATE INDEX ix_movi_contables_ixd_sub_tipo_ser_nro ON movi_contables (subdia, codi_tipo_docu, serie, nro_docu);
CREATE INDEX ix_sub_clas_cuen_fk_codi_clas_cuen ON sub_clas_cuen (codi_clas_cuen); -- indice de FK (mejora)
