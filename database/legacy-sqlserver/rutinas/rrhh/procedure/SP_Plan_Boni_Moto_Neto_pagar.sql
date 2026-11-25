CREATE PROCEDURE [dbo].[SP_Plan_Boni_Moto_Neto_pagar]
	@mesa [char](8),
	@embar [char](5),
	@tip [char](1)
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
	if(@tip='Q')	
	begin
		Declare C1 cursor for select codi_pers, codi_carg  , codi_unid_oper from asistencia_motorista where mesanio=@mesa	and (codi_carg='1005' or codi_carg='1007')
		open C1
		fetch C1 into @per, @car ,@emb
		WHILE @@FETCH_STATUS = 0
		begin	
			set @net=0
			set @p=null
			select @p=apel_1+ ' ' + apel_2 + ' ' +nomb_1 + ' ' + nomb_2 from personal where codi_pers=@per
			select @net=valor from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
				and planilla_boni_moto.codi_pers=@per and planilla_boni_moto.codi_unid_oper=@emb and planilla_boni_moto.mesanio=@mesa
				and planilla_boni_concepto.codi_conc='999990' and tipo=@tip
			insert into #temporal(codi_pers, codi_carg, neto , persona, semana, embar) values (@per, @car, @net, @p, @mesa, @emb)
					
			fetch C1 into @per, @car,  @emb
		end 
		close C1
		deallocate C1
	end
	if(@tip='M')	
	begin
		Declare C2 cursor for select codi_pers, codi_carg  , codi_unid_oper from asistencia_motorista where mesanio=@mesa	and codi_unid_oper=@embar
		open C2
		fetch C2 into @per, @car ,@emb
		WHILE @@FETCH_STATUS = 0
		begin	
			set @net=0
			set @p=null
			select @p=apel_1+ ' ' + apel_2 + ' ' +nomb_1 + ' ' + nomb_2 from personal where codi_pers=@per
			select @net=valor from planilla_boni_moto, planilla_boni_concepto where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
				and planilla_boni_moto.codi_pers=@per and planilla_boni_moto.codi_unid_oper=@embar and planilla_boni_moto.mesanio=@mesa
				and planilla_boni_concepto.codi_conc='999990' and tipo=@tip
			insert into #temporal(codi_pers, codi_carg, neto , persona, semana, embar) values (@per, @car, @net, @p, @mesa, @emb)
					
			fetch C2 into @per, @car,  @emb
		end 
		close C2
		deallocate C2
	end
	select * from #temporal
End
GO
