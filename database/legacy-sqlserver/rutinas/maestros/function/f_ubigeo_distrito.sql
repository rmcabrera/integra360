CREATE FUNCTION [dbo].[f_ubigeo_distrito](@codigo [int])
RETURNS [varchar](6) WITH EXECUTE AS CALLER
AS 
BEGIN 

declare @ret  varchar(6)
   
--if @codigo=0 or isnull(codigo) set @ret=''

SELECT @ret=Codi_Ubi_Dist_Sunat  FROM UBIGEO_DISTRITO    where Codi_Ubi_Dist=@codigo; 

return @ret

END
GO
