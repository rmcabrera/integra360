-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
-- Las FK se crean NOT VALID porque en SQL Server estaban WITH NOCHECK.
-- Tras depurar datos: ALTER TABLE <t> VALIDATE CONSTRAINT <fk>;

ALTER TABLE factura ADD CONSTRAINT fk_factura_tipo_factura FOREIGN KEY (tipo_fact) REFERENCES tipo_factura (codi_tipo) NOT VALID;
ALTER TABLE factura_detalle ADD CONSTRAINT fk_factura_detalle_factura FOREIGN KEY (codi_fact) REFERENCES factura (codi_fact) NOT VALID;
ALTER TABLE factura_credito ADD CONSTRAINT fk_factura_credito_cliente_creditos FOREIGN KEY (codi_credito) REFERENCES cliente_creditos (codi_credito) ON UPDATE CASCADE NOT VALID;
ALTER TABLE factura_credito ADD CONSTRAINT fk_factura_credito_factura FOREIGN KEY (codi_fact) REFERENCES factura (codi_fact) ON DELETE CASCADE ON UPDATE CASCADE NOT VALID;
ALTER TABLE vale_credito ADD CONSTRAINT fk_vale_credito_registro_vale FOREIGN KEY (codi_vale) REFERENCES registro_vale (codi_vale) ON DELETE CASCADE ON UPDATE CASCADE NOT VALID;
ALTER TABLE vale_credito ADD CONSTRAINT fk_vale_credito_cliente_creditos FOREIGN KEY (codi_credito) REFERENCES cliente_creditos (codi_credito) ON UPDATE CASCADE NOT VALID;
ALTER TABLE registro_vale_detalle ADD CONSTRAINT fk_registro_vale_detalle_registro_vale FOREIGN KEY (codi_vale) REFERENCES registro_vale (codi_vale) NOT VALID;
ALTER TABLE guia_transportista_detalle ADD CONSTRAINT fk_guia_transportista_detalle_guia_transportista FOREIGN KEY (id_guia) REFERENCES guia_transportista (id_guia) ON DELETE CASCADE ON UPDATE CASCADE NOT VALID;
ALTER TABLE guia_detalle ADD CONSTRAINT fk_guia_detalle_guia FOREIGN KEY (codi_guia) REFERENCES guia (codi_guia) NOT VALID;
ALTER TABLE nota_debito_deta ADD CONSTRAINT fk_nota_debito_deta_nota_debito FOREIGN KEY (codi_nota_debi) REFERENCES nota_debito (codi_nota_debi) NOT VALID;
ALTER TABLE convenio_detalle ADD CONSTRAINT fk_convenio_detalle_convenio FOREIGN KEY (codi_conv) REFERENCES convenio (codi_conv) NOT VALID;
ALTER TABLE nota_credito_deta ADD CONSTRAINT fk_nota_credito_deta_nota_credito FOREIGN KEY (codi_nota_cred) REFERENCES nota_credito (codi_nota_cred) NOT VALID;
ALTER TABLE acta_entrega_detalle ADD CONSTRAINT fk_acta_entrega_detalle_acta_entrega FOREIGN KEY (codi_act) REFERENCES acta_entrega (codi_act) NOT VALID;
ALTER TABLE facturas_detalle ADD CONSTRAINT fk_facturas_detalle_facturas FOREIGN KEY (codi_fact) REFERENCES facturas (codi_fact) NOT VALID;
