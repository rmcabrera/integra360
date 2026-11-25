-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
CREATE INDEX ix_cliente_proveedor_acti ON cliente_proveedor (esta_acti);
CREATE INDEX ix_cliente_proveedor_deno ON cliente_proveedor (denominacion) INCLUDE (codi_clie_prov);
CREATE INDEX ix_cliente_proveedor_esta_clie ON cliente_proveedor (esta_acti) INCLUDE (codi_clie_prov, razo_soci, ruc, denominacion, frecuencia);
CREATE INDEX ix_cliente_proveedor_razo_soci ON cliente_proveedor (razo_soci);
CREATE INDEX ix_ubigeo_provincia_fk_codi_ubi_reg_sunat ON ubigeo_provincia (codi_ubi_reg_sunat); -- indice de FK (mejora)
CREATE INDEX ix_ubigeo_distrito_fk_codi_ubi_prov_sunat ON ubigeo_distrito (codi_ubi_prov_sunat); -- indice de FK (mejora)
