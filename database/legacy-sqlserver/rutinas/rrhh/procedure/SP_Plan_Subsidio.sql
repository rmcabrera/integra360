CREATE PROCEDURE [dbo].[SP_Plan_Subsidio]
	@embar [char](5),
	@mesa [char](6),
	@codsem [char](8),
	@fecha [datetime]
WITH EXECUTE AS CALLER
AS
Begin
	Declare @persona char(5)
	Declare @cargo char(4)
	Declare @codiplan char(10)
	Declare @mx numeric(10)
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
	Declare @car char(4)
	Declare @por numeric(12,2)
	Declare @montsub numeric(12,2)
	Declare @tipo char(1)
	Declare @dd numeric(2)
	Declare @ddnoa numeric(2)
	Declare @ns numeric(2)
	declare @CodiValo int
	Declare C2 cursor for select codi_pers , dias,dias_noafe, monto  from subsidios where codi_unid_oper=@embar and codi_sema=@codsem
	open C2
	fetch C2 into @persona, @dd, @ddnoa, @montsub
	WHILE @@FETCH_STATUS = 0
	begin	
	--se realiza un bucle por persona registra en una semana y embarcacion determinada
		set @total =0
		set @totalafec =0
		set @totdesc =0
		set @netopagar =0
		set @totalaport =0

	--se selecciona el maximo id de la tabla
		select @mx= max(right(codi_plan_subs,9)) from planilla_subsidio
		if (@mx is null)	set @mx=0

		set @mx= @mx + 1	
		set @idplan = 'S' + replicate('0', 9 - len(convert(char(9),@mx) )) +convert(char(9),@mx) 
	--se crea los registro en planilla de tripulantes
		insert into planilla_subsidio (codi_plan_subs,  mesanio, codi_unid_oper , codi_pers, importe,  form_pago, nro_cheque, tipo, codi_sema)
		values (@idplan, @mesa,  @embar, @persona,0,'TELE_CRED', '', '',@codsem)

	-- se procede a la insercion de los conceptos
		set @afi='0'
		set @afec='0'
		set @val=@montsub*@dd
		if (@val>0)
		begin
			select @afec=afecto from conceptos_afectos_planillas where codi_tipo_plan='05' and codi_conc='100202' and esta_acti='1'
			insert into planilla_subs_concepto (codi_plan_subs, codi_conc, afecto, valor,monto)
			values(@idplan,'100202',@afec,@val,0)
			set @total=@total + @val
			if (@afec='1') set @totalafec=@totalafec +@val
		end

		set @afi='0'
		set @afec='0'
	
		set @val=@montsub*@ddnoa
		if (@val>0)
		begin
			select @afec=afecto from conceptos_afectos_planillas where codi_tipo_plan='05' and codi_conc='100204' and esta_acti='1'
			insert into planilla_subs_concepto (codi_plan_subs, codi_conc, afecto, valor,monto)
			values(@idplan,'100204',@afec,@val,0)
			set @total=@total + @val
			if (@afec='1') set @totalafec=@totalafec +@val
		end	

	--insertar total ingresos afectos
		insert into planilla_subs_concepto (codi_plan_subs, codi_conc, afecto, valor,monto)
		values(@idplan,'199998','0',@totalafec,0)
	--insertar total ingresos
		insert into planilla_subs_concepto (codi_plan_subs, codi_conc, afecto, valor,monto)
		values(@idplan,'199999','0',@total,0)


	----------insertar descuentos
		set @totdesc=0

		select @totdesc=sum(valor)   from planilla_subs_concepto where
			codi_plan_subs=@idplan and left(codi_conc,1)='2'
		if (@totdesc is null) set @totdesc=0

		insert into planilla_subs_concepto (codi_plan_subs, codi_conc, afecto, valor,monto)
		values(@idplan,'299999','0',@totdesc , 0)

--insertar neto a pagar
	
		set @netopagar= @total  - @totdesc 
		insert into planilla_subs_concepto (codi_plan_subs, codi_conc, afecto, valor,monto)
		values(@idplan,'999990','0',@netopagar,0)

--se actualiza el importe del tripulante
		update planilla_subsidio set importe=@netopagar where codi_plan_subs =@idplan

	----------- insertar aportaciones
		Declare @CconcP  char(6)
		set @codivalo=''
		Declare C1 cursor for select codi_conc, codi_valo_unit, afecto from conceptos_afectos_planillas where codi_tipo_plan='05' and esta_acti='1'
				and codi_conc<>'399999' and left(codi_conc,1) ='3'
		open C1
		fetch C1 into @CconcP, @codivalo,@afec
		WHILE @@FETCH_STATUS = 0
		begin	

			set @afec='0'
			set @val=0
			set @mont=0
	
			select @mont= valor, @tipo =tipo_valo  from valores_unitarios_anuales where codi_valo_unit=@codivalo
				and fech_asig<= @fecha and fech_asig_fin >= @fecha
	
			if (@tipo='0') set @val= round(@totalafec * @mont/100,2)
			if (@tipo='1') set @val= round( @mont,2)
	
			insert into planilla_subs_concepto (codi_plan_subs, codi_conc, afecto, valor,monto)
			values(@idplan,@CconcP,@afec,@val,@mont )

			fetch C1 into @CconcP, @codivalo,@afec
		end
		close C1		
		deallocate c1

	-------------------------------------------------------------------------------------------------------
--insertar total aportaciones
		select @totalaport=sum(valor)  from planilla_subs_concepto where
			codi_plan_SUBS=@idplan and left(codi_conc,1)='3'

		insert into planilla_subs_concepto (codi_plan_subs, codi_conc, afecto, valor,monto)
		values(@idplan,'399999','0',@totalaport,0)
	
		fetch C2 into @persona, @dd, @ddnoa, @montsub
	end
	close C2	
	deallocate c2
	

End
GO
