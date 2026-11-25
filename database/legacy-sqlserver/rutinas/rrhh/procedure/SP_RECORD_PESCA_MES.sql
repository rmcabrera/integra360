CREATE PROCEDURE [dbo].[SP_RECORD_PESCA_MES]
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
	DECLARE @dias int
	DECLARE @diasb int
	declare @carg char(4)
	declare @grup varchar(50)	
	Select @grup = upper(grupo) from empresa

	create table  #temporal (persona char(5), toneladas numeric(12,3) null,
		salidas int null, diasboni int null , participacion numeric(12,2) null,  bonificacion numeric(12,2) null, nombre varchar(150) null,
		censo varchar(20) null, DNI varchar(10) null)

	if @grup =  'BARAKA' 
	BEGIN					
		declare C1 cursor for select distinct codi_pers from planilla_pesca_tripulantes, semana 
				where semana.codi_sema=planilla_pesca_tripulantes.codi_sema and 
					planilla_pesca_tripulantes.mesanio = ( @anio + @mes ) and codi_pers<>'00000' and monto<>0
			union 
				select distinct codi_pers from planilla_boni_moto 
					where 	planilla_boni_moto.mesanio=( @anio+@mes) and codi_pers<>'00000' 
			order by codi_pers
	end
	else
	BEGIN					
		declare C1 cursor for select distinct codi_pers from planilla_pesca_tripulantes, semana 
				where semana.codi_sema=planilla_pesca_tripulantes.codi_sema and 
					planilla_pesca_tripulantes.mesanio = ( @mes + @anio ) and codi_pers<>'00000' and monto<>0
			union 
				select distinct codi_pers from planilla_boni_moto 
					where 	planilla_boni_moto.mesanio=( @mes + @anio  ) and codi_pers<>'00000' 
			order by codi_pers	
	end

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
		 select @pes= isnull(sum(pesc_real) ,0) from planilla_pesca_tripulantes, semana 
			where semana.codi_sema=planilla_pesca_tripulantes.codi_sema and 
				planilla_pesca_tripulantes.mesanio = ( @anio + @mes ) and codi_pers<>'00000' and monto<>0
				and codi_pers=@pers

		select @nom= apel_1+ isnull(' '+apel_2,'') + isnull(' '+nomb_1,'')+isnull(' '+nomb_2,''),
			@ce = nro_censo, @dn= nro_docu_iden  from personal where codi_pers=@pers

		select @dias = sum(cast(jueves as numeric)+cast(viernes as numeric) + cast(sabado as  numeric) + cast(domingo as numeric)+
					cast(lunes as numeric) + cast(martes as numeric) + cast(miercoles as numeric) ) 
			from asistencia_tripulantes_pesca,semana where 	semana.codi_sema=asistencia_tripulantes_pesca.codi_sema and 
				asistencia_tripulantes_pesca.mesanio = (@anio+@mes)  and codi_pers=@pers;
		
		set @par=0
		select @par= isnull(sum(valor),0) from planilla_de_tripulantes , planilla_tripulante_conceptos
			where mesanio=( @anio+@mes) and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
				and codi_conc='199998' and codi_pers=@pers

		set @boni=0
		if @grup =  'BARAKA' 
		BEGIN		
			select @boni= isnull(sum(valor),0) from planilla_boni_moto , planilla_boni_concepto
				where mesanio=( @anio+@mes) and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
					and codi_conc='199998' and tipo='M' and codi_pers=@pers
		end
		else
		BEGIN		
			select @boni= isnull(sum(valor),0) from planilla_boni_moto , planilla_boni_concepto
				where mesanio=( @mes + @anio ) and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
					and codi_conc='199998' and tipo='M' and codi_pers=@pers
		end

		set @diasb=0
		set @diasb= dbo.F_DIAS_SALIDA(@anio,@pers,'1',@mes)

		insert into #temporal (persona , toneladas , salidas , diasboni, participacion ,  bonificacion , nombre, censo, dni )
		values (@pers, @pes, @dias, @diasb, @par,@boni, @nom, @ce,  @dn)

		fetch C1 into  @pers
	end
	close C1
	deallocate C1

	select * from #temporal
End
GO
