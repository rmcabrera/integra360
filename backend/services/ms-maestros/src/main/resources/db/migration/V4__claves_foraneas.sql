-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
-- Las FK se crean NOT VALID porque en SQL Server estaban WITH NOCHECK.
-- Tras depurar datos: ALTER TABLE <t> VALIDATE CONSTRAINT <fk>;

ALTER TABLE valores_unitarios_anuales ADD CONSTRAINT fk_valores_unitarios_anuales_valores_unitarios FOREIGN KEY (codi_valo_unit) REFERENCES valores_unitarios (codi_valo_unit) NOT VALID;
ALTER TABLE ubigeo_provincia ADD CONSTRAINT fk_ubigeo_provincia_ubigeo_region FOREIGN KEY (codi_ubi_reg_sunat) REFERENCES ubigeo_region (codi_ubi_reg_sunat) NOT VALID;
ALTER TABLE ubigeo_distrito ADD CONSTRAINT fk_ubigeo_distrito_ubigeo_provincia FOREIGN KEY (codi_ubi_prov_sunat) REFERENCES ubigeo_provincia (codi_ubi_prov_sunat) NOT VALID;
