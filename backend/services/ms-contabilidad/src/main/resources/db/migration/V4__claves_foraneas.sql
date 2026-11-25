-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
-- Las FK se crean NOT VALID porque en SQL Server estaban WITH NOCHECK.
-- Tras depurar datos: ALTER TABLE <t> VALIDATE CONSTRAINT <fk>;

ALTER TABLE decl_diar_zarp_deta ADD CONSTRAINT fk_decl_diar_zarp_deta_decl_diar_zarp FOREIGN KEY (codi_decl_diar_zarp) REFERENCES decl_diar_zarp (codi_decl_diar_zarp) NOT VALID;
ALTER TABLE sub_clas_cuen ADD CONSTRAINT fk_sub_clas_cuen_clases_cuentas FOREIGN KEY (codi_clas_cuen) REFERENCES clases_cuentas (codi_clas_cuen) ON UPDATE CASCADE NOT VALID;
ALTER TABLE tipo_form_most_eeff ADD CONSTRAINT fk_tipo_form_most_eeff_tipo_eeff FOREIGN KEY (codi_tipo_eeff) REFERENCES tipo_eeff (codi_tipo_eeff) NOT VALID;
ALTER TABLE decl_zarp_trim_deta ADD CONSTRAINT fk_decl_zarp_trim_deta_decl_zarp_trim FOREIGN KEY (codi_zarp_trim) REFERENCES decl_zarp_trim (codi_zarp_trim) NOT VALID;
ALTER TABLE detalle_calc_af ADD CONSTRAINT fk_detalle_calc_af_activos FOREIGN KEY (codi_activo) REFERENCES activos (codi_activo) NOT VALID;
