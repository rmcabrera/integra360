-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
-- Las FK se crean NOT VALID porque en SQL Server estaban WITH NOCHECK.
-- Tras depurar datos: ALTER TABLE <t> VALIDATE CONSTRAINT <fk>;

ALTER TABLE menugrupos ADD CONSTRAINT fk_menugrupos_grupos FOREIGN KEY (codi_grup) REFERENCES grupos (codi_grup) NOT VALID;
ALTER TABLE empresa_establec_tasas ADD CONSTRAINT fk_empresa_establec_tasas_empresa_establecimiento FOREIGN KEY (codi_empre_estab) REFERENCES empresa_establecimiento (codi_empre_estab) NOT VALID;
