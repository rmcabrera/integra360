CREATE PROCEDURE [dbo].[SP_REPORTE_PLANILLA_PESCA]
	@embar [char](5),
	@semana [char](8)
WITH EXECUTE AS CALLER
AS
BEGIN	
	declare @fini datetime
	declare @fter datetime
	declare @faux datetime
	declare @per char(5)
	declare @car char(4)
	declare @nper varchar(70)
	declare @cens char(8)
	Declare @bru numeric(12,2)
	Declare @net numeric(12,2)
	Declare @cbs numeric(12,2)
	Declare @rq numeric(12,2)
	Declare @ade numeric(12,2)
	Declare @ct numeric(12,2)
	Declare @jud numeric(12,2)
	Declare @otr numeric(12,2)
	Declare @dd  numeric(2)
	declare @mt numeric(12,2)	
	declare @dn varchar(15)
	declare @pr numeric(12,2)
	declare @tn numeric(12,2)
	create Table #temporal (codper char(5) null , personas varchar(70) null, cargo char(4) null,censo char(8) null, jueves numeric(12,2) null , viernes numeric(12,2) null , 
		sabado numeric(12,2) null , domingo numeric(12,2) null , lunes numeric(12,2) null , martes numeric(12,2) null , miercoles numeric(12,2) null , bruto numeric(12,2) null,
		cbssp numeric(12,2) null, IRqta numeric(12,2) null, CtaCte numeric(12,2) null, Judicial numeric(12,2) null, GRepub numeric(12,2) null, otros numeric(12,2) null,
		neto numeric (12,2) null, dias numeric(2) null, inicio datetime null, nrosema char(2) null ,cembar char(5) null, jut numeric(12,2) null, vit numeric(12,2) null,
		sat numeric(12,2) null, dot numeric(12,2) null, lut numeric(12,2) null, mat numeric(12,2) null, mit numeric(12,2) null, precio numeric(12,2) null)
	
	declare @ns char(2)
	Select @fini=fech_inic , @fter=fech_term , @ns = nro_sema from semana where codi_sema=@semana
	
	declare C1 cursor for select codi_pers,codi_carg from asistencia_tripulantes_pesca where codi_unid_oper=@embar and codi_sema=@semana;
	open C1
	fetch C1 into @per, @car
	WHILE @@FETCH_STATUS = 0
	begin
		set @nper=''
		set @cens=''
		set @bru=0
		Set @net=0
		set @dd=0
		set @cbs=0
		set @otr=0
		set @ct=0
		set @rq=0
		set @jud=0
		set @pr =0
		set @tn =0
		set @ade=0
		select @nper=apel_1+' ' +apel_2+ ' ' +nomb_1+ ' '+nomb_2 , @cens =NRO_CENSO from personal where codi_pers=@per
		
		select @bru=valor from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_unid_oper=@embar and planilla_de_tripulantes.codi_sema=@semana and planilla_de_tripulantes.codi_pers=@per
			and planilla_tripulante_conceptos.codi_conc='100200'

		select @net=valor from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_unid_oper=@embar and planilla_de_tripulantes.codi_sema=@semana and planilla_de_tripulantes.codi_pers=@per
			and planilla_tripulante_conceptos.codi_conc='999990'

		select @cbs=sum(valor) from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_unid_oper=@embar and planilla_de_tripulantes.codi_sema=@semana and planilla_de_tripulantes.codi_pers=@per
			and (planilla_tripulante_conceptos.codi_conc='200100' or planilla_tripulante_conceptos.codi_conc='200101' or planilla_tripulante_conceptos.codi_conc='200102'
			or planilla_tripulante_conceptos.codi_conc='200103' )

		select @rq=valor from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_unid_oper=@embar and planilla_de_tripulantes.codi_sema=@semana and planilla_de_tripulantes.codi_pers=@per
			and planilla_tripulante_conceptos.codi_conc='200040'

		if (@rq is null) set @rq=0

		select @ct=sum(valor) from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_unid_oper=@embar and planilla_de_tripulantes.codi_sema=@semana and planilla_de_tripulantes.codi_pers=@per
			and ( (planilla_tripulante_conceptos.codi_conc>='200001' and planilla_tripulante_conceptos.codi_conc<='200009') or 
				(planilla_tripulante_conceptos.codi_conc>='200091' and planilla_tripulante_conceptos.codi_conc<='200099'))

		if (@ct is null) set @ct=0

		select @ade=sum(valor) from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_unid_oper=@embar and planilla_de_tripulantes.codi_sema=@semana and planilla_de_tripulantes.codi_pers=@per
			and ( planilla_tripulante_conceptos.codi_conc>='200051' and planilla_tripulante_conceptos.codi_conc<='200059')

		if (@ade is null) set @ade=0
				
		select @jud=sum(valor) from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_unid_oper=@embar and planilla_de_tripulantes.codi_sema=@semana and planilla_de_tripulantes.codi_pers=@per
			and ( (planilla_tripulante_conceptos.codi_conc>='200011' and planilla_tripulante_conceptos.codi_conc<='200019'))
				
		if (@jud is null) set @jud=0

		select @otr=sum(valor) from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_unid_oper=@embar and planilla_de_tripulantes.codi_sema=@semana and planilla_de_tripulantes.codi_pers=@per and left(codi_conc,1)='2'
			and  not ((planilla_tripulante_conceptos.codi_conc>='200051' and planilla_tripulante_conceptos.codi_conc<='200059') or 
				(planilla_tripulante_conceptos.codi_conc>='200001' and planilla_tripulante_conceptos.codi_conc<='200009') or
				(planilla_tripulante_conceptos.codi_conc>='200091' and planilla_tripulante_conceptos.codi_conc<='200099') or 
				planilla_tripulante_conceptos.codi_conc='200040' or planilla_tripulante_conceptos.codi_conc='200100' or 
				planilla_tripulante_conceptos.codi_conc='200101'or planilla_tripulante_conceptos.codi_conc='200102' or
				 planilla_tripulante_conceptos.codi_conc='200103' or  planilla_tripulante_conceptos.codi_conc='299999'   )

		if (@otr is null) set @otr=0
	
		set @dd=dbo.F_Dias_traba_trip (@Semana , @Embar, @per)  
		set @pr= dbo.F_Precio_SNP(@semana)
		insert into #temporal (codper, personas,  cargo, censo, bruto, cbssp , irqta, ctacte, judicial ,grepub, otros,neto, dias, inicio, nrosema, cembar, precio)
			values(@per,@nper,@car,   @cens, @bru, @cbs, @rq, @ct, @jud, @ade,@otr, @net, @dd, @fini, @ns, @embar,@pr)
		
		set @faux=@fini
		while (@faux<=@fter)
		begin
			select @mt= monto from planilla_pesca_tripulantes where codi_unid_oper=@embar and codi_sema=@semana 
				and codi_pers=@per and dia=@faux
			if (@mt is null)	set @mt=0
			set @tn=0
			set @tn= dbo.F_Toneladas_Dias(@faux, @embar, @PER)
			if (@tn is null)	set @tn=0
			set @dn = DATENAME ( weekday , @Faux )
		 	if (@Dn='Jueves') update #temporal set jueves=@mt , jut=@tn where codper=@per
		 	if (@Dn='Viernes') update #temporal set viernes=@mt , vit=@tn where codper=@per
		 	if (@Dn='Sábado') update #temporal set sabado=@mt  , sat=@tn where codper=@per
		 	if (@Dn='Domingo') update #temporal set domingo=@mt  , dot=@tn where codper=@per
		 	if (@Dn='Lunes') update #temporal set lunes=@mt  , lut=@tn where codper=@per
		 	if (@Dn='Martes') update #temporal set martes=@mt  , mat=@tn where codper=@per
		 	if (@Dn='Miercoles') update #temporal set miercoles=@mt  , mit=@tn where codper=@per
	             		set @Faux=DATEADD(day,1,@Faux)		
		end 
		fetch C1 into @per, @car
	end
	close C1
	deallocate C1

	select * from #temporal

END
GO
