CREATE FUNCTION [dbo].[uf_datos_ult_compra](@prod [char](8), @cantidad [numeric](12, 4))
RETURNS @Rt TABLE (
	[produc] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fecha] [datetime] NULL,
	[compra] [numeric](12, 2) NULL,
	[boni] [numeric](12, 2) NULL
) WITH EXECUTE AS CALLER
AS 
begin
	--declare @prod char(8) , @cantidad numeric(12,4), @result int
	--select @prod='00080427' , @cantidad =168, @result =1

	declare @tx table (idd int identity , cantidad numeric(12,4) null, fecha datetime null, tipo char(2) null)
	declare @valor numeric(12,3) 
	
	insert @tx
	select b.cantidad, fech_nota_ingr, tipo_nota_ingr  --, a.codi_nota_ingr
	from nota_ingreso A (nolock)
	join detalle_nota_ingreso B (nolock)
	on A.codi_nota_ingr=B.codi_nota_ingr
	where a.tipo_nota_ingr in ('01','26') and B.codi_prod=@prod
	order by fech_nota_ingr desc


	declare @cant numeric(12,4), @suma numeric(12,4), @suma_compra numeric(12,4) , @suma_boni numeric(12,4)
	declare @fec datetime 
	declare @cad varchar(1000), @tip char(2), @fecaux datetime
	set @cad=''
	declare CC cursor for select cantidad, fecha, tipo from @Tx order by fecha desc 
	open CC
	set @suma=0
	set @suma_compra=0
	set @suma_boni=0
	
	fetch CC into @cant, @fec, @tip
	while @@fetch_status=0
	begin
		if @tip='01' set @suma_compra = @suma_compra + @cant
		if @tip='26' set @suma_boni = @suma_boni + @cant
		
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
		
		fetch CC into @cant, @fec, @tip
	end

	close CC
	deallocate CC
		
	if @cad<>'' set @cad = substring(@cad, 1, len(@cad) - 1 )
/*		
	if @result= 1  set @valor=@suma_compra
	if @result= 2  set @valor=@suma_boni

	if @valor is null set @valor=0
*/	
	insert @Rt
	select 	@prod as producto, @cad as fecha, @suma_compra as compra, @suma_boni as boni
	return 
	---return @valor	
end
GO
