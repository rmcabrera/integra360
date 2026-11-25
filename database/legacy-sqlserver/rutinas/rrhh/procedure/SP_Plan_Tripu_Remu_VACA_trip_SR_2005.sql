CREATE PROCEDURE [dbo].[SP_Plan_Tripu_Remu_VACA_trip_SR_2005]
	@semanai [char](8),
	@semanaf [char](8),
	@anio [char](4),
	@mes [char](6),
	@MES_CALc [char](2)
WITH EXECUTE AS CALLER
AS
Begin
	Declare @per char(5)
	Declare @car char(4)
	declare @net numeric(12,3)
	declare @netbt numeric(12,3)
	declare @netbm numeric(12,3)
	declare @grati numeric(12,3)
	declare @grati2 numeric(12,3)
	declare @porc_dist numeric(12,3)
	declare @p varchar(70)
	declare @sem char(8)
	declare @sema char(8)
	Declare @emb char(5)
	Declare @nro_sema smallint
	Declare @inic varchar(10)
	DECLARE @tota_ingr numeric(12,3)
	DECLARE @tota_ingrB numeric(12,3)
	DECLARE @tota_ingrC numeric(12,3)
	DECLARE @dev5ta numeric(12,3)

	DECLARE @rent_quin numeric(12,3)
	DECLARE @juic numeric(12,3)
	DECLARE @mont_juic numeric(12,3)
	DECLARE @tipo_juic smallint
	DECLARE @cont1 smallint
	declare @cont_juic integer
	declare @tota_juic numeric(12,3)
	declare @tota_desc numeric(12,3)
	declare @codi_juic char (10)
	declare @tota_grat numeric(12,3)
	DECLARE @NA CHAR(1)
	declare @mesi char (2)
	declare @mesf char (2)

	Select @inic = inicial from empresa
	
	Select @mesi = right(aniomes,2) from semana where codi_sema = @semanai;
	Select @mesf = right(aniomes,2) from semana where codi_sema = @semanaf;

--	print @mesi
--	print @mesf
	Delete from DETA_INGR_GRAT_TRIP 
	where codi_Sema >= @semanai and codi_Sema <= @semanaf AND CODI_tipo_plan = '03' and mes = @mes_calc

	create Table #Temporal (indi char(1) null ,codi_pers char(5) null , codi_carg char(4) null, tota_ingr numeric(12,3)  null , persona varchar(70) null , semana char(8) null, embar char(5) null,
			nro_sema smallint null, porc_part decimal( 12,3 ) null, tota_grat numeric(12,3)  null , anio char(4) null , MES_CALC Char(2) null )	
--	if @inic <> 'JCR' 
--	begin
		Declare C1 cursor for select codi_pers, codi_carg , codi_sema, codi_unid_oper--, NRO_ASIS
		 from asistencia_tripulantes_pesca where codi_sema >= @semanai and codi_sema <= @semanaf --and mesanio = @anio + @mes_calc --and codi_pers = @per 
/*	end
	else
	begin
		Declare C1 cursor for select codi_pers, codi_carg , codi_sema, codi_unid_oper--, NRO_ASIS 
		from asistencia_tripulantes_pesca 
		where ( (codi_sema >= @semanai and codi_sema <= @semanaf  ) and codi_sema <> '00000097' and codi_sema <> '00000098')
		and left( mesanio, 4) = @anio
	end*/
	open C1
	fetch C1 into @per, @car, @sem, @emb--, @NA
	WHILE @@FETCH_STATUS = 0
	begin	
		set @net=0
		set @p= null
		select @p=apel_1+ ' ' + apel_2 + ' ' +nomb_1 + ' ' + isnull(nomb_2 , '') from personal where codi_pers=@per
		select @net= ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_pers=@per and planilla_de_tripulantes.codi_unid_oper=@emb and planilla_de_tripulantes.codi_sema=@sem
			and planilla_tripulante_conceptos.codi_conc='199999'  and mesanio = @anio + @mes_calc  --and nro_asis=@na
		select @netbt = ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from Planilla_Boni_tripu, Planilla_BoniTri_Conceptos
			where Planilla_Boni_tripu.codi_plan_btri = Planilla_BoniTri_Conceptos.codi_plan_btri
			and Planilla_Boni_tripu.codi_pers=@per and Planilla_Boni_tripu.codi_unid_oper=@emb and Planilla_Boni_tripu.codi_sema=@sem
			and Planilla_BoniTri_Conceptos.codi_conc='199999'  and mesanio = @anio + @mes_calc 
/*		if @netbt > 0
		begin
			print @per	
			print @netbt	
		end */
		--and nro_asis=@na
--		select @netbm = ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from Planilla_Boni_moto, Planilla_Boni_Concepto where Planilla_Boni_moto.codi_plan_boni = Planilla_Boni_Concepto.codi_plan_boni
--			and Planilla_Boni_moto.codi_pers=@per and Planilla_Boni_moto.codi_unid_oper=@emb and Planilla_Boni_moto.mesanio=@sem
--			and Planilla_Boni_Concepto.codi_conc='199998' --and nro_asis=@na
		select @dev5ta= ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_pers=@per and planilla_de_tripulantes.codi_unid_oper=@emb and planilla_de_tripulantes.codi_sema=@sem
			and ( planilla_tripulante_conceptos.codi_conc='100090' OR planilla_tripulante_conceptos.codi_conc='100070') and mesanio = @anio + @mes_calc  --and nro_asis=@na
		select @grati = ISNULL( SUM( ISNULL( valor , 0 ) ) , 0 )  from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_pers=@per and planilla_de_tripulantes.codi_unid_oper=@emb and planilla_de_tripulantes.codi_sema=@sem
			and planilla_tripulante_conceptos.codi_conc='101901' and mesanio = @anio + @mes_calc  -- and nro_asis=@na

		select @grati2 =  ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from Planilla_Boni_tripu, Planilla_BoniTri_Conceptos
			where Planilla_Boni_tripu.codi_plan_btri = Planilla_BoniTri_Conceptos.codi_plan_btri
			and Planilla_Boni_tripu.codi_pers=@per and Planilla_Boni_tripu.codi_unid_oper=@emb and Planilla_Boni_tripu.codi_sema=@sem
			and Planilla_BoniTri_Conceptos.codi_conc='101901' 

		select @porc_dist = isnull( max( isnull( porc_distr , 22.4 ) ) , 22.4 ) from planilla_pesca_tripulantes where codi_pers=@per and codi_unid_oper=@emb 
			and codi_sema=@sem 
		Select @nro_sema = nro_sema from semana where codi_sema = @sem
		set @tota_grat = @tota_grat + isnull( @grati , 0 ) 
/*		insert into #temporal(indi, codi_pers, codi_carg, tota_ingr, persona, semana, embar, nro_sema, porc_part, tota_grat, anio ) 
		values ( '1', @per, @car, @net, @p, @sem , @emb, @nro_sema, @porc_dist, @grati, @anio) */

		insert into DETA_INGR_GRAT_TRIP (codi_sema, anio, codi_pers, codi_carg, codi_unid_oper, grati, importe, porc_part, nro_sema, codi_tipo_plan, mesanio_prov, Codi_plan_orig, mes ) 
		values ( @sem, @ANIO, @per, @car, @emb, @grati + @grati2, @NET + @netbt - @dev5ta, @porc_dist, @nro_sema , '03', @mes, '08', @mes_calc)
				
		fetch C1 into @per, @car ,@sem, @emb--, @NA
	end 
	close C1
	deallocate C1
	
	Declare Cbm1 cursor for select codi_pers, mesanio, codi_unid_oper
		 from PLANILLA_BONI_MOTO where left( mesanio , 2 ) >= @mesi  and left( mesanio , 2 ) <= @mesf
			and right( mesanio, 4) = @anio and left(mesanio, 2) = @mes_calc  --and codi_pers = @per
	open Cbm1
	fetch Cbm1 into @per, @sem, @emb
	WHILE @@FETCH_STATUS = 0
	begin	
		set @net=0
		set @p= null
		select @p=apel_1+ ' ' + apel_2 + ' ' +nomb_1 + ' ' + isnull(nomb_2 , '') , @car = codi_carg from personal where codi_pers=@per
		
		select @netbm = ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from Planilla_Boni_moto, Planilla_Boni_Concepto where Planilla_Boni_moto.codi_plan_boni = Planilla_Boni_Concepto.codi_plan_boni
			and Planilla_Boni_moto.codi_pers=@per and Planilla_Boni_moto.codi_unid_oper=@emb and Planilla_Boni_moto.mesanio=@sem
			and Planilla_Boni_Concepto.codi_conc='199999'  and Planilla_Boni_moto.tipo = 'M' --and nro_asis=@na

		select @grati = ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from Planilla_Boni_moto, Planilla_Boni_Concepto where Planilla_Boni_moto.codi_plan_boni = Planilla_Boni_Concepto.codi_plan_boni
			and Planilla_Boni_moto.codi_pers=@per and Planilla_Boni_moto.codi_unid_oper=@emb and Planilla_Boni_moto.mesanio=@sem
			and Planilla_Boni_Concepto.codi_conc='101901'  and Planilla_Boni_moto.tipo = 'M' --and nro_asis=@na
		set @sem = rtrim( ltrim( @sem ) )
		set @nro_sema = cast( left( @sem , 2 ) as char )
/*		print @per
		print @nro_sema
		print @sem
		print substring( @sem ,3, 4 )
		print left( @sem , 2 )
*/
		set @tota_grat = @tota_grat + isnull( @grati , 0 ) 		
		Select @sema = min(codi_sema ) from semana where left(aniomes ,4) = substring( @sem ,3, 4 ) and right(aniomes ,2) = left( @sem , 2 );		
		Select @cont1 = count(codi_sema) from DETA_INGR_GRAT_TRIP 
		where codi_sema = @sema and codi_pers = @per and anio = @anio and codi_tipo_plan = '03';
--		print @cont1
--		print @sema
/*		if @cont1 >= 1 
		begin
			update dgt
			set grati = grati + @grati , importe = importe + @netbm
			from DETA_INGR_GRAT_TRIP  dgt
			where codi_sema = @sema and codi_pers = @per and anio = @anio and codi_tipo_plan = '03';
		end
		else
		begin*/
			select @porc_dist = isnull( max( isnull( porc_distr , 18 ) ) , 18 ) from planilla_pesca_tripulantes where codi_pers=@per and codi_unid_oper=@emb 
				and codi_sema=@sema
			insert into DETA_INGR_GRAT_TRIP (CODI_sEMA, ANIO, codi_pers, codi_carg, CODI_UNID_OPER, GRATI, IMPORTE, porc_part, nro_sema, CODI_TIPO_PLAN, mesanio_prov , Codi_plan_orig, mes) 
			values ( @sema, @ANIO, @per, @car, @emb, @grati, @netbm, @porc_dist, @nro_sema , '03', @mes, '14', @mes_calc)
--		end
				
		fetch Cbm1 into @per, @sem, @emb--, @NA
	end 
	close Cbm1
	deallocate Cbm1
	
	set @net = 0

	delete from GRAT_TRIP_DETA_CONC
	where codi_sema_inic = @semanai and codi_sema_fin = @semanaf and anio = @anio AND CODI_tipo_plan = '03' and mes = @mes_calc --and codi_pers = @PER;

	Declare curs_carg_conc
	Cursor for
	Select distinct codi_pers from DETA_INGR_GRAT_TRIP
	where codi_Sema >= @semanai and codi_Sema <= @semanaf and codi_tipo_plan = '03' and mes = @mes_calc--and codi_pers = @per;
	open curs_carg_conc;
	fetch curs_carg_conc into @per
	WHILE @@FETCH_STATUS = 0
	begin	
		Select @net = isnull(  sum( isnull( grati, 0 )  ) , 0 )  from DETA_INGR_GRAT_TRIP
		where codi_Sema >= @semanai and codi_Sema <= @semanaf and anio = @anio and codi_pers = @per AND CODI_tipo_plan = '03' and mes = @mes_calc;
		
		/*select @tota_ingr = isnull( sum ( isnull( valor , 0 ) ) , 0 ) from planilla_de_tripulantes, planilla_tripulante_conceptos 
		where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_pers=@per and left ( planilla_de_tripulantes.mesanio , 4 ) = @anio
			and planilla_tripulante_conceptos.codi_conc='199998' 
		select @tota_ingrB = isnull( sum ( isnull( valor , 0 ) ) , 0 ) from planilla_BONI_MOTO, PLANILLA_BONI_CONCEPTO
		where planilla_BONI_MOTO.codi_plan_BONI = PLANILLA_BONI_CONCEPTO.codi_plan_BONI
			and planilla_BONI_MOTO.codi_pers=@per and RIGHT ( planilla_BONI_MOTO.mesanio , 4 ) = @anio
			and PLANILLA_BONI_CONCEPTO.codi_conc='199998' 
		select @tota_ingrC = isnull( sum ( isnull( valor , 0 ) ) , 0 ) from Planilla_Boni_tripu , Pt,Planilla_BoniTri_Conceptos  
		where Planilla_Boni_tripu.codi_plan_Btri= Planilla_BoniTri_Conceptos.codi_plan_Btri
			and Planilla_Boni_tripu.codi_pers=@per and left ( Planilla_Boni_tripu.mesanio , 4 ) = @anio
			and Planilla_BoniTri_Conceptos.codi_conc='199998' */


		SET @tota_ingr = 0 -- ISNULL( @tota_ingr , 0 ) + ISNULL( @tota_ingrB , 0 ) + ISNULL( @tota_ingrC , 0 )
		Insert into GRAT_TRIP_DETA_CONC ( codi_pers, codi_sema_inic, codi_sema_fin, anio, codi_conc, monto, valor, codi_tipo_plan , mesanio_prov, mes)
		Values ( @per, @semanai, @semanaf, @anio, '199998',0,  @net , '03', @mes, @mes_calc)
		SET @tota_ingr = isnull( @tota_ingr, 0 ) 
		
		/*SET @rent_quin = 0
		if @tota_ingr > 21700 
		begin
			set @rent_quin = isnull( @net * 0.15 , 0 ) 
			set @rent_quin = isnull(  @rent_quin  , 0 ) 
			if @rent_quin > 0 
			begin
				Insert into GRAT_TRIP_DETA_CONC ( codi_pers, codi_sema_inic, codi_sema_fin, anio, codi_conc, monto, valor, CODI_TIPO_PLAN , mesanio_prov )
				Values ( @per, @semanai, @semanaf, @anio, '200040', 15,  isnull( @rent_quin , 0 ), '03' , @mes)
			end
		end*/
		set @cont_juic = 0
		set @tota_juic = 0
		set @tota_DESC = 0
		/*if @net > 0
		BEGIN
			Declare curs_carg_juic cursor for 
			Select  codi_juic, mont_desc, tipo_Desc from juicios
			where codi_pers = @per and esta_acti = 1;
			Open curs_carg_juic ;
			Fetch curs_carg_juic into @codi_juic, @mont_juic, @tipo_juic;
			WHILE @@FETCH_STATUS = 0
			begin
				--print @per
				--print @mont_juic
				--print @tipo_juic 
				set @cont_juic = @cont_juic  + 1
				if @tipo_juic = 0 
				begin
					set @juic = isnull( ( @net - @rent_quin ) * @mont_juic / 100 , 0 ) 
					--SET @mont_juic = @mont_juic / 100
				end
				else
				begin
					set @juic = isnull(  @mont_juic , 0 ) 
					SET @mont_juic = 0
				end				
				if @juic > 0 
				begin
					set @tota_juic = ISNULL( @tota_juic , 0 ) + ISNULL( @juic, 0 ) 
					Insert into GRAT_TRIP_DETA_CONC ( codi_pers, codi_sema_inic, codi_sema_fin, anio, codi_conc, monto, valor , CODI_tipo_plan, mesanio_prov )
					Values ( @per, @semanai, @semanaf, @anio, '20001' + cast( @cont_juic as char (1) ) , @mont_juic,  @juic , '03', @mes)
				end			
				Fetch curs_carg_juic into @codi_juic, @mont_juic, @tipo_juic;		
			end
			close curs_carg_juic;
			deallocate curs_carg_juic;
		END 
		set @tota_juic = isnull(  @tota_juic , 0 ) 
		set @tota_desc = @rent_quin  + @tota_juic
		set @tota_desc = isnull(  @tota_desc  , 0 ) 
		Insert into GRAT_TRIP_DETA_CONC ( codi_pers, codi_sema_inic, codi_sema_fin, anio, codi_conc, monto, valor , codi_tipo_plan, mesanio_prov)
		Values ( @per, @semanai, @semanaf, @anio, '299999' , 0 ,  @tota_desc , '03', @mes)
		*/
		
		Insert into GRAT_TRIP_DETA_CONC ( codi_pers, codi_sema_inic, codi_sema_fin, anio, codi_conc, monto, valor , codi_tipo_plan, mesanio_prov, mes)
		Values ( @per, @semanai, @semanaf, @anio, '999990' , 0 ,  isnull( @net , 0 ) - isnull( @tota_desc , 0 ) , '03', @mes, @mes_calc)

		fetch curs_carg_conc into @per
	end
	Close curs_carg_conc ;
	deallocate curs_carg_conc ;
	select * from DETA_INGR_GRAT_TRIP WHERE  ANIO = @ANIO and codi_tipo_plan = '03' and mes = @mes_calc
	order by codi_pers, codi_Sema
	select * from GRAT_TRIP_DETA_CONC WHERE ANIO = @ANIO and codi_tipo_plan = '03' and mes = @mes_calc
	order by codi_pers, codi_Sema_inic, codi_conc

End
GO
