CREATE PROCEDURE [dbo].[sp_carg_deta_coti_unic]
	@codi_coti_unic [char](10),
	@codi_clie_prov [char](5),
	@estado_in [char](1),
	@Codi_prod [char](8) OUTPUT,
	@cantidad [decimal](9, 2) OUTPUT,
	@codi_mone [char](2) OUTPUT,
	@prec_unit [decimal](9, 2) OUTPUT,
	@estado [char](1) OUTPUT
WITH EXECUTE AS CALLER
AS
declare @ccp char (10)
declare @cp char (8)
declare @cm char (2)
declare @pu decimal(9,2)
declare @can decimal(9,2)
declare @esta char(1)
declare @cpf char (8)
if @codi_clie_prov = '0'
	Begin
		Create Table #Detalle_Cotizacion_T
 		(Codi_prod char(8), cantidad decimal(9,2), codi_mone char (2), prec_unit decimal(9,2) , estado char(1))	
		Declare Curs_deta_coti_unic cursor for
		Select Codi_coti_prov 
		From Cotizacion_Unica
		Where codi_coti_unic_prov = @codi_coti_unic
		Order by Codi_coti_prov
				
		Open Curs_deta_coti_unic
		Fetch Next From Curs_deta_coti_unic into @ccp
		WHILE @@FETCH_STATUS = 0
			Begin
				Declare Curs_deta_coti_prov Cursor For
				Select Codi_prod, isnull(cantidad,0), codi_mone, isnull(prec_unit,0), estado
				From Detalle_cotizacion_por_proveedor
				Where Codi_coti_prov = @ccp
				order by codi_prod
				
				Open Curs_deta_coti_prov 
				Fetch Next From Curs_deta_coti_prov into 
				@cp, @can, @cm, @pu, @esta
				While @@fetch_status = 0
					Begin
						Insert Into #Detalle_Cotizacion_T (Codi_prod , cantidad , codi_mone , prec_unit , estado)	
						Values (@cp, @can, @cm, @pu, @esta)

						Fetch Next From Curs_deta_coti_prov into 
						@cp, @can, @cm, @pu, @esta
					End				
				Close Curs_deta_coti_prov
				deallocate Curs_deta_coti_prov
								
				Fetch Next From Curs_deta_coti_unic into @ccp	
			End
			
			Close Curs_deta_coti_unic
			Deallocate Curs_deta_coti_unic

		Create Table #Coti_filt_prod (codi_prod char(8))
		
		Declare Curs_Filt_prod Cursor For
		Select Distinct Codi_prod From #Detalle_Cotizacion_T

		Open Curs_Filt_Prod 
		Fetch Next From Curs_Filt_Prod  into @cpf
		While @@Fetch_Status = 0
			Begin
				Insert Into #Coti_Filt_Prod (Codi_prod)			
				Values (@cpf)
				Fetch Next From Curs_filt_Prod into @cpf
			End
		Close Curs_Filt_Prod
		Deallocate Curs_Filt_Prod

		Set @cpf = '0'
		Create Table #Coti_Unic_Deta
 		(Codi_prod char(8), cantidad decimal(9,2), codi_mone char (2), prec_unit decimal(9,2) , estado char(1))	
		
		Declare Curs_Deta_Fina cursor For
		Select Codi_prod
		From #Coti_Filt_Prod
		
		Open Curs_deta_Fina
		Fetch Next From Curs_Deta_fina into @cpf
			
		While @@Fetch_Status = 0
			Begin
				Select @CAN = (Select SUM(cantidad) From #Detalle_Cotizacion_T Where codi_prod = @cpf)
				Select @Cm = (Select min(codi_mone) From #Detalle_Cotizacion_T Where codi_prod = @cpf)
				Select @pu = (Select min(prec_unit) From #Detalle_Cotizacion_T Where codi_prod = @cpf)
				Select @esta = (Select min(estado) From #Detalle_Cotizacion_T Where codi_prod = @cpf)
				
				Insert Into #Coti_Unic_Deta (codi_prod, cantidad, codi_mone, prec_unit, estado)
				Values (@cpf, @can, @cm, @pu, @esta)
	
				Fetch Next From Curs_Deta_fina into @cpf	
			End 
		Close Curs_Deta_Fina
		Deallocate Curs_Deta_Fina		
			
		Select *
		From #Coti_Unic_deta
	End 
Else
	Begin 
		Create Table #Deta_Coti_Gene
 		(Codi_prod char(8), cantidad decimal(9,2), codi_mone char (2), prec_unit decimal(9,2) , estado char(1))			

		Declare Curs_cpp1 cursor for
		Select Codi_coti_prov 
		From Cotizacion_por_proveedor
		Where codi_clie_prov = @codi_clie_prov and estado = @estado_in
		Order by Codi_coti_prov
				
		Open Curs_Cpp1
		Fetch Next From Curs_CPP1 into @ccp
		
		While @@fetch_status = 0 
			Begin
				Declare Curs_Deta_Coti_prov_Pend Cursor For
				Select Codi_prod, isnull(cantidad,0), codi_mone, isnull(prec_unit,0), estado
				From Detalle_cotizacion_por_proveedor
				Where codi_coti_prov = @ccp
				Order By Codi_Prod	
				
				Open Curs_Deta_Coti_prov_Pend
								
				Fetch Next From Curs_Deta_Coti_prov_Pend into
				@cp, @can, @cm, @pu, @esta
				
				While @@fetch_status = 0 
					Begin
						Insert Into #Deta_Coti_Gene (Codi_prod , cantidad , codi_mone , prec_unit , estado )
						Values (@cp, @can, @cm, @pu, @esta)

						Fetch Next From Curs_Deta_Coti_prov_Pend into
						@cp, @can, @cm, @pu, @esta
					End		
				Close Curs_Deta_Coti_prov_Pend
				DeAllocate Curs_Deta_Coti_prov_Pend
		
				Fetch Next From Curs_CPP1 into @ccp
			End
		
		Close Curs_Cpp1
		DeAllocate Curs_Cpp1	

		Create Table #Coti_filt_prod1 (codi_prod char(8))
		
		Declare Curs_Filt_prod1 Cursor For
		Select Distinct Codi_prod From #Deta_Coti_gene

		Open Curs_Filt_Prod1 
		Fetch Next From Curs_Filt_Prod1  into @cpf
		While @@Fetch_Status = 0
			Begin
				Insert Into #Coti_Filt_Prod1 (Codi_prod)			
				Values (@cpf)
				Fetch Next From Curs_filt_Prod1 into @cpf
			End
		Close Curs_Filt_Prod1
		Deallocate Curs_Filt_Prod1

		Set @cpf = '0'
		Create Table #Coti_Unic_Deta1
 		(Codi_prod char(8), cantidad decimal(9,2), codi_mone char (2), prec_unit decimal(9,2) , estado char(1))	
		
		Declare Curs_Deta_Fina1 cursor For
		Select Codi_prod
		From #Coti_Filt_Prod1
		
		Open Curs_deta_Fina1
		Fetch Next From Curs_Deta_fina1 into @cpf
			
		While @@Fetch_Status = 0
			Begin
				Select @CAN = (Select SUM(cantidad) From #Deta_Coti_Gene Where codi_prod = @cpf)
				Select @Cm = (Select min(codi_mone) From #Deta_Coti_Gene Where codi_prod = @cpf)
				Select @pu = (Select min(prec_unit) From #Deta_Coti_Gene Where codi_prod = @cpf)
				Select @esta = (Select min(estado) From #Deta_Coti_Gene Where codi_prod = @cpf)
				
				Insert Into #Coti_Unic_Deta1 (codi_prod, cantidad, codi_mone, prec_unit, estado)
				Values (@cpf, @can, @cm, @pu, @esta)
	
				Fetch Next From Curs_Deta_fina1 into @cpf	
			End 
		Close Curs_Deta_Fina1
		Deallocate Curs_Deta_Fina1	
		
		Select *
		From #Coti_Unic_deta1
	End
GO
