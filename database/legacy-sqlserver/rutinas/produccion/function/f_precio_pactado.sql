CREATE FUNCTION [dbo].[f_precio_pactado](@codi [char](15))
RETURNS [numeric](12, 3) WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @prec numeric(12,3)
--	select @prec=prec_pact from precio_pactado where codi_sema=@semana
--	and codi_clie_prov=@cliente 
	select @prec= prec_pact from detalle_Zarpe where codi_deta_zarp=@codi
	return @prec
	
END
GO
