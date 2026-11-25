CREATE FUNCTION [dbo].[F_REgistro](@sd [char](1), @comp [char](10), @mes [char](2))
RETURNS [char](10) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @reg char(10)
	select @reg=registro from movi_contables where subdia=@sd and compr=@comp and mes=@mes and not(registro is null ) and registro <>''
	return @reg
END
GO
