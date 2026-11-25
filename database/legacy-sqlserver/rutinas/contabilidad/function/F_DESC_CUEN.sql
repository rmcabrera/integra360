CREATE FUNCTION [dbo].[F_DESC_CUEN](@nc [char](7))
RETURNS [varchar](100) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt varchar(100)
	select @rt=desc_cuen from cuentas_contable where nro_cuen=@nc
	return @rt
END
GO
