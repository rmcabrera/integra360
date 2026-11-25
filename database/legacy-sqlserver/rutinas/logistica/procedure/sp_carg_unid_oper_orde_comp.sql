CREATE PROCEDURE [dbo].[sp_carg_unid_oper_orde_comp]
	@codi_coti_unic [char](10),
	@codi_orde_pedi [char](10),
	@codi_unid_oper_dest [char](5) OUTPUT,
	@codi_unid_oper_soli [char](5) OUTPUT,
	@codi_list_requ [char](8) OUTPUT
WITH EXECUTE AS CALLER
AS
declare @codi_COTI_PROV char(10)
declare @codi_deta_coti char(12)
declare @codi_coti char(10)
declare @cont integer

Create Table #Unid_Oper_Orde_Comp
(Codi_Unid_oper_dest Char(5), Codi_Unid_oper_soli Char(5), codi_list_requ char (8))

Create Table #Codi_Deta_Coti (Codi_deta_Coti Char (12))

Create Table #Codi_Coti (Codi_Coti Char (10))

if @codi_coti_unic = '0'
	Begin
		Select @Codi_list_requ = (Select Codi_list_requ From ORDEN_DE_PEDIDO Where codi_orde_pedi = @codi_orde_pedi)
		Select @codi_unid_oper_soli = (Select codi_unid_oper_soli From Lista_de_Requerimientos Where codi_list_requ = @codi_list_requ)
		Select @codi_unid_oper_dest = (Select codi_unid_oper_dest From Lista_de_Requerimientos Where codi_list_requ = @codi_list_requ)

		insert Into #Unid_Oper_Orde_Comp (Codi_Unid_oper_dest, Codi_Unid_oper_soli, codi_list_requ)
		Values (@codi_unid_oper_dest, @codi_unid_oper_soli, @codi_list_requ)		
	End
Else
	Begin	
		Declare Curs_carg_coti_prov Cursor For 
		Select Codi_Coti_Prov
		From Cotizacion_Unica
		Where Codi_coti_unic_prov = @codi_coti_unic
		Open Curs_carg_coti_prov
		FETCH NEXT FROM Curs_carg_coti_prov INTO @codi_coti_prov
		WHILE @@FETCH_STATUS = 0
		Begin
			Declare Curs_carg_codi_deta_coti Cursor For
			Select Codi_Deta_coti
			From Coti_por_prov_Deta_Coti
			Where Codi_Coti_Prov = @codi_coti_prov
			Open Curs_carg_codi_deta_coti
			Fetch Curs_carg_codi_deta_coti into @Codi_Deta_Coti
			WHILE @@FETCH_STATUS = 0
			Begin
				Select @Cont = (Select count(codi_deta_coti) From #Codi_deta_coti Where Codi_deta_coti = @codi_deta_coti)
				if @Cont <= 0 
					Begin
						Insert Into #Codi_Deta_coti (Codi_deta_coti) Values (@Codi_deta_coti)
--						print  @codi_deta_coti
					End
				Fetch Curs_carg_codi_deta_coti into @Codi_Deta_Coti						
			End
			Close Curs_carg_codi_deta_coti
			Deallocate Curs_carg_codi_deta_coti	
			FETCH NEXT FROM Curs_carg_coti_prov INTO @codi_coti_prov
		End
		Close Curs_carg_coti_prov 
		DeAllocate Curs_carg_coti_prov 

		Set @Cont = 0

		Declare Curs_carg_Coti Cursor For
		Select Codi_Deta_Coti From #Codi_deta_Coti	
		Open Curs_carg_Coti	
		Fetch Curs_carg_Coti into @Codi_Deta_Coti	
		While @@Fetch_Status = 0
		Begin	
			Select @Codi_coti = (Select Codi_Coti From Detalle_Cotizacion_Pedido Where Codi_Deta_coti = @Codi_Deta_coti)		
								
			Select @Cont = (Select Count(Codi_Coti) From #Codi_Coti Where Codi_Coti = @Codi_Coti)
			if @cont <= 0 
			Begin
				Insert Into #Codi_coti (codi_coti) Values (@Codi_coti)
				Select @Codi_list_requ = (Select Codi_list_requ_orig From Cotizacion_de_Pedidos Where Codi_Coti = @Codi_Coti)
				Select @codi_unid_oper_soli = (Select codi_unid_oper_soli From Lista_de_Requerimientos Where codi_list_requ = @codi_list_requ)
				Select @codi_unid_oper_dest = (Select codi_unid_oper_dest From Lista_de_Requerimientos Where codi_list_requ = @codi_list_requ)							
				
				Insert Into #Unid_Oper_Orde_Comp (Codi_Unid_oper_dest, Codi_Unid_oper_soli, codi_list_requ)
				Values (@codi_unid_oper_dest, @codi_unid_oper_soli, @codi_list_requ)
								
			End
			Fetch Curs_carg_Coti into @Codi_Deta_Coti	
		End										
		Close Curs_Carg_Coti										
		Deallocate Curs_Carg_Coti													
												
	End
Select * From #Unid_Oper_Orde_Comp
GO
