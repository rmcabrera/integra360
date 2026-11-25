CREATE PROCEDURE [dbo].[SP_Boletas_tripu_boni]
	@sem [char](8),
	@embar [char](5)
WITH EXECUTE AS CALLER
AS
begin
	declare @seman varchar(100)
	declare @persona char(5)
	declare @fini datetime
	declare @fter datetime
	declare @fi datetime
	declare @dni varchar(20)
	declare @fc datetime
	declare @nomb varchar(150)
	declare @nro varchar(2)
 	declare @desc varchar(20)
	Declare @carg  char(4)
	declare @dcarg varchar(50)
	declare @nrocen varchar(15)
	declare @dias int 
	declare  @tone numeric(12,3)
	declare @id char(10)
	declare @ssalud varchar(30)
	select @nro = nro_sema ,@fini = fech_inic, @fter= fech_term from semana where codi_sema=@sem
	set @seman='SEMANA N° '+@nro + ' DEL ' + convert(char(10),@fini,103) + ' AL ' +convert(char(10),@fter,103)
	
	select @desc = desc_unid_oper from embarcaciones where codi_unid_oper=@embar
	
	create Table #Temporal (codi_plan_trip char(10) null, sema varchar(100) null, descri varchar(100) null, codipers char(5) null, nombre varchar(150) null,
		codicargo char(4) null, dcargo varchar(50) null, nrocenso varchar(15) null, diastrab int null, toneladas numeric(12,3) null,
		fechaing datetime null, fechacese datetime null , nombole varchar(150) null, carbole varchar(150) null , nro_docu_iden varchar(20) null, essalud varchar(30) null)
	
	create table #Temporal2 (codi_pers char(5) null, codi_conc char(6) null, valor numeric(12,2) null, monto numeric(12,2), desc_conc varchar(60) null, fech_inic datetime null)

	create table #temporal4(codi_pers char(5) null, TrabJu int null, TrabVi int null, TrabSA int null, TrabDo int null, TrabLu int null, TrabMa int null, TrabMi int null)

	create table #temporal3 (codi_pers char(5) null, Sju char(5) null, Svi char(5) null, Ssa char(5) null, SDo char(5) null, SLu char(5) null, SMa char(5) null, SMi char(5) null, 
		Jueves numeric(12,3) null, Viernes numeric(12,3) null, Sabado numeric(12,3) null, Domingo numeric(12,3) null, Lunes numeric(12,3) null,
		Martes numeric(12,3) null, Miercoles numeric(12,3) null)

	Declare C1 cursor for select codi_plan_btri, codi_pers from planilla_boni_tripu where codi_sema=@sem and codi_unid_oper=@embar
			and codi_pers<>'00000'
	open c1
	fetch C1 into @id, @persona
	WHILE @@FETCH_STATUS = 0
	begin	
		set @nomb =''
		set @carg  =''
		set @dni  =''
		set @dcarg =''
		set @nrocen =''
		set @dias =0
		set @tone =0
		set @fi= null
		set @fc=null
		select  @ssalud = carn_essalud , @dni= nro_docu_iden, @fi =fech_ingre, @fc=fech_cese, @nrocen= nro_censo, @carg= codi_carg,  @nomb=upper(apel_1+ '  ' + isnull(apel_2 ,'') +'  ' + isnull(nomb_1,'') +'  ' + isnull(nomb_2 , ''))
			from personal where codi_pers=@persona
		select @dcarg = desc_cargo from cargos where codi_carg= @carg
		set @dias=dbo.F_Dias_traba_trip(@sem,@embar , @persona ) 

		insert into #Temporal (codi_plan_trip, sema , descri , codipers , nombre ,codicargo , dcargo , nrocenso , diastrab , toneladas, fechaing, fechacese , nro_docu_iden, essalud)
			values (@id, @seman, @desc,@persona,  @nomb, @carg, @dcarg, @nrocen, @dias, @tone,  @fi, @fc,@dni , @ssalud )	

		insert into #Temporal2 
			select @persona, Planilla_BoniTri_Conceptos.codi_conc, valor, monto, desc_conc , @fini
			from Planilla_BoniTri_Conceptos , conceptos where
				Planilla_BoniTri_Conceptos.codi_conc= conceptos.codi_conc
				and codi_plan_btri= @id 

		insert into #Temporal3 
			select @persona, sum(case when datepart(dw,dia)=4 then  codi_carg else 0 end), 
				sum(case when datepart(dw,dia)=5 then  codi_carg else 0 end), 
				sum(case when datepart(dw,dia)=6 then  codi_carg else 0 end),
				sum(case when datepart(dw,dia)=7 then  codi_carg else 0 end),
				sum(case when datepart(dw,dia)=1 then  codi_carg else 0 end),
				sum(case when datepart(dw,dia)=2 then  codi_carg else 0 end),
				sum(case when datepart(dw,dia)=3 then  codi_carg else 0 end),
				sum(case when datepart(dw,dia)=4 then  pesc_real else 0 end), 
				sum(case when datepart(dw,dia)=5 then  pesc_real else 0 end), 
				sum(case when datepart(dw,dia)=6 then  pesc_real else 0 end),
				sum(case when datepart(dw,dia)=7 then  pesc_real else 0 end),
				sum(case when datepart(dw,dia)=1 then  pesc_real else 0 end),
				sum(case when datepart(dw,dia)=2 then  pesc_real else 0 end),
				sum(case when datepart(dw,dia)=3 then  pesc_real else 0 end)
				from planilla_pesca_tripulantes
				 where codi_pers=@persona and codi_unid_oper=@embar and codi_sema=@sem
					group by codi_sema 

		insert into #Temporal4 
			select @persona,  sum(case when datepart(dw, dia)=4 then 1 else 0 end),
				sum(case when datepart(dw, dia)=5 then 1 else 0 end),
				sum(case when datepart(dw, dia)=6 then 1 else 0 end),
				sum(case when datepart(dw, dia)=7 then 1 else 0 end),
				sum(case when datepart(dw, dia)=1 then 1 else 0 end),
				sum(case when datepart(dw, dia)=2 then 1 else 0 end),
				sum(case when datepart(dw, dia)=3 then 1 else 0 end)
				 from planilla_pesca_tripulantes 
				where codi_unid_oper=@embar and codi_sema=@sem and monto>0
				group by  codi_sema

		fetch C1 into @id, @persona		
	end
	close C1
	deallocate c1
	
	Declare @nb varchar(150)
	declare @cb varchar(150)
	select @nb=nom_bole, @cb = car_bole from empresa 
	update #temporal set nombole=@nb ,carbole =@cb
	 select * , @sem as Codisem  from #Temporal, #Temporal2, #temporal3, #Temporal4
		 where  #Temporal.codipers= #Temporal2.codi_pers and
			 #Temporal.codipers= #Temporal3.codi_pers and
			 #Temporal2.codi_pers= #Temporal3.codi_pers and 
			#Temporal.codipers= #Temporal4.codi_pers 

--	select * from #temporal3
end
GO
