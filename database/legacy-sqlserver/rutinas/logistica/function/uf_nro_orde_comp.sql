CREATE FUNCTION [dbo].[uf_nro_orde_comp](@codi [char](10))
RETURNS [varchar](4000) WITH EXECUTE AS CALLER
AS 
begin
	--declare @codi char(10)
	--select @codi='0000096057'
	
	declare @use varchar(100), @obs varchar(200)
	declare @cad nvarchar(4000)
	
	set @cad=''
	declare C1 cursor for  select distinct nro_orde_comp
				   from(
				   select isnull(nro_orde_comp,'') nro_orde_comp
			       from nota_ingr_por_orde_comp A(nolock) 
			       join orden_de_compra B(nolock)
		               on A.codi_orde_comp = B.codi_orde_comp
			       where A.codi_nota_ingr = @codi
			       
			       union all
			       
			       select isnull(nro_orde_comp,'') nro_orde_comp
			       from orden_de_compra A(nolock) 
			       join detalle_nota_ingreso D(nolock)
			       on A.codi_orde_comp=left(D.codi_deta_orde_comp,10)
			       where D.codi_nota_ingr=@codi) as sql
	open c1
	fetch c1 into @use
	while @@fetch_status=0
	begin
		if  (rtrim(@use)<>'') set @cad = @cad + @use+ ', '
		fetch c1 into @use
	end 
	close c1
	deallocate c1
	if len(@cad)>0 	set @cad = substring(@cad,1, len(@cad) -1 ) 
	return @cad
	--select @cad
end
GO
