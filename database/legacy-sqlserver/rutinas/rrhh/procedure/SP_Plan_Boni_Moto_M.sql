CREATE PROCEDURE [dbo].[SP_Plan_Boni_Moto_M]
	@embar [char](5),
	@mesa [char](6),
	@fecha [datetime],
	@soles [numeric](12, 2)
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
	Declare @tipo char(1)
	Declare @dd numeric(2)
	Declare @ns numeric(2)
	Declare @CconcP  char(6)
	declare @codivalo CHAR(2)
	Declare @Vvac numeric(12,2) ---------valor de vacaciones
	Declare @tAFEC numeric(12,2) ---------valor de vacaciones
	declare @sindic char(2)
	Declare @Tpc2 numeric(12,3)
	Declare @Tpc numeric(12,3)
	DEclare @CTS numeric(12,2)

	Select 	@tpc2=venta from tipo_cambio_a_dolar where codi_mone_orig='01' and convert( char(10) , fech_camb, 103)= convert( char(10) , @fecha, 103)
	Select 	@tpc=venta from tipo_cambio_a_dolar where codi_mone_orig='01' and convert( char(10) , fech_camb, 103)= convert( char(10) , @fecha, 103)


	Declare C2 cursor for select codi_pers , dias_traba_mens, codi_carg from asistencia_motorista where codi_unid_oper=@embar and mesanio=@mesa
	open C2
	fetch C2 into @persona, @dd, @car
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
		set @idplan = 'M'+ replicate('0', 9 - len(convert(char(10),@mx) )) +convert(char(10),@mx) 
	--se crea los registro en planilla de tripulantes
		insert into planilla_boni_moto (codi_plan_boni,  mesanio, codi_unid_oper , codi_pers, importe,  form_pago, nro_cheque, tipo)
		values (@idplan, @mesa,  @embar, @persona,0,'TELE_CRED', '', 'M')

	-- se procede a la insercion de los conceptos
		set @afi='0'
		set @afec='0'
		set @val=0

	--calculamos el monto 
		declare @mensn numeric(12,2)
		declare @menst numeric(12,2)
		declare @ndias numeric(2)
		declare @ma1 varchar(10)
		declare @ma2 varchar(10)
		declare @nmes1 numeric(4)
		declare @nmes2 numeric(2)
		DECLARE @CODMON CHAR(2)
		if (@car<>'1108' and @car<>'1101')
		begin
			select @mensn= suel_basi, @CODMON = CODI_MONE_BASI  from personal where codi_pers=@persona
			IF (@CODMON='02') 	SET @MENSN=@MENSN*@TPC2
		
			if ( (month(@fecha)+1) <=12) 
			begin
				set @nmes2= convert(numeric(2) ,LEFT(@mesa,2)) +1
				set @ma1= '01/'+LEFT(@mesa,2)+'/'+RIGHT(@mesa,4)
				set @ma2= '01/'+replicate('0', 2 - len(convert(varchar(2),@nmes2) )) +convert(varchar(2),@nmes2) +'/'+RIGHT(@mesa,4)
				set @ndias= DATEDIFF ( d , convert (datetime, @ma1), convert (datetime, @ma2) ) 				
			end
			else
			begin
				set @nmes1= convert(numeric(4) , RIGHT(@mesa,4)) +1
				set @ma1= '01/'+LEFT(@mesa,2)+'/'+RIGHT(@mesa,4)
				set @ma2= '01/01/'+convert(varchar(4),@nmes1) 
				set @ndias= DATEDIFF ( d , convert (datetime, @ma1),  convert (datetime, @ma2) ) 						
			end
			set @val= @mensn*@dd/30
		end 

--		print @dd
--		print @val
--		print @ma1
--		print @ma2
--		print @ndias
--		print @car

		if (@car='1101' )		
		begin
			select @menst= sum(pesc_real) from 
				(select codi_unid_oper,pesc_real from zarpes where codi_unid_oper=@embar and
					month(fech_desc)=month(@fecha) and year(fech_desc)=year(@fecha) and (codi_unid_oper in (select codi_unid_oper 
					from asistencia_tripulantes_pesca where codi_pers=@persona and mesanio=@mesa)
				AND CODI_sema in (select codi_sema from asistencia_tripulantes_pesca where codi_pers=@persona))
				and fech_desc in (select fech_inic
					from asistencia_tripulantes_pesca, semana 
					where semana.codi_sema=asistencia_tripulantes_pesca.codi_sema 
					and codi_unid_oper=@embar and codi_pers=@persona and jueves='1' and mesanio=(right(@mesa,4)+left(@mesa,2))
				union
				select fech_inic+1 
					from asistencia_tripulantes_pesca, semana 
					where semana.codi_sema=asistencia_tripulantes_pesca.codi_sema 
					and codi_unid_oper=@embar and codi_pers=@persona and viernes='1' and mesanio=(right(@mesa,4)+left(@mesa,2))
				union
				select fech_inic+2 
					from asistencia_tripulantes_pesca, semana 
					where semana.codi_sema=asistencia_tripulantes_pesca.codi_sema 
					and codi_unid_oper=@embar and codi_pers=@persona and sabado='1' and mesanio=(right(@mesa,4)+left(@mesa,2))
				union
				select fech_inic+3 
					from asistencia_tripulantes_pesca, semana 
					where semana.codi_sema=asistencia_tripulantes_pesca.codi_sema 
					and codi_unid_oper=@embar and codi_pers=@persona and domingo='1' and mesanio=(right(@mesa,4)+left(@mesa,2))
				union
				select fech_inic+4 
					from asistencia_tripulantes_pesca, semana 
					where semana.codi_sema=asistencia_tripulantes_pesca.codi_sema 
					and codi_unid_oper=@embar and codi_pers=@persona and lunes='1' and mesanio=(right(@mesa,4)+left(@mesa,2))
				union
				select fech_inic+5 
					from asistencia_tripulantes_pesca, semana 
					where semana.codi_sema=asistencia_tripulantes_pesca.codi_sema 
					and codi_unid_oper=@embar and codi_pers=@persona and martes='1' and mesanio=(right(@mesa,4)+left(@mesa,2))
				union
				select fech_term
					from asistencia_tripulantes_pesca, semana 
					where semana.codi_sema=asistencia_tripulantes_pesca.codi_sema 
					and codi_unid_oper=@embar and codi_pers=@persona and miercoles='1' and mesanio=(right(@mesa,4)+left(@mesa,2)))
				)as D group by codi_unid_oper;

		end	

		if (@car='1108' )	set @val= @soles*@dd

	--insertar bonif
		select @afec=afecto from conceptos_afectos_planillas where codi_tipo_plan='14' and codi_conc='100201' and esta_acti='1'
		insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
		values(@idplan,'100201',@afec,@val,0)

		set @total=@total + @val

		if (@afec='1') set @totalafec=@totalafec +@val

----------- insertar ingresos

		set @codivalo=''
		Declare C3 cursor for select codi_conc, codi_valo_unit, afecto from conceptos_afectos_planillas where codi_tipo_plan='14' and esta_acti='1'
				and not (codi_conc='199999' or codi_conc='199998'  or codi_conc='100201' ) and left(codi_conc,1) ='1' 
				AND NOT (CODI_VALO_UNIT IS NULL)
		open C3
		fetch C3 into @CconcP, @codivalo,@afec
		WHILE @@FETCH_STATUS = 0
		begin	

			set @val=0
			set @mont=0
	
			select @mont= valor, @tipo =tipo_valo  from valores_unitarios_anuales where codi_valo_unit=@codivalo
				and fech_asig<= @fecha and fech_asig_fin >= @fecha
	
			if (@tipo='0') set @val= round(@total * @mont/100,2)			
			if (@tipo='1') set @val= round( @mont,2)

			if (@afec='1') set @totalafec=@totalafec +@val
	
			insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
			values(@idplan,@CconcP,@afec,@val,@mont )
			
			set @codivalo=0
			fetch C3 into @CconcP, @codivalo,@afec
		end
		close C3		
		deallocate c3

	-------------------------------------------------------------------------------------------------------
	--insertar total ingresos

	--insertar total ingresos afectos
		insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
		values(@idplan,'199998','0',@totalafec,0)
	--insertar total ingresos
		insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
		values(@idplan,'199999','0',@total,0)

		set @CTS= round( (@total  + round(@total*16.66/100,2) ) * 8.33/100,2)

	--insertar pensiones 	
		set @afec='0'
		set @val=0
		set @mont=0

		select @mont= valor, @tipo =tipo_valo  from valores_unitarios_anuales where codi_valo_unit='18' 
			and fech_asig<= @fecha and fech_asig_fin >= @fecha
		select @afec=afecto from conceptos_afectos_planillas where codi_tipo_plan='14' and codi_conc='200101' and esta_acti='1'
		if (@tipo='0') set @val= round(@total * @mont/100,2)
		if (@tipo='1') set @val= round(@mont,2)


		insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
		values(@idplan,'200101',@afec,@val,@mont)

--selecciono la suma del neto de descuentos obligatorios
		Declare @Descobl numeric(12,2)

		select @descobl=sum(valor)   from planilla_boni_concepto where
			codi_plan_boni=@idplan and left(codi_conc,1)='2'
		if(@descobl is null) set @descobl=0

--insercion de juicios
		Declare @idconp char(6)		
		declare @salida numeric(12,2)		
		Declare @mon char(2)
		Declare @inte_tiem char(1)
		Declare @Codjuicio char(6)
		Declare @it numeric(3)
		Declare @montdesc numeric(12,2)
		Declare @idaux char(10)
		declare @SWW char(1)
		declare @RTC int
		declare @DescCTS numeric(12,2)
		declare @itcts int
		declare @aplicatodo char(1)
		Declare CJui cursor for select codi_juic,codi_mone, mont_desc, tipo_desc,inte_tiem_desc, apli_toda_remu  from juicios where codi_pers=@persona and esta_acti='1'
			and fech_juic<= @fecha -----AND inte_tiem_desc='M'
		open Cjui		
		fetch Cjui into @codjuicio, @mon,@montdesc ,@tipo, @inte_tiem, @aplicatodo
		set @it=11
 		set @itcts = 1
		set @descCts=0

		WHILE @@FETCH_STATUS = 0
		begin	
			set @mont=0
			set @val=0

			if (@tipo='0') 
			begin
				set @val= round((@total - @descobl) * @montdesc/100,2)
				set @mont= @montdesc
			end 
			if (@tipo='1') set @val= round(@montdesc,2)

			if (@mon='02') set @val= @val * @tpc
			
			if(@inte_tiem='S' and @tipo='1') set @val= @val*4
			if(@inte_tiem='Q' and @tipo='1') set @val= @val*2

			set @salida=dbo.F_NETO_OVER_B(@idplan)					
			if ((@salida-@val)<0 ) break
			
			set @SWW='1'
			set @it=11
			set  @RTC =0
			while (@SWW='1' )
			begin
			 	set @idconp = '2000' + replicate('0', 2 - len(convert(char(2),@it) )) +convert(char(2),@it) 	
 				select @rtc=count(codi_conc)  from planilla_boni_concepto where codi_plan_boni=@idplan and codi_conc=@idconp
				if ( @rtc is null ) set @rtc=0
				if ( @rtc =0 ) set @sww='0'
				Set @it= @it + 1		
			 end

			insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
			values(@idplan,@idconp,'0',@val,@mont )

			commit

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
				 @OBSERVACION_6 ='PLANILLA MOTORISTAS'

			update plan_conc_desc set nro_pago=@mx where codi_prin=@idaux

		/*	if ( @aplicatodo='1' )
			begin
				set @mont=0
				set @val=0
				if (@tipo='0') 
				begin
					set @val= round(@CTS*@montdesc/100,2)
					set @mont= @montdesc
				end 
				if (@tipo='1') set @val= round(@montdesc,2)
				if (@mon='02') set @val= @val * @tpc
				if(@inte_tiem='S' and @tipo='1') set @val= @val*4
				if(@inte_tiem='Q' and @tipo='1') set @val= @val*2
	
				---set @salida=dbo.F_NETO_OVER_B(@idplan)					
				--if ((@CTS- @val)<0 ) break
	
				set @idconp = '302' + replicate('0', 3 - len(convert(char(3),@itcts) )) +convert(char(3),@itcts) 	
				
				insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
				values(@idplan,@idconp,'0',@val,@mont )
	
				--select @mx=max(codi_prin) from plan_conc_desc
				--if (@mx is null)	set @mx=0
				--set @mx= @mx + 1	
				--set @idaux = replicate('0', 10 - len(convert(char(10),@mx) )) +convert(char(10),@mx) 				
	
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
			--		 @OBSERVACION_6 ='PLANILLA MOTORISTAS DESC JUIC CTS'
	
			--	update plan_conc_desc set nro_pago=@mx where codi_prin=@idaux

				Set  @descCTs= @descCts + @val
				Set @itcts= @itcts + 1		
			end */ 

			
			fetch Cjui into @codjuicio, @mon,@montdesc, @tipo, @inte_tiem, @aplicatodo		end
		close Cjui
		deallocate cjui

		Declare @Sal numeric(12,2)	
		Declare @Saldo numeric(12,2)	
		Declare @aux numeric(12,2)
			
--insercion de prestamos empresa
		set @saldo=0
		Declare CPresE cursor for select codi_pres,codi_mone, mont_desc,tipo_desc, inte_tiem_desc,saldo from prestamos where codi_pers=@persona and esta_acti='1'
			and codi_tipo_pres='01' and fech_pres <=  @fecha and saldo>0 ---------and inte_tiem_desc='M'
		open CPresE
		set @saldo=0
		fetch CpresE into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo
		
		WHILE @@FETCH_STATUS = 0
		begin	
			set @mont=0
			set @val=0
			if (@tipo='0') 
			begin
				set @val= round(@total * @montdesc/100,2)
				set @mont=@montdesc
			end
			if (@tipo='1') set @val= round(@montdesc,2)
			
			if (@mon='02') 
			begin
				set @val= @val * @tpc
				set @saldo =@saldo * @tpc
			end

			if(@inte_tiem='S' and @tipo='1') set @val= @val*4
			if(@inte_tiem='Q' and @tipo='1') set @val= @val*2

			if(@val > @saldo) set @val= @saldo

			set @salida=dbo.F_NETO_OVER_B(@idplan)					

			if ((@salida-@val)<0 ) break

			set @SWW='1'
			set @it=1
			set  @RTC =0
			while (@SWW='1')
			begin
 				set @idconp = '2000' + replicate('0', 2 - len(convert(char(2),@it) )) +convert(char(2),@it) 	
 				select @rtc=count(codi_conc)  from planilla_boni_concepto where codi_plan_boni=@idplan and codi_conc=@idconp
				if ( @rtc is null ) set @rtc=0
				if ( @rtc =0 ) set @sww='0'
				Set @it= @it + 1		
			 end
			
			insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
			values(@idplan,@idconp,'0',@val,@mont)

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
				 @OBSERVACION_7 ='PLANILLA MOTORISTAS'

			update plan_conc_desc set nro_pago=@mx where codi_prin=@idaux

			set @aux=@val
			if (@mon='02') set @aux=round(@val/@tpc,2)
			
			update prestamos set saldo=(saldo - @aux) where codi_pres=@codjuicio
			select @sal =saldo from prestamos where codi_pres=@codjuicio
			if(@sal<=0)   update prestamos set esta_acti='0' where codi_pres=@codjuicio
			fetch CpresE into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo
		end
		close CpresE
		deallocate CpresE


--insercion de creditos bancarios
		set @saldo=0
		Declare CPresB Cursor for select codi_pres,codi_mone, mont_desc,tipo_desc, inte_tiem_desc,saldo from prestamos where codi_pers=@persona and esta_acti='1'
			and codi_tipo_pres='02' and fech_pres <=  @fecha and saldo>0 ---------- and inte_tiem_desc='M'
		open CPresB
		fetch CpresB into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo
		set @it=91
		WHILE @@FETCH_STATUS = 0
		begin	
			set @mont=0
			set @val=0

			if (@tipo='0') 
			begin
				set @val= round(@total * @montdesc/100,2)
				set @mont=@montdesc
			end
			if (@tipo='1') set @val= round(@montdesc,2)
			
			if (@mon='02') 
			begin
				set @val= @val * @tpc
				set @saldo= @saldo * @tpc
			end

			if(@inte_tiem='S' and @tipo='1') set @val= @val*4
			if(@inte_tiem='Q' and @tipo='1') set @val= @val*2

			if(@val > @saldo) set @val= @saldo
				
			set @salida=dbo.F_NETO_OVER_B(@idplan)					

			if ((@salida-@val)<0 ) break

			set @SWW='1'
			set @it=91
			set  @RTC =0
			while (@SWW='1' )
			begin
 				set @idconp = '2000' + replicate('0', 2 - len(convert(char(2),@it) )) +convert(char(2),@it) 	
 				select @rtc=count(codi_conc)  from planilla_boni_concepto where codi_plan_boni=@idplan and codi_conc=@idconp
				if ( @rtc is null ) set @rtc=0
				if ( @rtc =0 ) set @sww='0'
				Set @it= @it + 1		
			 end	

			insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
			values(@idplan,@idconp,'0',@val,@mont)

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
				 @OBSERVACION_7 ='PLANILLA MOTORISTAS'

			update plan_conc_desc set nro_pago=@mx where codi_prin=@idaux

			set @aux=@val
			if (@mon='02') set @aux=round(@val/@tpc,2)
			
			update prestamos set saldo=(saldo - @aux) where codi_pres=@codjuicio
			select @sal =saldo from prestamos where codi_pres=@codjuicio
			if(@sal<=0)   update prestamos set esta_acti='0' where codi_pres=@codjuicio

			fetch CpresB into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo
		end
		close CpresB
		deallocate CpresB

--insercion de OTROS Prestamos
		set @saldo=0
		Declare CPresB Cursor for select codi_pres,codi_mone, mont_desc,tipo_desc, inte_tiem_desc,saldo from prestamos where codi_pers=@persona and esta_acti='1'
			and codi_tipo_pres='05' and fech_pres <=  @fecha and saldo>0 ---------- and inte_tiem_desc='M'
		open CPresB
		fetch CpresB into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo
		set @it=127
		WHILE @@FETCH_STATUS = 0
		begin	
			set @mont=0
			set @val=0

			if (@tipo='0') 
			begin
				set @val= round(@total * @montdesc/100,2)
				set @mont=@montdesc
			end
			if (@tipo='1') set @val= round(@montdesc,2)
			
			if (@mon='02') 
			begin
				set @val= @val * @tpc
				set @saldo= @saldo * @tpc
			end

			if(@inte_tiem='S' and @tipo='1') set @val= @val*4
			if(@inte_tiem='Q' and @tipo='1') set @val= @val*2

			if(@val > @saldo) set @val= @saldo

			set @salida=dbo.F_NETO_OVER_B(@idplan)					

			if ((@salida-@val)<0 ) break
				
			set @SWW='1'
			set @it=127
			set  @RTC =0
			while (@SWW='1' )
			begin
 				set @idconp = '200' + replicate('0', 3 - len(convert(char(3),@it) )) +convert(char(3),@it) 
 				select @rtc=count(codi_conc)  from planilla_boni_concepto where codi_plan_boni=@idplan and codi_conc=@idconp
				if ( @rtc is null ) set @rtc=0
				if ( @rtc =0 ) set @sww='0'
				Set @it= @it + 1		
			 end
			
			insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
			values(@idplan,@idconp,'0',@val,@mont)

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
				 @OBSERVACION_7 ='PLANILLA MOTORISTAS'

			update plan_conc_desc set nro_pago=@mx where codi_prin=@idaux

			set @aux=@val
			if (@mon='02') set @aux=round(@val/@tpc,2)
			
			update prestamos set saldo=(saldo - @aux) where codi_pres=@codjuicio
			select @sal =saldo from prestamos where codi_pres=@codjuicio
			if(@sal<=0)   update prestamos set esta_acti='0' where codi_pres=@codjuicio

			fetch CpresB into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo
		end
		close CpresB
		deallocate CpresB


--insercion de bazares
		DECLARE @BAZ CHAR(7)
		set @saldo=0
		Declare CPresB Cursor for select codi_pres,codi_mone, mont_desc,tipo_desc, inte_tiem_desc,saldo, codi_baza  from prestamos where codi_pers=@persona and esta_acti='1'
			and codi_tipo_pres='03' and fech_pres <=  @fecha and saldo>0 ---------- and inte_tiem_desc='M'
		open CPresB
		fetch CpresB into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo, @baz
		set @it=21
		WHILE @@FETCH_STATUS = 0
		begin	
			set @mont=0
			set @val=0

			if (@tipo='0') 
			begin
				set @val= round(@total * @montdesc/100,2)
				set @mont=@montdesc
			end
			if (@tipo='1') set @val= round(@montdesc,2)
			
			if (@mon='02') 
			begin
				set @val= @val * @tpc
				set @saldo= @saldo * @tpc
			end

			if(@inte_tiem='S' and @tipo='1') set @val= @val*4
			if(@inte_tiem='Q' and @tipo='1') set @val= @val*2

			if(@val > @saldo) set @val= @saldo
				

			set @salida=dbo.F_NETO_OVER_B(@idplan)					

			if ((@salida-@val)<0 ) break
--			set @idconp = '2001' + replicate('0', 2 - len(convert(char(2),@it) )) +convert(char(2),@it) 	
			select @idconp=codi_conc from bazar where codi_baza=@baz
			
			insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
			values(@idplan,@idconp,'0',@val,@mont)

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
				 @OBSERVACION_7 ='PLANILLA MOTORISTAS'

			update plan_conc_desc set nro_pago=@mx where codi_prin=@idaux

			set @aux=@val
			if (@mon='02') set @aux=round(@val/@tpc,2)
			
			update prestamos set saldo=(saldo - @aux) where codi_pres=@codjuicio
			select @sal =saldo from prestamos where codi_pres=@codjuicio
			if(@sal<=0)   update prestamos set esta_acti='0' where codi_pres=@codjuicio
			Set @it= @it + 1

			fetch CpresB into @codjuicio, @mon,@montdesc ,@tipo ,@inte_tiem, @saldo,@baz
		end
		close CpresB
		deallocate CpresB

--insercion adelantos 
		set @saldo=0
		Declare CAde cursor for select codi_adel,codi_mone_adel, mont_pago, inte_tiem_desc,saldo  from adelantos where codi_pers=@persona and esta_pago='0'
			and fech_adel <= @fecha and saldo>0 ----------and inte_tiem_desc='M'
		open CAde	
		fetch CAde into @codjuicio, @mon,@montdesc ,@inte_tiem, @saldo
		WHILE @@FETCH_STATUS = 0
		begin	
			set @mont=0
			set @val=0
			set @val= round(@montdesc,2)

			if (@mon='02') 
			begin
				set @val= @val * @tpc
				set @saldo = @saldo * @tpc
			end

			if(@inte_tiem='S' ) set @val= @val*4
			if(@inte_tiem='Q' ) set @val= @val*2

			if(@val > @saldo) set @val= @saldo

			set @salida=dbo.F_NETO_OVER_B(@idplan)					

			if ((@salida-@val)<0 ) break
				
			set @SWW='1'
			set @it=51
			set  @RTC =0
			while (@SWW='1' )
			begin
				set @idconp = '2000' + replicate('0', 2 - len(convert(char(2),@it) )) +convert(char(2),@it) 	
 				select @rtc=count(codi_conc)  from planilla_boni_concepto where codi_plan_boni=@idplan and codi_conc=@idconp
				if ( @rtc is null ) set @rtc=0
				if ( @rtc =0 ) set @sww='0'
				Set @it= @it + 1		
			 end
			
			insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
			values(@idplan,@idconp,'0',@val,@mont)

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
				 @OBSERVACION ='PLANILLA MOTORISTAS'

			update plan_conc_desc set nro_pago=@mx where codi_prin=@idaux

			set @aux=@val
			if (@mon='02') set @aux=round(@val/@tpc,2)
			
			update adelantos set saldo=(saldo - @aux) where codi_adel=@codjuicio
			select @sal =saldo from adelantos where codi_adel=@codjuicio
			if(@sal<=0)   update adelantos set esta_pago='1' where codi_adel=@codjuicio
	
			fetch CAde into @codjuicio, @mon,@montdesc ,@inte_tiem, @saldo
		end
		close CAde
		deallocate Cade



--insert total descuentos
		select @totdesc=sum(valor)   from planilla_BONI_concepto where
			codi_plan_boni=@idplan and left(codi_conc,1)='2'
		if (@totdesc is null) set @totdesc=0
		insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
		values(@idplan,'299999','0',@totdesc,0)

--insertar neto a pagar
		set @netopagar= @total  - @totdesc
		insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
		values(@idplan,'999990','0',@netopagar,0)

--se actualiza el importe del tripulante
		update planilla_boni_moto set importe=@netopagar where codi_plan_boni =@idplan and tipo='M'

	----------- insertar aportaciones

		set @codivalo=''
		Declare C1 cursor for select codi_conc, codi_valo_unit, afecto from conceptos_afectos_planillas where codi_tipo_plan='14' and esta_acti='1'
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
				--IF (@cconcP='301052' ) set @val= round(@total*1.1666 * @mont/100,2)
				IF (@cconcP='301052' ) set @val= @CTS - @descCTS

				else set @val= round(@total * @mont/100,2)
			end
			if (@tipo='1') set @val= round( @mont,2)
	
			insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
			values(@idplan,@CconcP,@afec,@val,@mont )
			
			set @codivalo=0
			fetch C1 into @CconcP, @codivalo,@afec
		end
		close C1		
		deallocate c1

	-------------------------------------------------------------------------------------------------------
--insertar total aportaciones
		select @totalaport=sum(valor)  from planilla_boni_concepto where
			codi_plan_boni =@idplan and left(codi_conc,1)='3'

		insert into planilla_boni_concepto (codi_plan_boni, codi_conc, afecto, valor,monto)
		values(@idplan,'399999','0',@totalaport,0)
	
		fetch C2 into @persona, @dd, @car
	end
	close C2
	deallocate c2

End
GO
