CREATE PROCEDURE [dbo].[SP_Planilla_Pesca_Calculo]
	@semana [char](8),
	@embar [char](5),
	@Nro [char](1)
WITH EXECUTE AS CALLER
AS
begin
 	Declare @embid char(5)
	Declare @cargo char(4)
	Declare @persona char(5)
	Declare @ju char(1)
	Declare @vi char(1)
	Declare @sa char(1)
	Declare @do char(1)
	Declare @lu char(1)
	Declare @ma char(1)
	Declare @mi char(1)

	Declare @Cju char(4)
	Declare @Cvi char(4)
	Declare @Csa char(4)
	Declare @Cdo char(4)
	Declare @Clu char(4)
	Declare @Cma char(4)
	Declare @Cmi char(4)
	Declare @asis char(1)

	Declare @Dia char(10)
	Declare @Ref numeric(12,3)
	Declare @Faux datetime
	Declare @Fini datetime
	Declare @Fter datetime
	Declare @FMax datetime
	Declare @pesca numeric(12,3)
	Declare @snp numeric(12,3)
	Declare @porc numeric(12,3)
	Declare @par numeric(12,3)	
	Declare @adi numeric (12,3)
	Declare @p numeric(12,3)	
	Declare @a numeric (12,3)
	Declare @esp numeric(12,3)	
	Declare @esa numeric (12,3)
	Declare @mont numeric(12,2)
	Declare @refri char(1)
	Declare @cons char(1)
	Declare @prcons numeric(12,3)
	Declare @ep numeric(12,3)
	Declare @ea numeric(12,3)

	Delete from planilla_pesca_tripulantes where codi_sema=@semana and codi_unid_oper=@embar and nro_asis=@nro

	Select @Fini=fech_inic ,@fter= fech_term from semana 
		where codi_sema=@semana

	set @snp=dbo.f_precio_snp(@semana)	
	select  @porc= porc_dist from embarcaciones where codi_unid_oper=@embar
	
	Declare Ctripu Cursor for select codi_pers, codi_carg, jueves,viernes,sabado,
		domingo,lunes, martes, miercoles, juev_carg, vier_carg, saba_carg, domi_carg, lune_carg, mart_carg, mier_carg  from asistencia_tripulantes_pesca
		where codi_sema=@semana and codi_unid_oper=@embar and nro_asis =@nro order by codi_pers
	open Ctripu
	fetch 	Ctripu into @persona, @cargo, @ju, @vi, @sa, @do, @lu, @ma, @mi, @cju, @cvi, @csa, @cdo, @clu, @cma, @cmi
	WHILE @@FETCH_STATUS = 0
	begin	
		set @faux = @Fini
		while @Faux<=@FTer
		begin
		    set @par=0
		    set @adi=0
		    set @pesca=0
		    set @mont=0	
		    set @asis='0'	
		    set @esp=0
		    set @esa=0
 		    set @prcons = 0
		    select @pesca= sum(pesc_real) from zarpes where codi_unid_oper=@embar and codi_sema=@semana and 
			convert(char(10),fech_repo,103) = convert(char(10),@faux,103)

		    select top 1 @refri= refrigerada ,@cons=conserva  from zarpes where codi_unid_oper=@embar and codi_sema=@semana and 
			convert(char(10),fech_repo,103) = convert(char(10),@faux,103)
	   	   set @ref = 1
		   if(@refri  ='1')	set @ref = 1.28
		   if(@cons  ='1')	select  @prcons= conserva from embarcaciones where codi_unid_oper=@embar
		
		    set @Dia = DATENAME ( weekday , @Faux )
		    if (@Dia='Jueves')
		    begin
		       Select @Fmax=max(fech_asig) from parte_cargo where fech_asig<= @fini and codi_carg=@cju  and codi_unid_oper=@embar

	                    select @par=parte , @adi=adicional , @esp= espe_part, @esa = espe_adic from parte_cargo where codi_carg=@cju and
				codi_unid_oper=@embar and convert(char(10),fech_asig,103)=convert(char(10),@fmax,103)

		        select @asis = jueves from asistencia_tripulantes_pesca where codi_sema=@semana
			and codi_unid_oper=@embar and codi_pers=@persona	and  nro_asis=@nro
		        set	 @cargo=@cju
		    end	
		    if (@Dia='Viernes')
		    begin
		       Select @Fmax=max(fech_asig) from parte_cargo where fech_asig<= @fini and codi_carg=@cvi and codi_unid_oper=@embar

	                    select @par=parte , @adi=adicional , @esp= espe_part, @esa = espe_adic from parte_cargo where codi_carg=@cvi and
				codi_unid_oper=@embar and convert(char(10),fech_asig,103)=convert(char(10),@fmax,103)

		        select @asis = viernes from asistencia_tripulantes_pesca where codi_sema=@semana
			and codi_unid_oper=@embar and codi_pers=@persona and  nro_asis=@nro
		        set	 @cargo=@cvi
		    end	
		    if (@Dia='Sábado')
		    begin
		       Select @Fmax=max(fech_asig) from parte_cargo where fech_asig<= @fini and codi_carg=@csa  and codi_unid_oper=@embar

	                    select @par=parte , @adi=adicional , @esp= espe_part, @esa = espe_adic from parte_cargo where codi_carg=@csa and
				codi_unid_oper=@embar and convert(char(10),fech_asig,103)=convert(char(10),@fmax,103)
		        select @asis = sabado from asistencia_tripulantes_pesca where codi_sema=@semana
			and codi_unid_oper=@embar and codi_pers=@persona 	and  nro_asis=@nro
		        set	 @cargo=@csa
		    end	
		    if (@Dia='Domingo')
		    begin
		       Select @Fmax=max(fech_asig) from parte_cargo where fech_asig<= @fini and codi_carg=@cdo  and codi_unid_oper=@embar

	                    select @par=parte , @adi=adicional , @esp= espe_part, @esa = espe_adic from parte_cargo where codi_carg=@cdo and
				codi_unid_oper=@embar and convert(char(10),fech_asig,103)=convert(char(10),@fmax,103)
		        select @asis = domingo from asistencia_tripulantes_pesca where codi_sema=@semana
			and codi_unid_oper=@embar and codi_pers=@persona	and  nro_asis=@nro
		        set	 @cargo=@cdo
		    end	
		
		    if (@Dia='Lunes')
         		    begin
			set @snp=dbo.f_precio_snp(@semana)	
		       Select @Fmax=max(fech_asig) from parte_cargo where fech_asig<= @fini and codi_carg=@clu  and codi_unid_oper=@embar

	                    select @par=parte , @adi=adicional , @esp= espe_part, @esa = espe_adic from parte_cargo where codi_carg=@clu and
				codi_unid_oper=@embar and convert(char(10),fech_asig,103)=convert(char(10),@fmax,103)
		        select @asis = lunes from asistencia_tripulantes_pesca where codi_sema=@semana
			and codi_unid_oper=@embar and codi_pers=@persona	and  nro_asis=@nro
		        set	 @cargo=@clu

		    end	
		    if (@Dia='Martes')
		    begin
		       Select @Fmax=max(fech_asig) from parte_cargo where fech_asig<= @fini and codi_carg=@cma  and codi_unid_oper=@embar

	                    select @par=parte , @adi=adicional , @esp= espe_part, @esa = espe_adic from parte_cargo where codi_carg=@cma and
				codi_unid_oper=@embar and convert(char(10),fech_asig,103)=convert(char(10),@fmax,103)
		        select @asis = martes from asistencia_tripulantes_pesca where codi_sema=@semana
			and codi_unid_oper=@embar and codi_pers=@persona	and  nro_asis=@nro
		        set	 @cargo=@cma
		    end	
		    if (@Dia='Miércoles')
		    begin
		       Select @Fmax=max(fech_asig) from parte_cargo where fech_asig<= @fini and codi_carg=@cmi  and codi_unid_oper=@embar

	                    select @par=parte , @adi=adicional , @esp= espe_part, @esa = espe_adic from parte_cargo where codi_carg=@cmi and
				codi_unid_oper=@embar and convert(char(10),fech_asig,103)=convert(char(10),@fmax,103)
		        select @asis = miercoles from asistencia_tripulantes_pesca where codi_sema=@semana
			and codi_unid_oper=@embar and codi_pers=@persona	and  nro_asis=@nro
		        set	 @cargo=@cmi
		    end	
		    if (@asis='0')
		    begin
                                   set @p=0
		        set @a=0	
                                   set @ep=0
		        set @ea=0	
		    end 
		    else
		    begin
                                   set @p=@par
		        set @a=@adi
                                   set @ep=@esp
		        set @ea=@esa
		    end 
		    insert into planilla_pesca_tripulantes (codi_sema,codi_unid_oper, codi_pers,
			codi_carg, dia, nom_dia, pesc_real, prec_snp, porc_distr, parte, adicional, monto,refri ,espe_parte, espe_adic,nro_asis)		
			values	(@semana, @embar, @persona, @cargo, @Faux, @Dia, @pesca, @snp,@porc, @p, @a, 0, @ref, @ep, @ea, @nro)
		    set @Faux=DATEADD(day,1,@Faux)
		end	
		fetch 	Ctripu into @persona, @cargo, @ju, @vi, @sa, @do, @lu, @ma, @mi, @cju, @cvi, @csa, @cdo, @clu, @cma, @cmi
	end
	close Ctripu
	deallocate Ctripu
	Declare @np numeric(12,2)
	Declare @ntr numeric(2)
	Declare @Vimp numeric(12,3)
	Declare @Vpcons numeric(12,3)

	Declare @VP numeric(12,4)
	Declare @VPC numeric(12,4)

	Declare @porcd numeric(12,2)
	Declare @vporcd numeric(12,2)
	set @porcd=0
             Select @Fmax=max(fech_asig) from parte_cargo where fech_asig<= @fini and codi_carg='1103' and codi_unid_oper=@embar
             select  @porcd = espe_adic from parte_cargo where codi_carg='1103' and
				codi_unid_oper=@embar and convert(char(10),fech_asig,103)=convert(char(10),@fmax,103)

	set @faux = @Fini
	while @Faux<=@FTer
	begin
		  set @vimp=0
		  set @vp=0	
		set @ntr=0
		set @vporcd=0
	                select @ntr =count(codi_sema)  from planilla_pesca_tripulantes where codi_sema=@semana
			and codi_unid_oper=@embar and convert(char(10),dia,103) = Convert(char(10),@faux,103) 		
			and  nro_asis=@nro
	
		    select @np =sum(parte)  from planilla_pesca_tripulantes where codi_sema=@semana
			and codi_unid_oper=@embar and convert(char(10),dia,103) = Convert(char(10),@faux,103)
			and  nro_asis=@nro
			   group by codi_sema, codi_unid_oper, dia

		    select @snp =prec_snp, @pesca=pesc_real, @porc=porc_distr , @ref=refri
			 from planilla_pesca_tripulantes where codi_sema=@semana  and  nro_asis=@nro
			and codi_unid_oper=@embar and convert(char(10),dia,103) = Convert(char(10),@faux,103)
		
		   set @Vimp = round(@snp * @pesca * @ref * (@porc/100),3)
		   set @Vpcons = round(@snp * @pesca * (@prcons/100),3)

		   Set @vp= round(@vimp/(@Np),3)
		   Set @vpc= round(@vpcons/(@Np),3)
		
		 if (@vp is null) set @vp=0	
		 if (@vpc is null) set @vpc=0	

		   update planilla_pesca_tripulantes set monto= round(round( (parte+adicional )*@vp,3) + round((parte+adicional )*@vpc,3) ,2), 
				espe_monto= round((parte+adicional )*@vpc,2)
			  where codi_sema=@semana and codi_unid_oper=@embar and 
				convert(char(10),dia,103) = convert(char(10),@faux,103)	and  nro_asis=@nro

		    set @Faux=DATEADD(day,1,@Faux)	
	end 	
end
GO
