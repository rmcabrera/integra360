CREATE FUNCTION [dbo].[uf_vende_x_cliente_group_dico](@calma [char](2), @FI [datetime], @FF [datetime], @clie [char](5))
RETURNS [varchar](4000) WITH EXECUTE AS CALLER
AS 
begin	
	--declare @calma char(2), @FI datetime, @FF datetime, @clie char(5)
	--select @calma ='03', @FI ='01/03/2020', @FF ='02/02/2020', @clie='02641'
		
	declare @dato varchar(200), @cad nvarchar(4000)
	
	set @cad=''
	
	declare C1 cursor for 
	select (select lower(login) from si_agrog.dbo.usuarios u(nolock) where u.codi_usua=cod_usua_vende)
	from si_agrog.dbo.FACTURA (nolock)
	where (cast(convert(varchar(10), si_agrog.dbo.FACTURA.fech_fact , 103) as datetime) between @FI and @FF)
	and (isnull(@calma,'00')='00' or si_agrog.dbo.FACTURA.codi_alma=@calma) and (ISNULL(si_agrog.dbo.FACTURA.ESTADO,'')<>'A') 
	and codi_clie_prov=@clie
	group by si_agrog.dbo.factura.codi_clie_prov, cod_usua_vende
	
	union all
	
	select (select lower(login) from si_dcvp.dbo.usuarios u(nolock) where u.codi_usua=cod_usua_vende)
	from si_dcvp.dbo.FACTURA (nolock)
	where (cast(convert(varchar(10), si_dcvp.dbo.FACTURA.fech_fact , 103) as datetime) between @FI and @FF)
	and (isnull(@calma,'00')='00' or si_dcvp.dbo.FACTURA.codi_alma=@calma) and (ISNULL(si_dcvp.dbo.FACTURA.ESTADO,'')<>'A') 
	and codi_clie_prov=@clie
	group by si_dcvp.dbo.factura.codi_clie_prov, cod_usua_vende
	
	open c1
	fetch c1 into @dato
	while @@fetch_status=0
	begin
		if  (rtrim(@dato)<>'') set @cad = @cad + @dato+', '
		fetch c1 into @dato
	end 
	close c1
	deallocate c1
	if len(@cad)>0 	set @cad = substring(@cad,1, len(@cad) -1 ) 
	
	return  @cad
	
	--select @cad
end
GO
