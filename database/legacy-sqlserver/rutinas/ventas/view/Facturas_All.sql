CREATE VIEW [dbo].[Facturas_All]
AS
SELECT     codi_clie_prov,
                         case when estado='A' then 'ANULADA' else (SELECT     CASE WHEN upper(tipo_pers) = 'NATURAL' THEN apel_1 + ' ' + apel_2 + isnull(' ' + nomb_1, '') + isnull(' ' + nomb_2, '') 
                                                   ELSE razo_soci END  
                            FROM          cliente_proveedor C
                            WHERE      C.codi_clie_prov = F.codi_clie_prov) end Cliente, cast(convert(char(10),fech_fact,103) as smalldatetime) fech_fact, ser_Fact, nro_fact, tipo_fact,
                          (SELECT     descrip
                            FROM          tipo_factura t
                            WHERE      T .codi_tipo = tipo_fact) Tipo, 
		cast( case when estado='A' then 0.00 else tota_fact * CASE WHEN codi_mone = '02' THEN
                          (SELECT     venta
                            FROM          tipo_cambio_a_dolar T
                            WHERE      CONVERT(char(10), t .fech_camb, 103) = CONVERT(char(10), F.fech_fact, 103) AND codi_mone_camb = '02') ELSE 1 END end as numeric(12,2)) Total, 
                      estado, (select top 1 razon_social from empresa) empre
FROM         factura F
UNION ALL
SELECT     codi_clie_prov,
                         case when estado='A' then 'ANULADA' else  (SELECT     CASE WHEN upper(tipo_pers) = 'NATURAL' THEN apel_1 + ' ' + apel_2 + isnull(' ' + nomb_1, '') + isnull(' ' + nomb_2, '') 
                                                   ELSE razo_soci END 
                            FROM          cliente_proveedor C
                            WHERE      C.codi_clie_prov = F.codi_clie_prov) end Cliente,cast(convert(char(10),fech_emis,103) as smalldatetime) fech_emis, ser_fact, nro_fact, '99',
                          (SELECT     descrip
                            FROM          tipo_factura t
                            WHERE      T .codi_tipo = '99') Tipo,
		cast( case when estado='A' then 0.00 else valo_tota * CASE WHEN codi_mone = '02' THEN
                          (SELECT     venta
                            FROM          tipo_cambio_a_dolar T
                            WHERE      CONVERT(char(10), t .fech_camb, 103) = CONVERT(char(10), F.fech_emis, 103) AND codi_mone_camb = '02') ELSE 1 END end as numeric(12,2)), 
                      estado, (select top 1 razon_social from empresa) empre
FROM         factura_pesca F
GO
