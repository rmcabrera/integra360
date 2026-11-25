CREATE PROCEDURE [dbo].[SP_Plan_BoniTRipu_Neto_pagar]
	@sema [char](8),
	@embar [char](5)
WITH EXECUTE AS CALLER
AS
Begin
	Declare @per char(5)
	Declare @car char(4)
	declare @net numeric(12,3)
	declare @p varchar(70)
	declare @sem char(8)
	declare @emb char(5)
	create Table #Temporal (codi_pers char(5) null , codi_carg char(4) null, neto numeric(12,3)  null , persona varchar(70) null , semana char(8) null, embar char(5) null)	
	Declare C2 cursor for 
	--select distinct codi_pers, codi_carg  , codi_unid_oper from planilla_pesca_tripulantes where espe_monto <>0 and codi_sema=@sema and 
	--		 codi_unid_oper=@embar
	select distinct codi_pers, codi_unid_oper from planilla_pesca_tripulantes where espe_monto <>0 and codi_sema=@sema and 
			 codi_unid_oper=@embar
	open C2
	fetch C2 into @per, @emb
--	fetch C2 into @per, @car ,@emb
	WHILE @@FETCH_STATUS = 0
	begin	
		select @car = CODI_CARG from planilla_pesca_tripulantes where espe_monto <>0 and codi_sema=@sema and 
			 codi_unid_oper=@embar AND CODI_PERS = @per
		set @net=0
		set @p=null
		select @p=apel_1+ ' ' + apel_2 + ' ' +nomb_1 + ' ' + isnull(nomb_2 , '') from personal where codi_pers=@per
		select @net=valor from planilla_boni_tripu, planilla_bonitri_conceptos where planilla_boni_tripu.codi_plan_btri= planilla_bonitri_conceptos.codi_plan_btri
			and planilla_boni_tripu.codi_pers=@per and planilla_boni_tripu.codi_sema=@sema and codi_unid_oper=@embar
			and planilla_bonitri_conceptos.codi_conc='999990' 
		insert into #temporal(codi_pers, codi_carg, neto , persona, semana, embar) values (@per, @car, @net, @p, @sema, @emb)
		fetch C2 into @per, @emb				
--		fetch C2 into @per, @car,  @emb
	end 
	close C2
	deallocate C2
	select * from #temporal
End
GO
