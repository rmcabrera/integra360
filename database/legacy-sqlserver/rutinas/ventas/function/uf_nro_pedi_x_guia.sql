CREATE FUNCTION [dbo].[uf_nro_pedi_x_guia](@codi [char](10))
RETURNS [varchar](4000) WITH EXECUTE AS CALLER
AS 
begin
	--declare @codi char(10)
	--select @codi='0000000003'
	
	declare @use varchar(100), @obs varchar(200)
	declare @cad nvarchar(4000)
	
	set @cad=''
	declare C1 cursor for select distinct cast(ser_guia as varchar) + ' - ' + cast(nro_guia as varchar)
				   from guia A(nolock) join guia_detalle B(nolock) on A.codi_guia=B.codi_guia
			       join orden_de_pedido C(nolock) on C.codi_orde_pedi = left(B.codi_deta_orde_pedi,10)
			       where C.codi_orde_pedi = @codi
	open c1
	fetch c1 into @use
	while @@fetch_status=0
	begin
		if  (rtrim(@use)<>'') set @cad = @cad + rtrim(@use) + ', '
		fetch c1 into @use
	end 
	close c1
	deallocate c1
	if len(@cad)>0 	set @cad = substring(@cad,1, len(@cad) -1 ) 
	
	return @cad
	--select @cad
end
GO
