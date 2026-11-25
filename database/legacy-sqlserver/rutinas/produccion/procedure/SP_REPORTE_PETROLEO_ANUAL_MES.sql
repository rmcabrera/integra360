CREATE PROCEDURE [dbo].[SP_REPORTE_PETROLEO_ANUAL_MES]
	@anio [char](4)
WITH EXECUTE AS CALLER
AS
begin
	declare @emb char(5)
	declare @nemb varchar(20)
	declare @T1 numeric(12,3)
	declare @nm int
	declare @em varchar(100)
	declare @sent varchar(100)
	declare @gr varchar(20)

	create Table #temporal(embar char(20) null,  mes1 numeric(12,3) null, mes2 numeric(12,3) null, 
	mes3 numeric(12,3) null, mes4 numeric(12,3) null, mes5 numeric(12,3) null , mes6 numeric(12,3) null,
	mes7 numeric(12,3) null , mes8 numeric(12,3) null, mes9 numeric(12,3) null , mes10 numeric(12,3) null, 
	mes11 numeric(12,3) null , mes12 numeric(12,3) null, empresa varchar(100) null , grupo varchar(20) null)


	select @em=razon_social from dbo.empresa

	Declare C1 cursor for select codi_unid_oper, desc_unid_oper,grupo  from dbo.embarcaciones
	open C1
	fetch C1 into @emb , @nemb, @gr
	WHILE @@FETCH_STATUS = 0
	begin
		
		insert into #temporal(embar, empresa, grupo )  values  (@nemb,@em, @gr)
		set @nm=1
		while @nm<=12
		begin 
			set @T1=0
			select @T1=sum(COMB_RECI) from dbo.zarpes where month(fech_repo)=@nm and year(fech_Repo)=@anio and
				codi_unid_oper=@emb
			if (@T1 is null) set @T1=0
			if (@nm=1)  update #temporal set mes1=@T1 where embar=@nemb
			if (@nm=2)  update #temporal set mes2=@T1 where embar=@nemb
			if (@nm=3)  update #temporal set mes3=@T1 where embar=@nemb
			if (@nm=4)  update #temporal set mes4=@T1 where embar=@nemb
			if (@nm=5)  update #temporal set mes5=@T1 where embar=@nemb
			if (@nm=6)  update #temporal set mes6=@T1 where embar=@nemb
			if (@nm=7)  update #temporal set mes7=@T1 where embar=@nemb
			if (@nm=8)  update #temporal set mes8=@T1 where embar=@nemb
			if (@nm=9)  update #temporal set mes9=@T1 where embar=@nemb
			if (@nm=10)  update #temporal set mes10=@T1 where embar=@nemb
			if (@nm=11)  update #temporal set mes11=@T1 where embar=@nemb
			if (@nm=12)  update #temporal set mes12=@T1 where embar=@nemb
			exec (@sent)
			set @nm= @nm +1
		end	
		fetch C1 into @emb , @nemb, @gr
	end
	close C1
	deallocate C1

/*	select @em=razon_social from si_isab.dbo.empresa

	Declare C2 cursor for select codi_unid_oper, desc_unid_oper  , grupo from si_isab.dbo.embarcaciones
	open C2
	fetch C2 into @emb , @nemb, @gr
	WHILE @@FETCH_STATUS = 0
	begin
		
		insert into #temporal(embar, empresa, grupo )  values  (@nemb,@em, @gr)
		set @nm=1
		while @nm<=12
		begin 
			set @T1=0
			select @T1=sum(COMB_RECI) from si_isab.dbo.zarpes where month(fech_repo)=@nm and year(fech_Repo)=@anio and
				codi_unid_oper=@emb
			
			if (@T1 is null) set @T1=0

			if (@nm=1)  update #temporal set mes1=@T1 where embar=@nemb
			if (@nm=2)  update #temporal set mes2=@T1 where embar=@nemb
			if (@nm=3)  update #temporal set mes3=@T1 where embar=@nemb
			if (@nm=4)  update #temporal set mes4=@T1 where embar=@nemb
			if (@nm=5)  update #temporal set mes5=@T1 where embar=@nemb
			if (@nm=6)  update #temporal set mes6=@T1 where embar=@nemb
			if (@nm=7)  update #temporal set mes7=@T1 where embar=@nemb
			if (@nm=8)  update #temporal set mes8=@T1 where embar=@nemb
			if (@nm=9)  update #temporal set mes9=@T1 where embar=@nemb
			if (@nm=10)  update #temporal set mes10=@T1 where embar=@nemb
			if (@nm=11)  update #temporal set mes11=@T1 where embar=@nemb
			if (@nm=12)  update #temporal set mes12=@T1 where embar=@nemb
			set @nm= @nm +1
		end	
		fetch C2 into @emb , @nemb, @gr
	end
	close C2
	deallocate C2
*/	
	select * from #temporal
end
GO
