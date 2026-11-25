CREATE FUNCTION [dbo].[F_PERSONAL_DIRECCION](@codi_per [varchar](5))
RETURNS [varchar](200) WITH EXECUTE AS CALLER
AS 
BEGIN 

declare @direc varchar(200)

SELECT @DIREC=direccion from personal where codi_pers=@codi_per

return isnull(@direc,'')


END
GO
