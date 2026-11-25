CREATE FUNCTION [dbo].[uf_nro_guia_x_pedi](@codi [int])
RETURNS [varchar](100) WITH EXECUTE AS CALLER
AS 
begin
	--declare @codi int
	--set @codi=7115

	declare @Cad varchar(10), @retorno varchar(100)
	set @retorno=''
	declare C1 cursor for 
	
	select rtrim(nro_guia) from guia (nolock) where codi_orden_pedi=@codi and isnull(estado,'')<>'A'
	/*select nro_guia from dbo.guia z(nolock) where z.codi_guia in 
		(select codi_guia from registro_orden_pedido x(nolock) where x.codi_orden_pedi=@codi)*/
	open c1
	fetch c1 into @Cad
	while @@Fetch_Status=0
	begin
		set @retorno =@retorno + rtrim(@cad) +', ' 
		fetch c1 into @Cad
	end
	close c1
	deallocate c1
	
	if rtrim(@retorno)<>'' set @retorno  = left(@retorno, len(@retorno) - 1 )
	
	return rtrim(@retorno)
end
GO
