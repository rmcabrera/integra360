-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
-- Las FK se crean NOT VALID porque en SQL Server estaban WITH NOCHECK.
-- Tras depurar datos: ALTER TABLE <t> VALIDATE CONSTRAINT <fk>;

ALTER TABLE taller_diario ADD CONSTRAINT fk_taller_diario_talleres FOREIGN KEY (codi_tall) REFERENCES talleres (codi_tall) NOT VALID;
ALTER TABLE taller_diario ADD CONSTRAINT fk_taller_diario_embarcaciones FOREIGN KEY (codi_unid_oper) REFERENCES embarcaciones (codi_unid_oper) NOT VALID;
ALTER TABLE saldo_poza ADD CONSTRAINT fk_saldo_poza_pozas FOREIGN KEY (codi_poza) REFERENCES pozas (codi_poza) NOT VALID;
ALTER TABLE zarpes ADD CONSTRAINT fk_zarpes_puerto FOREIGN KEY (codi_puer) REFERENCES puerto (codi_puer) NOT VALID;
ALTER TABLE zarpes ADD CONSTRAINT fk_zarpes_puerto_2 FOREIGN KEY (codi_puer2) REFERENCES puerto (codi_puer) NOT VALID;
ALTER TABLE precio_snp ADD CONSTRAINT fk_precio_snp_especies FOREIGN KEY (codi_espe) REFERENCES especies (codi_espe) NOT VALID;
ALTER TABLE saldo_tanques ADD CONSTRAINT fk_saldo_tanques_tanq_auxiliar FOREIGN KEY (codi_tanq_auxi) REFERENCES tanq_auxiliar (codi_tanq_auxi) NOT VALID;
ALTER TABLE precio_pactado ADD CONSTRAINT fk_precio_pactado_especies FOREIGN KEY (codi_espe) REFERENCES especies (codi_espe) NOT VALID;
ALTER TABLE detalle_zarpe ADD CONSTRAINT fk_detalle_zarpe_especies FOREIGN KEY (codi_espe) REFERENCES especies (codi_espe) NOT VALID;
ALTER TABLE detalle_zarpe ADD CONSTRAINT fk_detalle_zarpe_zarpes FOREIGN KEY (codi_zarp) REFERENCES zarpes (codi_zarp) NOT VALID;
ALTER TABLE zarpe_combustible ADD CONSTRAINT fk_zarpe_combustible_zarpes FOREIGN KEY (codi_zarp) REFERENCES zarpes (codi_zarp) NOT VALID;
ALTER TABLE orden_produccion_factura ADD CONSTRAINT fk_orden_produccion_factura_orden_produccion FOREIGN KEY (codi_orde_produc) REFERENCES orden_produccion (codi_orde_produc) NOT VALID;
ALTER TABLE analisis_parametro ADD CONSTRAINT fk_analisis_parametro_analisis_aceite FOREIGN KEY (cod_analisis) REFERENCES analisis_aceite (cod_analisis) ON DELETE CASCADE NOT VALID;
