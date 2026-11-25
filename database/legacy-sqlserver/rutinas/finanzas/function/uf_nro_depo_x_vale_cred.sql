CREATE FUNCTION [dbo].[uf_nro_depo_x_vale_cred](@codi [numeric](18, 0))
RETURNS [varchar](100) WITH EXECUTE AS CALLER
AS 
begin
	--declare @codi numeric(18)
	--set @codi = 2094

	declare @Cad varchar(10), @retorno varchar(100)
	set @retorno=''
	declare C1 cursor for 
	select codi_depo 
	from caja_chica_depo (nolock)
	where tipo_rela='S' and codi_docu=@codi
	
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
