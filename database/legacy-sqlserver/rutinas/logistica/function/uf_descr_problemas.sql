CREATE FUNCTION [dbo].[uf_descr_problemas](@subf [char](4))
RETURNS [varchar](4000) WITH EXECUTE AS CALLER
AS 
begin
	--declare @subf char(4)
	--select @subf='0467'
	
	declare @obs varchar(200)
	declare @cad nvarchar(4000)
	
	set @cad=''
	declare C1 cursor for  select distinct isnull(rtrim(descripcion),'')
				FROM control_problemas A(nolock) join control_problemas_detalle B(nolock) on A.id_control=B.id_control
				where id_sub_fami_prod=@subf
	open c1
	fetch c1 into @obs
	while @@fetch_status=0
	begin
		if rtrim(@obs)<>'' set @cad = @cad + @obs +', '
		fetch c1 into @obs
	end 
	close c1
	deallocate c1
	if len(@cad)>0 	set @cad = substring(@cad,1, len(@cad) -1 ) 
	return  @cad
	--select @cad
end
GO
