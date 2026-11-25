CREATE FUNCTION [dbo].[F_DIAS_LABO_MENS_PESC](@ani [char](4), @MES [char](2), @per [char](5))
RETURNS [numeric](2, 0) WITH EXECUTE AS CALLER
AS 
BEGIN 
	
	declare @rt numeric(2)
	declare @rtm numeric(2)
	declare @rtt numeric(2)
	declare @rtt1 numeric(2)
	declare @rttm1 numeric(2)
	declare @rttm2 numeric(2)
	declare @rttm3 numeric(2)
	declare @rttm numeric(2)

--	if (@Carg='1005' or @Carg='1007' or @Carg='1008')
--	begin
		select @rtm = sum(dias_traba_mens) from asistencia_motorista where right(mesanio,4)=@ani and left(mesanio, 2)= @mes and  codi_pers=@per
--	end
--	else
--	begin
		select @rtt1 =sum(cast(jueves as numeric)+cast(viernes as numeric) + cast(sabado as  numeric) + cast(domingo as numeric)+
				cast(lunes as numeric) + cast(martes as numeric) + cast(miercoles as numeric) ) 
		from asistencia_tripulantes_pesca 
		where left( mesanio,4)=@ani and right( mesanio,2) = @mes  and codi_pers=@per 

		select @rttm1 =sum(cast(jueves as numeric)+cast(viernes as numeric) + cast(sabado as  numeric) + cast(domingo as numeric)+
				cast(lunes as numeric) + cast(martes as numeric) + cast(miercoles as numeric) ) 
		from asistencia_tripulantes_pesca 
		where left( mesanio,4)=@ani and right( mesanio,2) = @mes  and codi_pers=@per  and ( codi_carg = '1005' )

		select @rttm2 =sum(cast(jueves as numeric)+cast(viernes as numeric) + cast(sabado as  numeric) + cast(domingo as numeric)+
				cast(lunes as numeric) + cast(martes as numeric) + cast(miercoles as numeric) ) 
		from asistencia_tripulantes_pesca 
		where left( mesanio,4)=@ani and right( mesanio,2) = @mes  and codi_pers=@per  and ( codi_carg = '1007' )

		select @rttm3 =sum(cast(jueves as numeric)+cast(viernes as numeric) + cast(sabado as  numeric) + cast(domingo as numeric)+
				cast(lunes as numeric) + cast(martes as numeric) + cast(miercoles as numeric) ) 
		from asistencia_tripulantes_pesca 
		where left( mesanio,4)=@ani and right( mesanio,2) = @mes  and codi_pers=@per  and ( codi_carg = '1008' )
		
		if (@rtm is null) set @rtm=0
		if (@rtt1 is null) set @rtt1 =0
		if (@rttm1 is null) set @rttm1 =0
		if (@rttm2 is null) set @rttm2 =0
		if (@rttm3 is null) set @rttm3 =0
		set @rttm = @rttm1 + @rttm2 + @rttm3
		set @rtt = @rtt1 - @rttm
		set @rt = @rtm + @rtt
--	end
/*	
	if (@rtt is null) set @rtt=0
	if (@rttm is null) set @rttm=0 */

	if (@rt is null) set @rt=0
	return @rt

END
GO
