CREATE PROCEDURE [dbo].[SP_CARG_CABE_COTI_UNIC_POR_PROV]
	@codi_clie_prov [char](5),
	@estado_in [char](1),
	@Codi_coti_prov [char](10) OUTPUT
WITH EXECUTE AS CALLER
AS
Select Codi_coti_prov 
From Cotizacion_por_proveedor
Where codi_clie_prov = @codi_clie_prov and estado = @estado_in
Order by Codi_coti_prov
GO
