CREATE PROCEDURE [dbo].[SP_REPORTE_PLANILLA_SUBSIDIO]
	@embar [char](5),
	@SEMA [char](8),
	@fter [datetime]
WITH EXECUTE AS CALLER
AS
BEGIN	
	declare @fini datetime
	declare @faux datetime
	declare @per varchar(5)
	declare @car varchar(4)
	declare @nper varchar(70)
	declare @cens varchar(8)
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
	Declare @jud  numeric(12,2)

	create Table #temporal (codper char(5) null , personas varchar(70) null, cargo varchar(4) null,censo varchar(8) null, bruto numeric(12,2) null,
		cbssp numeric(12,2) null, cbssp2 numeric(12,2) null,cbssp3 numeric(12,2) null , cbssp4 numeric(12,2) null,  IRqta numeric(12,2) null, 
		CtaCte numeric(12,2) null, otros numeric(12,2) null, deduc numeric(12,2) null,
		neto numeric (12,2) null, mes char(8) null ,cembar varchar(5) null, p1 numeric(12,2) null, p2 numeric(12,2) null,
		p3 numeric(12,2) null, p4 numeric(12,2) null, p5 numeric(12,2) null, p6 numeric(12,2) null, p7 numeric(12,2) null, Totapor numeric(12,2) null, 
		c1 numeric(12,2) null, c2 numeric(12,2) null, c3 numeric(12,2) null , c4 numeric(12,2) null, c5 numeric(12,2) null, c6 numeric(12,2) null ,c7 numeric(12,2) null,
		c8 numeric(12,2) null,  c9 numeric(12,2) null , c10 numeric(12,2) null,  c11 numeric(12,2) null)
	
	declare @ns char(2)
	
--	Select @fini=fech_inic , @fter=fech_term , @ns = nro_sema from semana where codi_sema=@semana
	
	declare @ccc numeric(12,2)
	select @cc1= valor  from valores_unitarios_anuales where codi_valo_unit=18 and ( fech_asig<= @fter and fech_asig_fin >= @fter)	---- pension
	select @cc2 =valor  from valores_unitarios_anuales where codi_valo_unit=17 and (fech_asig<= @fter and fech_asig_fin >= @fter)		--- prestac
	select @cc3 =valor  from valores_unitarios_anuales where codi_valo_unit=19 and (fech_asig<= @fter and fech_asig_fin >= @fter)		---- subsid
	select @cc4 =valor  from valores_unitarios_anuales where codi_valo_unit=16 and (fech_asig<= @fter and fech_asig_fin >= @fter)		---c sind	
	select @cc5 =valor  from valores_unitarios_anuales where codi_valo_unit=23 and (fech_asig<= @fter and fech_asig_fin >= @fter)		--- pens apor
	select @cc6 =valor  from valores_unitarios_anuales where codi_valo_unit=20 and (fech_asig<= @fter and fech_asig_fin >= @fter)		--- prest apor
	select @cc7 =valor  from valores_unitarios_anuales where codi_valo_unit=21 and (fech_asig<= @fter and fech_asig_fin >= @fter)		--- subsid apor
	select @cc8 =valor  from valores_unitarios_anuales where codi_valo_unit=22 and (fech_asig<= @fter and fech_asig_fin >= @fter)		--- compen
	select @cc9 =valor  from valores_unitarios_anuales where codi_valo_unit=24 and (fech_asig<= @fter and fech_asig_fin >= @fter)		--- gratifi
	select @cc10= valor  from valores_unitarios_anuales where codi_valo_unit=10 and (fech_asig<= @fter and fech_asig_fin >= @fter)	------ IES
	select @cc11 =valor  from valores_unitarios_anuales where codi_valo_unit=46 and (fech_asig<= @fter and fech_asig_fin >= @fter)	--- SCTR salud
--	select @ccc =valor  from valores_unitarios_anuales where codi_valo_unit=37 and (fech_asig<= @fter and fech_asig_fin >= @fter)	--- SCTR  pension

--	set @cc11=@cc11 + @ccc

	declare C1 cursor for select codi_pers,codi_carg from subsidios where codi_unid_oper=@embar and codi_sema=@sema;
	open C1
	fetch C1 into @per, @car
	WHILE @@FETCH_STATUS = 0
	begin
		set @nper=''
		set @cens=''
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

		select @nper=apel_1+' ' +apel_2+ ' ' +nomb_1+ ' '+nomb_2 , @cens =NRO_CENSO from personal where codi_pers=@per
	
		select @bru=valor from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and planilla_subs_concepto.codi_conc='199999' 

		select @net=valor from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and planilla_subs_concepto.codi_conc='999990' 

		select @cbs=valor from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and planilla_subs_concepto.codi_conc='200101' 

		if (@cbs is null) set @cbs=0

		select @cbs2=valor from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and planilla_subs_concepto.codi_conc='200100' 

		if (@cbs2 is null) set @cbs2=0

		select @cbs3=valor from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and planilla_subs_concepto.codi_conc='200102' 

		if (@cbs3 is null) set @cbs3=0

		select @cbs4=valor from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and ( planilla_subs_concepto.codi_conc>='200011' and planilla_subs_concepto.codi_conc<='200019') 

		if (@cbs4 is null) set @cbs4=0


		select @rq=valor from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and planilla_subs_concepto.codi_conc='200040' 

		if (@rq is null) set @rq=0

		select @ct=sum(valor) from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and ( (planilla_subs_concepto.codi_conc>='200001' and planilla_subs_concepto.codi_conc<='200009') or 
				(planilla_subs_concepto.codi_conc>='200091' and planilla_subs_concepto.codi_conc<='200099')  ) 


		if (@ct is null) set @ct=0

		select @otr=sum(valor) from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and  not (( planilla_subs_concepto.codi_conc>='200011' and planilla_subs_concepto.codi_conc<='200019') or 
				(planilla_subs_concepto.codi_conc>='200001' and planilla_subs_concepto.codi_conc<='200009') or
				(planilla_subs_concepto.codi_conc>='200091' and planilla_subs_concepto.codi_conc<='200099') or 
				planilla_subs_concepto.codi_conc='200040' or planilla_subs_concepto.codi_conc='200100' or 
				planilla_subs_concepto.codi_conc='200101'or planilla_subs_concepto.codi_conc='200102' or
				 planilla_subs_concepto.codi_conc='200103' or  planilla_subs_concepto.codi_conc='299999'   ) 
				AND left(codi_conc,1)='2' 



		if (@otr is null) set @otr=0

		select @ded=valor from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and planilla_subs_concepto.codi_conc='299999' 
	
		if (@ded is null) set @ded=0


		select @ap1=valor from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and planilla_subs_concepto.codi_conc='300033' 

		if (@ap1 is null) set @ap1=0


		select @ap2=valor from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and planilla_subs_concepto.codi_conc='300030' 

		if (@ap2 is null) set @ap2=0

		select @ap3=valor from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and planilla_subs_concepto.codi_conc='300031' 


		if (@ap3 is null) set @ap3=0

		select @ap4=valor from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and planilla_subs_concepto.codi_conc='300032' 
		if (@ap4 is null) set @ap4=0

		select @ap5=valor from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and planilla_subs_concepto.codi_conc='300034' 


		if (@ap5 is null) set @ap5=0

		select @ap6=valor from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and planilla_subs_concepto.codi_conc='300000' 
		if (@ap6 is null) set @ap6=0

		select @ap7=sum(valor) from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and (planilla_subs_concepto.codi_conc='300020' or  planilla_subs_concepto.codi_conc='300021' )

		if (@ap7 is null) set @ap7=0

		select @tap=sum(valor) from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and planilla_subsidio.codi_unid_oper=@embar and planilla_subsidio.codi_sema=@sema and planilla_subsidio.codi_pers=@per
			and planilla_subs_concepto.codi_conc='399999'  

		if (@tap is null) set @tap=0

		insert into #temporal (codper, personas,  cargo, censo, bruto, cbssp ,cbssp2,cbssp3,cbssp4, irqta, ctacte, otros,deduc,neto,  mes, cembar,
			p1,p2, p3, p4, p5, p6, p7, totapor ,c1, c2, c3,c4, c5, c6, c7, c8, c9, c10, c11)
			values(@per,@nper,@car,   @cens, @bru, @cbs,@cbs2,@cbs3,@cbs4, @rq, @ct, @otr,@ded, @net, @sema, @embar,
			@ap1, @ap2, @ap3, @ap4, @ap5, @ap6, @ap7, @tap, @cc1, @cc2,@cc3,@cc4,@cc5,@cc6,@cc7,@cc8,@cc9,@cc10,@cc11)
		
		fetch C1 into @per, @car
	end
	close C1
	deallocate C1

	select * from #temporal

END
GO
