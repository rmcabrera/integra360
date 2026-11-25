CREATE PROCEDURE [dbo].[SP_PERSONAL_ALL]
WITH EXECUTE AS CALLER
AS
begin
	declare @BD varchar(20)
	declare @ct int
	declare @i int
	declare @sql varchar(300)
	declare @uni varchar(20)
	declare @sl nvarchar(300)
	declare @vr varchar(20)
	declare @Existb int

	set @sql=''
	set @ct=0
	set @i=1
	set @ct = (select count(name) from master.dbo.sysdatabases where name like 'siep_%' OR name like 'si_%')
	
	declare C1 cursor for select name from master.dbo.sysdatabases where name like 'siep_%' OR name like 'si_%'
	open C1
	fetch C1 into @BD
	while @@FETCH_STATUS =0
	begin
		set @vr=''
		set @sl ='select count('+@BD+'.dbo.sysobjects.name) from '+@BD+'.dbo.sysobjects where  ('+@BD+'.dbo.sysobjects.name = ''configsys'') AND ('+@BD+'.dbo.sysobjects.xtype = ''U'') '
		CREATE TABLE #T1 (v VARCHAR(300) null)
		insert into #t1
			exec(@sl)
		set @Existb=(select v from #t1)
		drop table #t1
		
		if (@Existb>0)
		begin
			set @sl ='select '+@BD+'.dbo.configsys.valor from '+@BD+'.dbo.configsys where '+@BD+'.dbo.configsys.id_conf=1'
			CREATE TABLE #T (v VARCHAR(300) null)
			insert into #t
				exec(@sl)
			set @vr=(select v from #t)
			drop table #t
			
			if (lower(@vr)='siscon')
			begin
				set @uni = ' union all ' 
		
				set @SQl = @SQL + 'select * from ' + @bd+ '.dbo.v_reporte_personal ' +@uni
				set @i =@i +1
			end 
		end
		fetch C1 into @BD
	end
	close C1
	deallocate C1
	set @sql = substring(@sql,1,len(@sql) - 10)
	exec (@sql)
end
GO
