CREATE PROCEDURE [dbo].[SP_RECORD_PESCA]
	@anio [char](4),
	@pers [char](5)
WITH EXECUTE AS CALLER
AS
Begin
	DEclare @fec1 datetime
	declare @sem varchar(8)	
	declare @unid  char(5)
	declare @pes numeric(12,3)
	declare @par numeric(12,2)
	declare @nsem varchar(5)
	declare @fec2 datetime
	declare @nemb varchar(30)
	DECLARE @dias int
	declare @carg char(4)
	declare @grup varchar(50)
	
	Select @grup = upper(grupo) from empresa

	create table  #temporal (persona char(5),semana char(5) null, fecha1 datetime null, fecha2 datetime null, codi char(5) null, embarca varchar(30) null, toneladas numeric(12,3) null,
		salidas int null, participacion numeric(12,2) null,  bonificacion numeric(12,2) null)
	
	declare C1 cursor for select semana.codi_sema, codi_unid_oper,sum(pesc_real) as Pesca  from planilla_pesca_tripulantes, semana 
			where codi_pers=@pers 	and semana.codi_sema=planilla_pesca_tripulantes.codi_sema 
				and left( planilla_pesca_tripulantes.mesanio ,  4 ) = @anio AND MONTO<>0
			group by semana.codi_sema, codi_unid_oper
	open C1
	fetch C1 into @sem, @unid, @pes
	WHILE @@FETCH_STATUS = 0
	begin
		set @nemb=''
		set @fec1=null
		set @fec2=null
		set @nsem=''
		set @dias= dbo.F_DIAS_SALIDA(@anio,@pers,'0',@sem)
		set @par=0
		set @par=isnull((select sum(valor) from planilla_de_tripulantes , planilla_tripulante_conceptos
				where codi_sema=@sem and codi_pers=@pers and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
					and codi_conc='100200' ),0)
		select @nemb=desc_unid_oper from embarcaciones where codi_unid_oper=@unid
		set @nemb='E/P ' + @nemb
		select @nsem=nro_sema, @fec1=fech_inic, @fec2=fech_term from semana where codi_sema=@sem

		insert into #temporal (persona ,semana , fecha1 , fecha2 , codi , embarca , toneladas , salidas , participacion ,  bonificacion  )
		values (@pers, @nsem,@fec1, @fec2, @unid, @nemb,@pes, @dias, @par,0)
		fetch C1 into @sem, @unid, @pes
		
	end
	close C1
	deallocate C1

	declare @ndias numeric(2)
	declare @ma1 varchar(10)
	declare @ma2 varchar(10)
	declare @nmes1 numeric(4)
	declare @nmes2 numeric(2)
	if @grup =  'BARAKA' 
	BEGIN		
		Declare C2 cursor for select right(mesanio,2),codi_unid_oper, valor from planilla_boni_moto , planilla_boni_concepto
		where left(mesanio,4)=@anio and codi_pers=@pers and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and codi_conc='199998' and tipo='M'
	end
	else
	BEGIN		
		Declare C2 cursor for select left(mesanio,2),codi_unid_oper, valor from planilla_boni_moto , planilla_boni_concepto
		where right(mesanio,4)=@anio and codi_pers=@pers and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and codi_conc='199998' and tipo='M'
	end

	open c2
	fetch C2 into @sem, @unid,  @par
	WHILE @@FETCH_STATUS = 0
	begin
		select @nemb=desc_unid_oper from embarcaciones where codi_unid_oper=@unid
		set @nemb='E/P ' + @nemb
		if ( cast(@sem as numeric)+1 <=12) 
		begin
			set @nmes2= convert(numeric(2) ,@sem) +1
			set @ma1= '01/'+@sem+'/'+@anio
			set @ma2= '01/'+replicate('0', 2 - len(convert(varchar(2),@nmes2) )) +convert(varchar(2),@nmes2) +'/'+@anio
		end
		else
		begin
			set @nmes1= convert(numeric(4) ,@anio) +1
			set @ma1= '01/'+@sem+'/'+@anio
			set @ma2= '01/01/'+convert(varchar(4),@nmes1) 
		end
		set @fec1=cast(@ma1 as datetime)
		set @fec2=cast(@ma2 as datetime)
		set @fec2=dateadd(d, -1 ,@fec2)		
		set @dias= dbo.F_DIAS_SALIDA(@anio,@pers,'1',@sem)
		insert into #temporal (persona ,semana , fecha1 , fecha2 , codi , embarca , toneladas , salidas , participacion ,  bonificacion  )
		values (@pers, @sem+'/'+right(@anio,2),@fec1, @fec2, @unid, @nemb,0, @DIAS, 0,@par)
		
		fetch C2 into @sem, @unid,  @par
	end 
	close C2
	deallocate C2

	select * from #temporal
End
GO
