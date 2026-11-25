CREATE PROCEDURE [dbo].[SP_DIAS_PESCA_ANUAL]
	@anio [char](4),
	@mes [char](2)
WITH EXECUTE AS CALLER
AS
Begin
	DEclare @fec1 datetime
	declare @sem varchar(8)	
	declare @unid  char(5)
	declare @pes numeric(12,3)
		
	declare @par numeric(12,2)
	declare @boni numeric(12,2)
	declare @nom varchar(150)	
	declare @nsem varchar(5)
	declare @fec2 datetime
	declare @nemb varchar(30)
	declare @ce varchar(20)
	declare @dn varchar(10)
	declare @pers char(5)
	declare @UNI char(5)

	DECLARE @dias int
	DECLARE @diasb int
	declare @carg char(4)
	create table  #temporal (persona char(5), toneladas numeric(12,3) null,
		salidas int null, diasboni int null , participacion numeric(12,2) null,  bonificacion numeric(12,2) null, nombre varchar(150) null,
		censo varchar(20) null, DNI varchar(10) null, EMBAR VARCHAR(20))
			
	declare C1 cursor for select distinct codi_pers from planilla_pesca_tripulantes, semana 
			where semana.codi_sema=planilla_pesca_tripulantes.codi_sema and 
				left(planilla_pesca_tripulantes.mesanio,4) = @anio and 
			            right(planilla_pesca_tripulantes.mesanio,2)<= @mes and codi_pers<>'00000' and monto<>0
		order by codi_pers
	open C1
	fetch C1 into @pers
	WHILE @@FETCH_STATUS = 0
	begin
		set @nemb=''
		set @fec1=null
		set @fec2=null
		set @nsem=''
		set @dias =0
		set @nom=''
		set @ce=''
		set @dn=''
		set @pes=0
		set @par=0
		 select @pes= isnull(sum(pesc_real) ,0), @par= isnull(sum(monto) ,0) from planilla_pesca_tripulantes, semana 
			where semana.codi_sema=planilla_pesca_tripulantes.codi_sema and 
				left(planilla_pesca_tripulantes.mesanio,4) = @anio and 
			            right(planilla_pesca_tripulantes.mesanio,2)<= @mes  and codi_pers<>'00000' and monto<>0
				and codi_pers=@pers

		select @nom= apel_1+ isnull(' '+apel_2,'') + isnull(' '+nomb_1,'')+isnull(' '+nomb_2,''),
			@ce = nro_censo, @dn= nro_docu_iden  from personal where codi_pers=@pers

		select @dias = sum(cast(jueves as numeric)+cast(viernes as numeric) + cast(sabado as  numeric) + cast(domingo as numeric)+
					cast(lunes as numeric) + cast(martes as numeric) + cast(miercoles as numeric) ) 
			from asistencia_tripulantes_pesca, semana where 	semana.codi_sema=asistencia_tripulantes_pesca.codi_sema and 
				left(semana.aniomes,4) =@anio
				and right(semana.aniomes,2)<=@mes  and codi_pers=@pers;

		SET @UNI= (select TOP 1 CODI_UNID_OPER
			from asistencia_tripulantes_pesca, semana where 	semana.codi_sema=asistencia_tripulantes_pesca.codi_sema and 
				left(semana.aniomes,4) =@anio
				and right(semana.aniomes,2)<=@mes  and codi_pers=@pers GROUP BY CODI_UNID_OPER);
		

		insert into #temporal (persona , toneladas , salidas , diasboni, participacion ,  bonificacion , nombre, censo, dni, EMBAR )
		values (@pers, @pes, @dias, @diasb, @par,@boni, @nom, @ce,  @dn, @UNI)

		fetch C1 into  @pers
	end
	close C1
	deallocate C1

	select * from #temporal
End
GO
