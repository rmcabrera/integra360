CREATE FUNCTION [dbo].[F_DIAS_SALIDA](@ani [char](4), @per [char](5), @TP [char](1), @sem [char](8))
RETURNS [numeric](2, 0) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt numeric(2)
	DECLARE @CG CHAR(4)
	SELECT @CG =CODI_CARG FROM PERSONAL WHERE CODI_PERS=@PER
	IF (@TP='1')
	BEGIN
		if (@Cg='1005' or @Cg='1007' or @Cg='1008' )
		BEGIN
			SELECT @RT=DIAS_TRABA_MENS FROM ASISTENCIA_MOTORISTA WHERE CODI_PERS=@PER AND RIGHT(MESANIO,4)=@ANI
				and left(MESANIO,2)=@sem
		END 
		ELSE	
		BEGIN	
			select @rt=sum(cast(jueves as numeric)+cast(viernes as numeric) + cast(sabado as  numeric) + cast(domingo as numeric)+
						cast(lunes as numeric) + cast(martes as numeric) + cast(miercoles as numeric) ) 
				from asistencia_tripulantes_pesca,semana where semana.codi_sema=asistencia_tripulantes_pesca.codi_sema and 
					left(semana.aniomes,4)=@ani and codi_pers=@per and 
					right(semana.aniomes,2)= @sem
		END
	END
	ELSE
	BEGIN
		select @rt=sum(cast(jueves as numeric)+cast(viernes as numeric) + cast(sabado as  numeric) + cast(domingo as numeric)+
					cast(lunes as numeric) + cast(martes as numeric) + cast(miercoles as numeric) ) 
			from asistencia_tripulantes_pesca,semana where semana.codi_sema=asistencia_tripulantes_pesca.codi_sema and 
				left(semana.aniomes,4)=@ani and codi_pers=@per and asistencia_tripulantes_pesca.codi_sema=@sem
	END
	if (@rt is null) set @rt=0
	return @rt
END
GO
