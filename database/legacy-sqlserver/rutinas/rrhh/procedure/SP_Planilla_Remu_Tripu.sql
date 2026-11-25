CREATE PROCEDURE [dbo].[SP_Planilla_Remu_Tripu]
	@semana [char](8),
	@embar [char](5),
	@fecha [datetime],
	@asis [char](1),
	@mesa [char](6)
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
	Declare @participa numeric(12,2)
	Declare @mont numeric(12,2)
	Declare @salida numeric(12,2)

	Declare @val2 numeric(12,2)
	Declare @Part1 numeric(12,2)
	Declare @Part2 numeric(12,2)
	Declare @total2 numeric(12,2)
	Declare @totalafec2 numeric(12,2)
	Declare @totdesc2 numeric(12,2)
	Declare @netopagar2 numeric(12,2)
	Declare @totalaport2 numeric(12,2)
	Declare @mont2 numeric(12,2)
	Declare @Vvac numeric(12,2) ---------valor de vacaciones
	Declare @tAFEC numeric(12,2) ---------valor de vacaciones
	declare @sindic char(2)
	Declare @por numeric(12,2)
	Declare @valaux numeric(12,2)
	declare @CTS numeric(12,2)	
	declare @DESCCTS numeric(12,2)	

	DECLARE @cvu integer
	Declare @tipo char(1)

	Declare @CconcP  char(6)
	declare @codivalo CHAR(2)


	Declare C2 cursor for select codi_pers from asistencia_tripulantes_pesca where codi_sema=@semana
		and codi_unid_oper=@embar and nro_asis=@asis
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
		select @mx= max(codi_plan_trip) from planilla_de_tripulantes
		if (@mx is null)	set @mx=0

		set @mx= @mx + 1	
		set @idplan = replicate('0', 10 - len(convert(char(10),@mx) )) +convert(char(10),@mx) 
--		print @idplan
	--se crea los registro en planilla de tripulantes
		insert into planilla_de_tripulantes (codi_plan_trip,codi_sema,codi_pers, codi_tipo_plan, estado, importe,form_pago, nro_cheq, fech_pago, codi_unid_oper, importe_especial, nro_asis, mesanio)
		values (@idplan, @semana,@persona, '08','P',0,'TELE_CRED','', @fecha, @embar,0, @asis, @mesa)

	-- se procede a la insercion de los conceptos
		set @afi='0'
		set @afec='0'
		set @val=0
		set @valaux=0
	--calculamos el monto de participacion de pesca		
		select @val= isnull( sum(round( monto ,2)) , 0 ) , @val2 = isnull( sum(round( espe_monto  ,2)) , 0 ) from planilla_pesca_tripulantes where codi_sema=@semana
			and codi_unid_oper=@embar and codi_pers=@persona  and nro_asis=@asis
	--insertar participacion de pesca
		
		set @valaux=@val - @val2
		set @part1 = @valaux
		set @part2 = 0
		select @afec=afecto from conceptos_afectos_planillas where codi_tipo_plan='08' and codi_conc='100200' and esta_acti='1'
		
		insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto, especial)
		values(@idplan,'100200',@afec,@valaux,0, @val2)

		set @total=@total + @valaux
		
		if (@afec='1') set @totalafec=@totalafec +@valaux

		if (@val2>0)
                         begin
			set @part2 = @val2
			select @afec=afecto from conceptos_afectos_planillas where codi_tipo_plan='08' and codi_conc='100203' and esta_acti='1'

			insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto, especial)
			values(@idplan,'100203',@afec,@val2,0, @val2)
			set @total=@total + @val2
			if (@afec='1') set @totalafec=@totalafec +@val2
		end	
		
----------- insertar ingresos

		set @codivalo=''
		Declare C3 cursor for select codi_conc, codi_valo_unit, afecto from conceptos_afectos_planillas where codi_tipo_plan='08' and esta_acti='1'
				and not (codi_conc='199999' or codi_conc='199998'  or codi_conc='100200'  or codi_conc='100203' ) and left(codi_conc,1) ='1' 
				AND NOT (CODI_VALO_UNIT IS NULL)
		open C3
		fetch C3 into @CconcP, @codivalo,@afec
		WHILE @@FETCH_STATUS = 0
		begin	

			set @val=0
			set @mont=0
	
			select @mont= valor, @tipo =tipo_valo  from valores_unitarios_anuales where codi_valo_unit=@codivalo
				and fech_asig<= @fecha and fech_asig_fin >= @fecha

			--if (@tipo='0') set @val= round(@total * @mont/100,2)			
			if (@tipo='0') set @val= round(@part1* @mont/100,2)  + round( @part2* @mont/100,2)		
			if (@tipo='1') set @val= round( @mont,2)

			if (@afec='1') set @totalafec=@totalafec +@val
	
			insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto)
			values(@idplan,@CconcP,@afec,@val,@mont )
			
			set @codivalo=0
			fetch C3 into @CconcP, @codivalo,@afec
		end
		close C3		
		deallocate c3

	-------------------------------------------------------------------------------------------------------
	--insertar total ingresos
	--	select @total=sum(valor)  from planilla_tripulante_conceptos where
	--		codi_plan_trip =@idplan and left(codi_conc,1)='1'

		insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto)
		values(@idplan,'199999','0',@total,0)

	--insertar total ingresos afectos
		insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto,especial)
		values(@idplan,'199998','0',@totalafec,0, @totalafec2)

	--verificar afiliacion sindical
		select @participa=sum(valor)  from planilla_tripulante_conceptos where
			codi_plan_trip=@idplan and (codi_conc = '100200' or codi_conc = '100203')

		set @CTS= round((@participa + round(@participa*16.66/100,2) )*8.33/100,2)

		select @afi = afil_sind from personal where codi_pers=@persona
		if (@afi='1')	
		begin
			set @afec='0'
			set @val=0
			set @mont=0
			set @val2=0
			set @mont2=0

			set @sindic = (select  top 1 codi_sind from sindicatos_personal where codi_pers=@persona and estado=1)
			set @mont = (select  top 1 porcentaje from sindicatos  where codi_sind =@sindic)
			set @tipo = (select  top 1 tipo_valor from sindicatos  where codi_sind =@sindic)

			--select @mont= valor, @tipo =tipo_valo  from valores_unitarios_anuales where codi_valo_unit='16' 
			--	and fech_asig<= @fecha and fech_asig_fin >= @fecha

			select @afec=afecto from conceptos_afectos_planillas where codi_tipo_plan='08' and codi_conc='200103' and esta_acti='1'

			if (@tipo='0') set @val= round(@participa * @mont/100,2)
			if (@tipo='1') set @val= round(@mont,2)

			if (@tipo='0') set @val2= round(@participa * @mont/100,2)
			if (@tipo='1') set @val2= round(@mont,2)
		-- insertamos cuota sindical
			IF (@VAL>0)
			BEGIN
				insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto, especial,codi)
				values(@idplan,'200103',@afec,@val,@mont, @val2,@sindic )
			END 
		end

	--insertar pensiones 	
		set @afec='0'
		set @val=0
		set @mont=0
		set @val2=0
		select @mont= valor, @tipo =tipo_valo  from valores_unitarios_anuales where codi_valo_unit='18' 
			and fech_asig<= @fecha and fech_asig_fin >= @fecha
		select @afec=afecto from conceptos_afectos_planillas where codi_tipo_plan='08' and codi_conc='200101' and esta_acti='1'

		--if (@tipo='0') set @val= round( @participa* @mont/100,2)
		if (@tipo='0') set @val= round( @part1* @mont/100,2)   + round(@part2* @mont/100,2)
		if (@tipo='1') set @val= round(@mont,2)

		insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto, especial)
		values(@idplan,'200101',@afec,@val,@mont, @val2)

---------------------------------------Aplicacion Renta 5
		set @val=0
		SET @MONT=0
		commit
		set @val=isnull(dbo.F_Renta_Quinta_Tripu(@persona , @fecha),0)
		if (@val>0)
		begin
			insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto, especial)
			values(@idplan,'200040',@afec,@val,@mont, @val2)
		end
-----------------------------------------------------
--selecciono la suma del neto de descuentos obligatorios
		Declare @Descobl numeric(12,2)
		Declare @Descobl2 numeric(12,2)

		select @descobl=sum(valor)  , @descobl2=sum(especial) from planilla_tripulante_conceptos where
			codi_plan_trip=@idplan and left(codi_conc,1)='2'
		if(@descobl is null) set @descobl=0
		if(@descobl2 is null) set @descobl2=0

--insercion de juicios
		Declare @Tpc numeric(12,3)
		Select 	@tpc=venta from tipo_cambio_a_dolar where codi_mone_orig='01' and convert( char(10) , fech_camb, 103)= convert( char(10) , @fecha, 103)
		
		Declare @mon char(2)
		Declare @inte_tiem char(1)
		Declare @Codjuicio char(6)
		Declare @it numeric(3)
		Declare @itcts numeric(3)
		Declare @montdesc numeric(12,2)
		Declare @idconp char(6)
		Declare @idaux char(10)
		Declare @PERI CHAR(1)
		declare @aplicatodo char(1)
		
		Declare CJui cursor for select codi_juic,codi_mone, mont_desc, tipo_desc,inte_tiem_desc , apli_toda_remu from juicios where codi_pers=@persona and esta_acti='1'
			and fech_juic<= @fecha  ---and inte_tiem_desc='S'
		open Cjui		
		fetch Cjui into @codjuicio, @mon,@montdesc ,@tipo, @inte_tiem,@aplicatodo
		set @it=11
		set @itcts=1
		set @desccts=0
		WHILE @@FETCH_STATUS = 0
		begin	
			set @mont=0
			set @val=0
			set @val2=0

			if (@tipo='0') 
			begin
				set @val= round((@participa - @descobl) * @montdesc/100,2)
				set @mont= @montdesc
			end 
			if (@tipo='1') set @val= round(@montdesc,2)

			if (@mon='02') set @val= @val * @tpc

			if(@inte_tiem='M' ) set @val= @val/4
			if(@inte_tiem='Q' ) set @val= @val/2

			set @salida=dbo.F_NETO_OVER(@idplan)					
			if ((@salida-@val)<0 ) break

			set @idconp = '2000' + replicate('0', 2 - len(convert(char(2),@it) )) +convert(char(2),@it) 	
			
			insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto ,especial)
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
				 @OBSERVACION_6 ='PLANILLA TRIPULANTES'

			update plan_conc_desc set nro_pago=@mx where codi_prin=@idaux

			Set @it= @it + 1		
			
	/*		if(@aplicatodo='1')	-------------------Aplica juicio a CTS
			begin
				set @mont=0
				set @val=0
				set @val2=0
				if (@tipo='0') 
				begin
					set @val= round(@cts * @montdesc/100,2)
					set @mont= @montdesc
				end 
				if (@tipo='1') set @val= round(@montdesc,2)
				if (@mon='02') set @val= @val * @tpc
					if(@inte_tiem='M' ) set @val= @val/4
				if(@inte_tiem='Q' ) set @val= @val/2
	
				--set @salida=dbo.F_NETO_OVER(@idplan)					
			--	if ((@CTS- @val)<0 ) break
					
				set @idconp = '302' + replicate('0', 3 - len(convert(char(3),@itcts) )) +convert(char(3),@itcts) 	
				
				insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto ,especial)
				values(@idplan,@idconp,'0',@val,@mont , @val2)
	
			--	select @mx=max(codi_prin) from plan_conc_desc
			--	if (@mx is null)	set @mx=0
			--	set @mx= @mx + 1	
			--	set @idaux = replicate('0', 10 - len(convert(char(10),@mx) )) +convert(char(10),@mx) 				
	
			--	Exec sp_insert_PLAN_CONC_DESC
			--	  @CODI_PRIN = @idaux,
			--	  @CODI_PLAN_CONC 	=@idplan,
			--	 @CODI_CONC 	=@idconp,
			--	 @CODI_DESC 	= @codjuicio,
			--	 @NRO_PAGO  = 0,
			--	 @CODI_TIPO_TRAB='03',
			--	 @INDI_TIPO_DESC = 'J',
			--	 @VALOR =@val
				
			--	select @mx=Max(cast(nro_pago as numeric))  from pagos_juicios where codi_juic=@codjuicio
			--	if (@mx is null)	set @mx=0
			--	set @mx= @mx + 1	
			--	set @idconp= CONVERT(char(4), @mx)
			--	Exec sp_insert_PAGOS_JUICIOS
			--		@CODI_JUIC_1 = @codjuicio,
			--		 @NRO_PAGO_2 = @idconp,
			--		 @FECH_PAGO_3 =@fecha,
			--		 @CODI_MONE_4  ='01',
			--		 @MONTO_5 	=@val,
			--		 @OBSERVACION_6 ='PLANILLA TRIPULANTES DESC JUIC CTS'
	
				--update plan_conc_desc set nro_pago=@mx where codi_prin=@idaux
				set @desccts= @desccts + @val
				Set @itcts= @itcts + 1		
			end */ 


			fetch Cjui into @codjuicio, @mon,@montdesc, @tipo, @inte_tiem, @aplicatodo
		end
		close Cjui
		deallocate cjui


		Declare @Sal numeric(12,2)	
		Declare @Saldo numeric(12,2)	
		Declare @aux numeric(12,2)
			
--insercion de prestamos empresa
		set @saldo=0
		Declare CPresE cursor for select codi_pres,codi_mone, mont_desc,tipo_desc, inte_tiem_desc,saldo from prestamos where codi_pers=@persona and esta_acti='1'
			and codi_tipo_pres='01' AND SALDO>0 --and fech_pres <=  @fecha 
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
				set @val= round(@participa * @montdesc/100,2)
--				set @val2= round(@totalafec2 * @montdesc/100,2)
				set @mont=@montdesc
			end
			if (@tipo='1') set @val= round(@montdesc,2)
--			if (@tipo='1') set @val2= round(@montdesc,2)
			
			if (@mon='02') 
			begin
				set @val= @val * @tpc
--				set @val2= @val2 * @tpc
				set @saldo =@saldo * @tpc

			end

			if(@inte_tiem='M' ) set @val= @val/4
			if(@inte_tiem='Q' ) set @val= @val/2

			Set @val2=@val
			if(@val > @saldo) set @val= @saldo

			set @salida=dbo.F_NETO_OVER(@idplan)					
			if ((@salida-@val)<0 ) break

			set @idconp = '2000' + replicate('0', 2 - len(convert(char(2),@it) )) +convert(char(2),@it) 	
			
			insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto, especial)
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
				 @OBSERVACION_7 ='PLANILLA TRIPULANTES'

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
			and codi_tipo_pres='02'  AND SALDO>0  ---and fech_pres <=  @fecha 
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
				set @val= round(@participa * @montdesc/100,2)
--				set @val2= round(@totalafec2 * @montdesc/100,2)
				set @mont=@montdesc
			end
			if (@tipo='1') set @val= round(@montdesc,2)
--			if (@tipo='1') set @val2= round(@montdesc,2)
			
			if (@mon='02') 
			begin
				set @val= @val * @tpc
--				set @val2= @val2 * @tpc
				set @saldo= @saldo * @tpc
			end
			Set @val2=@val

			if(@inte_tiem='M' ) set @val= @val/4
			if(@inte_tiem='Q' ) set @val= @val/2

			if(@val > @saldo) set @val= @saldo
			set @salida=dbo.F_NETO_OVER(@idplan)					
			if ((@salida-@val)<0 ) break

			set @idconp = '2000' + replicate('0', 2 - len(convert(char(2),@it) )) +convert(char(2),@it) 	
			
			insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto, especial)
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
				 @OBSERVACION_7 ='PLANILLA TRIPULANTES'

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

--insercion de otros prestamos
		set @saldo=0
		Declare CPresB Cursor for select codi_pres,codi_mone, mont_desc,tipo_desc, inte_tiem_desc,saldo from prestamos where codi_pers=@persona and esta_acti='1'
			and codi_tipo_pres='05' AND SALDO>0  ---and fech_pres <=  @fecha 
		open CPresB
		fetch CpresB into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo
		set @it=127
		WHILE @@FETCH_STATUS = 0
		begin	
			set @mont=0
			set @val=0
			set @val2=0

			if (@tipo='0') 
			begin
				set @val= round(@participa * @montdesc/100,2)
--				set @val2= round(@totalafec2 * @montdesc/100,2)
				set @mont=@montdesc
			end
			if (@tipo='1') set @val= round(@montdesc,2)
--			if (@tipo='1') set @val2= round(@montdesc,2)
			
			if (@mon='02') 
			begin
				set @val= @val * @tpc
--				set @val2= @val2 * @tpc
				set @saldo= @saldo * @tpc
			end
			Set @val2=@val


			if(@inte_tiem='M' ) set @val= @val/4
			if(@inte_tiem='Q' ) set @val= @val/2

			if(@val > @saldo) set @val= @saldo
			set @salida=dbo.F_NETO_OVER(@idplan)					
			if ((@salida-@val)<0 ) break

			set @idconp = '200' + replicate('0', 3 - len(convert(char(3),@it) )) +convert(char(3),@it) 	
			
			insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto, especial)
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
				 @OBSERVACION_7 ='PLANILLA TRIPULANTES'

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


--insercion de bazar
		declare @CONCBAZ char(7)
		set @saldo=0
		Declare CPresB Cursor for select codi_pres,codi_mone, mont_desc,tipo_desc, inte_tiem_desc,saldo , codi_baza from prestamos where codi_pers=@persona and esta_acti='1'
			and codi_tipo_pres='03' AND SALDO>0  ---and fech_pres <=  @fecha 
		open CPresB
		fetch CpresB into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo, @concbaz
		set @it=21
		WHILE @@FETCH_STATUS = 0
		begin	
			set @mont=0
			set @val=0
			set @val2=0

			if (@tipo='0') 
			begin
				set @val= round((@participa - @descobl) * @montdesc/100,2)
---				set @val2= round((@totalafec2 - @descobl2) * @montdesc/100,2)
				set @mont= @montdesc
			end 
			if (@tipo='1') set @val= round(@montdesc,2)
--			if (@tipo='1') set @val2= round(@montdesc,2)

			if (@mon='02') set @val= @val * @tpc
--			if (@mon='02') set @val2= @val2 * @tpc

			Set @val2=@val

			if (@mon='02') 
			begin
				set @val= @val * @tpc
--				set @val2= @val2 * @tpc
				set @saldo= @saldo * @tpc
			end
			Set @val2=@val

			if(@inte_tiem='M' ) set @val= @val/4
			if(@inte_tiem='Q' ) set @val= @val/2

			if(@val > @saldo) set @val= @saldo
			set @salida=dbo.F_NETO_OVER(@idplan)					
			if ((@salida-@val)<0 ) break
				
--			set @idconp = '2001' + replicate('0', 2 - len(convert(char(2),@it) )) +convert(char(2),@it) 	
			select 	@idconp=codi_conc from bazar where codi_baza= @concbaz

			insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto, especial)
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
				 @OBSERVACION_7 ='PLANILLA TRIPULANTES'

			update plan_conc_desc set nro_pago=@mx where codi_prin=@idaux

			set @aux=@val
			if (@mon='02') set @aux=round(@val/@tpc,2)
			
			update prestamos set saldo=(saldo - @aux) where codi_pres=@codjuicio
			select @sal =saldo from prestamos where codi_pres=@codjuicio
			if(@sal<=0)   update prestamos set esta_acti='0' where codi_pres=@codjuicio
			Set @it= @it + 1

			fetch CpresB into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo, @concbaz
		end
		close CpresB
		deallocate CpresB



--insercion adelantos 

		set @saldo=0
		Declare CAde cursor for select codi_adel,codi_mone_adel, mont_pago, inte_tiem_desc,saldo  from adelantos where codi_pers=@persona and esta_pago='0'
			and fech_adel <= @fecha and saldo>0
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

			if(@inte_tiem='M' ) set @val= @val/4
			if(@inte_tiem='Q' ) set @val= @val/2

			if(@val > @saldo) set @val= @saldo
			set @salida=dbo.F_NETO_OVER(@idplan)					
			if ((@salida-@val)<0 ) break
				
			set @idconp = '2000' + replicate('0', 2 - len(convert(char(2),@it) )) +convert(char(2),@it) 	
			
			insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto, especial)
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
				 @OBSERVACION ='PLANILLA TRIPULANTES'

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
		select @totdesc=sum(valor) , @totdesc2=sum(especial)  from planilla_tripulante_conceptos where
			codi_plan_trip=@idplan and left(codi_conc,1)='2'
		insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto, especial)
		values(@idplan,'299999','0',@totdesc,0, @totdesc2)

--insertar neto a pagar
		set @netopagar= ISNULL( @total , 0) - ISNULL( @totdesc, 0)
		set @netopagar2= ISNULL(@total2, 0) - ISNULL(@totdesc2, 0)
		insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto, especial)
		values(@idplan,'999990','0',@netopagar,0, @netopagar2)

--se actualiza el importe del tripulante
		update planilla_de_tripulantes set importe=@netopagar where codi_plan_trip =@idplan

	----------- insertar aportaciones

		set @codivalo=''
		Declare C1 cursor for select codi_conc, codi_valo_unit, afecto from conceptos_afectos_planillas where codi_tipo_plan='08' and esta_acti='1'
				and codi_conc<>'399999' and left(codi_conc,1) ='3'  AND NOT (CODI_VALO_UNIT IS NULL)
		open C1
		fetch C1 into @CconcP, @codivalo,@afec
		WHILE @@FETCH_STATUS = 0
		begin	

			set @afec='0'
			set @val=0
			set @mont=0
	
			select @mont= valor, @tipo =tipo_valo  from valores_unitarios_anuales where codi_valo_unit=@codivalo
				and fech_asig<= @fecha and fech_asig_fin >= @fecha
			if (@tipo='0') 
			begin
				---IF (@cconcP='301052' ) set @val= round(@participa*1.1666*@mont/100,2) 
				IF (@cconcP='301052' ) set @val= @CTS - @DEScCTs
				else set @val= round(@part1 * @mont/100,2)  + round(@part2 * @mont/100,2)  -- set @val= round(@participa * @mont/100,2)
				
			end

			if (@tipo='1') set @val= round( @mont,2)
	
			insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto)
			values(@idplan,@CconcP,@afec,@val,@mont )
			
			set @codivalo=0
			fetch C1 into @CconcP, @codivalo,@afec
		end
		close C1		
		deallocate c1

	-------------------------------------------------------------------------------------------------------
--insertar total aportaciones
		select @totalaport=sum(valor)  from planilla_tripulante_conceptos where
			codi_plan_trip =@idplan and left(codi_conc,1)='3'

		insert into planilla_tripulante_conceptos (codi_plan_trip, codi_conc, afecto, valor,monto)
		values(@idplan,'399999','0',@totalaport,0)
	
		fetch C2 into @persona
	end
	close C2
	deallocate c2

	
End
GO
