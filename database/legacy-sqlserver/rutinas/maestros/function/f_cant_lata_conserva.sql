CREATE FUNCTION [dbo].[f_cant_lata_conserva](@codi [char](10))
RETURNS [numeric](12, 4) WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @ret numeric(12,4)
	Select @ret=sum(cant_prod_dia)  from detalle_produccion_dia 
		where codi_prod_dia=@codi group by codi_prod_dia
	return @ret
END
GO
