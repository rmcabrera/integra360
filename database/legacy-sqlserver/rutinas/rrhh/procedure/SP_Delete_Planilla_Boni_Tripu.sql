CREATE PROCEDURE [dbo].[SP_Delete_Planilla_Boni_Tripu]
	@sema [char](8),
	@embar [char](5)
WITH EXECUTE AS CALLER
AS
Begin
	Declare @persona char(5)
	Declare @planilla char(10)
	Declare @prin char(10)
	Declare @tabla char(6)
	Declare @nro int
	Declare @ind char(1)
	Declare @valo numeric(12,3)
	Declare @dev numeric(12,3)
	Declare @mone char(2)
	Declare @sum numeric(12,3)
	declare @fec datetime
	Declare @Tpc numeric(12,3)
	Declare C1 cursor for select codi_plan_btri from  planilla_boni_tripu  where codi_sema=@sema and codi_unid_oper=@embar 
	open C1
	fetch C1 into @planilla
	WHILE @@FETCH_STATUS = 0
	begin	
		Declare C2 Cursor for select  codi_desc, nro_pago, indi_tipo_desc, valor from plan_conc_desc
			where codi_plan_conc=@planilla
		Open C2
		fetch C2 into @tabla, @nro, @ind ,@valo
		WHILE @@FETCH_STATUS = 0
		begin	
			if(@ind='A')
			begin 
				set @dev=0
				set @sum=0
				select @dev=monto from pagos_adelantos where codi_adel=@tabla and nro_pago=@nro
				select @mone =codi_mone_adel from adelantos where codi_adel=@tabla
				if (@mone='01')	update adelantos set saldo=saldo + @dev, esta_pago='0' where codi_Adel=@tabla					
				else
				begin	
				 	select @fec=fech_pago from pagos_adelantos where codi_adel=@tabla and nro_pago=@nro
					Select 	@tpc=venta from tipo_cambio_a_dolar where codi_mone_orig='01' and convert( char(10) , fech_camb, 103)= convert( char(10) , @fec, 103)					
					set @sum = @dev /@tpc
					update adelantos set saldo=saldo + @sum, esta_pago='0' where codi_Adel=@tabla					
				end
				Delete from pagos_adelantos where codi_adel=@tabla and nro_pago=@nro	
			end	
			if(@ind='P')
			begin 
				set @dev=0
				set @sum=0
				select @dev=monto from pagos_prestamos where codi_pres=@tabla and nro_pago=@nro
				select @mone =codi_mone from prestamos where codi_pres=@tabla
				if (@mone='01')	update prestamos set saldo=saldo + @dev, esta_acti='1' where codi_pres=@tabla					
				else
				begin	
				 	select @fec=fech_pago from pagos_prestamos where codi_pres=@tabla and nro_pago=@nro
					Select 	@tpc=venta from tipo_cambio_a_dolar where codi_mone_orig='01' and convert( char(10) , fech_camb, 103)= convert( char(10) , @fec, 103)					
					set @sum = @dev /@tpc
					update prestamos set saldo=saldo + @sum, esta_acti='1' where codi_pres=@tabla					
				end
				Delete from pagos_prestamos where codi_pres=@tabla and nro_pago=@nro	
			end	
			if(@ind='J') Delete from pagos_juicios where codi_juic=@tabla and nro_pago=@nro

			fetch C2 into @tabla, @nro, @ind ,@valo
		end
		close C2		deallocate C2
		delete from plan_conc_desc where codi_plan_conc=@planilla
		
		Delete from planilla_bonitri_conceptos where codi_plan_btri=@planilla
		fetch C1 into @planilla
	end
	close C1	deallocate C1
	Delete from  planilla_boni_tripu  where codi_sema=@sema and codi_unid_oper=@embar
End
GO
