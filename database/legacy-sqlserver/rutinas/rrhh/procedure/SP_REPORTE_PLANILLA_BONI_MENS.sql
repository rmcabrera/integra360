CREATE PROCEDURE [dbo].[SP_REPORTE_PLANILLA_BONI_MENS]
	@embar [char](5),
	@MESA [char](6),
	@fter [datetime]
WITH EXECUTE AS CALLER
AS
BEGIN	
	declare @per char(5)
	declare @car char(4)
	declare @nper varchar(70)
	declare @nomc varchar(20)
	declare @cens char(8)
	Declare @bru numeric(12,2)
	Declare @net numeric(12,2)
	Declare @cbs numeric(12,2) 
	Declare @cbs2 numeric(12,2)
	Declare @cbs3 numeric(12,2)
	Declare @cbs4 numeric(12,2)
	Declare @rq numeric(12,2)
	Declare @ct numeric(12,2)
	Declare @otr numeric(12,2)
	Declare @ded  numeric(12,2)
	Declare @ap1 numeric(12,2)
	Declare @ap2 numeric(12,2)
	Declare @ap3 numeric(12,2)
	Declare @ap4 numeric(12,2)
	Declare @ap5 numeric(12,2)
	Declare @ap6 numeric(12,2)
	Declare @ap7 numeric(12,2)
	Declare @tap numeric(12,2)
	Declare @cc1 numeric(12,2)
	Declare @cc2 numeric(12,2)
	Declare @cc3 numeric(12,2)
	Declare @cc4 numeric(12,2)
	Declare @cc5 numeric(12,2)
	Declare @cc6 numeric(12,2)
	Declare @cc7 numeric(12,2)
	Declare @cc8 numeric(12,2)
	Declare @cc9 numeric(12,2)
	Declare @cc10 numeric(12,2)
	Declare @cc11 numeric(12,2)
	Declare @VLU numeric(12,2)
	declare @di int

	create Table #temporal (codper char(5) null , personas varchar(70) null, cargo char(4) null,censo char(8) null, bruto numeric(12,2) null,
		cbssp numeric(12,2) null, cbssp2 numeric(12,2) null,cbssp3 numeric(12,2) null , cbssp4 numeric(12,2) null,  IRqta numeric(12,2) null, 
		CtaCte numeric(12,2) null, otros numeric(12,2) null, deduc numeric(12,2) null,
		neto numeric (12,2) null, inicio datetime null, nrosema char(2) null ,cembar char(5) null, p1 numeric(12,2) null, p2 numeric(12,2) null,
		p3 numeric(12,2) null, p4 numeric(12,2) null, p5 numeric(12,2) null, p6 numeric(12,2) null, p7 numeric(12,2) null, Totapor numeric(12,2) null, 
		c1 numeric(12,2) null, c2 numeric(12,2) null, c3 numeric(12,2) null , c4 numeric(12,2) null, c5 numeric(12,2) null, c6 numeric(12,2) null ,c7 numeric(12,2) null,
		c8 numeric(12,2) null,  c9 numeric(12,2) null , c10 numeric(12,2) null,  c11 numeric(12,2) null, dias int null, nomcar varchar(20) null)
	
	declare @ns char(2)


	declare C1 cursor for select codi_pers,codi_carg from asistencia_motorista	where codi_unid_oper=@embar and mesanio=@mesa
	open C1
	fetch C1 into @per, @car
	WHILE @@FETCH_STATUS = 0
	begin
		set @nper=''
		set @cens=''
		set @nomc=''
		set @bru=0
		Set @net=0
		set @ded=0
		set @cbs=0
		set @cbs2=0
		set @cbs3=0
		set @cbs4=0
		set @otr=0
		set @ct=0
		set @rq=0
		set @ap1=0
		set @ap2=0
		set @ap3=0
		set @ap4=0
		set @ap5=0
		set @ap6=0
		set @ap7=0
		set @tap=0
		set @di=0

		set @nomc = (select abrev from cargos where codi_carg=@car)

		if (@car='1001')	set @di =  dbo.F_Dias_PAtron ( @embar  ,@mesa , @per)  
		else	set @di =  dbo.F_Dias_traba_Moto (@mesa , @embar  , @per, 'M')  

		select @nper=apel_1+' ' +apel_2+ ' ' +nomb_1+ ' '+nomb_2 , @cens =NRO_CENSO from personal where codi_pers=@per
		
		select @bru=sum(valor) from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and not (codi_conc='101901' or codi_conc='101902' or codi_conc='199999'  or codi_conc='199998' )  and tipo='M' and left(codi_conc,1)='1'

		select @net=valor from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and planilla_boni_concepto.codi_conc='999990' and tipo='M'

		select @cbs=sum(valor) from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and planilla_boni_concepto.codi_conc='101901'   and tipo='M'	---  VACACIONES
		if (@cbs is null) set @cbs=0
		select @cc1= valor  from valores_unitarios_anuales where codi_valo_unit IN (Select codi_valo_unit from conceptos_afectos_planillas where codi_tipo_plan='14' and 
			codi_conc='101901')  and ( fech_asig<= @fter and fech_asig_fin >= @fter)	---- VACACIONES

		select @cbs2=sum(valor) from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and planilla_boni_concepto.codi_conc='101902'   and tipo='M'	---- GRATIFICACIONES

		select @cc2= valor  from valores_unitarios_anuales where codi_valo_unit IN (Select codi_valo_unit from conceptos_afectos_planillas where codi_tipo_plan='14' and 
			codi_conc='101902')  and ( fech_asig<= @fter and fech_asig_fin >= @fter)	---- GRATIFICACIONES

		if (@cbs2 is null) set @cbs2=0

		select @cbs3=sum(valor) from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and planilla_boni_concepto.codi_conc='199998'  and tipo='M'		---- INGRESOS AFECTOS

		if (@cbs3 is null) set @cbs3=0

		select @cbs4=sum(valor) from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and  planilla_boni_concepto.codi_conc='200101'   and tipo='M'	---- PENSIONES
		if (@cbs4 is null) set @cbs4=0
		select @cc4= valor  from valores_unitarios_anuales where codi_valo_unit IN (Select codi_valo_unit from conceptos_afectos_planillas where codi_tipo_plan='14' and 
			codi_conc='200101')  and ( fech_asig<= @fter and fech_asig_fin >= @fter)	---- PENSIONES


		select @rq=valor from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and planilla_boni_concepto.codi_conc='200040' and tipo='M'

		if (@rq is null) set @rq=0

		select @ct=sum(valor) from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and (	(planilla_boni_concepto.codi_conc>='200091' and planilla_boni_concepto.codi_conc<='200099') or
				( planilla_boni_concepto.codi_conc>='200051' and planilla_boni_concepto.codi_conc<='200059') or 
				( planilla_boni_concepto.codi_conc>='200001' and planilla_boni_concepto.codi_conc<='200009') ) and tipo='M'

		if (@ct is null) set @ct=0

		select @ap7=sum(valor) from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per and left(codi_conc,1)='2'
			and  (planilla_boni_concepto.codi_conc>='200010' and planilla_boni_concepto.codi_conc<='200019') and tipo='M'

		if (@ap7 is null) set @ap7 =0


		select @otr=sum(valor) from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per and left(codi_conc,1)='2'
			and  not (   (planilla_boni_concepto.codi_conc>='200010' and planilla_boni_concepto.codi_conc<='200019') or
				(planilla_boni_concepto.codi_conc>='200051' and planilla_boni_concepto.codi_conc<='200059') or 
				(planilla_boni_concepto.codi_conc>='200091' and planilla_boni_concepto.codi_conc<='200099') or 
				( planilla_boni_concepto.codi_conc>='200001' and planilla_boni_concepto.codi_conc<='200009') or 
				planilla_boni_concepto.codi_conc='200040' or planilla_boni_concepto.codi_conc='200100' or 
				planilla_boni_concepto.codi_conc='200101'or planilla_boni_concepto.codi_conc='200102' or
				 planilla_boni_concepto.codi_conc='200103' or  planilla_boni_concepto.codi_conc='299999'   ) and tipo='M'

		if (@otr is null) set @otr=0
	
		select @ded=valor from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and planilla_boni_concepto.codi_conc='299999'   and tipo='M'		--- total descuentos

		if (@ded is null) set @ded=0

		select @ap1=valor from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and planilla_boni_concepto.codi_conc='200103'  and tipo='M'			---- CUOTA SINDICAL

		select @cc5= valor  from valores_unitarios_anuales where codi_valo_unit IN (Select codi_valo_unit from conceptos_afectos_planillas where codi_tipo_plan='14' and 
			codi_conc='200103')  and ( fech_asig<= @fter and fech_asig_fin >= @fter)	---- CUOTA SINDICAL

		if (@ap1 is null) set @ap1=0

		select @ap2=valor from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and planilla_boni_concepto.codi_conc='200103'  	and tipo='M'		----CUOTA SINDICAL

		if (@ap2 is null) set @ap2=0

		select @ap3=valor from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and planilla_boni_concepto.codi_conc='300033' 	and tipo='M'		---- PENSIONES APORTACIONES
		if (@ap3 is null) set @ap3=0
		select @cc7= valor  from valores_unitarios_anuales where codi_valo_unit IN (Select codi_valo_unit from conceptos_afectos_planillas where codi_tipo_plan='14' and 
			codi_conc='300033')  and ( fech_asig<= @fter and fech_asig_fin >= @fter)	---- PENSIONES APORTACIONES

		select @ap4=valor from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and planilla_boni_concepto.codi_conc='301050'  	and tipo='M'	--- ADMINISTRACION
		if (@ap4 is null) set @ap4=0
		select @cc8= valor  from valores_unitarios_anuales where codi_valo_unit IN (Select codi_valo_unit from conceptos_afectos_planillas where codi_tipo_plan='14' and 
			codi_conc='301050')  and ( fech_asig<= @fter and fech_asig_fin >= @fter)		---ADMINISTRACION

		select @ap5=valor from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and planilla_boni_concepto.codi_conc='301051'  	and tipo='M'		--- SALUD

		if (@ap5 is null) set @ap5=0
		select @cc9= valor  from valores_unitarios_anuales where codi_valo_unit IN (Select codi_valo_unit from conceptos_afectos_planillas where codi_tipo_plan='14' and 
			codi_conc='301051')  and ( fech_asig<= @fter and fech_asig_fin >= @fter)	-----    SALUD

		set @ap6 =(select sum(valor) from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and (planilla_boni_concepto.codi_conc='300020'  or  planilla_boni_concepto.codi_conc='300021'  ) and tipo='M')		---- SCTR

		if (@ap6 is null) set @ap6=0

		set @cc10= (select sum(valor)  from valores_unitarios_anuales where codi_valo_unit IN (Select codi_valo_unit from conceptos_afectos_planillas where codi_tipo_plan='14' and 
			(codi_conc='300020'   or codi_conc='300021' )and ( fech_asig<= @fter and fech_asig_fin >= @fter)))	--    SCTR

	--	select @ap7=valor from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
	--		and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
	--		and planilla_boni_concepto.codi_conc='301052'  and tipo='M'		----   CTS
	--	if (@ap7 is null) set @ap7=0

		select @cc11= valor  from valores_unitarios_anuales where codi_valo_unit IN (Select codi_valo_unit from conceptos_afectos_planillas where codi_tipo_plan='14' and 
			codi_conc='301052')  and ( fech_asig<= @fter and fech_asig_fin >= @fter)	---  CTS

		select @tap=valor from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
			and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa and planilla_boni_moto.codi_pers=@per
			and planilla_boni_concepto.codi_conc='399999'  	and tipo='M'		--- pension

		if (@tap is null) set @tap=0

		insert into #temporal (codper, personas,  cargo, censo, bruto, cbssp ,cbssp2,cbssp3,cbssp4, irqta, ctacte, otros,deduc,neto,  inicio, nrosema, cembar,
			p1,p2, p3, p4, p5, p6, p7, totapor ,c1, c2, c3,c4, c5, c6, c7, c8, c9, c10, c11, dias, nomcar)
		values(@per,@nper,@car,   @cens, @bru, @cbs,@cbs2,@cbs3,@cbs4, @rq, @ct, @otr,@ded, @net, @fter, @ns, @embar,
			@ap1, @ap2, @ap3, @ap4, @ap5, @ap6, @ap7, @tap, @cc1, @cc2,@cc3,@cc4,@cc5,@cc6,@cc7,@cc8,@cc9,@cc10,@cc11, @di, @nomc)
		
		fetch C1 into @per, @car
	end
	close C1
	deallocate C1

	select * from #temporal

END
GO
