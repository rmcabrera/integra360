CREATE PROCEDURE [dbo].[SP_Reporte_Semanas_Dina]
	@s1 [int],
	@s2 [int],
	@an [int]
WITH EXECUTE AS CALLER
AS
Begin
	declare @SQL nvarchar(1100)
	declare @St nvarchar(1100)
	Declare @Cat char(30)
	DEclare @I int
	Create Table #temporal (persona varchar(200) null)
	set @i =0
	Declare C1 cursor for select 'S'+cast(nro_sema as varchar(2)) from semana where cast(nro_sema as int) between @s1 and @s2 and cast(left(aniomes,4) as int) =@an
	open c1
	set @St=''
	fetch C1 into @Cat
	WHILE @@FETCH_STATUS = 0
	begin	
		set @i = @i +1 
		set @cat= rtrim(ltrim(upper(REPLACE(@Cat,' ','_'))))
		Set @st = @st +  upper(@Cat) + ' numeric(12,3) null , '
		fetch C1 into @Cat
	End
	close C1
	deallocate C1
	set @st = 'ALTER TABLE #temporal  ADD ' +left (@st, len(@st) - 1 ) 
	exec(@st) 
	
	exec("Select * from #temporal") 
End
GO
