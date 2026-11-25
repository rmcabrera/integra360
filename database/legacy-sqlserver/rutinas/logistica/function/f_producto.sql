CREATE FUNCTION [dbo].[f_producto](@codi_prod [char](10))
RETURNS [varchar](100) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @prod as varchar(100)
	Select @prod=desc_prod  From productos where codi_prod = @codi_prod;
	
	return @prod
END
GO
