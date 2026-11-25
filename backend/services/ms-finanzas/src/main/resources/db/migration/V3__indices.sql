-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
CREATE INDEX ix_caja_chica_alma_clie ON caja_chica (codi_alma, codi_clie_prov);
CREATE INDEX ix_caja_chica_alma_fecha ON caja_chica (codi_alma, fecha);
CREATE INDEX ix_caja_chica_nro_recib ON caja_chica (nro_recibo) INCLUDE (tipo_io, codi_clie_prov, codi_tipo_docu, serie, nro_docu, tipo_contab);
CREATE INDEX ix_caja_chica_tipodoc_ser ON caja_chica (codi_tipo_docu, serie) INCLUDE (nro_recibo, tipo_io, nro_docu, tipo_contab);
CREATE INDEX ix_caja_chica_depo_tipo_depo_docu ON caja_chica_depo (tipo_rela) INCLUDE (codi_depo, codi_docu);
CREATE INDEX ix_caja_chica_depo_tipo_rela ON caja_chica_depo (tipo_rela) INCLUDE (codi_docu, importe);
CREATE INDEX ix_conci_banco_conci_cuen_anio_situ ON conci_banco (nro_cuen, anio, codi_tipo_situ_conc_banc) INCLUDE (mes, subdia, compr, fecha, codi_tipo_docu, nro_docu, codi_clie_prov, glosa, importe, cargo_abono, anio_docu, mes_docu, codi_contable);
CREATE INDEX ix_depositos_alma_fecha ON depositos (codi_alma, fecha);
