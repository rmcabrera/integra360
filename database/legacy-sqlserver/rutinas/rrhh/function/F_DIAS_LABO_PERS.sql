CREATE FUNCTION [dbo].[F_DIAS_LABO_PERS](@ani [char](4), @per [char](5), @carg [char](4))
RETURNS [numeric](2, 0) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt numeric(2)
	if (@Carg='1005' or @Carg='1007' or @Carg='1008')
	begin
		select @rt=sum(dias_traba_mens) from asistencia_motorista where right(mesanio,4)=@ani and  codi_pers=@per
	end
	else
	begin
		select @rt=sum(cast(jueves as numeric)+cast(viernes as numeric) + cast(sabado as  numeric) + cast(domingo as numeric)+
				cast(lunes as numeric) + cast(martes as numeric) + cast(miercoles as numeric) ) 
		from asistencia_tripulantes_pesca,semana where semana.codi_sema=asistencia_tripulantes_pesca.codi_sema and 
			left(semana.aniomes,4)=@ani and codi_pers=@per
	end
	
	if (@rt is null) set @rt=0
	return @rt
END
GO
