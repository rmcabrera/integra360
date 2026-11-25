CREATE PROCEDURE [dbo].[SP_Plan_Tripu_Remu_Neto_pagar_diferencias]
	@semana [char](8),
	@embar [char](5)
WITH EXECUTE AS CALLER
AS
Begin
	Declare @per char(5)
	Declare @p varchar(70)
	Declare @car char(4)
	declare @net numeric(12,2)
	declare @net2 numeric(12,2)
	Declare @se char(8)
	Declare @em char(5)
	Declare @g char(1)
	create Table #Temporal (codi_pers char(5) null , codi_carg char(4) null, neto numeric(12,2)  null, neto2 numeric(12,2)  null , persona varchar(70) null,
 		semana char(8) null, emba char(5) null, grupo char(1) null)	
	Declare C1 cursor for select codi_pers, codi_carg from asistencia_tripulantes_pesca where codi_sema=@semana 
		and codi_unid_oper=@embar
	open C1
	fetch C1 into @per, @car
	WHILE @@FETCH_STATUS = 0
	begin	
		set @net=0
		set @net2=0
		select @p = apel_1+ ' ' +isnull(apel_2 , '')+ ' '+ isnull( nomb_1,'')+ ' ' +isnull(nomb_2,'') from personal where codi_pers=@per

		select  @net=valor , @net2=especial , @em= codi_unid_oper, @se =codi_sema from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
			and planilla_de_tripulantes.codi_pers=@per and planilla_de_tripulantes.codi_unid_oper=@embar and planilla_de_tripulantes.codi_sema=@semana
			and planilla_tripulante_conceptos.codi_conc='999990'
		set @g='0'
		if (@car='1101') set @g='1'
		insert into #temporal(codi_pers, codi_carg, neto, neto2, persona,semana,emba, grupo ) values (@per, @car, @net, @net2,@p,@se, @em, @g)
				
		fetch C1 into @per, @car
	end 
	close C1
	deallocate C1
	select * from #temporal
End
GO
