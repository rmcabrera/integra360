CREATE FUNCTION [dbo].[F_razo_soci_clie_prov](@codi_Cp [char](5))
RETURNS [varchar](100) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @codi_clie_prov char(5)
	declare @clie_prov varchar(100)
	declare @banco char(7)
	Declare @tp char (1)
	Select @tp = left(TIPO_PERS , 1) from cliente_proveedor where codi_clie_prov=@codi_cp
	if upper(@tp) = 'N'
	begin
		select @clie_prov = apel_1 + ' ' + isnull(apel_2,'') + ' ' + isnull(nomb_1,'') + ' ' + isnull(nomb_2, '' ) from cliente_proveedor where codi_clie_prov=@codi_cp
	End
	else
	begin
		select @clie_prov = isnull(razo_soci , '') from cliente_proveedor where codi_clie_prov=@codi_cp
	end

	return @CLIE_PROV
END
GO
