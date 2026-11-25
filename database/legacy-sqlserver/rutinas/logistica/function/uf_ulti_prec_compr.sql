CREATE FUNCTION [dbo].[uf_ulti_prec_compr](@codi_prod [char](8))
RETURNS [numeric](12, 4) WITH EXECUTE AS CALLER
AS 
begin
	--declare @codi_prod char(8)
	--select @codi_prod='00010005'

	declare @fecmax datetime
	declare @rt numeric(12,4)
	set @fecmax = (select top 1 max(fech_nota_ingr)
					from nota_ingreso A (nolock)
						join DETALLE_NOTA_INGRESO b  (nolock)
							on A.CODI_NOTA_INGR=B.CODI_NOTA_INGR
								where tipo_nota_ingr='01' and codi_prod=@codi_prod)

	set @rt= isnull((select distinct top 1  PREC_UNIT *case when  A.codi_mone ='01' then 1 else TIPO_CAMB end as UltiPrecio 
				from nota_ingreso A  (nolock)
				join DETALLE_NOTA_INGRESO B  (nolock)
				on A.CODI_NOTA_INGR=B.CODI_NOTA_INGR
				where tipo_nota_ingr='01' and codi_prod=@codi_prod and PREC_UNIT<>0 and 
					FECH_NOTA_INGR =@fecmax),0)

	return @rt
end
GO
