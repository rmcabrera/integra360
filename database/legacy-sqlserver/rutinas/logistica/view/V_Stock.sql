CREATE VIEW [dbo].[V_Stock]
AS
SELECT DISTINCT CODI_PROD, STOCK, DESC_PROD, FECH_NOTA_INGR
FROM         (SELECT     TOP 100 PERCENT dbo.PRODUCTOS.CODI_PROD, dbo.PRODUCTOS.DESC_PROD, dbo.NOTA_INGRESO.FECH_NOTA_INGR, 
                                              dbo.PRODUCTOS.STOCK
                       FROM          dbo.DETALLE_NOTA_INGRESO INNER JOIN
                                              dbo.NOTA_INGRESO ON dbo.DETALLE_NOTA_INGRESO.CODI_NOTA_INGR = dbo.NOTA_INGRESO.CODI_NOTA_INGR INNER JOIN
                                              dbo.PRODUCTOS ON dbo.DETALLE_NOTA_INGRESO.CODI_PROD = dbo.PRODUCTOS.CODI_PROD
                       WHERE      (dbo.PRODUCTOS.STOCK > 0) AND (NOTA_INGRESO.FECH_NOTA_INGR <= '05/11/2003')
                       GROUP BY dbo.PRODUCTOS.CODI_PROD, dbo.PRODUCTOS.DESC_PROD, dbo.NOTA_INGRESO.FECH_NOTA_INGR, dbo.PRODUCTOS.STOCK, 
                                              DETALLE_NOTA_INGRESO.CODI_PROD
                       ORDER BY dbo.PRODUCTOS.codi_prod) DERIVEDTBL
GO
