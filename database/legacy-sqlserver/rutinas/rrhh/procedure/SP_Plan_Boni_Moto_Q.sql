CREATE PROCEDURE [dbo].[SP_Plan_Boni_Moto_Q]
	@mesa [char](6),
	@fecha [datetime]
WITH EXECUTE AS CALLER
AS
Begin
	Declare @persona char(5)
	Declare @code char(5)
	Declare @cargo char(4)
	Declare @codiplan char(10)
	Declare @mx numeric(9)
	Declare @idplan char(10)
	Declare @afec char(1)
	Declare @afi char(1)
	Declare @val numeric(12,2)
	Declare @total numeric(12,2)
	Declare @totalafec numeric(12,2)
	Declare @totdesc numeric(12,2)
	Declare @netopagar numeric(12,2)
	Declare @totalaport numeric(12,2)
	Declare @mont numeric(12,2)
	Declare @por numeric(12,2)
	Declare @tipo char(1)
	Declare @dd numeric(2)
	Declare C2 cursor for select codi_unid_oper,codi_pers ,dias_traba_quin  from asistencia_motorista where mesanio=@mesa and (codi_carg='1105' or codi_carg='1107')
	open C2
	fetch C2 into @code,@persona ,@dd
	WHILE @@FETCH_STATUS = 0
	begin	
	--se realiza un bucle por persona registra en una semana y embarcacion determinada
		set @total =0
		set @totalafec =0
		set @totdesc =0
		set @netopagar =0
		set @totalaport =0
	--se selecciona el maximo id de la tabla
		select @mx= max(right(codi_plan_boni,9)) from planilla_boni_moto
		if (@mx is null)	set @mx=0

		set @mx= @mx + 1	

		set @idplan ='M'+ replicate('0', 9 - len( ltrim(convert(varchar(9),@mx)) )) +ltrim(convert(varchar(9),@mx))

	--se crea los registro en planilla de tripulantes
		insert into planilla_boni_moto (codi_plan_boni,  mesanio, codi_unid_oper , codi_pers, importe,  form_pago, nro_cheque, tipo)
		values (@idplan, @mesa,  @code, @persona,0,'TELE_CRED', '', 'Q')

	-- se procede a la insercion de los conceptos
		set @afi='0'
		set @afec='0'
		set @val=0
	--calculamos el monto de participacion de pesca		
		
		declare @mensn numeric(12,2)

		select @mensn= suel_neto  from personal where codi_pers=@persona

		set @val= @mensn*@dd/30

	--insertar participacion de pesca
		select @afec=afecto from conceptos_afectos_planillas where codi_tipo_plan='14' and codi_conc='100201' and esta_acti='1'

		insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
		values(@idplan,'100201',@afec,@val,0)

		set @total=@total + @val

		if (@afec='1') set @totalafec=@totalafec +@val

	--insertar total ingresos afectos
		insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
		values(@idplan,'199998','0',@totalafec,0)

	--insertar total ingresos
		insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
		values(@idplan,'199999','0',@total,0)

--insert total descuentos
		select @totdesc=sum(valor)   from planilla_boni_concepto where
			codi_plan_boni=@idplan and left(codi_conc,1)='2'
		if (@totdesc is null) set @totdesc=0
		insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
		values(@idplan,'299999','0',@totdesc,0)

--insertar neto a pagar
		set @netopagar= @total  - @totdesc
		insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
		values(@idplan,'999990','0',@netopagar,0)

--se actualiza el importe del tripulante
		update planilla_boni_moto set importe=@netopagar where codi_plan_boni =@idplan

		fetch C2 into @code,@persona, @dd
	end
	close C2
	deallocate c2
	

End
GO
