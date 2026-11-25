CREATE PROCEDURE [dbo].[Sp_Informe_Pesca]
	@semana [char](8)
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
	DEclare @Esp varchar(100)
	Declare @Inicio datetime
	Declare @Termino Datetime
	Declare @CodZArpe char(10)
	Declare @Real numeric(12,3)
	Declare @Plan char(5)
	Declare @AcumReal numeric(12,3)
	Declare @Petro numeric(12,3)
	Declare @PetroAcum	numeric(12,3)
	Declare @FAnt datetime
	Declare @Prov char(5)	

	Create Table #Temporal ( Fecha datetime Null, codi_emba char(5) Null,
	embarcaciones char(25) Null , salida datetime Null, PescaEst numeric(12,3) Null,
	Arribo datetime Null, Especie varchar(100) Null, descinic datetime null, 
	descterm datetime Null, toneladas numeric(12,3) Null, planta char(5) Null,
	AcumTone numeric(12,3) Null, Petroleo numeric(12,3) Null, PetroAcumulado numeric(12,3) Null ,
	ProveedorPetro char(5) Null)

	Select  @Ini=convert(char(10),Fech_Inic,103) , 
		@Ter=convert(char(10),FEch_term,103)  from
	Semana where codi_Sema=@semana
	
	set @Fini=cast(@ini as datetime)
	set @Fter= cast(@ter as datetime)
	set @faux = @Fini
	while @Faux<=@FTer
	begin
	    Declare CEmb Cursor For Select codi_unid_oper,desc_unid_oper from embarcaciones
   	    open CEmb
		fetch 	Cemb into @cemb, @emb
		WHILE @@FETCH_STATUS = 0
		    begin	
			set @pesest=0
			set @sali=Null
			set @arri=Null
			set @inicio=Null
			set @termino=Null
			Set @esp=Null
			Set @codzarpe=Null
			Set @plan = Null
			Set @Real= 0
			Set @AcumReal = 0
			Set @Petro = 0
			Set @petroacum = 0
			Set @prov = Null
			set @FAnt=DATEADD(day,-1,@Faux)			
			select  @codzarpe = Codi_zarp ,@pesest= pesc_esti, @sali=fech_zarp , @arri= fech_arri  ,
				@inicio =fech_inic_desc, @Termino= fech_term_desc , 
				@real = pesc_real, @plan = codi_clie_prov , @petro= comb_reci ,
				@prov=codi_prov_petr	 from zarpes	
				where convert(char(10),fech_repo,103) = convert(char(10),@Faux, 103) 
					and codi_unid_oper=@cemb and codi_sema=@semana
			set @esp=dbo.f_list_espe_zarpe(@codZArpe)  
			if @petro=Null 
			begin
			   set @petro=0
			end
			if @real=Null 
			begin
			   set @real=0
			end
			set @acumreal=@acumreal + @real
		             set @petroacum=@petroacum + @petro

 			if @Fant>=@Fini	
			begin
 			    select @acumreal=acumtone,@petroacum=PetroAcumulado from #temporal 	
				where codi_emba=@Cemb and convert(char(10), fecha,103)= convert(char(10),@Fant,103)
			   set @acumreal=@acumreal + @real
			   set @petroacum=@petroacum + @petro
			end

	  		insert into #temporal(fecha, codi_emba ,embarcaciones, Salida, pescaEst,
				arribo, especie,	descinic, descterm, toneladas,planta,
				Acumtone,Petroleo, PetroAcumulado ,proveedorpetro ) 
				values(@Faux,@cemb, @emb,@sali,@pesest,@arri, @esp,
				@inicio,@termino, @real,@plan,@acumreal,@petro,
				@petroacum,@prov )
			fetch Cemb into @cemb, @emb
		  end
	    close CEmb	
	   DEALLOCATE Cemb
	    set @Faux=DATEADD(day,1,@Faux)
	end	
		
	select * from #temporal
end
GO
