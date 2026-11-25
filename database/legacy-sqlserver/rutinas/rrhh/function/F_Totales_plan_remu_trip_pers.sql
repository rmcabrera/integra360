CREATE FUNCTION [dbo].[F_Totales_plan_remu_trip_pers](@semana [char](8), @embar [char](5), @conp [char](6), @pers [char](5), @asis [char](1))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @Ret numeric(12,3)
	if (@asis='0')
		begin
			select @ret=sum(valor) from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and codi_unid_oper=@embar and codi_sema=@semana and codi_conc=@conp and codi_pers=@pers
		end
	else
		begin
			select @ret=sum(valor) from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and codi_unid_oper=@embar and codi_sema=@semana and codi_conc=@conp and codi_pers=@pers and nro_asis=@asis
		end
	return @ret
END
GO
