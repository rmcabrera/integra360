-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
-- Las FK se crean NOT VALID porque en SQL Server estaban WITH NOCHECK.
-- Tras depurar datos: ALTER TABLE <t> VALIDATE CONSTRAINT <fk>;

ALTER TABLE anticipos_documento_compra ADD CONSTRAINT fk_anticipos_documento_compra_anticipos FOREIGN KEY (codi_anti) REFERENCES anticipos (codi_anti) NOT VALID;
