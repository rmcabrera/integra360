CREATE FUNCTION [dbo].[F_Totales_plan_boni_moto](@mesa [char](8), @embar [char](5), @conp [char](6), @tip [char](1))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @Ret numeric(12,3)
	select @ret=sum(valor) from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
		and codi_unid_oper=@embar and mesanio=@mesa and codi_conc=@conp and tipo=@tip
	if (@ret is null) set @ret=0
	return @ret
END
GO
