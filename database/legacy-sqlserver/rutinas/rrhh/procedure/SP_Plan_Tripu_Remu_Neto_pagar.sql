CREATE PROCEDURE [dbo].[SP_Plan_Tripu_Remu_Neto_pagar]
	@semana [char](8),
	@embar [char](5),
	@nasis [char](1)
WITH EXECUTE AS CALLER
AS
Begin

/* ----ESTO ESTABA EN CRID
	Declare @per char(5)   
	Declare @car char(4)
	declare @net numeric(12,3)      
	declare @p varchar(70)
	declare @sem char(8)
	Declare @emb char(5)
	create Table #Temporal (codi_pers char(5) null , codi_carg char(4) null, neto numeric(12,3)  null , persona varchar(70) null , semana char(8) null, embar char(5) null)	
	Declare C1 cursor for select codi_pers, codi_carg , codi_sema, codi_unid_oper from asistencia_tripulantes_pesca where codi_sema=@semana 
		and codi_unid_oper=@embar and nro_asis=@asi
	open C1  
	fetch C1 into @per, @car, @sem, @emb
	WHILE @@FETCH_STATUS = 0    
	begin	
		set @net=0
		set @p= null
		select @p=apel_1+ ' ' + apel_2 + ' ' +nomb_1 + ' ' + nomb_2 from personal where codi_pers=@per
		select @net= ISNULL(valor, 0) from planilla_de_tripulantes, planilla_tripulante_conceptos 
			where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_pers=@per and planilla_de_tripulantes.codi_unid_oper=@embar and planilla_de_tripulantes.codi_sema=@semana
			and planilla_tripulante_conceptos.codi_conc='999990' and nro_asis=@asi
		insert into #temporal(codi_pers, codi_carg, neto, persona, semana, embar) values (@per, @car, @net, @p, @sem , @emb)
				
		fetch C1 into @per, @car ,@sem, @emb
	end 
	close C1
	deallocate C1
	select * from #temporal */


----ESTO ES DE FACOISA


	Declare @per char(5)
	Declare @car char(4)
	declare @net numeric(12,3)
	declare @p varchar(70)
	declare @sem char(8)
	Declare @emb char(5)
	create Table #Temporal (codi_pers char(5) null , codi_carg char(4) null, neto numeric(12,3)  null , persona varchar(70) null , semana char(8) null, embar char(5) null)	
	Declare C1 cursor for select codi_pers, codi_carg , codi_sema, codi_unid_oper from asistencia_tripulantes_pesca where codi_sema=@semana 
		and codi_unid_oper=@embar and nro_asis=@nasis
	open C1
	fetch C1 into @per, @car, @sem, @emb
	WHILE @@FETCH_STATUS = 0
	begin	
		set @net=0
		set @p= null
		select @p=apel_1+ ' ' + apel_2 + ' ' +nomb_1 + ' ' + nomb_2 from personal where codi_pers=@per
		select @net=valor from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_pers=@per and planilla_de_tripulantes.codi_unid_oper=@embar and planilla_de_tripulantes.codi_sema=@semana
			and planilla_tripulante_conceptos.codi_conc='999990' and nro_asis=@nasis
		insert into #temporal(codi_pers, codi_carg, neto, persona, semana, embar) values (@per, @car, @net, @p, @sem , @emb)
				
		fetch C1 into @per, @car ,@sem, @emb
	end 
	close C1
	deallocate C1
	select * from #temporal
End
GO
