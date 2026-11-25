CREATE FUNCTION [dbo].[f_dife_hora_fech](@fi [datetime], @ff [datetime])
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @nume_hora numeric(12,2)
	set @nume_hora =  datediff(mi, @fi, @ff) 


	return @nume_hora
END
GO
