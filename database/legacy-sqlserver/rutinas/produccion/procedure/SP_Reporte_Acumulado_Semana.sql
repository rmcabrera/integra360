CREATE PROCEDURE [dbo].[SP_Reporte_Acumulado_Semana]
	@se [char](6)
WITH EXECUTE AS CALLER
AS
begin
	Declare @emb as char(5)
	Declare @semana as char(8)
	Declare @ton as numeric(12,3)
	Declare @cli as char(5)
	Declare @puer as char(5)
	Declare @fec as datetime
	DECLARE @IT AS INT
	Declare @nemb as varchar(30)	
	Declare @ncli as varchar(120)	
	Declare @npuer as varchar(20)	
	Declare @sem as varchar(2)

	Create Table #Temporal(idd char (5) null, embarca varchar(30) null, Tm1 numeric(12,3) null , Fabri1 varchar(150) null ,Tm2 numeric(12,3) null , Fabri2 varchar(150) null , 
		Tm3 numeric(12,3) null , Fabri3 varchar(150) null ,Tm4 numeric(12,3) null , Fabri4 varchar(150) null ,Tm5 numeric(12,3) null , Fabri5 varchar(150) null ,
		Tm6 numeric(12,3) null , Fabri6 varchar(150) null ,Tm7 numeric(12,3) null , Fabri7 varchar(150) null ,fechaini datetime null, fechater datetime null, sema char(2) null,
	 	grupo char(10) null, empresa varchar(150) null, AUXX INT NULL)
	
	Declare @fini as datetime
	Declare @fter as datetime	
	Declare @faux as datetime	
	Declare @C as int
	Declare @Fab as varchar(150)
	declare @gr as varchar(10)
	declare @em as varchar(150)
	declare @auxit as int
		
	set @sem=left(@se,2)

	select  @semana=codi_sema ,@fini = fech_inic , @fter =Fech_term from  dbo.semana where nro_sema=@sem and left(aniomes,4)=right(@se,4)

	select @em=razon_social from dbo.empresa
	Declare C2 cursor for select codi_unid_oper, desc_unid_oper, grupo  from  dbo.embarcaciones
	open C2
	fetch C2 into @emb ,@nemb, @gr
	WHILE @@FETCH_STATUS = 0
	begin
		insert into #temporal(idd, embarca,fechaini, fechater,sema, grupo,empresa,AUXX) values (@emb, @nemb,@fini,@fter,@sem,@gr,@em,1)

		set @faux = @Fini
		set @C=1
		while @Faux<=@FTer
		begin
			set @Ton=0
			set @cli=null
			set @puer=null
			SET @IT=1
			DECLARE CAa CURSOR FOR SELECT PESC_REAL , CODI_CLIE_PROV, CODI_PUER from  dbo.zarpes 
				where convert(char(10),fech_repo,103) = convert(char(10),@Faux, 103) 
				and codi_unid_oper=@emb and codi_sema=@semana --and pesc_real>0
			OPEN CAa
			FETCH CAa INTO @TON , @CLI, @PUER
			WHILE @@FETCH_STATUS = 0
			begin

--    			select  @Ton =SUM( pesc_real) , @cli=codi_clie_prov , @puer =codi_puer from siep_jcr.dbo.zarpes 
--				where cast(convert(char(10),fech_repo,103) as smalldatetime)= @Faux and codi_unid_oper=@emb and codi_sema=@semana
				IF (@IT>1 ) 
				begin 
					select @auxit= max(auxx) from #temporal where idd=@emb
					if ( @auxit< @it)	insert into #temporal(idd, embarca,fechaini, fechater,sema, grupo,empresa,AUXX) values (@emb, @nemb,@fini,@fter,@sem,@gr,@em,@IT)	
				end
				set @ncli=null	
				set @npuer=null	
	
				select @ncli =denominacion from  dbo.cliente_proveedor where codi_clie_prov=@cli
				select @npuer= desc_puer from  dbo.puerto where codi_puer=@puer
				
				set @fab =null
				set @fab =null
				if (@ton is null) set @ton=0
--				if (@ton>0)
--				begin	
					set @Fab=@ncli
					if (@ncli is null or @ncli='') 	set @Fab=@npuer
				--	else set @Fab=rtrim(@ncli) + ' - '+ rtrim(@npuer)
					IF (@TON IS NULL) SET @TON=0
					if(@c=1)	update #temporal set Tm1=@Ton , fabri1=@fab where idd=@emb AND AUXX=@IT
					if(@c=2)	update #temporal set Tm2=@Ton , fabri2=@fab where idd=@emb AND AUXX=@IT
					if(@c=3)	update #temporal set Tm3=@Ton , fabri3=@fab where idd=@emb AND AUXX=@IT
					if(@c=4)	update #temporal set Tm4=@Ton , fabri4=@fab where idd=@emb AND AUXX=@IT
					if(@c=5)	update #temporal set Tm5=@Ton , fabri5=@fab where idd=@emb AND AUXX=@IT
					if(@c=6)	update #temporal set Tm6=@Ton , fabri6=@fab where idd=@emb AND AUXX=@IT
					if(@c=7)	update #temporal set Tm7=@Ton , fabri7=@fab where idd=@emb AND AUXX=@IT

				SET @IT=@IT + 1
--				End			

				FETCH CaA INTO @TON , @CLI, @PUER
			END 	
			CLOSE CAa
			DEALLOCATE CaA	

			set @C= @C + 1
			set @Faux=DATEADD(day,1,@Faux)
		end 
		fetch C2 into @emb ,@nemb, @gr
	end 
	close C2
	deallocate C2

/*	set @sem=left(@se,2)
	select  @semana=codi_sema ,@fini = fech_inic , @fter =Fech_term from  si_isab.dbo.semana where nro_sema=@sem and left(aniomes,4)=right(@se,4)

	select @em=razon_social from si_isab.dbo.empresa
	Declare C3 cursor for select codi_unid_oper, desc_unid_oper, grupo  from si_isab.dbo.embarcaciones
	open C3
	fetch C3 into @emb ,@nemb, @gr
	WHILE @@FETCH_STATUS = 0
	begin
		insert into #temporal(idd, embarca,fechaini, fechater,sema, grupo,empresa,AUXX) values (@emb, @nemb,@fini,@fter,@sem,@gr,@em,1)
		set @faux = @Fini
		set @C=1
		while @Faux<=@FTer
		begin
			set @Ton=0
			set @cli=null
			set @puer=null
			SET @IT=1
			DECLARE CA CURSOR FOR SELECT PESC_REAL , CODI_CLIE_PROV, CODI_PUER from si_isab.dbo.zarpes 
				where convert(char(10),fech_repo,103) = convert(char(10),@Faux, 103)
			 and codi_unid_oper=@emb and codi_sema=@semana --and pesc_real>0
			OPEN CA
			FETCH CA INTO @TON , @CLI, @PUER
			WHILE @@FETCH_STATUS = 0
			begin
	--    			select  @Ton = pesc_real , @cli=codi_clie_prov , @puer =codi_puer from siep_jaal.dbo.zarpes 
	--				where convert(char(10),fech_repo,103) = convert(char(10),@Faux, 103) and codi_unid_oper=@emb and codi_sema=@semana
				IF (@IT>1 ) 
				begin 
					select @auxit= max(auxx) from #temporal where idd=@emb
					if ( @auxit< @it)	insert into #temporal(idd, embarca,fechaini, fechater,sema, grupo,empresa,AUXX) values (@emb, @nemb,@fini,@fter,@sem,@gr,@em,@IT)	
				end

				set @ncli=null	
				set @npuer=null	
	
				select @ncli =denominacion from si_isab.dbo.cliente_proveedor where codi_clie_prov=@cli
				select @npuer= desc_puer from si_isab.dbo.puerto where codi_puer=@puer
				
				set @fab =null
				set @fab =null
--				if (@ton>0)
--				begin	
					set @Fab=@ncli
					if (@ncli is null) 	set @Fab=@npuer
			--		else set @Fab= @ncli + ' - '+ @npuer
					IF (@TON IS NULL)	SET @TON=0	
					if(@c=1)	update #temporal set Tm1=@Ton , fabri1=@fab where idd=@emb AND AUXX=@IT
					if(@c=2)	update #temporal set Tm2=@Ton , fabri2=@fab where idd=@emb AND AUXX=@IT
					if(@c=3)	update #temporal set Tm3=@Ton , fabri3=@fab where idd=@emb AND AUXX=@IT
					if(@c=4)	update #temporal set Tm4=@Ton , fabri4=@fab where idd=@emb AND AUXX=@IT
					if(@c=5)	update #temporal set Tm5=@Ton , fabri5=@fab where idd=@emb AND AUXX=@IT
					if(@c=6)	update #temporal set Tm6=@Ton , fabri6=@fab where idd=@emb AND AUXX=@IT
					if(@c=7)	update #temporal set Tm7=@Ton , fabri7=@fab where idd=@emb AND AUXX=@IT
					SET @IT=@IT  + 1
--				End	
				FETCH CA INTO @TON , @CLI, @PUER
			END
			CLOSE CA
			DEALLOCATE CA	
			set @C= @C + 1
			set @Faux=DATEADD(day,1,@Faux)
		end 
		fetch C3 into @emb ,@nemb, @gr
	end 
	close C3
	deallocate C3
*/
	select * from #temporal
	
end
GO
