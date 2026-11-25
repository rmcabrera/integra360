CREATE FUNCTION [dbo].[uf_fech_ult_compra](@prod [char](8), @cantidad [numeric](12, 4))
RETURNS [varchar](100) WITH EXECUTE AS CALLER
AS 
begin
	--	declare @prod char(8) , @cantidad numeric(12,4)
	--	select @prod='00080427' , @cantidad =168

	declare @tx table (idd int identity , cantidad numeric(12,4) null, fecha datetime null)

	insert @tx
	select b.cantidad, fech_nota_ingr--, a.codi_nota_ingr
	from nota_ingreso A (nolock)
	join detalle_nota_ingreso B (nolock)
	on A.codi_nota_ingr=B.codi_nota_ingr
	where a.tipo_nota_ingr in ('01','26') and B.codi_prod=@prod
	order by fech_nota_ingr desc

	declare @cant numeric(12,4), @suma numeric(12,4)
	declare @fec datetime 
	declare @cad varchar(1000), @fecaux datetime
	set @cad=''
	declare CC cursor for select cantidad, fecha from @Tx order by fecha desc 
	open CC
	set @suma=0
	fetch CC into @cant, @fec
	while @@fetch_status=0
	begin
		set @suma= @suma + @cant
		set @cantidad = @cantidad - @suma
		
		
		if @cantidad >0
		begin
			--select @fec, @suma
			
			if @fecaux is null or @fecaux <>cast(convert(char(10),@fec,103) as datetime)
				set @cad = @cad + convert(char(10),@fec,103) +', '			
				
			if @fecaux is null set @fecaux = cast(convert(char(10),@fec,103) as datetime)
		end
		else
		begin
			--select @fec, @suma	
			if @fecaux is null or @fecaux <>cast(convert(char(10),@fec,103) as datetime)
				set @cad = @cad + convert(char(10),@fec,103) +', '		
				
			if @fecaux is null set @fecaux = cast(convert(char(10),@fec,103) as datetime)
			break
		end 
		
		fetch CC into @cant, @fec
	end

	close CC
	deallocate CC
	
	if @cad<>'' set @cad = substring(@cad, 1, len(@cad) - 1 )
	
	return @cad
	
end
GO
