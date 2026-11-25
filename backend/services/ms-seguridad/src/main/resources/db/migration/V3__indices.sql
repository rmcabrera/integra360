-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
CREATE INDEX ix_menugrupos_fk_codi_grup ON menugrupos (codi_grup); -- indice de FK (mejora)
CREATE INDEX ix_empresa_establec_tasas_fk_codi_empre_estab ON empresa_establec_tasas (codi_empre_estab); -- indice de FK (mejora)
