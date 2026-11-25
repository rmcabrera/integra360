CREATE FUNCTION [dbo].[f_cuenta_compras](@codi [char](10), @sd [char](1), @mesa [char](6))
RETURNS [char](7) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @cu char(7)
	select @cu=nro_cuen from movi_contables where (left(nro_cuen,1)='6' or left(nro_cuen,1)='3' or (left(nro_cuen,1)='4' and nro_cuen<>dbo.F_CUENTA_PROV('02')) and nro_cuen<>dbo.F_CUENTA_PROV('01')) 
		and (otros=0 or isnull(otros,0)=0) and subdia=@sd and codi_vouc=@codi and mes=left(@mesa,2) and anio=right(@mesa,4)
	return @cu
END
GO
