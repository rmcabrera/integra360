CREATE FUNCTION [dbo].[f_saldo_ant](@mes [char](6), @cuenta [char](7))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @rt numeric(12,2)
	select @rt=saldonue from saldos_cuentas where mesanio=@mes and nro_Cuen=@cuenta
	if (@rt is null) set @rt=0
	return  @rt
END
GO
