CREATE FUNCTION [dbo].[F_desc_proy](@codi_proy [char](10))
RETURNS [varchar](200) WITH EXECUTE AS CALLER
AS 
BEGIN 

	declare @desc_proy as char(20)

	Select @desc_proy = isnull( desc_proy , '' )  From Proyecto where codi_proy = @codi_proy;

	return @desc_proy
END
GO
