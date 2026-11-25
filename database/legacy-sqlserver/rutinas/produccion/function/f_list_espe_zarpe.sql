CREATE FUNCTION [dbo].[f_list_espe_zarpe](@codi [char](10))
RETURNS [char](200) WITH EXECUTE AS CALLER
AS 
BEGIN 
Declare @stri varchar(100)
Declare @aux varchar(50)

Declare Cur Cursor for Select distinct desc_espe  from detalle_zarpe, especies
	where especies.codi_espe= detalle_zarpe.codi_espe and codi_zarp=@codi
open Cur
FETCH Cur INTO @aux
WHILE @@FETCH_STATUS = 0
begin
set @stri =@stri + ltrim(@aux) + " - "
FETCH Cur INTO @aux
end
close Cur
DEALLOCATE cur

set @stri = left(@stri, len(ltrim(@stri)) -1 )
return @stri
END
GO
