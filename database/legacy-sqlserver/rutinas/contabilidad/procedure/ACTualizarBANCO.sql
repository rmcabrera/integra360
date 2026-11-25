CREATE PROCEDURE [dbo].[ACTualizarBANCO]
	@sd [char](1),
	@ms [char](2),
	@an [char](4)
WITH EXECUTE AS CALLER
AS
begin
	declare @a1 char(10)
	declare @a2 char(8)
	declare @a3 char(7)
	declare c1 cursor for select codi_vouc, compr, nro_cuen from movi_contables where codi_contable in 
		(select miN(codi_contable) from movi_contables where subdia=@sd and mes=@ms and anio=@an
		group by codi_vouc) 	
	open c1
	fetch C1 into @a1,@a2,@a3
	WHILE @@FETCH_STATUS = 0
	begin
		update movi_contables set banco=@a3 where compr=@a2 and codi_vouc=@a1 and subdia=@sd
			and mes=@ms and anio=@an
		fetch C1 into @a1,@a2,@a3
	end
	close C1
	deallocate C1
end
GO
