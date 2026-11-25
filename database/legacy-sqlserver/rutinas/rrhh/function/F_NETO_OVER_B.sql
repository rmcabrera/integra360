CREATE FUNCTION [dbo].[F_NETO_OVER_B](@idplan [char](10))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	DECLARE @RT NUMERIC(12,2)
	DECLARE @TOTAL NUMERIC(12,2)
	DECLARE @DESCU NUMERIC(12,2)

	select @total=sum(valor)from planilla_boni_concepto where
			codi_plan_boni=@idplan  and codi_conc='199999'
	if (@total is null) set @total=0
	select @descu=sum(valor)  from planilla_boni_concepto where
			codi_plan_boni=@idplan and left(codi_conc,1)='2'

	if (@descu is null) set @descu=0
	set @rt=@total - @descu

	RETURN @RT
END
GO
