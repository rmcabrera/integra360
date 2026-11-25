-- Codigo de kardex: secuencia en lugar de MAX(codi_kard)+1 (SP_KARDEX_INSERT)
CREATE SEQUENCE IF NOT EXISTS kardex_codi_seq;
SELECT setval('kardex_codi_seq',
              COALESCE((SELECT max(codi_kard::numeric)::bigint FROM kardex WHERE codi_kard ~ '^[0-9]{1,18}$'), 0) + 1,
              false);

-- Recalculo cronologico por producto/periodo
CREATE INDEX IF NOT EXISTS ix_kardex_prod_periodo_fecha ON kardex (codi_prod, periodo, fech_tran, codi_kard);
CREATE INDEX IF NOT EXISTS ix_kardex_docu_origen ON kardex (codi_docu_i_o);
