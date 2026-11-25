CREATE PROCEDURE [dbo].[SP_REPORTE_PESCA_ANUAL]
	@anio [char](4)
WITH EXECUTE AS CALLER
AS
begin
	declare @emb char(5)
	declare @nemb varchar(20)
	declare @T1 numeric(12,3)
	declare @T1D numeric(12,3)
	declare @nm int
	declare @em varchar(100)
	declare @sent varchar(100)
	declare @gr varchar(20)

	create Table #temporal(embar char(20) null,  mes1 numeric(12,3) null, mes2 numeric(12,3) null, 
		mes3 numeric(12,3) null, mes4 numeric(12,3) null, mes5 numeric(12,3) null , mes6 numeric(12,3) null,
		mes7 numeric(12,3) null , mes8 numeric(12,3) null, mes9 numeric(12,3) null , mes10 numeric(12,3) null, 
		mes11 numeric(12,3) null , mes12 numeric(12,3) null, empresa varchar(100) null , grupo varchar(20) null,
		mes1D numeric(12,3) null, mes2D numeric(12,3) null, 
		mes3D numeric(12,3) null, mes4D numeric(12,3) null, mes5D numeric(12,3) null , mes6D numeric(12,3) null,
		mes7D numeric(12,3) null , mes8D numeric(12,3) null, mes9D numeric(12,3) null , mes10D numeric(12,3) null, 
		mes11D numeric(12,3) null , mes12D numeric(12,3) null)

	select @em=razon_social from si_rosa.dbo.empresa

	Declare C1 cursor for select codi_unid_oper, desc_unid_oper,grupo  from si_rosa.dbo.embarcaciones
	open C1
	fetch C1 into @emb , @nemb, @gr
	WHILE @@FETCH_STATUS = 0
	begin
		
		insert into #temporal(embar, empresa, grupo )  values  (@nemb,@em, @gr)
		set @nm=1
		while @nm<=12
		begin 
			set @T1=0
			set @T1D=0
			select @T1=sum(cantidad) from si_rosa.dbo.zarpes Z 
				join  si_rosa.dbo.detalle_zarpe D on Z.codi_zarp=D.codi_zarp where codi_Espe in ( select codi_espe from si_rosa.dbo.especies E where E.tipo_cons='I')
					and month(fech_repo)=@nm and year(fech_Repo)=@anio and codi_unid_oper=@emb
			select @T1D=sum(cantidad) from si_rosa.dbo.zarpes Z 
				join  si_rosa.dbo.detalle_zarpe D on Z.codi_zarp=D.codi_zarp where codi_Espe in ( select codi_espe from si_rosa.dbo.especies E where E.tipo_cons='D')
					and month(fech_repo)=@nm and year(fech_Repo)=@anio and codi_unid_oper=@emb
			if (@T1 is null) set @T1=0
			if (@T1D is null) set @T1D=0
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

			if (@nm=1)  update #temporal set mes1d=@T1d where embar=@nemb
			if (@nm=2)  update #temporal set mes2d=@T1d where embar=@nemb
			if (@nm=3)  update #temporal set mes3d=@T1d where embar=@nemb
			if (@nm=4)  update #temporal set mes4d=@T1d where embar=@nemb
			if (@nm=5)  update #temporal set mes5d=@T1d where embar=@nemb
			if (@nm=6)  update #temporal set mes6d=@T1d where embar=@nemb
			if (@nm=7)  update #temporal set mes7d=@T1d where embar=@nemb
			if (@nm=8)  update #temporal set mes8d=@T1d where embar=@nemb
			if (@nm=9)  update #temporal set mes9d=@T1d where embar=@nemb
			if (@nm=10)  update #temporal set mes10d=@T1d where embar=@nemb
			if (@nm=11)  update #temporal set mes11d=@T1d where embar=@nemb
			if (@nm=12)  update #temporal set mes12d=@T1d where embar=@nemb
			exec (@sent)
			set @nm= @nm +1
		end	
		fetch C1 into @emb , @nemb, @gr
	end
	close C1
	deallocate C1

	select @em=razon_social from si_isab.dbo.empresa

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
			set @T1d=0
			select @T1=sum(cantidad) from si_isab.dbo.zarpes Z 
				join si_isab.dbo.detalle_zarpe D on Z.codi_zarp=D.codi_zarp where codi_Espe in (select codi_espe from si_isab.dbo.especies E where e.tipo_cons='I') 
					and month(fech_repo)=@nm and year(fech_Repo)=@anio and codi_unid_oper=@emb
			select @T1d=sum(cantidad) from si_isab.dbo.zarpes Z 
				join si_isab.dbo.detalle_zarpe D on Z.codi_zarp=D.codi_zarp where codi_Espe in (select codi_espe from si_isab.dbo.especies E where e.tipo_cons='D') 
					and month(fech_repo)=@nm and year(fech_Repo)=@anio and codi_unid_oper=@emb

			
			if (@T1 is null) set @T1=0
			if (@T1d is null) set @T1d=0

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

			if (@nm=1)  update #temporal set mes1d=@T1d where embar=@nemb
			if (@nm=2)  update #temporal set mes2d=@T1d where embar=@nemb
			if (@nm=3)  update #temporal set mes3d=@T1d where embar=@nemb
			if (@nm=4)  update #temporal set mes4d=@T1d where embar=@nemb
			if (@nm=5)  update #temporal set mes5d=@T1d where embar=@nemb
			if (@nm=6)  update #temporal set mes6d=@T1d where embar=@nemb
			if (@nm=7)  update #temporal set mes7d=@T1d where embar=@nemb
			if (@nm=8)  update #temporal set mes8d=@T1d where embar=@nemb
			if (@nm=9)  update #temporal set mes9d=@T1d where embar=@nemb
			if (@nm=10)  update #temporal set mes10d=@T1d where embar=@nemb
			if (@nm=11)  update #temporal set mes11d=@T1d where embar=@nemb
			if (@nm=12)  update #temporal set mes12d=@T1d where embar=@nemb

			set @nm= @nm +1
		end	
		fetch C2 into @emb , @nemb, @gr
	end
	close C2
	deallocate C2
	
	select *, (select top 1 razon_social from empresa) empre from #temporal
end
GO
