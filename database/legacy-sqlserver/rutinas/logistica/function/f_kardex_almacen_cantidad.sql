CREATE FUNCTION [dbo].[f_kardex_almacen_cantidad](@idalma [char](2), @ite [numeric](18, 0), @idprod [char](8), @codtran [numeric](18, 0))
RETURNS [decimal](2, 0) WITH EXECUTE AS CALLER
AS 
BEGIN 
declare @cant decimal(2)

	select @cant=cantidad from kardex_almacenes where codi_alma=@idalma and item=@ite and codi_prod=@idprod and codi_transa=@codtran
	and i_o='I';

	return isnull(@cant,0)
END
GO
