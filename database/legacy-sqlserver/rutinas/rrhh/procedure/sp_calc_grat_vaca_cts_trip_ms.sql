CREATE PROCEDURE [dbo].[sp_calc_grat_vaca_cts_trip_ms]
	@semanai [char](8),
	@semanaf [char](8),
	@anio [char](4),
	@mes [char](6),
	@mes_calc [char](2),
	@codi_pers [char](5),
	@Tipo_camb [decimal](9, 4),
	@indi_boni [int],
	@codi_tipo_plan [char](2),
	@tipo [char](1),
	@apli_juic [int]
WITH EXECUTE AS CALLER
AS
Begin
--Declarar Variables
	Declare @per char(5)
	Declare @car char(4)
	declare @net numeric(12,3)
	declare @netbt numeric(12,3)
	declare @netbm numeric(12,3)
	declare @grati numeric(12,3)
	declare @grati2 numeric(12,3)
	declare @vaca numeric(12,3)
	declare @vacabt numeric(12,3)
	declare @vacabm numeric(12,3)
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
	declare @tota_vaca numeric(12,3)
	declare @NA char(1)
	declare @mesi char (2)
	declare @mesf char (2)
	declare @codi_conc_juic char(6)
	Declare @codi_conc_inic char(8)
	Declare @codi_conc_fina char(8)
	Declare @unid_oper char(5)
	declare @tota_valo numeric(12,3)	
-- Fin Declarar Variables	
	Select @inic = inicial from empresa	
	Select @mesi = right(aniomes,2) from semana where codi_sema = @semanai;
	Select @mesf = right(aniomes,2) from semana where codi_sema = @semanaf;	
	if @codi_tipo_plan = '02' 
	BEGIN
		set @codi_conc_inic = '101902'
		set @codi_conc_fina = '101902'
	end
	if @codi_tipo_plan = '03' 
	BEGIN
		set @codi_conc_inic = '101901'
		set @codi_conc_fina = '101901'
	end
	if @codi_tipo_plan = '06' 
	BEGIN
		set @codi_conc_inic = '301052'
		set @codi_conc_fina = '301052'
	end
	if @tipo = 'S'	
	begin
		if ltrim(rtrim(@codi_pers )) = ''
		begin
			Delete from DETA_INGR_GRAT_TRIP 
			where codi_Sema >= @semanai and codi_Sema <= @semanaf AND codi_tipo_plan = @codi_tipo_plan and anio = @anio	
			 and mes = @mes_calc
			delete from GRAT_TRIP_DETA_CONC
			where codi_sema_inic >= @semanai and codi_sema_fin <= @semanaf and anio = @anio AND codi_tipo_plan = @codi_tipo_plan
			and mes = @mes_calc
		end
		else
		begin
			Delete from DETA_INGR_GRAT_TRIP 
			where codi_Sema >= @semanai and codi_Sema <= @semanaf AND codi_tipo_plan = @codi_tipo_plan 
			and anio = @anio and codi_pers = @codi_pers and mes = @mes_calc
			delete from GRAT_TRIP_DETA_CONC
			where codi_sema_inic >= @semanai and codi_sema_fin <= @semanaf and anio = @anio AND codi_tipo_plan = @codi_tipo_plan 
			and codi_pers = @codi_pers  and mes = @mes_calc
		end	
	end
	else
	begin
		if ltrim(rtrim(@codi_pers )) = ''
		begin
			Delete from DETA_INGR_GRAT_TRIP
			where codi_tipo_plan = @codi_tipo_plan and mes = @mes_calc  and anio = @anio 	
			Delete from GRAT_TRIP_DETA_CONC
			where anio = @anio AND codi_tipo_plan = @codi_tipo_plan and mes = @mes_calc
		end
		else
		begin
			Delete from DETA_INGR_GRAT_TRIP
			where codi_tipo_plan = @codi_tipo_plan and mes = @mes_calc and codi_pers = @codi_pers and anio = @anio 	
			Delete from GRAT_TRIP_DETA_CONC
			where anio = @anio AND codi_tipo_plan = @codi_tipo_plan and mes = @mes_calc and codi_pers = @codi_pers
		end
	end
	if @tipo = 'S'	
	begin
		if ltrim(rtrim(@codi_pers )) = ''
		begin
			Declare C1 cursor for 
			select pe.codi_pers, atp.codi_carg, atp.codi_sema, atp.codi_unid_oper, 
				pe.apel_1 + ' ' + isnull(pe.apel_2, '') + ' ' + pe.nomb_1 + ' ' + isnull(pe.nomb_2, ''), se.nro_sema, uo.desc_unid_oper
			From asistencia_tripulantes_pesca atp, personal pe, semana se, unid_oper uo
			where atp.codi_pers = pe.codi_pers and atp.codi_sema = se.codi_sema and atp.codi_unid_oper = uo.codi_unid_oper
			and atp.codi_sema >= @semanai and atp.codi_sema <= @semanaf 
			and ( atp.mesanio = @anio + @mes_calc or atp.mesanio = @mes_calc + @anio )
		end
		else
		begin
			Declare C1 cursor for 
			select pe.codi_pers, atp.codi_carg, atp.codi_sema, atp.codi_unid_oper, 
				pe.apel_1 + ' ' + isnull(pe.apel_2, '') + ' ' + pe.nomb_1 + ' ' + isnull(pe.nomb_2, ''), se.nro_sema, uo.desc_unid_oper
			From asistencia_tripulantes_pesca atp, personal pe, semana se, unid_oper uo
			where atp.codi_pers = pe.codi_pers and atp.codi_sema = se.codi_sema and atp.codi_unid_oper = uo.codi_unid_oper
			and atp.codi_sema >= @semanai and atp.codi_sema <= @semanaf and atp.codi_pers = @codi_pers
			and ( atp.mesanio = @anio + @mes_calc or atp.mesanio = @mes_calc + @anio ) 
		end
	end
	else
	begin
		if ltrim(rtrim(@codi_pers )) = ''
		begin
			Declare C1 cursor for 
			select pe.codi_pers, atp.codi_carg, atp.codi_sema, atp.codi_unid_oper, 
				pe.apel_1 + ' ' + isnull(pe.apel_2, '') + ' ' + pe.nomb_1 + ' ' + isnull(pe.nomb_2, ''), se.nro_sema, uo.desc_unid_oper
			From asistencia_tripulantes_pesca atp, personal pe, semana se, unid_oper uo
			where atp.codi_pers = pe.codi_pers and atp.codi_sema = se.codi_sema and atp.codi_unid_oper = uo.codi_unid_oper
			and ( atp.mesanio = @anio + @mes_calc or atp.mesanio = @mes_calc + @anio )
		end
		else
		begin
			Declare C1 cursor for
			select pe.codi_pers, atp.codi_carg, atp.codi_sema, atp.codi_unid_oper,
				pe.apel_1 + ' ' + isnull(pe.apel_2, '') + ' ' + pe.nomb_1 + ' ' + isnull(pe.nomb_2, ''), se.nro_sema, uo.desc_unid_oper
			From asistencia_tripulantes_pesca atp, personal pe, semana se, unid_oper uo
			where atp.codi_pers = pe.codi_pers and atp.codi_sema = se.codi_sema and atp.codi_unid_oper = uo.codi_unid_oper
			and ( atp.mesanio = @anio + @mes_calc or atp.mesanio = @mes_calc + @anio ) and atp.codi_pers = @codi_pers
		end
	end
	open c1;
	fetch C1 into @per, @car, @sem, @emb, @p, @nro_Sema, @unid_oper;
	WHILE @@FETCH_STATUS = 0
	begin

		set @tota_ingr = 0		
		select @porc_dist = isnull( max( isnull( porc_dist , 22.4 ) ) , 22.4 ) from embarcaciones where codi_unid_oper=@emb		
		select @tota_ingr = ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from planilla_de_tripulantes pt, planilla_tripulante_conceptos ptc
		where pt.codi_plan_trip = ptc.codi_plan_trip and pt.codi_pers=@per and pt.codi_unid_oper=@emb
			and ptc.codi_conc='199998'  and pt.codi_sema = @sem
			and ( pt.mesanio = @anio + @mes_calc or pt.mesanio = @mes_calc + @anio )	

		select @tota_vaca = ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from planilla_de_tripulantes pt, planilla_tripulante_conceptos ptc
		where pt.codi_plan_trip = ptc.codi_plan_trip and pt.codi_pers=@per and pt.codi_unid_oper=@emb
			and ptc.codi_conc='101901'  and pt.codi_sema = @sem
			and ( pt.mesanio = @anio + @mes_calc or pt.mesanio = @mes_calc + @anio )
		select @dev5ta = ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from planilla_de_tripulantes pt, planilla_tripulante_conceptos ptc
		where pt.codi_plan_trip = ptc.codi_plan_trip and pt.codi_pers=@per and pt.codi_unid_oper=@emb 
			and ( ptc.codi_conc = '100090' or ptc.codi_conc = '100070' ) and pt.codi_sema = @sem 
			and ( pt.mesanio = @anio + @mes_calc or pt.mesanio = @mes_calc + @anio )
		select @tota_valo = ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from planilla_de_tripulantes pt, planilla_tripulante_conceptos ptc
		where pt.codi_plan_trip = ptc.codi_plan_trip and pt.codi_pers=@per and pt.codi_unid_oper=@emb 
			and ( ptc.codi_conc >= @codi_conc_inic and ptc.codi_conc <= @codi_conc_fina )  and pt.codi_sema = @sem 
			and ( pt.mesanio = @anio + @mes_calc or pt.mesanio = @mes_calc + @anio )		
		set @tota_ingr = @tota_ingr - @dev5ta
		if @codi_tipo_plan = '06' 
		BEGIN
			set @tota_ingr = @tota_ingr - @tota_vaca
		end
		insert into Deta_ingr_grat_trip (CODI_sEMA, ANIO, codi_pers, codi_carg, codi_unid_oper, grati, importe, porc_part, 
				nro_sema, codi_tipo_plan, mesanio_prov, Codi_plan_orig, mes , tipo_camb) 
		values ( @sem, @ANIO, @per, @car, @emb, @tota_valo , @tota_ingr , @porc_dist,
				@nro_sema , @codi_tipo_plan, @mes, '08', @mes_calc, @Tipo_camb )			
		fetch C1 into @per, @car, @sem, @emb, @p, @nro_Sema, @unid_oper;
	end
	Close C1;
	deallocate C1;
	if @indi_boni = 1
	begin
		if ltrim(rtrim(@codi_pers )) = ''
		begin
			Declare C2 cursor for
			select pe.codi_pers, am.codi_carg, @semanaf as codi_sema, am.codi_unid_oper,
				pe.apel_1 + ' ' + isnull(pe.apel_2, '') + ' ' + pe.nomb_1 + ' ' + isnull(pe.nomb_2, ''), @mes_calc as nro_sema, uo.desc_unid_oper
			From asistencia_motorista am, personal pe, unid_oper uo
			where am.codi_pers = pe.codi_pers and am.codi_unid_oper = uo.codi_unid_oper 
			and ( am.mesanio = @anio + @mes_calc or am.mesanio = @mes_calc + @anio )
		end
		else
		begin
			Declare C2 cursor for
			select pe.codi_pers, am.codi_carg, @semanaf as codi_sema, am.codi_unid_oper,
				pe.apel_1 + ' ' + isnull(pe.apel_2, '') + ' ' + pe.nomb_1 + ' ' + isnull(pe.nomb_2, ''), @mes_calc as nro_sema, uo.desc_unid_oper
			From asistencia_motorista am, personal pe, unid_oper uo
			where am.codi_pers = pe.codi_pers and am.codi_unid_oper = uo.codi_unid_oper and am.codi_pers = @codi_pers 
			and ( am.mesanio = @anio + @mes_calc or am.mesanio = @mes_calc + @anio )
		end
		open C2;
		fetch C2 into @per, @car, @sem, @emb, @p, @nro_Sema, @unid_oper;
		while @@fetch_status = 0
		begin
			select @tota_ingr = ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from planilla_boni_moto pt, planilla_boni_concepto ptc
			where pt.codi_plan_boni = ptc.codi_plan_boni and pt.codi_pers=@per and pt.codi_unid_oper=@emb  and tipo = 'M'
				and ptc.codi_conc='199998' and ( pt.mesanio = @anio + @mes_calc or pt.mesanio = @mes_calc + @anio )	

			select @tota_vaca = ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from planilla_boni_moto pt, planilla_boni_concepto ptc
			where pt.codi_plan_boni = ptc.codi_plan_boni and pt.codi_pers=@per and pt.codi_unid_oper=@emb  and tipo = 'M'
				and ptc.codi_conc='101901' and ( pt.mesanio = @anio + @mes_calc or pt.mesanio = @mes_calc + @anio )	

			select @dev5ta = ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from planilla_boni_moto pt, planilla_boni_concepto ptc
			where pt.codi_plan_boni = ptc.codi_plan_boni and pt.codi_pers=@per and pt.codi_unid_oper=@emb  and tipo = 'M'
				and ( ptc.codi_conc = '100090' or ptc.codi_conc = '100070' ) and ( pt.mesanio = @anio + @mes_calc or pt.mesanio = @mes_calc + @anio )	
			select @tota_valo = ISNULL(  SUM( ISNULL( valor , 0 ) )  , 0 ) from planilla_boni_moto pt, planilla_boni_concepto ptc
			where pt.codi_plan_boni = ptc.codi_plan_boni and pt.codi_pers=@per and pt.codi_unid_oper=@emb  and tipo = 'M'
				and ( ptc.codi_conc >= @codi_conc_inic and ptc.codi_conc <= @codi_conc_fina )
				and ( pt.mesanio = @anio + @mes_calc or pt.mesanio = @mes_calc + @anio )	
			
			set @tota_ingr = @tota_ingr - @dev5ta
			if @codi_tipo_plan = '06' 
			BEGIN
				set @tota_ingr = @tota_ingr - @tota_vaca
			end
	
			insert into Deta_ingr_grat_trip (CODI_sEMA, ANIO, codi_pers, codi_carg, codi_unid_oper, grati, importe, porc_part,
					nro_sema, codi_tipo_plan, mesanio_prov, Codi_plan_orig, mes , tipo_camb)
			values ( @sem, @ANIO, @per, @car, @emb, @tota_valo , @tota_ingr  , @porc_dist,
					@nro_sema , @codi_tipo_plan, @mes, '14', @mes_calc, @Tipo_camb)	
			fetch C2 into @per, @car, @sem, @emb, @p, @nro_Sema, @unid_oper;
		end
		close C2;
		deallocate C2;
	end
	if @tipo = 'S'
	begin
		if ltrim(rtrim(@codi_pers )) = ''
		begin
			Declare curs_carg_conc Cursor for
			Select distinct codi_pers, codi_unid_oper from DETA_INGR_GRAT_TRIP
			where codi_Sema >= @semanai and codi_Sema <= @semanaf and codi_tipo_plan = @codi_tipo_plan and anio = @anio
			and mes = @mes_calc 
		end
		else
		begin
			Declare curs_carg_conc Cursor for
			Select distinct codi_pers, codi_unid_oper from DETA_INGR_GRAT_TRIP
			where codi_Sema >= @semanai and codi_Sema <= @semanaf and codi_tipo_plan = @codi_tipo_plan and anio = @anio and codi_pers = @codi_pers
			and mes = @mes_calc
		end
	end
	else
		begin
		if ltrim(rtrim(@codi_pers )) = ''
		begin
			Declare curs_carg_conc Cursor for
			Select distinct codi_pers, codi_unid_oper from DETA_INGR_GRAT_TRIP
			where codi_tipo_plan = @codi_tipo_plan and anio = @anio and mes = @mes_calc
		end
		else
		begin
			Declare curs_carg_conc Cursor for
			Select distinct codi_pers, codi_unid_oper from DETA_INGR_GRAT_TRIP
			where codi_tipo_plan = @codi_tipo_plan and anio = @anio and mes = @mes_calc and codi_pers = @codi_pers
		end
	end
	set @rent_quin = 0
	open curs_carg_conc;
	fetch curs_carg_conc into @per, @emb
	WHILE @@FETCH_STATUS = 0
	begin	
		if @tipo = 'S'
		begin
			Select @net = isnull(  sum( isnull( grati, 0 )  ) , 0 )  from DETA_INGR_GRAT_TRIP
			where codi_Sema >= @semanai and codi_Sema <= @semanaf and anio = @anio and codi_pers = @per
				AND codi_tipo_plan = @codi_tipo_plan and mes = @mes_calc and codi_unid_oper = @emb;
		end
		ELSE
		begin
			Select @net = isnull(  sum( isnull( grati, 0 )  ) , 0 )  from DETA_INGR_GRAT_TRIP
			where anio = @anio and codi_pers = @per AND codi_tipo_plan = @codi_tipo_plan and mes = @mes_calc  and codi_unid_oper = @emb;
		end		
		Insert into Grat_trip_deta_conc ( codi_pers, codi_sema_inic, codi_sema_fin, anio, codi_conc, monto, valor, codi_tipo_plan , mesanio_prov, mes, codi_unid_oper)
		Values ( @per, @semanai, @semanaf, @anio, '199998',0,  @net , @codi_tipo_plan, @mes, @mes_calc, @emb)
		set @tota_DESC = 0
		if @apli_juic = 1 
		begin	
			set @cont_juic = 0
			set @tota_juic = 0
			if @net > 0
			BEGIN
				Declare curs_carg_juic cursor for 
				Select  codi_juic, mont_desc, tipo_Desc from juicios
				where codi_pers = @per and esta_acti = 1 and apli_toda_remu = 1
				order by tipo_Desc ;
				Open curs_carg_juic ;
				Fetch curs_carg_juic into @codi_juic, @mont_juic, @tipo_juic;
				WHILE @@FETCH_STATUS = 0
				begin
					set @cont_juic = @cont_juic  + 1
					set @codi_conc_juic = '20001' + cast(@cont_juic  as char(1))
					if @tipo_juic = 0 
					begin
						set @juic = isnull( ( @net - @rent_quin ) * @mont_juic / 100 , 0 ) 
						SET @mont_juic = @mont_juic
					end
					else
					begin
						set @juic = isnull(  @mont_juic , 0 ) 
						SET @mont_juic = 0
					end						
					if @juic > 0 
					begin
						if @juic > @net begin 
							set @juic = @net 
						end
						if ISNULL( @tota_juic , 0 ) + ISNULL( @juic, 0 ) > @net
						begin
							set @juic = @net - ISNULL( @tota_juic , 0 )
						end							
						set @tota_juic = ISNULL( @tota_juic , 0 ) + ISNULL( @juic, 0 ) 
						if @juic > 0 
						begin
							Insert into GRAT_TRIP_DETA_CONC ( codi_pers, codi_sema_inic, codi_sema_fin, anio, codi_conc, monto, 
									valor , CODI_tipo_plan, mesanio_prov, codi_juic, mes, codi_unid_oper )
							Values ( @per, @semanai, @semanaf, @anio, @codi_conc_juic , @mont_juic,  
									@juic , @codi_tipo_plan, @mes, @codi_juic, @mes_calc, @emb )
						end
					end			
					Fetch curs_carg_juic into @codi_juic, @mont_juic, @tipo_juic;		
				end
				close curs_carg_juic;
				deallocate curs_carg_juic;
			END 
		end
		set @tota_juic = isnull(  @tota_juic , 0 )
		set @rent_quin = isnull(  @rent_quin , 0 )
		set @tota_desc = @rent_quin  + @tota_juic
		set @tota_desc = isnull(  @tota_desc  , 0 )
		Insert into GRAT_TRIP_DETA_CONC ( codi_pers, codi_sema_inic, codi_sema_fin, anio, codi_conc, monto, valor , codi_tipo_plan, mesanio_prov, mes, codi_unid_oper)
		Values ( @per, @semanai, @semanaf, @anio, '299999' , 0 ,  @tota_desc , @codi_tipo_plan, @mes, @mes_calc, @emb)	
		Insert into GRAT_TRIP_DETA_CONC ( codi_pers, codi_sema_inic, codi_sema_fin, anio, codi_conc, monto, valor , codi_tipo_plan, mesanio_prov, mes, codi_unid_oper)
		Values ( @per, @semanai, @semanaf, @anio, '999990' , 0 ,  isnull( @net , 0 ) - isnull( @tota_desc , 0 ) , @codi_tipo_plan, @mes, @mes_calc, @emb)
		if @tipo_camb > 0 
		begin
			Insert into GRAT_TRIP_DETA_CONC ( codi_pers, codi_sema_inic, codi_sema_fin, anio, codi_conc, monto, valor , codi_tipo_plan, mesanio_prov, mes, codi_unid_oper)
			Values ( @per, @semanai, @semanaf, @anio, '999991' , 0 ,  ( isnull( @net , 0 ) - isnull( @tota_desc , 0 ) ) / @tipo_camb, @codi_tipo_plan, @mes, @mes_calc, @emb)
		end
			fetch curs_carg_conc into @per, @emb
	end
	Close curs_carg_conc ;
	deallocate curs_carg_conc ;
	if @tipo = 'S'
	begin
		select * from DETA_INGR_GRAT_TRIP
		where codi_Sema >= @semanai and codi_Sema <= @semanaf AND codi_tipo_plan = @codi_tipo_plan and anio = @anio and mes = @mes_calc
		order by codi_pers, codi_Sema
		select * from GRAT_TRIP_DETA_CONC
		where codi_sema_inic >= @semanai and codi_sema_fin <= @semanaf and anio = @anio AND codi_tipo_plan = @codi_tipo_plan and mes = @mes_calc
		order by codi_pers, codi_Sema_inic, codi_conc
	end
	else
	begin
		select * from DETA_INGR_GRAT_TRIP
		where codi_tipo_plan = @codi_tipo_plan and anio = @anio and mes = @mes_calc
		order by codi_pers, codi_Sema
		select * from GRAT_TRIP_DETA_CONC
		where anio = @anio AND codi_tipo_plan = @codi_tipo_plan and mes = @mes_calc
		order by codi_pers, codi_Sema_inic, codi_conc
	end
End
GO
