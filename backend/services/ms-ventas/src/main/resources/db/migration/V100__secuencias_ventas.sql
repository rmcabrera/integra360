-- Reemplaza la generacion de codigos con MAX()+1 (propensa a duplicados con concurrencia)
-- por una secuencia. Se inicializa con el maximo existente para convivir con datos migrados.
CREATE SEQUENCE IF NOT EXISTS factura_codi_seq;

SELECT setval('factura_codi_seq',
              COALESCE((SELECT max(codi_fact::bigint) FROM factura WHERE codi_fact ~ '^[0-9]+$'), 0) + 1,
              false);

-- Busquedas frecuentes de la pantalla de comprobantes
CREATE INDEX IF NOT EXISTS ix_factura_cliente_fecha ON factura (codi_clie_prov, fech_fact DESC);
CREATE INDEX IF NOT EXISTS ix_factura_fecha ON factura (fech_fact DESC);
