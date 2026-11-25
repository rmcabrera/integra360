CREATE FUNCTION [dbo].[uf_ulti_prec_compr_real](@codi_prod [char](8))
RETURNS [numeric](12, 4) WITH EXECUTE AS CALLER
AS 
begin
	--declare @codi_prod char(8)
	--select @codi_prod='00080299'

	declare @fecmax datetime
	declare @rt numeric(12,4)
	set @fecmax = (select top 1 max(fech_nota_ingr)
					from nota_ingreso A (nolock)
						join DETALLE_NOTA_INGRESO b  (nolock)
							on A.CODI_NOTA_INGR=B.CODI_NOTA_INGR
								where tipo_nota_ingr='01' and codi_prod=@codi_prod)

	set @rt= isnull((select distinct top 1  isnull(prec_compra,PREC_UNIT) as UltiPrecio 
				from nota_ingreso A  (nolock)
				join DETALLE_NOTA_INGRESO B  (nolock)
				on A.CODI_NOTA_INGR=B.CODI_NOTA_INGR
				where tipo_nota_ingr='01' and codi_prod=@codi_prod and PREC_UNIT<>0 and 
					FECH_NOTA_INGR =@fecmax),0)

	--select @rt
	return @rt
end
GO
