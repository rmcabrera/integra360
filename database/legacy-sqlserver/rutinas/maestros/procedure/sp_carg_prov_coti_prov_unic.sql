CREATE PROCEDURE [dbo].[sp_carg_prov_coti_prov_unic]
	@estado_in [char](1),
	@desc_clie_prov [char](5) OUTPUT
WITH EXECUTE AS CALLER
AS
Declare @cade1 varchar(100)
declare @codi_clie_prov char(5)
declare @tipo_pers varchar(12)
declare @apel1 varchar(35)
declare @apel2 varchar(35)
declare @nomb1 varchar(35)
declare @nomb2 varchar(35)
declare @razo_soci varchar(100)

Create  Table #Desc_Prov
(Desc_prov varchar (150))

Declare curs_inse_prov_coti_prov Cursor for
Select Distinct Codi_clie_prov
From Cotizacion_por_proveedor
Where estado = @estado_in

Open curs_inse_prov_coti_prov
Fetch curs_inse_prov_coti_prov into @codi_clie_prov
While @@fetch_status = 0 
	Begin
		Set @tipo_pers = UPPER((Select tipo_pers From Cliente_Proveedor where codi_clie_prov = @codi_clie_prov))
		if @tipo_pers = 'NATURAL' 
			BEGIN
				Set @apel1 = (Select apel_1 From Cliente_Proveedor where Codi_clie_prov = @codi_clie_prov)
				Set @apel2 = (Select apel_2 From Cliente_Proveedor where Codi_clie_prov = @codi_clie_prov)
				Set @nomb1 = (Select nomb_1 From Cliente_Proveedor where Codi_clie_prov = @codi_clie_prov)
				Set @nomb2 = (Select nomb_2 From Cliente_Proveedor where Codi_clie_prov = @codi_clie_prov)
				set @cade1 = (@codi_clie_prov +  ' - ' + @apel1 + ' ' + @apel2 + ' ' + @nomb1 + ' ' + @nomb2)				
			END	
		Else
			Begin
				Set @razo_soci = (Select razo_soci From Cliente_Proveedor where Codi_clie_prov = @codi_clie_prov)
				set @cade1 = (@codi_clie_prov +  ' - ' + @razo_soci)				
			End
		Insert Into #Desc_Prov (Desc_prov)
		Values (@cade1)
		Fetch curs_inse_prov_coti_prov into @codi_clie_prov
	End
close curs_inse_prov_coti_prov
DeAllocate curs_inse_prov_coti_prov
Select *
From #Desc_Prov
GO
