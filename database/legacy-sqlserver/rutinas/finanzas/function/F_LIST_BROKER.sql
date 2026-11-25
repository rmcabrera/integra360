CREATE FUNCTION [dbo].[F_LIST_BROKER](@nro_warr [varchar](50))
RETURNS [char](200) WITH EXECUTE AS CALLER
AS 
BEGIN 
Declare @stri varchar(100)
Declare @des varchar(100)

set @stri=''
declare Cur cursor for select (select isnull(abreviatura,'') from cliente_proveedor C where C.codi_clie_prov=broker) + ' - ' +
		(select isnull(abreviatura,'') from cliente_proveedor C where c.codi_clie_prov=comprador) from warrant_control where i_o='S' and nro_warr=@nro_warr
open Cur
FETCH Cur INTO @des
WHILE @@FETCH_STATUS = 0
begin
	set @stri =@stri + rtrim(ltrim(@des)) 
	FETCH Cur INTO @des
	if (not @des is null and ltrim(rtrim(@des))<>'') set @stri =@stri + '/' 
end
close Cur
DEALLOCATE cur

set @stri=ltrim(rtrim(@stri))
if (right(@stri,1)='/') set @stri = left(@stri, len(@stri) - 1)
return @stri

END
GO
