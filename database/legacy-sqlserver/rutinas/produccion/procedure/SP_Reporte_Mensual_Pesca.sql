CREATE PROCEDURE [dbo].[SP_Reporte_Mensual_Pesca]
	@mes [int]
WITH EXECUTE AS CALLER
AS
Begin
	declare @SQL nvarchar(1100)
	declare @St nvarchar(1100)
	Declare @Cat char(30)
	DEclare @I int
	Create Table #temporal (fecha datetime null)
	set @i =0
	Declare C1 cursor for select desc_unid_oper from embarcaciones
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
	
	Declare @ton numeric(12,3)
	Declare @emb char(5)
	DEclare @Fec datetime
	
	Declare C2 cursor for select fech_repo from zarpes where datepart(month, fech_repo)= @mes group by fech_repo order by fech_repo asc
	open c2
	fetch C2 into @fec
	WHILE @@FETCH_STATUS = 0
	begin	
		insert into #temporal(fecha) values (@fec)
		Declare C3 cursor for select codi_unid_oper, pesc_real from zarpes where fech_repo=@fec
		open c3
		fetch C3 into @emb, @ton
		WHILE @@FETCH_STATUS = 0
		begin	
			select @cat=desc_unid_oper from embarcaciones where codi_unid_oper=@emb
			set @cat= replace(@cat ,' ' ,'_')
			set @st= "update #temporal set "+@cat + " = " + convert(char,@ton) + " where convert(char(10),fecha,103)= '" + convert(char(10), @fec ,103)+"'"
			exec(@st) 
			fetch C3 into @emb, @ton
		end 	
		close C3
		deallocate C3
		fetch C2 into @fec
	end
	close C2
	deallocate C2
	exec("Select * from #temporal") 
End
GO
