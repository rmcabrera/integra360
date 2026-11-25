-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
CREATE UNIQUE INDEX ix_pbcatvld_pbcatvld_idx ON pbcatvld (pbv_name);
CREATE UNIQUE INDEX ix_pbcattbl_pbcattbl_idx ON pbcattbl (pbt_tnam, pbt_ownr);
CREATE UNIQUE INDEX ix_pbcatfmt_pbcatfmt_idx ON pbcatfmt (pbf_name);
CREATE UNIQUE INDEX ix_pbcatedt_pbcatedt_idx ON pbcatedt (pbe_name, pbe_seqn);
CREATE UNIQUE INDEX ix_pbcatcol_pbcatcol_idx ON pbcatcol (pbc_tnam, pbc_ownr, pbc_cnam);
