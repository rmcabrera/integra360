CREATE FUNCTION [dbo].[F_SUM_CONCEPTOS](@MESA [char](6), @EMBAR [char](5), @CONCEP [char](1))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @rt numeric(12,2)
	if (@concep ='1')
	begin
		select @rt=sum(valor) from planilla_boni_concepto, planilla_boni_moto where planilla_boni_concepto.codi_plan_boni= planilla_boni_moto.codi_plan_boni and 
			mesanio=@mesa and codi_unid_oper=@embar and left(codi_conc,1)=@concep and not (codi_conc='199998' or codi_conc='199999')
	end 
	if (@concep ='2')
	begin
		select @rt=sum(valor) from planilla_boni_concepto, planilla_boni_moto where planilla_boni_concepto.codi_plan_boni= planilla_boni_moto.codi_plan_boni and 
			mesanio=@mesa and codi_unid_oper=@embar and left(codi_conc,1)=@concep and not ( codi_conc='299999')
	end 
	if (@concep ='3')
	begin
		select @rt=sum(valor) from planilla_boni_concepto, planilla_boni_moto where planilla_boni_concepto.codi_plan_boni= planilla_boni_moto.codi_plan_boni and 
			mesanio=@mesa and codi_unid_oper=@embar and left(codi_conc,1)=@concep and not (codi_conc='399999')
	end 
	if (@rt is null) set @rt=0
	return @rt	
END
GO
