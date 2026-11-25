CREATE FUNCTION [dbo].[F_Totales_plan_boni_trip_pers](@semana [char](8), @embar [char](5), @conp [char](6), @codi_pers [char](5))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @Ret numeric(12,3)
	select @ret=sum(valor) from Planilla_Boni_tripu, Planilla_BoniTri_Conceptos where Planilla_Boni_tripu.CODI_PLAN_BTRI= Planilla_BoniTri_Conceptos.CODI_PLAN_BTRI
		and codi_unid_oper=@embar and codi_sema=@semana and codi_conc=@conp and codi_pers = @codi_pers
	return @ret
END
GO
