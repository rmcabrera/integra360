CREATE PROCEDURE [dbo].[Sp_Informe_Pesca_Diario]
	@semana [char](8),
	@fechad [datetime]
WITH EXECUTE AS CALLER
AS
Begin
	Declare @Ini  char(10)
	Declare @Ter Char(10)
	Declare @Fini datetime
	Declare @FTer datetime
	Declare @FAux datetime
	Declare @Emb char(25)
	Declare @CEmb char(5)
	Declare @sali datetime
	Declare @pesest numeric(12,3)
	Declare @Arri datetime
	Declare @Esp varchar(100)
	Declare @luga_desc varchar(250)
	Declare @luga_fond varchar(250)
	Declare @Inicio datetime
	Declare @Termino Datetime
	Declare @CodZArpe varchar(10)
	Declare @Real numeric(12,3)
	Declare @Plan char(5)
	Declare @AcumReal numeric(12,3)
	Declare @Petro numeric(12,3)
	Declare @PetroAcum numeric(12,3)
	Declare @capa_neta numeric(12,3)
	Declare @FAnt datetime
	Declare @Prov char(5)	
	declare @orden smallint
	declare @fond smallint
	declare @capa_bode numeric(12,3)
	declare @nro_sema smallint
	declare @horo_mp numeric(12,3)
	declare @horo_ma1 numeric(12,3)
	declare @horo_ma2 numeric(12,3)
	Declare @situ char(2)	
	declare @pesc_tota numeric(12,3)
	declare @acumtota numeric(12,3)
	declare @acum_hayd_real numeric(12,3)
	declare @acum_hayd_tota numeric(12,3)
	declare @acum_terc_real numeric(12,3)
	declare @acum_terc_tota numeric(12,3)
	declare @cont_hayd integer
	declare @indi_hayd integer
	declare @indi_petr_hayd integer
	Declare @stri varchar(100)
	Declare @aux varchar(500)
	declare @acumreal_HAYD numeric(12,3) 
	declare @petroacum_hayd numeric(12,3) 
	declare @acumtota_hayd numeric(12,3)
	declare @acumreal_terc numeric(12,3) 
	declare @petroacum_terc numeric(12,3) 
	declare @acumtota_terc numeric(12,3)

	
	Create Table #Temporal ( Fecha datetime Null, codi_emba char(5) Null,
	embarcaciones char(25) Null , salida datetime Null, PescaEst numeric(12,3) Null,
	Arribo datetime Null, Especie varchar(100) Null, descinic datetime null, 
	descterm datetime Null, toneladas numeric(12,3) Null, planta char(5) Null,
	AcumTone numeric(12,3) Null, Petroleo numeric(12,3) Null, PetroAcumulado numeric(12,3) Null ,
	ProveedorPetro char(5) Null, capa_neta numeric(12,3) Null, orden smallint, capa_bode numeric(12,3) Null, luga_fond varchar(250) NULL, nro_sema smallint null, 
	situ char(2) null, horo_mp numeric(12,3) Null, horo_ma1 numeric(12,3) Null, horo_ma2 numeric(12,3) Null, CODI_ZARP char(10) null, pesc_tota  numeric(12,3) Null,
	acum_tota numeric(12,3) Null, 
	acum_hayd numeric(12,3) Null, acum_terc numeric(12,3) Null, acum_hayd_tota numeric(12,3) Null, acum_terc_tota numeric(12,3) Null, 
	Petr_Acum_hayd numeric(12,3) Null , Petr_Acum_terc numeric(12,3) Null , indi_hayd integer null, indi_petr_hayd integer null
	)

	Select  	@Ini=convert(char(10),Fech_Inic,103) , 
		@Ter=convert(char(10),FEch_term,103)  ,
		@nro_sema = isnull( nro_sema , 0)
	from Semana where codi_Sema=@semana
	
	set @Fini=cast(@ini as datetime)
	set @Fter= cast(@ter as datetime)
	set @faux = @Fini
	while @Faux<=@FTer
	begin
	    Declare CEmb Cursor For 
		Select e.codi_unid_oper,desc_unid_oper, capa_neta, orden, capa_bode , Z.codi_zarp
		from embarcaciones e, zarpes z
		where e.codi_unid_oper *= z.codi_unid_oper and e.estado = '1'
			and  convert(char(10),z.fech_repo,103) = convert(char(10),@fechad, 103) and z.codi_sema=@semana
   	    open CEmb
		fetch 	Cemb into @cemb, @emb, @capa_neta, @orden, @capa_bode, @codzarpe
		WHILE @@FETCH_STATUS = 0
		    begin	
--			Print @codzarpe
			set @stri = ''
			set @esp = ''
--			set @esp=dbo.f_list_espe_zarpe(@codzarpe)	
--
			Declare Cur Cursor for Select distinct isnull( desc_espe  , '') from detalle_zarpe, especies
				where especies.codi_espe= detalle_zarpe.codi_espe and codi_zarp = rtrim( ltrim( @codzarpe ))
			open Cur
			FETCH Cur INTO @aux
			WHILE @@FETCH_STATUS = 0
			begin
				if @stri = '' 
				begin
					set @stri =@stri + ltrim(@aux) 
				end
				else
				begin
					set @stri =@stri + ' - ' + ltrim(@aux) 
				end			

				FETCH Cur INTO @aux
			end
			close Cur
			DEALLOCATE cur

			set @esp = @stri  -- left(@stri, len(ltrim(@stri)) -1 )

--
--			Print @esp
			set @pesest=0
			set @sali=Null
			set @arri=Null
			set @inicio=Null
			set @termino=Null
			--Set @esp=Null
			--Set @codzarpe=Null
			Set @plan = Null
			Set @Real= 0
			Set @pesc_tota = 0
			Set @acumtota = 0
			Set @AcumReal = 0
			Set @Petro = 0
			Set @petroacum = 0
			Set @prov = Null
			set @situ = null
			set @luga_fond = ''
			set @FAnt=DATEADD(day,-1,@Faux)		

			select  @pesest= pesc_esti, @sali=fech_zarp , @arri= fech_arri  ,
				@inicio =fech_inic_desc, @Termino= fech_term_desc , 
				@real = ISNULL( pesc_real , 0 ) , @plan = codi_clie_prov , @petro= comb_reci , @prov=codi_prov_petr,
				@luga_fond = luga_fond, @situ = codi_situ, @horo_mp = orom_mp, @horo_ma1 = orom_ma1, @horo_ma2 = orom_ma2, 
				@Pesc_tota = ISNULL( pesc_tota , 0 ) --, @codzarpe = Codi_zarp
			from zarpes	
			where convert(char(10),fech_repo,103) = convert(char(10),@Faux, 103) 
					and codi_unid_oper=@cemb and codi_sema=@semana and Codi_zarp = @codzarpe 


			if @petro=Null
			begin
			   set @petro=0
			end
			if @real=Null
			begin
			   set @real=0
			end
			set @acumreal = @acumreal + @real
			set @acumtota = @acumtota + @Pesc_tota
			Set @cont_hayd = (Select count(codi_clie_prov) from cliente_proveedor where codi_clie_prov = @plan and
						codi_clie_prov in (Select codi_clie_prov from cliente_proveedor where UPPER(denominacion) like '%HAYDUK%'))
			set @indi_hayd = 0
			if @cont_hayd > 0  begin set @indi_hayd = 1 end

			Set @cont_hayd = 0
			Set @cont_hayd = (Select count(codi_clie_prov) from cliente_proveedor where codi_clie_prov = @prov and
						codi_clie_prov in (Select codi_clie_prov from cliente_proveedor where UPPER(denominacion) like '%HAYDUK%'))
			set @indi_petr_hayd = 0
			if @cont_hayd > 0  begin set @indi_petr_hayd = 1 end
			
		             set @petroacum=@petroacum + @petro
/* 			if @Fant>=@Fini	
			begin
 			    select @acumreal=acumtone,@petroacum=PetroAcumulado, @acumtota = isnull( acum_tota , 0 ) from #temporal 	
				where codi_emba=@Cemb and convert(char(10), fecha,103)= convert(char(10),@Fant,103)
			   set @acumreal=@acumreal + @real
			   set @acumtota = @acumtota + isnull( @pesc_tota , 0 ) 
			   set @petroacum=@petroacum + @petro
			end */
			select  @acumreal = sum( isnull( pesc_real , 0 ) ) , @petroacum = sum( isnull( comb_reci , 0 ) ) , @acumtota = sum( isnull ( pesc_tota , 0 ) )
			from zarpes	
			where codi_unid_oper=@cemb and codi_sema=@semana 
				AND fech_repo < DATEADD(DAY, 1, @Faux )
			
			select  @acumreal_HAYD = isnull( sum( isnull( pesc_real , 0 ) ) , 0 )  , 
				@acumtota_hayd = isnull( sum( isnull ( pesc_tota , 0 ) ) , 0 ) 
			from zarpes	
			where codi_unid_oper=@cemb and codi_sema=@semana  
				AND fech_repo < DATEADD(DAY, 1, @Faux ) and
				codi_clie_prov in (Select codi_clie_prov from cliente_proveedor where UPPER(denominacion) like '%HAYDUK%')

			select  @petroacum_hayd = isnull( sum( isnull( comb_reci , 0 ) ) , 0 ) 
			from zarpes	
			where codi_unid_oper=@cemb and codi_sema=@semana  
				AND fech_repo < DATEADD(DAY, 1, @Faux ) and
				codi_prov_petr in (Select codi_clie_prov from cliente_proveedor where UPPER(denominacion) like '%HAYDUK%')


			set @acumreal_terc = isnull(@acumreal, 0 ) - isnull(@acumreal_HAYD, 0 )
			set @petroacum_terc = isnull(@petroacum, 0 ) - isnull(@petroacum_hayd, 0 )
			set @acumtota_terc = isnull(@acumtota, 0 ) - isnull(@acumtota_hayd, 0 )

	  		insert into #temporal(fecha, codi_emba ,embarcaciones, Salida, pescaEst,
				arribo, especie,	descinic, descterm, toneladas,planta,
				Acumtone,Petroleo, PetroAcumulado ,proveedorpetro, capa_neta, orden, capa_bode, luga_fond , nro_sema,
				situ, horo_mp, horo_ma1, horo_ma2, codi_zarp , pesc_tota, acum_tota ,
				acum_hayd, acum_terc, acum_hayd_tota, acum_terc_tota, Petr_Acum_hayd, Petr_Acum_terc, indi_hayd, indi_petr_hayd ) 


				values(@Faux,@cemb, @emb,@sali,@pesest,@arri, @esp,
				@inicio,@termino, @real,@plan,@acumreal,@petro,
				@petroacum,@prov, @capa_neta , @orden, @capa_bode, @luga_fond , @nro_sema,
				@situ, @horo_mp, @horo_ma1, @horo_ma2 , @codzarpe, @pesc_tota, @acumtota,
				@acumreal_HAYD, @acumtota_terc, @acumtota_hayd, @acumtota_terc, @petroacum_hayd, @petroacum_terc, @indi_hayd,
				@indi_petr_hayd )

			fetch Cemb into @cemb, @emb, @capa_neta, @orden, @capa_bode, @codzarpe
		  end
	    close CEmb	
	   DEALLOCATE Cemb
	    set @Faux=DATEADD(day,1,@Faux)
	end	
		
	select * from #temporal where convert(char(10),fecha,103)=convert(char(10),@fechad,103)
end
GO
