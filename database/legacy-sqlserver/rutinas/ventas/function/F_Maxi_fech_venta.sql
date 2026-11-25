CREATE FUNCTION [dbo].[F_Maxi_fech_venta](@codi_alma [char](2), @codi_prod [char](8))
RETURNS [datetime] WITH EXECUTE AS CALLER
AS 
BEGIN 

	--Declare @codi_alma char(2), @codi_prod char(8)
	Declare @fech_maxi datetime
	
	select @codi_alma='05', @codi_prod='00080673'
						
	set @fech_maxi = (select top 1 max(fech_Fact)
				from factura A(nolock)
					join factura_detalle b(nolock)
						on A.codi_Fact=B.codi_Fact
							where A.codi_alma=@codi_alma and codi_prod=@codi_prod and codi_tipo_pago=1 and
								cast(CONVERT(char(10),fech_Fact,103)as datetime) <=getdate() )
													
	/*set @fech_maxi = (select top 1 fech_Fact
						from factura A(nolock) join factura_detalle B(nolock)
						on A.codi_Fact=B.codi_Fact
						where A.codi_alma=@codi_alma and B.codi_prod=@codi_prod and codi_tipo_pago=1	
						order by fech_Fact desc)*/

	return @fech_maxi
	
	--select @fech_maxi
END
GO
