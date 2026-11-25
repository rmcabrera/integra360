CREATE FUNCTION [dbo].[f_list_guias_zarpes](@fact [char](10))
RETURNS [char](200) WITH EXECUTE AS CALLER
AS 
BEGIN 
Declare @stri varchar(100)
Declare @ser varchar(50)
Declare @nro varchar(50)

declare Cur cursor for select detalle_zarpe.seri_guia ,detalle_zarpe.nro_guia from detalle_zarpe,detalle_factura_pesca 
	where detalle_zarpe.codi_deta_zarp=detalle_factura_pesca.codi_Deta_zarp and not nro_guia is null
		and codi_fact_pesc =@fact
		order by detalle_factura_pesca.codi_deta_zarp;
open Cur
FETCH Cur INTO @ser , @nro
WHILE @@FETCH_STATUS = 0
begin
--set @stri =@stri + rtrim(ltrim(@ser))+ "-"+rtrim(ltrim(@nro)) + ", "
set @stri =@stri + rtrim(ltrim(@nro)) 
FETCH Cur INTO @ser, @nro
if (not @nro is null and ltrim(rtrim(@nro))<>'') set @stri =@stri + ", "
end
close Cur
DEALLOCATE cur
set @stri=ltrim(rtrim(@stri))
if (right(@stri,1)=',') set @stri = left(@stri, len(@stri) - 1)
return @stri
END
GO
