CREATE PROCEDURE [dbo].[Sp_Update_Deta_Coti_Pedi]
	@Codi_coti_Prov [char](10)
WITH EXECUTE AS CALLER
AS
Declare @CODI_DETA_COTI Char(12)
Declare @Prec_auxi Decimal
Declare @Codi_Prod_auxi char(8)

Declare Curs_Reco_Coti_por_Prov_Deta_coti Cursor FOR
SELECT Codi_deta_Coti FROM Coti_Por_Prov_Deta_Coti
Where Codi_coti_Prov = @Codi_coti_Prov
Open Curs_Reco_Coti_por_prov_deta_coti
Fetch Curs_Reco_Coti_por_prov_deta_coti into @codi_deta_coti
While @@fetch_status = 0 
Begin
	Select @codi_prod_auxi = (Select Codi_Prod From Detalle_Cotizacion_Pedido Where Codi_Deta_coti = @Codi_deta_coti)
	Select @Prec_auxi = (Select prec_unit From Detalle_Cotizacion_por_proveedor Where Codi_coti_prov = @Codi_coti_prov and Codi_prod = @Codi_prod_auxi)

	Update Detalle_cotizacion_pedido 
	Set Prec_unit = @prec_auxi
	Where Codi_deta_coti = @codi_deta_coti and Codi_prod = @codi_prod_auxi

	Fetch Curs_Reco_Coti_por_prov_deta_coti into @codi_deta_coti
End
Close Curs_Reco_Coti_por_prov_deta_coti 
Deallocate Curs_Reco_Coti_por_prov_deta_coti
GO
