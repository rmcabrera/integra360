CREATE PROCEDURE [dbo].[SP_Planilla_Boni_Tripu]
	@semana [char](8),
	@embar [char](5),
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
	Declare @val2 numeric(12,2)
	Declare @total2 numeric(12,2)
	Declare @totalafec2 numeric(12,2)
	Declare @totdesc2 numeric(12,2)
	Declare @netopagar2 numeric(12,2)
	Declare @totalaport2 numeric(12,2)
	Declare @mont2 numeric(12,2)

	Declare @por numeric(12,2)
	DECLARE @cvu integer
	Declare @tipo char(1)

	Declare C2 cursor for select  distinct codi_pers from planilla_pesca_tripulantes where espe_monto <>0 and codi_sema=@semana and 
			 codi_unid_oper=@embar
	open C2
	fetch C2 into @persona
	WHILE @@FETCH_STATUS = 0
	begin	
	--se realiza un bucle por persona registra en una semana y embarcacion determinada
		set @total =0
		set @totalafec =0
		set @totdesc =0
		set @netopagar =0
		set @totalaport =0

		set @total2 =0
		set @totalafec2 =0
		set @totdesc2 =0
		set @netopagar2 =0
		set @totalaport2 =0
	--se selecciona el maximo id de la tabla
		select @mx= max(right(codi_plan_btri,9)) from planilla_boni_tripu
		if (@mx is null)	set @mx=0

		set @mx= @mx + 1	
		set @idplan = 'B'+replicate('0', 9 - len(convert(char(9),@mx) )) +convert(char(9),@mx) 
--		print @idplan
	--se crea los registro en planilla de boni  tripulantes
		insert into planilla_boni_tripu (codi_plan_btri,codi_sema,codi_pers, codi_tipo_plan, estado, importe,form_pago, nro_cheque, fech_pago, codi_unid_oper, importe_especial)
		values (@idplan, @semana,@persona, '15','P',0,'TELE_CRED','', @fecha, @embar,0)

	-- se procede a la insercion de los conceptos
		set @afi='0'
		set @afec='0'
		set @val=0
	--calculamos el monto de participacion de pesca		
		select @val= isnull( sum(round( espe_monto  ,2)) , 0 ) from planilla_pesca_tripulantes where codi_sema=@semana
			and codi_unid_oper=@embar and codi_pers=@persona

	--insertar participacion de pesca
		select @afec=afecto from conceptos_afectos_planillas where codi_tipo_plan='15' and codi_conc='100203' and esta_acti='1'
		insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto, especial)
		values(@idplan,'100203',@afec,@val,0, @val2)

		set @total=@total + @val
		set @total2=@total2 + @val2
		PRINT @total
		PRINT @total2
		if (@afec='1') set @totalafec=@totalafec +@val

		PRINT @totalAFEC
		PRINT @totalAFEC2

	--insertar total ingresos afectos
		insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto,especial)
		values(@idplan,'199998','0',@totalafec,0, @totalafec2)
	--insertar total ingresos
		insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto, especial)
		values(@idplan,'199999','0',@total,0, @total2)

	--verificar afiliacion sindical
		select @afi = afil_sind from personal where codi_pers=@persona
		if (@afi='1')	
		begin
			set @afec='0'
			set @val=0
			set @mont=0
			set @val2=0
			set @mont2=0

			select @mont= valor, @tipo =tipo_valo  from valores_unitarios_anuales where codi_valo_unit='16' 
				and fech_asig<= @fecha and fech_asig_fin >= @fecha

			select @afec=afecto from conceptos_afectos_planillas where codi_tipo_plan='15' and codi_conc='200103' and esta_acti='1'

			if (@tipo='0') set @val= round(@totalafec * @mont/100,2)
			if (@tipo='1') set @val= round(@mont,2)

			if (@tipo='0') set @val2= round(@totalafec2 * @mont/100,2)
			if (@tipo='1') set @val2= round(@mont,2)
		-- insertamos cuota sindical
			insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto, especial)
			values(@idplan,'200103',@afec,@val,@mont, @val2)
		end


	--insertar prestaciones 	
		set @afec='0'
		set @val=0
		set @mont=0
		set @val2=0

		select @mont= valor, @tipo =tipo_valo  from valores_unitarios_anuales where codi_valo_unit='17' 
			and  fech_asig<= @fecha and fech_asig_fin >= @fecha
		select @afec=afecto from conceptos_afectos_planillas where codi_tipo_plan='15' and codi_conc='200100' and esta_acti='1'

		if (@tipo='0') set @val= round(@totalafec * @mont/100,2)

		if (@tipo='1') set @val= round(@mont,2)

		insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto, especial)
		values(@idplan,'200100',@afec,@val,@mont,@val2)

	--insertar pensiones 	
		set @afec='0'
		set @val=0
		set @mont=0
		set @val2=0
		select @mont= valor, @tipo =tipo_valo  from valores_unitarios_anuales where codi_valo_unit='18' 
			and fech_asig<= @fecha and fech_asig_fin >= @fecha
		select @afec=afecto from conceptos_afectos_planillas where codi_tipo_plan='15' and codi_conc='200101' and esta_acti='1'
		if (@tipo='0') set @val= round(@totalafec * @mont/100,2)
		if (@tipo='1') set @val= round(@mont,2)


		insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto, especial)
		values(@idplan,'200101',@afec,@val,@mont, @val2)

	--insertar subsidio
		set @afec='0'
		set @val=0
		set @mont=0
		set @val2=0
		select @mont= valor, @tipo =tipo_valo  from valores_unitarios_anuales where codi_valo_unit='19' 
			and fech_asig<= @fecha and fech_asig_fin >= @fecha
		select @afec=afecto from conceptos_afectos_planillas where codi_tipo_plan='15' and codi_conc='200102' and esta_acti='1'
		if (@tipo='0') set @val= round(@totalafec * @mont/100,2)
		if (@tipo='1') set @val= round( @mont,2)

		insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto, especial)
		values(@idplan,'200102',@afec,@val,@mont, @val2)

--selecciono la suma del neto de descuentos obligatorios
		Declare @Descobl numeric(12,2)
		Declare @Descobl2 numeric(12,2)

		select @descobl=sum(valor)  , @descobl2=sum(especial) from planilla_bonitri_conceptos where
			codi_plan_btri=@idplan and left(codi_conc,1)='2'
		if(@descobl is null) set @descobl=0
		if(@descobl2 is null) set @descobl2=0

--insercion de juicios
		Declare @Tpc numeric(12,3)
		Select 	@tpc=venta from tipo_cambio_a_dolar where codi_mone_orig='01' and convert( char(10) , fech_camb, 103)= convert( char(10) , @fecha, 103)
		
		Declare @mon char(2)
		Declare @inte_tiem char(1)
		Declare @Codjuicio char(6)
		Declare @it numeric(3)
		Declare @montdesc numeric(12,2)
		Declare @idconp char(6)
		Declare @idaux char(10)
		Declare CJui cursor for select codi_juic,codi_mone, mont_desc, tipo_desc,inte_tiem_desc from juicios where codi_pers=@persona and esta_acti='1'
			and fech_juic<= @fecha and inte_tiem_desc='S'
		open Cjui		
		fetch Cjui into @codjuicio, @mon,@montdesc ,@tipo, @inte_tiem
		set @it=11
		WHILE @@FETCH_STATUS = 0
		begin	
			set @mont=0
			set @val=0
			set @val2=0

			if (@tipo='0') 
			begin
				set @val= round((@totalafec - @descobl) * @montdesc/100,2)
				set @val2= round((@totalafec2 - @descobl2) * @montdesc/100,2)
				set @mont= @montdesc
			end 
			if (@tipo='1') set @val= round(@montdesc,2)
			if (@tipo='1') set @val2= round(@montdesc,2)

			if (@mon='02') set @val= @val * @tpc
			if (@mon='02') set @val2= @val2 * @tpc
				
			set @idconp = '2000' + replicate('0', 2 - len(convert(char(2),@it) )) +convert(char(2),@it) 	
			
			insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto ,especial)
			values(@idplan,@idconp,'0',@val,@mont , @val2)

			select @mx=max(codi_prin) from plan_conc_desc
			if (@mx is null)	set @mx=0
			set @mx= @mx + 1	
			set @idaux = replicate('0', 10 - len(convert(char(10),@mx) )) +convert(char(10),@mx) 				

			Exec sp_insert_PLAN_CONC_DESC
			  @CODI_PRIN = @idaux,
			  @CODI_PLAN_CONC 	=@idplan,
			 @CODI_CONC 	=@idconp,
			 @CODI_DESC 	= @codjuicio,
			 @NRO_PAGO  = 0,
			 @CODI_TIPO_TRAB='03',
			 @INDI_TIPO_DESC = 'J',
			 @VALOR =@val
			
			select @mx=Max(cast(nro_pago as numeric))  from pagos_juicios where codi_juic=@codjuicio
			if (@mx is null)	set @mx=0
			set @mx= @mx + 1	
			set @idconp= CONVERT(char(4), @mx)
			Exec sp_insert_PAGOS_JUICIOS
				@CODI_JUIC_1 = @codjuicio,
				 @NRO_PAGO_2 = @idconp,
				 @FECH_PAGO_3 =@fecha,
				 @CODI_MONE_4  ='01',
				 @MONTO_5 	=@val,
				 @OBSERVACION_6 ='PLANILLA BONIFICACIONES SEMANAL'

			update plan_conc_desc set nro_pago=@mx where codi_prin=@idaux

			Set @it= @it + 1		
			fetch Cjui into @codjuicio, @mon,@montdesc, @tipo, @inte_tiem
		end
		close Cjui
		deallocate cjui


		Declare @Sal numeric(12,2)	
		Declare @Saldo numeric(12,2)	
		Declare @aux numeric(12,2)
			
--insercion de prestamos empresa
		set @saldo=0
		Declare CPresE cursor for select codi_pres,codi_mone, mont_desc,tipo_desc, inte_tiem_desc,saldo from prestamos where codi_pers=@persona and esta_acti='1'
			and tipo_pres='EMPRESA' and fech_pres <=  @fecha and inte_tiem_desc='S'
		open CPresE
		set @saldo=0
		fetch CpresE into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo
		set @it=1
		WHILE @@FETCH_STATUS = 0
		begin	
			set @mont=0
			set @val=0
			set @val2=0
			if (@tipo='0') 
			begin
				set @val= round(@totalafec * @montdesc/100,2)
				set @val2= round(@totalafec2 * @montdesc/100,2)
				set @mont=@montdesc
			end
			if (@tipo='1') set @val= round(@montdesc,2)
			if (@tipo='1') set @val2= round(@montdesc,2)
			
			if (@mon='02') 
			begin
				set @val= @val * @tpc
				set @val2= @val2 * @tpc
				set @saldo =@saldo * @tpc
			end

			if(@val > @saldo) set @val= @saldo

			set @idconp = '2000' + replicate('0', 2 - len(convert(char(2),@it) )) +convert(char(2),@it) 	
			
			insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto, especial)
			values(@idplan,@idconp,'0',@val,@mont, @val2)

			select @mx=max(codi_prin) from plan_conc_desc
			if (@mx is null)	set @mx=0
			set @mx= @mx + 1	
			set @idaux = replicate('0', 10 - len(convert(char(10),@mx) )) +convert(char(10),@mx) 				

			Exec sp_insert_PLAN_CONC_DESC
			  @CODI_PRIN = @idaux,
			  @CODI_PLAN_CONC 	=@idplan,
			 @CODI_CONC 	=@idconp,
			 @CODI_DESC 	= @codjuicio,
			 @NRO_PAGO  = 0,
			 @CODI_TIPO_TRAB='03',
			 @INDI_TIPO_DESC = 'P',
			 @VALOR =@val
			
			select @mx=Max(cast(nro_pago as numeric)) from pagos_prestamos where codi_pres=@codjuicio
			if (@mx is null)	set @mx=0
			set @mx= @mx + 1	
			set @idconp= CONVERT(char(4), @mx)
			Exec sp_insert_PAGO_Pres
				@CODI_pres_1 = @codjuicio,
				 @NRO_PAGO_2 = @idconp,
				 @FECH_PAGO_3 =@fecha,
				 @CODI_MONE_4  ='01',
				 @MONTO_5 	=@val,
				 @OBSERVACION_7 ='PLANILLA BONIFICACIONES SEMANAL'

			update plan_conc_desc set nro_pago=@mx where codi_prin=@idaux

			set @aux=@val
			if (@mon='02') set @aux=round(@val/@tpc,2)
			
			update prestamos set saldo=(saldo - @aux) where codi_pres=@codjuicio
			select @sal =saldo from prestamos where codi_pres=@codjuicio
			if(@sal<=0)   update prestamos set esta_acti='0' where codi_pres=@codjuicio
			Set @it= @it + 1

			fetch CpresE into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo
		end
		close CpresE
		deallocate CpresE


--insercion de creditos bancarios
		set @saldo=0
		Declare CPresB Cursor for select codi_pres,codi_mone, mont_desc,tipo_desc, inte_tiem_desc,saldo from prestamos where codi_pers=@persona and esta_acti='1'
			and tipo_pres='BANCARIO' and fech_pres <=  @fecha and inte_tiem_desc='S'
		open CPresB
		fetch CpresB into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo
		set @it=91
		WHILE @@FETCH_STATUS = 0
		begin	
			set @mont=0
			set @val=0
			set @val2=0

			if (@tipo='0') 
			begin
				set @val= round(@totalafec * @montdesc/100,2)
				set @val2= round(@totalafec2 * @montdesc/100,2)
				set @mont=@montdesc
			end
			if (@tipo='1') set @val= round(@montdesc,2)
			if (@tipo='1') set @val2= round(@montdesc,2)
			
			if (@mon='02') 
			begin
				set @val= @val * @tpc
				set @val2= @val2 * @tpc
				set @saldo= @saldo * @tpc
			end

			if(@val > @saldo) set @val= @saldo
				
			set @idconp = '2000' + replicate('0', 2 - len(convert(char(2),@it) )) +convert(char(2),@it) 	
			
			insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto, especial)
			values(@idplan,@idconp,'0',@val,@mont, @val2)

			select @mx=max(codi_prin) from plan_conc_desc
			if (@mx is null)	set @mx=0
			set @mx= @mx + 1	
			set @idaux = replicate('0', 10 - len(convert(char(10),@mx) )) +convert(char(10),@mx) 				

			Exec sp_insert_PLAN_CONC_DESC
			  @CODI_PRIN = @idaux,
			  @CODI_PLAN_CONC 	=@idplan,
			 @CODI_CONC 	=@idconp,
			 @CODI_DESC 	= @codjuicio,
			 @NRO_PAGO  = 0,
			 @CODI_TIPO_TRAB='03',
			 @INDI_TIPO_DESC = 'P',
			 @VALOR =@val
			
			select @mx=Max(cast(nro_pago as numeric)) from pagos_prestamos where codi_pres=@codjuicio
			if (@mx is null)	set @mx=0
			set @mx= @mx + 1	
			set @idconp= CONVERT(char(4), @mx)
			Exec sp_insert_PAGO_Pres
				@CODI_pres_1 = @codjuicio,
				 @NRO_PAGO_2 = @idconp,
				 @FECH_PAGO_3 =@fecha,
				 @CODI_MONE_4  ='01',
				 @MONTO_5 	=@val,
				 @OBSERVACION_7 ='PLANILLA BONIFICACIONES SEMANAL'

			update plan_conc_desc set nro_pago=@mx where codi_prin=@idaux

			set @aux=@val
			if (@mon='02') set @aux=round(@val/@tpc,2)
			
			update prestamos set saldo=(saldo - @aux) where codi_pres=@codjuicio
			select @sal =saldo from prestamos where codi_pres=@codjuicio
			if(@sal<=0)   update prestamos set esta_acti='0' where codi_pres=@codjuicio
			Set @it= @it + 1

			fetch CpresB into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo
		end
		close CpresB
		deallocate CpresB


--insercion adelantos 

		set @saldo=0
		Declare CAde cursor for select codi_adel,codi_mone_adel, mont_pago, inte_tiem_desc,saldo  from adelantos where codi_pers=@persona and esta_pago='0'
			and fech_adel <= @fecha and inte_tiem_desc='S'
		open CAde	
		fetch CAde into @codjuicio, @mon,@montdesc ,@inte_tiem, @saldo
		set @it=51
		WHILE @@FETCH_STATUS = 0
		begin	
			set @mont=0
			set @val=0
			set @val2=0
			set @val= round(@montdesc,2)
			set @val2= round(@montdesc,2)

			if (@mon='02') 
			begin
				set @val= @val * @tpc
				set @val2= @val2 * @tpc
				set @saldo = @saldo * @tpc
			end

			if(@val > @saldo) set @val= @saldo
				
			set @idconp = '2000' + replicate('0', 2 - len(convert(char(2),@it) )) +convert(char(2),@it) 	
			
			insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto, especial)
			values(@idplan,@idconp,'0',@val,@mont, @val2)

			select @mx=max(codi_prin) from plan_conc_desc
			if (@mx is null)	set @mx=0
			set @mx= @mx + 1	
			set @idaux = replicate('0', 10 - len(convert(char(10),@mx) )) +convert(char(10),@mx) 				

			Exec sp_insert_PLAN_CONC_DESC
			  @CODI_PRIN = @idaux,
			  @CODI_PLAN_CONC 	=@idplan,
			 @CODI_CONC 	=@idconp,
			 @CODI_DESC 	= @codjuicio,
			 @NRO_PAGO  = 0,
			 @CODI_TIPO_TRAB='03',
			 @INDI_TIPO_DESC = 'A',
			 @VALOR =@val
			
			select @mx=Max(cast(nro_pago as numeric)) from pagos_adelantos where codi_adel=@codjuicio
			if (@mx is null)	set @mx=0
			set @mx= @mx + 1	
			set @idconp= CONVERT(char(4), @mx)
			Exec sp_insert_PAGO_ADEL
				@CODI_ADel = @codjuicio,
				 @NRO_PAGO = @idconp,
				 @FECH_PAGO =@fecha,
				 @CODI_MONE  ='01',
				 @MONTO 	=@val,
				 @OBSERVACION ='PLANILLA BONIFICACIONES SEMANAL'

			update plan_conc_desc set nro_pago=@mx where codi_prin=@idaux

			set @aux=@val
			if (@mon='02') set @aux=round(@val/@tpc,2)
			
			update adelantos set saldo=(saldo - @aux) where codi_adel=@codjuicio
			select @sal =saldo from adelantos where codi_adel=@codjuicio
			if(@sal<=0)   update adelantos set esta_pago='1' where codi_adel=@codjuicio
			Set @it= @it + 1		
			fetch CAde into @codjuicio, @mon,@montdesc ,@inte_tiem, @saldo
		end
		close CAde
		deallocate Cade

--insert total descuentos
		select @totdesc=sum(valor)  from planilla_bonitri_conceptos where
			codi_plan_btri=@idplan and left(codi_conc,1)='2'
		insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto, especial)
		values(@idplan,'299999','0',@totdesc,0, @totdesc2)

--insertar neto a pagar
		set @netopagar= ISNULL( @total , 0) - ISNULL( @totdesc, 0)

		insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto, especial)
		values(@idplan,'999990','0',@netopagar,0, @netopagar2)

--se actualiza el importe del tripulante
		update planilla_boni_tripu set importe=@netopagar, importe_especial=@netopagar2 where codi_plan_btri =@idplan

	----------- insertar aportaciones
		Declare @CconcP  char(6)
		Declare @codivalo int
		set @codivalo=''
		Declare C1 cursor for select codi_conc, codi_valo_unit, afecto from conceptos_afectos_planillas where codi_tipo_plan='15' and esta_acti='1'
				and codi_conc<>'399999' and left(codi_conc,1) ='3' order by codi_conc
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
	
			insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto)
			values(@idplan,@CconcP,@afec,@val,@mont )

			fetch C1 into @CconcP, @codivalo,@afec
		end
		close C1		deallocate c1


--insertar total aportaciones
		select @totalaport=sum(valor) , @totalaport2=sum(especial) from planilla_bonitri_conceptos where
			codi_plan_btri=@idplan and left(codi_conc,1)='3'
		insert into planilla_bonitri_conceptos (codi_plan_btri, codi_conc, afecto, valor,monto, especial)
		values(@idplan,'399999','0',@totalaport,0,@totalaport2)

	
		fetch C2 into @persona
	end
	close C2
	deallocate c2
	

End
GO
