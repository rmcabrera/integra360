CREATE FUNCTION [dbo].[F_CUENTA_PROV](@id [char](2))
RETURNS [char](7) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt char(7)
	select @rt=cuenta from cuentas_provision where codigo=@id
	
	return @rt
END
GO
