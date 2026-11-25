CREATE PROCEDURE [dbo].[sp_carg_deta_orde_comp]
	@codi_coti_unic [char](10),
	@codi_orde_pedi [char](10),
	@codi_unid_oper_dest [char](5),
	@codi_unid_oper_soli [char](5),
	@codi_prod [char](8) OUTPUT,
	@cantidad [decimal](9, 2) OUTPUT,
	@precio [decimal](9, 2) OUTPUT,
	@nro_cuen [char](7) OUTPUT
WITH EXECUTE AS CALLER
AS
declare @codi_COTI_PROV char(10)
declare @codi_deta_coti char(12)
declare @codi_orde_pedi_auxi char(10)
declare @codi_list_requ char(10)
declare @codi_coti char(10)
declare @cont integer
declare @cont_prod integer
declare @cont_orde_comp_gene integer
DECLARE @cont_prod_deta_orde_comp integer
declare @codi_prod_auxi char(8)
declare @cant_prod decimal(9,2)
declare @cant_prod_auxi decimal(9,2)
declare @prec_prod decimal(9,2)
declare @codi_unid_oper_dest_auxi char(5)
declare @codi_unid_oper_soli_auxi char(5)

Create Table #Deta_Orde_Comp
(Codi_prod Char(8), Cantidad decimal(9,2), precio decimal(9,2), nro_cuen char(7))  

Create Table #Prec_prod
(Codi_prod Char(8), prec_prod decimal(9,2)) 

Create Table #Codi_Deta_Coti (Codi_deta_Coti Char (12))
Create Table #Codi_Coti (Codi_Coti Char (10))
if @codi_coti_unic = '0'
Begin
	Set @cont_orde_comp_gene = (Select Count(codi_orde_comp) From Orden_compra_pedido_cotiza 
					Where Codi_docu = @codi_orde_pedi and codi_tipo_docu = '0040')	

	if @cont_orde_comp_gene = 0 
	begin
		Declare Curs_Carg_deta_oc Cursor For		
		Select codi_prod, isnull(cantidad,0), isnull(nro_cuen,'0')
		From Detalle_orden_de_pedido
		Where codi_orde_pedi = @codi_orde_pedi		
		Open Curs_Carg_deta_oc
		Fetch Curs_Carg_deta_oc into @codi_prod, @cantidad, @nro_cuen;
		while @@fetch_status = 0 
		Begin	
			
			Select @precio = (Select isnull(prec_prom,0) From Productos Where Codi_prod = @codi_prod)
			
			Insert Into #Deta_Orde_Comp (Codi_prod, Cantidad, precio,nro_cuen)
			Values (@codi_prod, @cantidad, @precio, @nro_cuen)			

			Fetch Curs_Carg_deta_oc into @codi_prod, @cantidad, @nro_cuen;
		End
		Close Curs_Carg_deta_oc
		Deallocate Curs_Carg_deta_oc		

	End
	Else
	Begin
		Declare Curs_Carg_deta_oc_2 Cursor For		
		Select codi_prod, isnull(cantidad,0), isnull(nro_cuen,'0')
		From Detalle_orden_de_pedido
		Where codi_orde_pedi = @codi_orde_pedi		
		Open Curs_Carg_deta_oc_2
		Fetch Curs_Carg_deta_oc_2 into @codi_prod, @cantidad, @nro_cuen;
		while @@fetch_status = 0 
		Begin	
			set @cont_prod_deta_orde_comp = (Select count(D.codi_orde_comp) From Detalle_orden_compra D, orden_compra_pedido_cotiza O,
							ORDEN_DE_COMPRA OC
							Where oc.codi_orde_comp = d.codi_orde_comp and oc.estado <> 'N' and O.CODI_DOCU = @CODI_ORDE_PEDI 
							AND O.CODI_TIPO_DOCU = '0040' AND D.CODI_PROD = @CODI_PROD	
							and O.CODI_ORDE_COMP = D.CODI_ORDE_COMP)

			Select @precio = (Select isnull(prec_prom,0) From Productos Where Codi_prod = @codi_prod)
--			print 'codi_prod  ' + @codi_prod
--			print 'cantidad orde pedi'
--			print @cantidad			
--			print 'cont_prod_deta_orde_comp'
--			print @cont_prod_deta_orde_comp
			if @cont_prod_deta_orde_comp > 0 
			begin			
				set @cant_prod = (Select sum(D.cantidad) From Detalle_orden_compra D, orden_compra_pedido_cotiza O
							Where O.CODI_DOCU = @CODI_ORDE_PEDI and O.CODI_ORDE_COMP = D.CODI_ORDE_COMP
								AND O.CODI_TIPO_DOCU = '0040' AND D.CODI_PROD = @CODI_PROD	)
--				print 'cant orde comp ante' 	
--				print @cant_prod
				set @cant_prod_auxi = @cantidad - @cant_prod
--				print 'cant sali'
--				print @cant_prod_auxi
				if @cant_prod_auxi > 0 
				begin
					set @cantidad = @cant_prod_auxi
				end
				else
				begin
					set @cantidad = 0
				end
					
			end
			else
			begin
				set @cantidad = @cantidad
			end
			if @cantidad > 0 
			begin
				Insert Into #Deta_Orde_Comp (Codi_prod, Cantidad, precio,nro_cuen)
				Values (@codi_prod, @cantidad, @precio, @nro_cuen)	
			end

			Fetch Curs_Carg_deta_oc_2 into @codi_prod, @cantidad, @nro_cuen;
		End
		Close Curs_Carg_deta_oc_2
		Deallocate Curs_Carg_deta_oc_2				
				
	End
End
Else
	Begin
		Declare Curs_carg_coti_prov_auxi Cursor For 
		Select Codi_Coti_Prov
		From Cotizacion_Unica
		Where Codi_coti_unic_prov = @codi_coti_unic
		Open Curs_carg_coti_prov_auxi
		FETCH NEXT FROM Curs_carg_coti_prov_auxi INTO @codi_coti_prov
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
						Insert Into #Codi_Deta_Coti (Codi_deta_coti) Values (@Codi_deta_coti)
						
						Select @codi_prod_auxi = (Select Codi_prod From Detalle_cotizacion_Pedido Where codi_deta_coti = @codi_deta_coti)
						
						Set @cont = 0
						Select @cont = (Select count(codi_prod) From #Prec_Prod Where Codi_prod = @codi_prod_auxi)
						if @cont <= 0 
						Begin
							Select @prec_prod = (Select prec_unit From Detalle_cotizacion_por_proveedor Where codi_coti_prov = @Codi_coti_prov and Codi_prod = @Codi_prod_auxi)
								
							Insert Into #Prec_prod (codi_prod, prec_prod) Values (@codi_prod_auxi, @prec_prod)
						End
						
					End
				Fetch Curs_carg_codi_deta_coti into @Codi_Deta_Coti						
			End
			Close Curs_carg_codi_deta_coti
			Deallocate Curs_carg_codi_deta_coti	
			FETCH NEXT FROM Curs_Carg_Coti_Prov_auxi INTO @codi_coti_prov
		End
		Close Curs_carg_coti_prov_auxi
		DeAllocate Curs_carg_coti_prov_auxi

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
				Select @Codi_orde_pedi_auxi = (Select Codi_orde_pedi From Cotizacion_de_Pedidos Where Codi_Coti = @Codi_Coti)
				Select @Codi_list_requ = (Select Codi_list_requ From Orden_de_pedido Where Codi_orde_pedi = @Codi_orde_pedi_auxi) 
				Select @codi_unid_oper_soli_auxi = (Select codi_unid_oper_soli From Lista_de_Requerimientos Where codi_list_requ = @codi_list_requ)
				Select @codi_unid_oper_dest_auxi = (Select codi_unid_oper_dest From Lista_de_Requerimientos Where codi_list_requ = @codi_list_requ)							
				if @codi_unid_oper_dest = @codi_unid_oper_dest_auxi 
					Begin
						Declare Curs_Carg_Deta_oc_cu Cursor For
						Select codi_prod, cantidad,nro_cuen
						From Detalle_orden_de_pedido
						Where codi_orde_pedi = @codi_orde_pedi_auxi
						Open Curs_Carg_Deta_oc_cu
						Fetch Curs_Carg_Deta_oc_cu into @codi_prod, @cantidad, @nro_cuen
						While @@fetch_status = 0
						Begin
							Select @precio = (Select prec_prod From #Prec_Prod Where codi_prod = @codi_prod )
							
							Select @Cont_prod = (Select Count(Codi_prod) From #Deta_orde_comp Where Codi_prod = @Codi_prod)
							Set @cant_prod = 0
							if @cont_prod <= 0 
								Begin
									Set @cant_prod = @cantidad											
								End	
							Else
								Begin
									Select @cant_prod = (Select Cantidad From #Deta_Orde_Comp Where codi_prod = @codi_prod )
									Set @cant_prod = @cantidad + @cant_prod	
								End
							
							Insert Into #Deta_Orde_Comp (Codi_prod, Cantidad, precio, nro_cuen)
							Values (@codi_prod, @cantidad, @precio, @nro_cuen)				

							Fetch Curs_Carg_Deta_oc_cu into @codi_prod, @cantidad, @nro_cuen
						End
						Close Curs_Carg_Deta_oc_cu
						Deallocate Curs_Carg_Deta_oc_cu
					End								
			End
			Fetch Curs_carg_Coti into @Codi_Deta_Coti	
		End										
		Close Curs_Carg_Coti										
		Deallocate Curs_Carg_Coti												
	End

Select * From #Deta_Orde_Comp
GO
