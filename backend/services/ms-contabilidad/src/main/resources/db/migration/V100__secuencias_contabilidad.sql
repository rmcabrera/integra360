-- Codigo de movimiento contable: secuencia en lugar de MAX()+1
CREATE SEQUENCE IF NOT EXISTS movi_contables_codi_seq;
SELECT setval('movi_contables_codi_seq',
              COALESCE((SELECT max(codi_contable::bigint) FROM movi_contables WHERE codi_contable ~ '^[0-9]{1,18}$'), 0) + 1,
              false);

CREATE INDEX IF NOT EXISTS ix_movi_contables_registro ON movi_contables (registro, codi_tipo_docu);
CREATE INDEX IF NOT EXISTS ix_movi_contables_compr ON movi_contables (anio, mes, subdia, compr);
