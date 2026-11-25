-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
CREATE INDEX ix_taller_diario_fk_codi_tall ON taller_diario (codi_tall); -- indice de FK (mejora)
CREATE INDEX ix_taller_diario_fk_codi_unid_oper ON taller_diario (codi_unid_oper); -- indice de FK (mejora)
CREATE INDEX ix_saldo_poza_fk_codi_poza ON saldo_poza (codi_poza); -- indice de FK (mejora)
CREATE INDEX ix_zarpes_fk_codi_puer ON zarpes (codi_puer); -- indice de FK (mejora)
CREATE INDEX ix_zarpes_fk_codi_puer2 ON zarpes (codi_puer2); -- indice de FK (mejora)
CREATE INDEX ix_precio_snp_fk_codi_espe ON precio_snp (codi_espe); -- indice de FK (mejora)
CREATE INDEX ix_saldo_tanques_fk_codi_tanq_auxi ON saldo_tanques (codi_tanq_auxi); -- indice de FK (mejora)
CREATE INDEX ix_precio_pactado_fk_codi_espe ON precio_pactado (codi_espe); -- indice de FK (mejora)
CREATE INDEX ix_detalle_zarpe_fk_codi_espe ON detalle_zarpe (codi_espe); -- indice de FK (mejora)
CREATE INDEX ix_detalle_zarpe_fk_codi_zarp ON detalle_zarpe (codi_zarp); -- indice de FK (mejora)
