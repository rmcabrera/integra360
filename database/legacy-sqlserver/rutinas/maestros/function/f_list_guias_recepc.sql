CREATE FUNCTION [dbo].[f_list_guias_recepc](@codi [char](10))
RETURNS [char](200) WITH EXECUTE AS CALLER
AS 
BEGIN 
Declare @stri varchar(100)
Declare @ser varchar(50)
Declare @nro varchar(50)

Declare Cur Cursor for Select  seri_guia ,nro_guia from recep_matprima
	where codi_clie_prov=@codi
open Cur
FETCH Cur INTO @ser , @nro
WHILE @@FETCH_STATUS = 0
begin
set @stri =@stri + RTRIM(ltrim(@ser))+ "-"+rtrim(ltrim(@nro)) + ", "
FETCH Cur INTO @ser, @nro
end
close Cur
DEALLOCATE cur

set @stri = left(@stri, len(rtrim(ltrim(@stri))) -1 )
return @stri
END
GO
