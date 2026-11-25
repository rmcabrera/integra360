CREATE FUNCTION [dbo].[F_BANCO](@cu [char](7))
RETURNS [varchar](150) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt varchar(150)
	select @rt=desc_cuen from cuentas_contable where nro_cuen=@cu
	return @rt
END
GO
