CREATE PROCEDURE [dbo].[up_productos_x_almacen_lista]
	@codialma [char](2),
	@filtro [varchar](10)
WITH EXECUTE AS CALLER
AS
if @codialma='00' 
  --RECUPERO TODOS LOS PRODUCTOS
	begin
	   SELECT P.CODI_PROD,   
	         P.DESC_PROD,   
	         P.CODI_SUB_FAMI_PROD,   
	         P.CODI_UNID_MEDI ,
	         P.stock ,          P.stoc_temp   
	    FROM PRODUCTOS as P
	end
else
--RECUPERO LOS PRODUCTOS DE CIERTO ALMACEN Y FILTRO
 



      if @filtro='N'  --- ninguno filtro
	begin      
	   SELECT P.CODI_PROD,   
	         P.DESC_PROD,   
	         P.CODI_SUB_FAMI_PROD,   
	         P.CODI_UNID_MEDI ,
	         P.stock ,          P.stoc_temp   
	    FROM PRODUCTOS P INNER JOIN    Almacen_Producto  AP    ON ( P.Codi_Prod = AP.CODI_PROD ) 
		--where    ( AP.Codi_Alma = @codialma ) 
	end

	else

	   SELECT P.CODI_PROD,   
	         P.DESC_PROD,   
	         P.CODI_SUB_FAMI_PROD,   
	         P.CODI_UNID_MEDI ,
	         P.stock ,          P.stoc_temp   
	    FROM PRODUCTOS P INNER JOIN    Almacen_Producto  AP 	   ON ( P.Codi_Prod = AP.CODI_PROD ) 
		--where    ( AP.Codi_Alma = @codialma )  AND LEFT(P.codi_prod, 2 )<> @filtro
GO
