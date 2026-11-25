CREATE FUNCTION [dbo].[F_NRO_SUB_CUEN](@nc [char](7))
RETURNS [char](7) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @SUB_CTA  char(7)

	select @SUB_CTA =NRO_SUB_CUEN  
	from cuentas_contable 
	where nro_cuen=@nc

	return @SUB_CTA
END
GO
