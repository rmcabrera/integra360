CREATE FUNCTION [dbo].[f_recupera_nota_ingreso_aceite](@codi_ingreso [numeric](18, 0))
RETURNS [numeric](18, 0) WITH EXECUTE AS CALLER
AS 
--Utilizado en el reporte de aceites
BEGIN 
	declare @nro numeric
	select @nro=nro_ingr from nota_ingreso_aceite where codi_ingr=@codi_ingreso	

	return @nro
END
GO
