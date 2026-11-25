CREATE PROCEDURE [dbo].[PA_Lista_Productos_Almacen]
	@codi_alma [char](2),
	@mmppaux [char](2),
	@filtro_x_almacen [bit]
WITH EXECUTE AS CALLER
AS
IF @filtro_x_almacen = 0 --no filtro x almacen y muestro todo
  BEGIN
	Select codi_prod, desc_prod, codi_unid_medi,  STOCK as st, stoc_temp as st_tmp
	From Productos	
	Where LEFT(codi_prod, 2 )<> @mmppaux
  END
ELSE
  BEGIN
	Select p.codi_prod, p.desc_prod, p.codi_unid_medi,  ap.stock_alma as st, ap.stock_temp_alma as st_tmp
	From Productos	p inner join  almacen_producto ap on ap.codi_prod = p.codi_prod
	Where ap.codi_alma = @codi_alma and LEFT(P.codi_prod, 2 )<> @mmppaux
  END
GO
