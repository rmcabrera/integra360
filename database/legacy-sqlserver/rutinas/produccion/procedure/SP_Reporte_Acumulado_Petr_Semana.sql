CREATE PROCEDURE [dbo].[SP_Reporte_Acumulado_Petr_Semana]
	@se [char](8)
WITH EXECUTE AS CALLER
AS
begin
	Declare @emb as char(5)
	Declare @ton as numeric(12,3)
	Declare @cli as char(5)
	Declare @puer as char(5)
	Declare @fec as datetime
	DECLARE @SEMANA CHAR(8)
	Declare @nemb as varchar(30)	
	Declare @ncli as varchar(70)	
	Declare @npuer as varchar(60)	
	Declare @it as int
	Create Table #Temporal(idd char (5) null, embarca varchar(30) null, Tm1 numeric(12,3) null , Fabri1 varchar(50) null ,Tm2 numeric(12,3) null , Fabri2 varchar(50) null , 
		Tm3 numeric(12,3) null , Fabri3 varchar(50) null ,Tm4 numeric(12,3) null , Fabri4 varchar(50) null ,Tm5 numeric(12,3) null , Fabri5 varchar(50) null ,
		Tm6 numeric(12,3) null , Fabri6 varchar(50) null ,Tm7 numeric(12,3) null , Fabri7 varchar(50) null ,fechaini datetime null, fechater datetime null, sema char(2) null,
		GRUPO CHAR(10) NULL, EMPRESA VARCHAR(150) NULL , auxx int null)
	
	Declare @fini as datetime
	Declare @fter as datetime	
	Declare @faux as datetime	
	Declare @C as int
	Declare @Fab as varchar(150)
	Declare @sem as varchar(2)
	declare @gr as char(10)
	declare @em as varchar(150)
	Declare @auxit as int
	set @sem=left(@se,2)

	select  @semana=codi_sema ,@fini = fech_inic , @fter =Fech_term from dbo.semana where nro_sema=@sem and left(aniomes,4)=right(@se,4)

	select @em=razon_social from dbo.empresa

	Declare C2 cursor for select codi_unid_oper, desc_unid_oper,GRUPO from dbo.embarcaciones
	open C2
	fetch C2 into @emb ,@nemb, @gr
	WHILE @@FETCH_STATUS = 0
	begin
		insert into #temporal(idd, embarca,fechaini,fechater,sema, grupo,empresa,auxx) values (@emb, @nemb,@fini,@fter,@sem,@gr,@em,1)
		set @faux = @Fini
		set @C=1
		while @Faux<=@FTer
		begin
			set @Ton=0
			set @cli=null
			set @puer=null
			set @it=1
			declare caa cursor for select  comb_reci, codi_prov_petr , codi_puer from dbo.zarpes 
				where convert(char(10),fech_repo,103) = convert(char(10),@Faux, 103) and codi_unid_oper=@emb and codi_sema=@semana and comb_reci>0 and not(comb_reci is null)
				order by fech_repo
			open caa
			fetch caa into @ton, @cli, @puer
--    			select  @Ton = SUM(comb_reci), @cli=codi_prov_petr , @puer =codi_puer from siep_jcr.dbo.zarpes 
--				where convert(char(10),fech_repo,103) = convert(char(10),@Faux, 103) and codi_unid_oper=@emb and codi_sema=@semana
--				GROUP BY codi_prov_petr , codi_puer
			WHILE @@FETCH_STATUS = 0
			begin
	
				set @ncli=null	
				set @npuer=null	
				if (@it>1 ) 
				begin
					select @auxit=max(auxx) from #temporal where idd=@emb
					if (@auxit<@it) 	insert into #temporal(idd, embarca,fechaini,fechater,sema, grupo,empresa,auxx) values (@emb, @nemb,@fini,@fter,@sem,@gr,@em,@it)	
				end 
				select @ncli =denominacion from dbo.cliente_proveedor where codi_clie_prov=@cli
	--			select @npuer= desc_puer from siep_jcr.dbo.puerto where codi_puer=@puer
				
				set @fab =null
				if (@ton>0)
				begin	
					set @Fab=@ncli
		--			if (@ncli is null) 	set @Fab=@npuer
		--			else set @Fab= @ncli + ' - '+ @npuer
			---	if (@ton is null) set @ton=0
					if(@c=1)	update #temporal set Tm1=@Ton , fabri1=@fab where idd=@emb and auxx=@it
					if(@c=2)	update #temporal set Tm2=@Ton , fabri2=@fab where idd=@emb and auxx=@it
					if(@c=3)	update #temporal set Tm3=@Ton , fabri3=@fab where idd=@emb and auxx=@it
					if(@c=4)	update #temporal set Tm4=@Ton , fabri4=@fab where idd=@emb and auxx=@it
					if(@c=5)	update #temporal set Tm5=@Ton , fabri5=@fab where idd=@emb and auxx=@it
					if(@c=6)	update #temporal set Tm6=@Ton , fabri6=@fab where idd=@emb and auxx=@it
					if(@c=7)	update #temporal set Tm7=@Ton , fabri7=@fab where idd=@emb and auxx=@it
					set @it= @it +1
				end 		
				fetch caa into @ton, @cli, @puer
			end 
			close caa
			deallocate caa	
			set @C= @C + 1
			set @Faux=DATEADD(day,1,@Faux)
		end 
		fetch C2 into @emb ,@nemb, @gr
	end 
	close C2
	deallocate C2

/*	set @sem=left(@se,2)

	select  @semana=codi_sema ,@fini = fech_inic , @fter =Fech_term from si_isab.dbo.semana where nro_sema=@sem and left(aniomes,4)=right(@se,4)
	select @em=razon_social from si_isab.dbo.empresa
	Declare C3 cursor for select codi_unid_oper, desc_unid_oper,GRUPO from si_isab.dbo.embarcaciones
	open C3
	fetch C3 into @emb ,@nemb, @gr
	WHILE @@FETCH_STATUS = 0
	begin
		insert into #temporal(idd, embarca,fechaini,fechater,sema, grupo,empresa,auxx) values (@emb, @nemb,@fini,@fter,@sem,@gr,@em,1)
		set @faux = @Fini
		set @C=1
		while @Faux<=@FTer
		begin
			set @Ton=0
			set @cli=null
			set @puer=null
			set @it=1
			declare caa cursor for select  comb_reci, codi_prov_petr , codi_puer from si_isab.dbo.zarpes 
				where convert(char(10),fech_repo,103) = convert(char(10),@Faux, 103) and codi_unid_oper=@emb and codi_sema=@semana and comb_reci>0 and not(comb_reci is null)
				order by fech_repo
			open caa
			fetch caa into @ton, @cli, @puer
--    			select  @Ton = SUM(comb_reci), @cli=codi_prov_petr , @puer =codi_puer from siep_jcr.dbo.zarpes 
--				where convert(char(10),fech_repo,103) = convert(char(10),@Faux, 103) and codi_unid_oper=@emb and codi_sema=@semana
--				GROUP BY codi_prov_petr , codi_puer
			WHILE @@FETCH_STATUS = 0
			begin
	
				set @ncli=null	
				set @npuer=null	
				if (@it>1 ) 
				begin
					select @auxit=max(auxx) from #temporal where idd=@emb
					if (@auxit<@it) 	insert into #temporal(idd, embarca,fechaini,fechater,sema, grupo,empresa,auxx) values (@emb, @nemb,@fini,@fter,@sem,@gr,@em,@it)	
				end 
				select @ncli =denominacion from si_isab.dbo.cliente_proveedor where codi_clie_prov=@cli
	--			select @npuer= desc_puer from siep_jcr.dbo.puerto where codi_puer=@puer
				
				set @fab =null
				if (@ton>0)
				begin	
					set @Fab=@ncli
		--			if (@ncli is null) 	set @Fab=@npuer
		--			else set @Fab= @ncli + ' - '+ @npuer
			---	if (@ton is null) set @ton=0
					if(@c=1)	update #temporal set Tm1=@Ton , fabri1=@fab where idd=@emb and auxx=@it
					if(@c=2)	update #temporal set Tm2=@Ton , fabri2=@fab where idd=@emb and auxx=@it
					if(@c=3)	update #temporal set Tm3=@Ton , fabri3=@fab where idd=@emb and auxx=@it
					if(@c=4)	update #temporal set Tm4=@Ton , fabri4=@fab where idd=@emb and auxx=@it
					if(@c=5)	update #temporal set Tm5=@Ton , fabri5=@fab where idd=@emb and auxx=@it
					if(@c=6)	update #temporal set Tm6=@Ton , fabri6=@fab where idd=@emb and auxx=@it
					if(@c=7)	update #temporal set Tm7=@Ton , fabri7=@fab where idd=@emb and auxx=@it
					set @it= @it +1
				end 		
				fetch caa into @ton, @cli, @puer
			end 
			close caa
			deallocate caa	
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
